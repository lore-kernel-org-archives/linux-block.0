Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154FF27F4CA
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 04:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769661913; cv=pass; b=XLF2+/Zn0ZYewawWIER8MQTSWgjmAl86hsHw6T7qDwnZuK/1X2Y4tqdYup+NIq55XJIlHP4otWDYyL4/ArKrffo2JDaKV1wWgzpTU1AhG6ixDoKlOhAFquDPvk07C1h8P0z+C553+7ZlhFqdNcpcRA1+LyVxlpqNpytWOESLAAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769661913; c=relaxed/simple;
	bh=ZF5iINT91H0yve/jJXL4zG61sTe6G3uoHblDBOVlfqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f47I1ZwvtByRTeRwJJ+v14uYrO08YxfeWy/2r9RZ5jpOMZj+M5aSm/ToSFpJqvBQfWVmxMNX05evg2jVY4nV8l5+zpU/5y+h176BuaIGQiWrNA/B2pCj/B0grkBajMNV+rH9TmYt93KAyz4lteq3upMXfHwxHcqrYVoGES7i/Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bfq4wL4J; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bfq4wL4J"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8de3e5b51bso4821166b.2
        for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 20:45:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769661910; cv=none;
        d=google.com; s=arc-20240605;
        b=ZeN95EDdO3UIoYccB7rrUkS0YrmW9z7WxpASO2PjIEmt6jZXV5xWIcKrg4vuo7hvPs
         TqD7XNwnHANKEsZNQOshreelWbL7Oi6ND7TRXSnPRkGfvvtERledC8ePGvIH5uOE/d5P
         BpQQyh8CjzoLTJxLl6w76L2uMMrTE2putts+ly+2Yr9IFpfG7FifLjG14ew9LpsQnXcm
         LhecqpfVACGvZIfxjswN+MvB0qXOa0AqkFp9Cu+J5vhAHbiCtXbP6JFiFvy9K4ZJq7yC
         EGsrsTfJxWk1MhEwco6oZ5WokACYsyr2WD8qmFLXCUVFnHoePgCAvbv7xwnkau7oXFxy
         Ajxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hYxddKj6SQ0P93MEX7RCnQXnk4Rzu5VstyCAiqgQN6w=;
        fh=lDf811sXNn9H3V2QF3RqKm2llpk94tdsXGIRt7SUmSQ=;
        b=YPLasifD0f3YHQD6oKgAlsU2NLH/SD//sZ745K1pOC6BwdxSBpoexTVhKcFZYXr852
         NQf2tHnc2ipKgkKa7cWCUk5FzeaSPWCBGC2MEESuoLWlz/uRLQ8XxiQywkUGpTiZzX3p
         UzWqihPzbfmXnicZQ/VJh+MudhPFK8ijYIU4dHAVHt9trNtIdW2F64RK59rhfBaqFqnT
         ae1NW65ipwRI/Xr6RjxhuJ/XoA47PKxPzg+RDaOqP8qswkD9PQXlhSkyJ6QZd2XjMhcT
         AhQvpXu1yMUfJRnBVq5XCkiGGgjb+xW6PgizoSW5hX01GxJcTYK1H+67N7LXMcxLhQGX
         ke7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769661910; x=1770266710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYxddKj6SQ0P93MEX7RCnQXnk4Rzu5VstyCAiqgQN6w=;
        b=bfq4wL4JKjberSUVpRFWA4RJOr29MyLzquvKKMRPp76TCqGilPzw6tGSzs51O9bmAD
         Ec24c8uILEvGOjLo4QtOXOISpwgWPdMhoqrx9TyKMkXMJDoLRIEd39okEeignCmx9OyF
         16v0LTpvq1Vb3KzaycEWvVVz5eEiXwzi2OmU0zlacB670y49klhw4Rg2OWPbvs7cApOd
         YB1I4/OGVOIajTEg1WFTxyEz21lKGoW4VFOLmTvcBv2DujZC7QZMcfmKLK8DsNVZWqbx
         yCzEBKhT1FqMzkzfGoMh1O19E9Q2LR9CcZJO5DwQjTX9igHTDIvUnvaak79+8gm4F5/v
         bA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769661910; x=1770266710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hYxddKj6SQ0P93MEX7RCnQXnk4Rzu5VstyCAiqgQN6w=;
        b=gONt4HEj/kdxXMGpxoRZDBeevwgxiBuQFEav44jPOPbdj9xLHZ/CdRkWHoOrPbfku9
         SKMRi1RFg6jbr+y8fBxVlulF03h9ampum77FqEKI3ovJkfJ8u7SeraKy4zBGoa8i+Eyi
         kFVgKO3w0O2N5NqzfBmYq2MfrgBKfH2g7R8DJ/Dz1/5/rEGzgD/xMFtSuybIZOE9e3S4
         2KlfxrbTXaBrcZ7Cjb3qmdL27YGt6gs/D2nt3tnTvhae8HtMnP9bMJ+oMifu5L7/IHPX
         Dn/19FPjGP/Folq9TmQsdJKVg/iztf5SW1CKBYbXxVsWiW+7OJwt3hnz9koHo64uu1+p
         soqA==
X-Forwarded-Encrypted: i=1; AJvYcCUeNPRViTVVceKRmf6gsjY+rSE2xZozNoFNEbzchdAK+iGoAngwlY6scQi3rVlfnyRYNVq6R+ezwH7PvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxee/bQu17+ymFCWUGleLY4lo8Y0UAzwwYSrQEurqx25xi73iUP
	UOdXP1DVa6/xxYVBtZW09nA+gylobSGg9d0BLsSQDKRZGImVh/mFlrWArDejDhWQuGci5XqTVh6
	FlwZoCCUckeozB4t+Bft9CG96Bi5EHjbWx6Wa4H/zcQ==
X-Gm-Gg: AZuq6aIHQfAGPrz/7qxl9RlqALcQhlfZ1ulpBqzreOrxGTvEBULC6EoBbD1mBsF6pqT
	kWoS/l0MZEHYufudKvEDpbnCeZHpnN8FPk0xXLcdEV2cmMWHkWA8kky/Zkz3jZtzKNjwGFMoQfo
	XFwdgMUkTat2I0OdlXzYEdm50CWxXRoKf4fWY9CqUfGn+7Wxg759SswLimAfB8/mRCzMLUKVhh4
	7XF3V6fNYqbiOrUoLTpSOa6oDSNQfXOdyz5M0qOmu4Cr6IJRa0zOJr0gxZezA3j+HN391NX
X-Received: by 2002:a05:6402:144e:b0:64b:a1e6:8013 with SMTP id
 4fb4d7f45d1cf-658c2e0a82dmr771562a12.6.1769661910191; Wed, 28 Jan 2026
 20:45:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129031501.3403688-1-ming.lei@redhat.com> <20260129031501.3403688-3-ming.lei@redhat.com>
In-Reply-To: <20260129031501.3403688-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 28 Jan 2026 20:44:58 -0800
X-Gm-Features: AZwV_Qh6k-nSHldYIOGuySwxN6zbPIkQjLuhVGJ9icgpr8VKxGG9f6YkCQMhjWE
Message-ID: <CADUfDZoYtEjVjqQDnHXQynZUp3NJv+bgWuFJuvOUS_hJcOy3qg@mail.gmail.com>
Subject: Re: [PATCH 2/5] ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Alexander Atanasov <alex@zazolabs.com>, 
	Yoav Cohen <yoav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 7:15=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add a new feature flag UBLK_F_NO_AUTO_PART_SCAN to allow users to suppres=
s
> automatic partition scanning when starting a ublk device.
>
> This is useful for some cases in which use don't want to scan
> partitions.
>
> Users still can manually trigger partition scanning later when appropriat=
e
> using standard tools (e.g., partprobe, blockdev --rereadpt).
>
> Reported-by: Yoav Cohen <yoav@nvidia.com>
> Link: https://lore.kernel.org/linux-block/DM4PR12MB63280C5637917C071C2F0D=
65A9A8A@DM4PR12MB6328.namprd12.prod.outlook.com/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 7 ++++++-
>  include/uapi/linux/ublk_cmd.h | 3 +++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 94470a2ec05e..0b98ab0f8257 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -80,7 +80,8 @@
>                 | UBLK_F_BUF_REG_OFF_DAEMON \
>                 | (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRIT=
Y : 0) \
>                 | UBLK_F_SAFE_STOP_DEV \
> -               | UBLK_F_BATCH_IO)
> +               | UBLK_F_BATCH_IO \
> +               | UBLK_F_NO_AUTO_PART_SCAN)
>
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>                 | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -2364,6 +2365,10 @@ static void ublk_partition_scan_work(struct work_s=
truct *work)
>                                              &disk->state)))
>                 goto out;
>
> +       /* Skip partition scan if disabled by user */
> +       if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN)
> +               goto out;

Seems like it's not necessary to schedule ublk_partition_scan_work()
in this case? Could just clear_bit(GD_SUPPRESS_PART_SCAN,
&disk->state) in ublk_ctrl_start_dev()?
Is it actually necessary to clear GD_SUPPRESS_PART_SCAN at all? Does
that flag block partprobe too?

Best,
Caleb

> +
>         mutex_lock(&disk->open_mutex);
>         bdev_disk_changed(disk, false);
>         mutex_unlock(&disk->open_mutex);
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index 743d31491387..a88876756805 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -367,6 +367,9 @@
>   */
>  #define UBLK_F_SAFE_STOP_DEV   (1ULL << 17)
>
> +/* Disable automatic partition scanning when device is started */
> +#define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD        0
>  #define UBLK_S_DEV_LIVE        1
> --
> 2.47.0
>
