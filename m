Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AAA1D7E42
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765837911; cv=pass; b=aExE8crvbRRbK17496n1aRdbM3wf2TvAfs9W4meJtwwLFuWZCqHYgCP3Mee4926TVoxplRPD7RK1ZTNBY38R1P/Y4TTe0WhzT72T7Iy2ot8BVDL+FjJBCfUEqfyI2NgYdnuGvr3UL3gUghgQC9GO8yEUlo92oCOLq0LGk/LqNRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765837911; c=relaxed/simple;
	bh=QGzVV4QL5Qx8QlkFTdI0XNkXyAsJUbAC2JBgUCK+1H0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHs21OyDpx8VLD0Q4AYahkcEt7QvfdCI2e7oI5Q6cnNaqNx0UkrIdkAjyPGTSI6k9/Gbu11gP0pfNZ03a7pkHgchwR47Sly7RUMss30u0Udoab9ZWuAAfE3pOaHN+DFoMpJjBhqgA/pBwpW0rniwYMYwkJrXt0R2JHDWbpQdb5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGQHtwBz; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGQHtwBz"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29e7ec26e3dso31855ad.0
        for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 14:31:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765837908; cv=none;
        d=google.com; s=arc-20240605;
        b=Kho6t0SZUuoCpwNxLNKb4xN7pNZIQw9RAotbtgZwxC7HYHlldN4FLHWa7YNsY+Z3dM
         QVXxAgILKqjse/26UFe21rH77Phnmfrh5dOZckbEJU9kR4D0eddURdIyVon49Q8d67fu
         fK4fS7HhR/YI9a6Res6zH0pPluid5oyhlaz7mdC4KbUX4s0R7kzgUmANqkql+VADR3ps
         mG2LD9avMMyiIzk19L4oWEevqE8GoGniSrAT4jlWbNR8osTJwj2DrTz3res/XQ1/87tL
         aubYQOQpjWK6PQPxeMZ9AIPy/Es2PctQSIQLGdzfA1cA1aiUf2d1paq/Hq2oyQeJZ89K
         CP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MDoS1wcUn46c1o+kUt4Dase0a7E8ksrz1tIiI0QmEA0=;
        fh=EuPmVpR1bSdxN3rZp2clhIb3l/2/oqDiadqYYNRYYHY=;
        b=XIVBhnuzstZil+bxHs7X2hPl6oY+2CGxrmd/VraiZfwpzFmXPSCaK/CcRsp3IjRxec
         7yPrRj0yYNzYBPpcLO7mQpfLK8ZW47CG92eYsBwExWF1VbNOhVlpSKBCD9G94Lr2sYXs
         1T3r4dUirJUmxo2pt2x4Oh74s/HmCnRWVazTAfd/QzPzl14fSYP0UvJZO5PYGsVuyXv0
         yxp7KeUEw+HBBYIgX1ZQX9o62R/8vCt9YN0XbNxwOSP8rvMNyAWGAFFvHiOMIgyev1nE
         VktvPMR51nZvA60bYZtEL3nUyODdVkccTS3ELy7whRGcTw5jvzPPqwfnyQyyvV/eZr0a
         ZcQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765837908; x=1766442708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDoS1wcUn46c1o+kUt4Dase0a7E8ksrz1tIiI0QmEA0=;
        b=HGQHtwBzGkSssG9+QPO9cDow2hPb57R5nO57hfCf3ruWPOvuMBOpsz3ZJGjoqV70IO
         dKTatmwSph5JOduj72DzU2SyGz5U2Gfmz4GTMmsZI6JL72BrxbvJ5Do9HDphTC1mIG4z
         dwnmKMcjc2f7mpEbUBVR6LmAkShoRN7sFaCki0+qgzzEnYg7NV1h7ev4lPY2zIOTSurg
         LiiX7yxql+DHgDGkz2ABhhBFEwkKT5k8PMQTh8yyCoKotCuM4rCHvd6LgM4o2dXikkZc
         DPgUWqNalyL6d5M0gt0G4C7Z7fhVB/9Kq5AZvb/0rWKVbVRxQHJlTrP5IsPvduaoD6Vw
         K63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765837908; x=1766442708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MDoS1wcUn46c1o+kUt4Dase0a7E8ksrz1tIiI0QmEA0=;
        b=Pu+0sum5BkxPPDh9OgSIbMgjgUDWJUVMJcU15E4N/Hsfhnzj4bpOW7mIcqgbjWhaEE
         kKzlX3H0dGlbQnnUj6fd5j4y2ar90x0Ez810tXGfuqaxV3f5ZeTlNgX2tXrWZ7Rkcyue
         LrUeHPMUS02+igqhwYNx5XOS8HjAzpMraC+Sb2d92lsXqcsYDBvxi0tsEXoSkjnJxJ8r
         vniRQZdKvozDgqQ5N9vawzZ2DaaK/fahqFxqs6wHk8t3/F39zKJvhduV8qmwysPXbW3G
         saqWP1iHQ0/jmAOCKp0HSM7jsd9FA0f9vJfUXIabW7xffl+U29HPHinVIK/6Dw/rf25r
         EH6g==
X-Forwarded-Encrypted: i=1; AJvYcCW4yELn5MFQIhcfps/oz/jmMzfF6wiwAQIKG8Dg/FZ0B921RpA8naLunnsvnoIT7CiyYo0bCJqwHrkZUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy2fxIIIBiOlLuyGvbLHtxB5NPhmPgYHUigSqUPfYZy5TkYGAv
	9uR0gddVZCo0WiGSsrhaZD7Uj2dh3X5p/8K8Gc/t8Qw5MI5u2AytmqiOldkyQboCSlvN6Ota1JU
	ni7aEKduBvmaSfv6IOV9JrdXJtIUseec25xGhoFby
X-Gm-Gg: AY/fxX5sE/xhOExdfLl/WVsegKZm5zoml1QdnciEbDiKTrA76IT3lGDOiOWXgFr4LVu
	qYZqw8qWlIHZaKKdgBkcztSkz+xWHcibGPjiQ4X0Ey6jDkXZ+ZFznbO7dYTtEc2gGwC9dpV8qk4
	+tEzwqUa9P6TxPyU/Hm0n11daRFJEIwdRpz+TpyBmPQ0pbY+p5GpGEoefOU4JvobbcZ7Rg4b2vQ
	rnoj/MW2jM7YU4ve1Y0iql3naTxQvYEQlHLOOMXVga9BQSjGQ9HDNat3E9aEOgzx2XQ54gEAsFo
	tT89G18GY6/NWA0l/41CtzNJ8MiI2vEDvM0/02WQKPgg149y4VCJOSI=
X-Google-Smtp-Source: AGHT+IGRIaboGVckS9g/qPRFtli3PshYjyLF2BM1BK7omXduoKeTI2/kIP9p0srIwsjovp30ojTHhjVXymdM79d4KN8=
X-Received: by 2002:a17:903:15ce:b0:29f:181c:1f0 with SMTP id
 d9443c01a7336-2a0906f3886mr5554235ad.11.1765837908008; Mon, 15 Dec 2025
 14:31:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d7c0b48450c70eeb5fd8acd6ecd23593f30dbf1f.1765775954.git.senozhatsky@chromium.org>
In-Reply-To: <d7c0b48450c70eeb5fd8acd6ecd23593f30dbf1f.1765775954.git.senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Mon, 15 Dec 2025 17:31:12 -0500
X-Gm-Features: AQt7F2r0EuuPIfhwSJRS6i_Tjcekk7gDmjBvcasparsnwyKoYpM333lodRLuq38
Message-ID: <CADyq12zu_o1fEz2B0nrZUFhbnEgiLPVkJv4ku5mrXYNBBNQ-Dg@mail.gmail.com>
Subject: Re: [PATCH 1/3] zram: use u32 for entry ac_time tracking
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	David Stevens <stevensd@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 12:47=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> We can reduce sizeof(zram_table_entry) on 64-bit systems
> by converting flags and ac_time to u32.  Entry flags fit
> into u32, and for ac_time u32 gives us over a century of
> entry lifespan (approx 136 years) which is plenty (zram
> uses system boot time (seconds)).

Makes sense.

>
> In struct zram_table_entry we use bytes aliasing, because
> bit-wait API (for slot lock) requires a whole unsigned
> long word.
>
> Suggested-by: David Stevens <stevensd@google.com>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Brian Geffon <bgeffon@google.com>

> ---
>  drivers/block/zram/zram_drv.c | 60 +++++++++++++++++------------------
>  drivers/block/zram/zram_drv.h |  9 ++++--
>  2 files changed, 37 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 67a9e7c005c3..65f99ff3e2e5 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -81,7 +81,7 @@ static void zram_slot_lock_init(struct zram *zram, u32 =
index)
>   */
>  static __must_check bool zram_slot_trylock(struct zram *zram, u32 index)
>  {
> -       unsigned long *lock =3D &zram->table[index].flags;
> +       unsigned long *lock =3D &zram->table[index].__lock;
>
>         if (!test_and_set_bit_lock(ZRAM_ENTRY_LOCK, lock)) {
>                 mutex_acquire(slot_dep_map(zram, index), 0, 1, _RET_IP_);
> @@ -94,7 +94,7 @@ static __must_check bool zram_slot_trylock(struct zram =
*zram, u32 index)
>
>  static void zram_slot_lock(struct zram *zram, u32 index)
>  {
> -       unsigned long *lock =3D &zram->table[index].flags;
> +       unsigned long *lock =3D &zram->table[index].__lock;
>
>         mutex_acquire(slot_dep_map(zram, index), 0, 0, _RET_IP_);
>         wait_on_bit_lock(lock, ZRAM_ENTRY_LOCK, TASK_UNINTERRUPTIBLE);
> @@ -103,7 +103,7 @@ static void zram_slot_lock(struct zram *zram, u32 ind=
ex)
>
>  static void zram_slot_unlock(struct zram *zram, u32 index)
>  {
> -       unsigned long *lock =3D &zram->table[index].flags;
> +       unsigned long *lock =3D &zram->table[index].__lock;
>
>         mutex_release(slot_dep_map(zram, index), _RET_IP_);
>         clear_and_wake_up_bit(ZRAM_ENTRY_LOCK, lock);
> @@ -130,34 +130,33 @@ static void zram_set_handle(struct zram *zram, u32 =
index, unsigned long handle)
>  }
>
>  static bool zram_test_flag(struct zram *zram, u32 index,
> -                       enum zram_pageflags flag)
> +                          enum zram_pageflags flag)
>  {
> -       return zram->table[index].flags & BIT(flag);
> +       return zram->table[index].attr.flags & BIT(flag);
>  }
>
>  static void zram_set_flag(struct zram *zram, u32 index,
> -                       enum zram_pageflags flag)
> +                         enum zram_pageflags flag)
>  {
> -       zram->table[index].flags |=3D BIT(flag);
> +       zram->table[index].attr.flags |=3D BIT(flag);
>  }
>
>  static void zram_clear_flag(struct zram *zram, u32 index,
> -                       enum zram_pageflags flag)
> +                           enum zram_pageflags flag)
>  {
> -       zram->table[index].flags &=3D ~BIT(flag);
> +       zram->table[index].attr.flags &=3D ~BIT(flag);
>  }
>
>  static size_t zram_get_obj_size(struct zram *zram, u32 index)
>  {
> -       return zram->table[index].flags & (BIT(ZRAM_FLAG_SHIFT) - 1);
> +       return zram->table[index].attr.flags & (BIT(ZRAM_FLAG_SHIFT) - 1)=
;
>  }
>
> -static void zram_set_obj_size(struct zram *zram,
> -                                       u32 index, size_t size)
> +static void zram_set_obj_size(struct zram *zram, u32 index, size_t size)
>  {
> -       unsigned long flags =3D zram->table[index].flags >> ZRAM_FLAG_SHI=
FT;
> +       unsigned long flags =3D zram->table[index].attr.flags >> ZRAM_FLA=
G_SHIFT;
>
> -       zram->table[index].flags =3D (flags << ZRAM_FLAG_SHIFT) | size;
> +       zram->table[index].attr.flags =3D (flags << ZRAM_FLAG_SHIFT) | si=
ze;
>  }
>
>  static inline bool zram_allocated(struct zram *zram, u32 index)
> @@ -208,14 +207,14 @@ static inline void zram_set_priority(struct zram *z=
ram, u32 index, u32 prio)
>          * Clear previous priority value first, in case if we recompress
>          * further an already recompressed page
>          */
> -       zram->table[index].flags &=3D ~(ZRAM_COMP_PRIORITY_MASK <<
> -                                     ZRAM_COMP_PRIORITY_BIT1);
> -       zram->table[index].flags |=3D (prio << ZRAM_COMP_PRIORITY_BIT1);
> +       zram->table[index].attr.flags &=3D ~(ZRAM_COMP_PRIORITY_MASK <<
> +                                          ZRAM_COMP_PRIORITY_BIT1);
> +       zram->table[index].attr.flags |=3D (prio << ZRAM_COMP_PRIORITY_BI=
T1);
>  }
>
>  static inline u32 zram_get_priority(struct zram *zram, u32 index)
>  {
> -       u32 prio =3D zram->table[index].flags >> ZRAM_COMP_PRIORITY_BIT1;
> +       u32 prio =3D zram->table[index].attr.flags >> ZRAM_COMP_PRIORITY_=
BIT1;
>
>         return prio & ZRAM_COMP_PRIORITY_MASK;
>  }
> @@ -225,7 +224,7 @@ static void zram_accessed(struct zram *zram, u32 inde=
x)
>         zram_clear_flag(zram, index, ZRAM_IDLE);
>         zram_clear_flag(zram, index, ZRAM_PP_SLOT);
>  #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
> -       zram->table[index].ac_time =3D ktime_get_boottime();
> +       zram->table[index].attr.ac_time =3D (u32)ktime_get_boottime_secon=
ds();
>  #endif
>  }
>
> @@ -447,7 +446,7 @@ static void mark_idle(struct zram *zram, ktime_t cuto=
ff)
>
>  #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
>                 is_idle =3D !cutoff ||
> -                       ktime_after(cutoff, zram->table[index].ac_time);
> +                       ktime_after(cutoff, zram->table[index].attr.ac_ti=
me);
>  #endif
>                 if (is_idle)
>                         zram_set_flag(zram, index, ZRAM_IDLE);
> @@ -461,18 +460,19 @@ static ssize_t idle_store(struct device *dev, struc=
t device_attribute *attr,
>                           const char *buf, size_t len)
>  {
>         struct zram *zram =3D dev_to_zram(dev);
> -       ktime_t cutoff_time =3D 0;
> +       ktime_t cutoff =3D 0;
>
>         if (!sysfs_streq(buf, "all")) {
>                 /*
>                  * If it did not parse as 'all' try to treat it as an int=
eger
>                  * when we have memory tracking enabled.
>                  */
> -               u64 age_sec;
> +               u32 age_sec;
>
> -               if (IS_ENABLED(CONFIG_ZRAM_TRACK_ENTRY_ACTIME) && !kstrto=
ull(buf, 0, &age_sec))
> -                       cutoff_time =3D ktime_sub(ktime_get_boottime(),
> -                                       ns_to_ktime(age_sec * NSEC_PER_SE=
C));
> +               if (IS_ENABLED(CONFIG_ZRAM_TRACK_ENTRY_ACTIME) &&
> +                   !kstrtouint(buf, 0, &age_sec))
> +                       cutoff =3D ktime_sub((u32)ktime_get_boottime_seco=
nds(),
> +                                          age_sec);
>                 else
>                         return -EINVAL;
>         }
> @@ -482,10 +482,10 @@ static ssize_t idle_store(struct device *dev, struc=
t device_attribute *attr,
>                 return -EINVAL;
>
>         /*
> -        * A cutoff_time of 0 marks everything as idle, this is the
> +        * A cutoff of 0 marks everything as idle, this is the
>          * "all" behavior.
>          */
> -       mark_idle(zram, cutoff_time);
> +       mark_idle(zram, cutoff);
>         return len;
>  }
>
> @@ -1588,7 +1588,7 @@ static ssize_t read_block_state(struct file *file, =
char __user *buf,
>                 if (!zram_allocated(zram, index))
>                         goto next;
>
> -               ts =3D ktime_to_timespec64(zram->table[index].ac_time);
> +               ts =3D ktime_to_timespec64(zram->table[index].attr.ac_tim=
e);
>                 copied =3D snprintf(kbuf + written, count,
>                         "%12zd %12lld.%06lu %c%c%c%c%c%c\n",
>                         index, (s64)ts.tv_sec,
> @@ -2013,7 +2013,7 @@ static void zram_slot_free(struct zram *zram, u32 i=
ndex)
>         unsigned long handle;
>
>  #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
> -       zram->table[index].ac_time =3D 0;
> +       zram->table[index].attr.ac_time =3D 0;
>  #endif
>
>         zram_clear_flag(zram, index, ZRAM_IDLE);
> @@ -3286,7 +3286,7 @@ static int __init zram_init(void)
>         struct zram_table_entry zram_te;
>         int ret;
>
> -       BUILD_BUG_ON(__NR_ZRAM_PAGEFLAGS > sizeof(zram_te.flags) * 8);
> +       BUILD_BUG_ON(__NR_ZRAM_PAGEFLAGS > sizeof(zram_te.attr.flags) * 8=
);
>
>         ret =3D cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE, "block/zram:=
prepare",
>                                       zcomp_cpu_up_prepare, zcomp_cpu_dea=
d);
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.=
h
> index 72fdf66c78ab..48d6861c6647 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -65,10 +65,15 @@ enum zram_pageflags {
>   */
>  struct zram_table_entry {
>         unsigned long handle;
> -       unsigned long flags;
> +       union {
> +               unsigned long __lock;
> +               struct attr {
> +                       u32 flags;
>  #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
> -       ktime_t ac_time;
> +                       u32 ac_time;
>  #endif

Why not just always enable CONFIG_ZRAM_TRACK_ENTRY_ACTIME now that it
doesn't consume any additional space? Also, why can't we do this with
a single unsigned long flags as before and have a simple method that
isolates and casts the lower 32bits as a u32?

static u32 *zram_get_actime_for_slot(struct zram *zram, u32 index) {
  return ((u32*)&zram->table[index].flags) + 1;
}

>
> --
> 2.52.0.239.gd5f0c6e74e-goog
>
