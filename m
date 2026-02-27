Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C6936CDF5
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772217011; cv=pass; b=OHCXyEUBRf61ldRuIc1DFYC+AgqIEvHE2KWsxpEVFRpOpSA59YqIbIOUDrB3MiWp3poxLpNL/RUjwIkietJFG7xDxZo5/IrvNVJXOMV1+OChJyF/yixIkNn56Sn70rMfaeMnfoC1KcMB3xDymrXa7SpStFQwjAHB/s06UtgS8zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772217011; c=relaxed/simple;
	bh=+v2dYSAaFB7IMV8xEcUF+hPKnRt1Wzez07uxT7r9AL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuPznqe9K/q4YboS4tEkY75x6MZ2l1FVA8W6ODLJnOSPla8suPoIBrbvD9+XuGezYct2vRBhkUWckAAZXsnLuEvg28ZlsJMGXKLZDbJ19SJzmxuAoJkpMMWwXHIV+rxgpVOsJ4ZTThM4m5GgfY0uVXltqRJcnG2Mma/uKtlOZok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=G7Mj2JeN; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="G7Mj2JeN"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8f8324d2eeso32740866b.2
        for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 10:30:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772217008; cv=none;
        d=google.com; s=arc-20240605;
        b=IjSXGjy8DfuWSrgTZ1t8S5VU3Q6Hocwc30dYgtfhZ5yYNxP6Vq134DH/UvhdSMDm60
         BqJnjAMfADm7nKeTPuRgTgjn6wrpk4f7CFVIXfCMQ37/6+dv8i7ssrWNgS1dTzJFtezL
         OSQ5FCWNIIkGUag4LIx0kLpL/A6psNIfNMHRcArCZYVWo1qFMtplmEEAv/I10cOc5HHB
         VYWs82oqi+84hnh5IP+7UfN9lIF+x1/590+Ym9VDu4Ott3TSbweZQAYOuqyNSrX8KuLh
         7aM9UfTCKvmIwpokSasBRe140fkytWZtjUm+ZDKAC+VFeY/eqcCCwxCsLr17HvTzn2/O
         3HfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GrqXthqf0tb1xz9unOxkZ9k7Wf/5r9VqL1lM1Fcws1M=;
        fh=3WhQ6ghUqRhWnn8PU4jRGNQQ/3BsU3Upg8SHu1nltC4=;
        b=UfahLeXGlXfsG2dD0kDo8fO1bYa3PQ/6ueCFyJyboObUY3iHfXgLY5+V0z/UlZENz4
         Qrh9kfHYb0IumGchnB9WSZ5IDO7KY6RsKO76TZIEsDF2F4ehMF1AYSV1OCQEXHBtSrRg
         fYaQPrh3CZq1SdDXiHpSaJIvG0ksngT1T5Z3MnAXHdoawVTgZ6zxuOrIbd2evXL9Jip5
         rxctHDGMoig3GVlTVlTnyZCKBf4vMus1TNYR56UaxgBEowInIhMP2mUYdCTz956ukuw+
         zvCvbWcdNT8095ZqAX1K+8w3eCxtnxevnRiZKZ+FppQvK2iyY7ay1GIIUyoj8cBcqol0
         uk/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772217008; x=1772821808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrqXthqf0tb1xz9unOxkZ9k7Wf/5r9VqL1lM1Fcws1M=;
        b=G7Mj2JeNx5ykfJhDyt9bWp0Sz19QyXDZ1TfD8hygOgQfiNg3pYLWf/25iiZjnCprbY
         Xc4g2aCKRS8swrKxrJlbOTFaanqufXd1aBEqFXRHx8Ly9s+mRZVcBjtLtRpmEzsTRnnA
         CkVzIoEQxcsseSZJa2Olwa//CExCXLhmc+WSjqUElsAdW5yS6u4V8Sj8IbBb3NfaOZm+
         nMTSUGzK+3MdiLmQ/3F4o/ndzoNk55vsexqjTLDXBpHHkFKGx1hcgiz/UAAuxn7nCm/q
         rqemtrjw3bkw7hBQRozPlLfeV5T7I7JNJo4jMt6J85NbarzpvY0r0233rTCmwmws/chi
         OYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772217008; x=1772821808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GrqXthqf0tb1xz9unOxkZ9k7Wf/5r9VqL1lM1Fcws1M=;
        b=aa0K/Aa4cfxUmKLeMdyI35MXfAYFcirnkuY3DgnSB0z7IIAFlkwscn2taCc7o5eeUP
         DStBNNvzgJQiZIGX0Tlwtyawck0g8YEcO0Z2isgxn80UUw544Wmjqyczn0oCIQm/e0Lx
         X5NpHRzaXnhPwv8z1mxm3HbIQdPWSX8iXuZw9MxJVY5v4EDO/wUDJkUw3UA6Vlo1qz3k
         jZ98xfe6riNb3a9/kjC/u3DcyO2i1Q+WOHaFDhLxl9QJ9Ovai6xqTZaQ8j/WujX1uJ3K
         1vI0hthlDuCOPWQPH1x3iTmMjWj7sTJlVSnH88RW2R+ZbZz+YiZ8biXJkP0cAl26wtso
         6LFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4cX3xGk8OJyaYM4UUM06UnU/hjUkyLmnolEgYsA2FX0Ek+Rl7I6SgjZYps112HQ/6fHJwG9ofe6fAjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNIb5hr6yoD2rj8o4Pj3IdHjIAjmm8NpoxmN7TaWfEBMhgmRTm
	xg72SfKbLokeAOXg4HjtXh+1QThkgxbxLpU1x8gcIIg3gAbNadVs8uyjC8N66671Qdq313wB/RJ
	NbPWzb5EzovMk0JGHPeQJjKQB51IiutN34JtRrkNAQA==
X-Gm-Gg: ATEYQzzRdPclRZzWcajawJVyPjxdc6TYOsj2123Vd4+szpikbTGM1vk6n9JxROTmQpu
	anvvdu0Zc7f3Vi18ZmNMx5UjRLYjZdlcOBiQn/zWoB+fe0X1Z7EE1mQ0Ax6BkA6sP8ZraXjUUzT
	Tv5Fy4+k/mw48BwaYWncajd2vob/WI9appEQ9ST3YInWbR1z9Qw29jmd+xLQ6Q/M8P2exZf+0LI
	Kyf10sX7WO2T2bnmMVNrNECwAQvNVSZbOFN1ecisLEvpyR1vL9tTb/FB9I9g1OWA6PIMq3x8Hjk
	A2WvhaY=
X-Received: by 2002:a17:907:d1d:b0:b8a:f2d7:9942 with SMTP id
 a640c23a62f3a-b93764f86d3mr115572666b.3.1772217007991; Fri, 27 Feb 2026
 10:30:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227145756.3877069-1-alex@zazolabs.com> <20260227145756.3877069-2-alex@zazolabs.com>
In-Reply-To: <20260227145756.3877069-2-alex@zazolabs.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 27 Feb 2026 10:29:56 -0800
X-Gm-Features: AaiRm52xSEkxKOKeyXFemTMBI7hnqLJHziUWPUVBeGO5NWckqXK8pq_P0xYSJ08
Message-ID: <CADUfDZqo2KWB9aDjAgxwKQkJLK-TU1GuWtqcdLCnRpLrfMmHKg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ublk: cleanup partition flags handling and
 introduce UBLK_F_NO_PARTITONS
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 7:07=E2=80=AFAM Alexander Atanasov <alex@zazolabs.c=
om> wrote:
>
> Currently the code misuse GD_SUPPRESS_PART_SCAN flag
> as it tries to use it as a switch for the auto partition scan.
> To fully disable creation of partitions GENHD_FL_NO_PART must
> be used, switch code to use it instead GD_SUPPRESS_PART_SCAN.
>
> Rules for partitions become:
>  - Unprivileged daemons - never scan partitions, they have
> GENHD_FL_NO_PART always set - they are devices without partitions.
>
>  - Trusted daemons - by default have partitions enabled,
> automatic initial scan can be disabled via UBLK_F_NO_AUTO_PART_SCAN flag.
> Partitions can be disabled via UBLK_F_NO_PARTITIONS flag.
>
> Rework the code to work as described above:
> - remove checks in ublk_partition_scan_work and rely on
> the caller to schedule the work only if it has to be done.
> - set GENHD_FL_NO_PART on unprivileged devices
> - set GENHD_FL_NO_PART depending on UBLK_F_NO_PARTITIONS on trusted
> devices.
>
> Fixes: 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
> ---
>  drivers/block/ublk_drv.c      | 23 +++++++++--------------
>  include/uapi/linux/ublk_cmd.h |  3 +++
>  2 files changed, 12 insertions(+), 14 deletions(-)
>
> -v1->v2:
>   - remove code duplication and extra flag settings
>   - switch from out-in to out-out to preserve backwards compatibility
>
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 3c918db4905c..36da63ba2a57 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -81,6 +81,7 @@
>                 | (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRIT=
Y : 0) \
>                 | UBLK_F_SAFE_STOP_DEV \
>                 | UBLK_F_BATCH_IO \
> +               | UBLK_F_NO_PARTITIONS \
>                 | UBLK_F_NO_AUTO_PART_SCAN)
>
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> @@ -2361,14 +2362,9 @@ static void ublk_partition_scan_work(struct work_s=
truct *work)
>         if (!disk)
>                 return;
>
> -       if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
> -                                            &disk->state)))
> -               goto out;
> -
>         mutex_lock(&disk->open_mutex);
>         bdev_disk_changed(disk, false);
>         mutex_unlock(&disk->open_mutex);
> -out:
>         ublk_put_disk(disk);
>  }
>
> @@ -4409,10 +4405,10 @@ static int ublk_ctrl_start_dev(struct ublk_device=
 *ub,
>          * wait while holding ub->mutex, which can deadlock with other
>          * operations that need the mutex. Defer partition scan to async
>          * work.
> -        * For unprivileged daemons, keep GD_SUPPRESS_PART_SCAN set
> -        * permanently.
> +        * For unprivileged daemons, set GENHD_FL_NO_PART to
> +        * disable partitions.
>          */
> -       set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> +       disk->flags |=3D GENHD_FL_NO_PART;
>
>         ublk_get_device(ub);
>         ub->dev_info.state =3D UBLK_S_DEV_LIVE;
> @@ -4429,12 +4425,11 @@ static int ublk_ctrl_start_dev(struct ublk_device=
 *ub,
>
>         set_bit(UB_STATE_USED, &ub->state);
>
> -       /* Skip partition scan if disabled by user */
> -       if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
> -               clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> -       } else {
> -               /* Schedule async partition scan for trusted daemons */
> -               if (!ub->unprivileged_daemons)
> +       if (!ub->unprivileged_daemons && !(ub->dev_info.flags & UBLK_F_NO=
_PARTITIONS)) {
> +               /* Enable partitions on device */
> +               disk->flags &=3D ~GENHD_FL_NO_PART;

Is it safe to modify disk->flags after the disk has been added? This looks =
racy.

Best,
Caleb


> +               /* Disable auto partition scan if requested */
> +               if (!(ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN))
>                         schedule_work(&ub->partition_scan_work);
>         }
>
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index a88876756805..bfd2adfb3d8d 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -370,6 +370,9 @@
>  /* Disable automatic partition scanning when device is started */
>  #define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
>
> +/* Disable partitions on the device */
> +#define UBLK_F_NO_PARTITIONS (1ULL << 19)
> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD        0
>  #define UBLK_S_DEV_LIVE        1
>
> base-commit: 72f4d6fca699a1e35b39c5e5dacac2926d254135
> --
> 2.43.0
>
>
