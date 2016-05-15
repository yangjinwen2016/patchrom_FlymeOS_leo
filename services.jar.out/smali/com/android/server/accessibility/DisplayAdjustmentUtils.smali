.class public Lcom/android/server/accessibility/DisplayAdjustmentUtils;
.super Ljava/lang/Object;
.source "DisplayAdjustmentUtils.java"


# static fields
.field private static final DEFAULT_DISPLAY_DALTONIZER:I = 0xc

.field private static final GRAYSCALE_MATRIX:[F

.field private static final INVERSION_MATRIX_VALUE_ONLY:[F

.field private static final LOG_TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/16 v1, 0x10

    const-class v0, Lcom/android/server/accessibility/DisplayAdjustmentUtils;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/android/server/accessibility/DisplayAdjustmentUtils;->LOG_TAG:Ljava/lang/String;

    new-array v0, v1, [F

    fill-array-data v0, :array_0

    sput-object v0, Lcom/android/server/accessibility/DisplayAdjustmentUtils;->GRAYSCALE_MATRIX:[F

    new-array v0, v1, [F

    fill-array-data v0, :array_1

    sput-object v0, Lcom/android/server/accessibility/DisplayAdjustmentUtils;->INVERSION_MATRIX_VALUE_ONLY:[F

    return-void

    nop

    :array_0
    .array-data 4
        0x3e59b3d0    # 0.2126f
        0x3e59b3d0    # 0.2126f
        0x3e59b3d0    # 0.2126f
        0x0
        0x3f371759    # 0.7152f
        0x3f371759    # 0.7152f
        0x3f371759    # 0.7152f
        0x0
        0x3d93dd98    # 0.0722f
        0x3d93dd98    # 0.0722f
        0x3d93dd98    # 0.0722f
        0x0
        0x0
        0x0
        0x0
        0x3f800000    # 1.0f
    .end array-data

    :array_1
    .array-data 4
        0x3ecdd2f2    # 0.402f
        -0x40e6e979    # -0.598f
        -0x40e6a7f0    # -0.599f
        0x0
        -0x4069ba5e    # -1.174f
        -0x41cdd2f2    # -0.174f
        -0x4069999a    # -1.175f
        0x0
        -0x4196872b    # -0.228f
        -0x4196872b    # -0.228f
        0x3f45a1cb    # 0.772f
        0x0
        0x3f800000    # 1.0f
        0x3f800000    # 1.0f
        0x3f800000    # 1.0f
        0x3f800000    # 1.0f
    .end array-data
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static applyAdjustments(Landroid/content/Context;I)V
    .locals 12
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "userId"    # I

    .prologue
    const/4 v11, 0x0

    const/4 v10, -0x1

    const/16 v9, 0x10

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    .local v3, "cr":Landroid/content/ContentResolver;
    const/4 v2, 0x0

    .local v2, "colorMatrix":[F
    const-string v8, "accessibility_display_inversion_enabled"

    invoke-static {v3, v8, v11, p1}, Landroid/provider/Settings$Secure;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v8

    if-eqz v8, :cond_0

    sget-object v8, Lcom/android/server/accessibility/DisplayAdjustmentUtils;->INVERSION_MATRIX_VALUE_ONLY:[F

    invoke-static {v2, v8}, Lcom/android/server/accessibility/DisplayAdjustmentUtils;->multiply([F[F)[F

    move-result-object v2

    :cond_0
    const-string v8, "live_display_color_matrix"

    invoke-static {v3, v8, p1}, Landroid/provider/Settings$Secure;->getStringForUser(Landroid/content/ContentResolver;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    .local v0, "adj":Ljava/lang/String;
    if-eqz v0, :cond_2

    const-string v8, " "

    invoke-virtual {v0, v8}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v7

    .local v7, "tmp":[Ljava/lang/String;
    array-length v8, v7

    if-ne v8, v9, :cond_2

    new-array v1, v9, [F

    .local v1, "adjMatrix":[F
    const/4 v6, 0x0

    .local v6, "i":I
    :goto_0
    if-ge v6, v9, :cond_1

    :try_start_0
    aget-object v8, v7, v6

    invoke-static {v8}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v8

    aput v8, v1, v6

    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    :cond_1
    invoke-static {v2, v1}, Lcom/android/server/accessibility/DisplayAdjustmentUtils;->multiply([F[F)[F
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .end local v1    # "adjMatrix":[F
    .end local v6    # "i":I
    .end local v7    # "tmp":[Ljava/lang/String;
    :cond_2
    :goto_1
    const-string v8, "accessibility_display_daltonizer_enabled"

    invoke-static {v3, v8, v11, p1}, Landroid/provider/Settings$Secure;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v8

    if-eqz v8, :cond_4

    const-string v8, "accessibility_display_daltonizer"

    const/16 v9, 0xc

    invoke-static {v3, v8, v9, p1}, Landroid/provider/Settings$Secure;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v4

    .local v4, "daltonizerMode":I
    if-nez v4, :cond_3

    sget-object v8, Lcom/android/server/accessibility/DisplayAdjustmentUtils;->GRAYSCALE_MATRIX:[F

    invoke-static {v2, v8}, Lcom/android/server/accessibility/DisplayAdjustmentUtils;->multiply([F[F)[F

    move-result-object v2

    invoke-static {v10}, Lcom/android/server/accessibility/DisplayAdjustmentUtils;->setDaltonizerMode(I)V

    .end local v4    # "daltonizerMode":I
    :goto_2
    invoke-static {v2}, Lcom/android/server/accessibility/DisplayAdjustmentUtils;->setColorTransform([F)V

    return-void

    .restart local v1    # "adjMatrix":[F
    .restart local v6    # "i":I
    .restart local v7    # "tmp":[Ljava/lang/String;
    :catch_0
    move-exception v5

    .local v5, "e":Ljava/lang/NumberFormatException;
    sget-object v8, Lcom/android/server/accessibility/DisplayAdjustmentUtils;->LOG_TAG:Ljava/lang/String;

    invoke-virtual {v5}, Ljava/lang/NumberFormatException;->getMessage()Ljava/lang/String;

    move-result-object v9

    invoke-static {v8, v9, v5}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .end local v1    # "adjMatrix":[F
    .end local v5    # "e":Ljava/lang/NumberFormatException;
    .end local v6    # "i":I
    .end local v7    # "tmp":[Ljava/lang/String;
    .restart local v4    # "daltonizerMode":I
    :cond_3
    invoke-static {v4}, Lcom/android/server/accessibility/DisplayAdjustmentUtils;->setDaltonizerMode(I)V

    goto :goto_2

    .end local v4    # "daltonizerMode":I
    :cond_4
    invoke-static {v10}, Lcom/android/server/accessibility/DisplayAdjustmentUtils;->setDaltonizerMode(I)V

    goto :goto_2
.end method

.method public static hasAdjustments(Landroid/content/Context;I)Z
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "userId"    # I

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .local v0, "cr":Landroid/content/ContentResolver;
    const-string v3, "accessibility_display_inversion_enabled"

    invoke-static {v0, v3, v2, p1}, Landroid/provider/Settings$Secure;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v3

    if-eqz v3, :cond_1

    :cond_0
    :goto_0
    return v1

    :cond_1
    const-string v3, "accessibility_display_daltonizer_enabled"

    invoke-static {v0, v3, v2, p1}, Landroid/provider/Settings$Secure;->getIntForUser(Landroid/content/ContentResolver;Ljava/lang/String;II)I

    move-result v3

    if-nez v3, :cond_0

    const-string v3, "live_display_color_matrix"

    invoke-static {v0, v3, p1}, Landroid/provider/Settings$Secure;->getStringForUser(Landroid/content/ContentResolver;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_0

    move v1, v2

    goto :goto_0
.end method

.method private static multiply([F[F)[F
    .locals 6
    .param p0, "matrix"    # [F
    .param p1, "other"    # [F

    .prologue
    const/4 v1, 0x0

    if-nez p0, :cond_0

    .end local p1    # "other":[F
    :goto_0
    return-object p1

    .restart local p1    # "other":[F
    :cond_0
    const/16 v2, 0x10

    new-array v0, v2, [F

    .local v0, "result":[F
    move-object v2, p0

    move v3, v1

    move-object v4, p1

    move v5, v1

    invoke-static/range {v0 .. v5}, Landroid/opengl/Matrix;->multiplyMM([FI[FI[FI)V

    move-object p1, v0

    goto :goto_0
.end method

.method private static setColorTransform([F)V
    .locals 7
    .param p0, "m"    # [F

    .prologue
    :try_start_0
    const-string v4, "SurfaceFlinger"

    invoke-static {v4}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v2

    .local v2, "flinger":Landroid/os/IBinder;
    if-eqz v2, :cond_2

    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v0

    .local v0, "data":Landroid/os/Parcel;
    const-string v4, "android.ui.ISurfaceComposer"

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    if-eqz p0, :cond_0

    const/4 v4, 0x1

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->writeInt(I)V

    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    const/16 v4, 0x10

    if-ge v3, v4, :cond_1

    aget v4, p0, v3

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->writeFloat(F)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .end local v3    # "i":I
    :cond_0
    const/4 v4, 0x0

    invoke-virtual {v0, v4}, Landroid/os/Parcel;->writeInt(I)V

    :cond_1
    const/16 v4, 0x3f7

    const/4 v5, 0x0

    const/4 v6, 0x0

    invoke-interface {v2, v4, v0, v5, v6}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "data":Landroid/os/Parcel;
    .end local v2    # "flinger":Landroid/os/IBinder;
    :cond_2
    :goto_1
    return-void

    :catch_0
    move-exception v1

    .local v1, "ex":Landroid/os/RemoteException;
    sget-object v4, Lcom/android/server/accessibility/DisplayAdjustmentUtils;->LOG_TAG:Ljava/lang/String;

    const-string v5, "Failed to set color transform"

    invoke-static {v4, v5, v1}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1
.end method

.method private static setDaltonizerMode(I)V
    .locals 6
    .param p0, "mode"    # I

    .prologue
    :try_start_0
    const-string v3, "SurfaceFlinger"

    invoke-static {v3}, Landroid/os/ServiceManager;->getService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v2

    .local v2, "flinger":Landroid/os/IBinder;
    if-eqz v2, :cond_0

    invoke-static {}, Landroid/os/Parcel;->obtain()Landroid/os/Parcel;

    move-result-object v0

    .local v0, "data":Landroid/os/Parcel;
    const-string v3, "android.ui.ISurfaceComposer"

    invoke-virtual {v0, v3}, Landroid/os/Parcel;->writeInterfaceToken(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Landroid/os/Parcel;->writeInt(I)V

    const/16 v3, 0x3f6

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-interface {v2, v3, v0, v4, v5}, Landroid/os/IBinder;->transact(ILandroid/os/Parcel;Landroid/os/Parcel;I)Z

    invoke-virtual {v0}, Landroid/os/Parcel;->recycle()V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v0    # "data":Landroid/os/Parcel;
    .end local v2    # "flinger":Landroid/os/IBinder;
    :cond_0
    :goto_0
    return-void

    :catch_0
    move-exception v1

    .local v1, "ex":Landroid/os/RemoteException;
    sget-object v3, Lcom/android/server/accessibility/DisplayAdjustmentUtils;->LOG_TAG:Ljava/lang/String;

    const-string v4, "Failed to set Daltonizer mode"

    invoke-static {v3, v4, v1}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0
.end method
