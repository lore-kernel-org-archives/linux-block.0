Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD7A24E4CF
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897777; cv=none; b=qrBepExvV/sLDX8M5okcZcb2b3bxrxJ4sQfIWttmDP7j3XOtvxn/wY0uZW44xzSXUXiv+Bfcl8PKrAlM4CgHFS01c04hJ0onwgYA/JpzN/+JoF/dzEtimbQ3G5zwtt8UXBSw6/FThK4zpjHOsn/oF4Zk6jW+cv76wvdXELwbQ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897777; c=relaxed/simple;
	bh=S6kUKxWOiNef07tgc0KNT6+NkG7RD6wL93aSd6x8eqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbu4RB/SeZzCFNd4m7v0wnJXvNkaDjvy5T1C5McAxNuIqGvcL8i3GLJG/9mohOGjxDjVcWZM5H0cPjglTKXTWCyJ+jq+woO27zVJjHLCUQgJjaGXBoBMPPfLh3WNsOU+v2uSdFVkzxSImHXhn8sf2TeybqWBrZOuBnr/k41P+Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b3xVeZTl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3xVeZTl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744897773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/T6X4YJmlSwG/5i/dF2gEaAb13fLCYiqz1zrUwVGjE=;
	b=b3xVeZTlKYsILiPvitFmsA24VqWzUG213Tbw5OKBNXEDyG5z/9UXA0BepBSRDacqhoF52w
	eQ7iY3iH7IOImnu3dcIPrmvZt9qDaFNJ/N7pZQhI7X0ZlLTdfHUP8ss74roN0koZO3SVea
	wrRTOz1FyyOuCdv4yWHM2HGdBUQfn14=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-5bEYXN5uN6eXf8lIO80hGw-1; Thu, 17 Apr 2025 09:49:32 -0400
X-MC-Unique: 5bEYXN5uN6eXf8lIO80hGw-1
X-Mimecast-MFC-AGG-ID: 5bEYXN5uN6eXf8lIO80hGw_1744897771
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-523f74690afso129298e0c.3
        for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 06:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744897771; x=1745502571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/T6X4YJmlSwG/5i/dF2gEaAb13fLCYiqz1zrUwVGjE=;
        b=SpBta2cROVGqB2g8RHEZpct6Hw1Hh7sYVxFVasGzgu1TUL6271kbtqCWgFectAMIou
         Ppgj372ASvtigZaoY39so8tPui6STk1OASnBMazvz1ajTLxp3ViqGYkAofCii9Ukb/5C
         vWREWL7+a3wWdir9Gx8KNig3u/EgMkvOdmwHz9FKOkcDIVqMGZhET5YqFUJZv7CFUNOk
         11TFo6jGrAyg2/JEPkp2cPlhyPnIn79nEqYhm91iqZCEIudNmpXJ+GW2e8s5aiqaHhNm
         kX5XXPzYipVhw4VROpmU83//gPpm7yD1jrQ2QiaFsPq2CamPWvw/QbKx1/7mgDpZSB+J
         vMMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoIvotfJdz7M/rjD3wwiOqbP/dh2Vn9kpez446waZEWUxg2Js4R5tm5WmVBFBBDchqRQ2OwGcyNX1eaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1bXCNvkKc+cwB4H1xB67ONanWWvdRibAOlgy/W7PtQZKvCziL
	JXGHLqDxC7EsjuRCTC8O9Am8D6HD0Zjn/8P0JB/htkob7zwtl+iXp3N4hVQEeWPb1zd0yGbMiyn
	f+jWtnSOhaoJ1joKRoyK0qGcj76nYctQQ9QL7ANl7l8MVhfShtyFYUZzRWRv5k/K+1HrqQ+at7W
	IWK2LKjlZldrmN2XYrm2cxkt0SQPDIsmUz1y4TcBbevxqRew==
X-Gm-Gg: ASbGncvnH+sikuHHDpLyIW6hzXR1jD9sUuuAujWb5KMULoHRAzXZlvbW7zG53rMJ7pF
	KWX0ww0wD9q6reL7yPU5ix9rgf34I8F/fvtzT8pKHiq8vx7u0Yep9Lid9Ad18RgX14HAnIQ==
X-Received: by 2002:a05:6122:2a13:b0:518:7ab7:afbb with SMTP id 71dfb90a1353d-5290e1c73damr4814054e0c.8.1744897771029;
        Thu, 17 Apr 2025 06:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9fxGwVPUHobbIoPyVIbhj+QAOQNEIHZS5xRLFZVGvxxFC9PfDNSaHUQZ6oluhC8vVcfJo6yKuAt61bU38bAw=
X-Received: by 2002:a05:6122:2a13:b0:518:7ab7:afbb with SMTP id
 71dfb90a1353d-5290e1c73damr4813981e0c.8.1744897770540; Thu, 17 Apr 2025
 06:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417132054.2866409-1-wozizhi@huaweicloud.com> <20250417132054.2866409-2-wozizhi@huaweicloud.com>
In-Reply-To: <20250417132054.2866409-2-wozizhi@huaweicloud.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 17 Apr 2025 21:49:17 +0800
X-Gm-Features: ATxdqUF8yEK1IuMl7a3ELvOoENmTEX0_GTb0tcVv30jKFOzrZt5xYQde2z2MhbU
Message-ID: <CAFj5m9KoE4-ywMPpJD-3+2e07ZV=FOhReEvzCXWP8pKQGube-w@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] blk-throttle: Fix wrong tg->[bytes/io]_disp update
 in __tg_update_carryover()
To: Zizhi Wo <wozizhi@huaweicloud.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, yangerkun@huawei.com, 
	yukuai3@huawei.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 9:31=E2=80=AFPM Zizhi Wo <wozizhi@huaweicloud.com> =
wrote:
>
> From: Zizhi Wo <wozizhi@huawei.com>
>
> In commit 6cc477c36875 ("blk-throttle: carry over directly"), the carryov=
er
> bytes/ios was be carried to [bytes/io]_disp. However, its update mechanis=
m
> has some issues.
>
> In __tg_update_carryover(), we calculate "bytes" and "ios" to represent t=
he
> carryover, but the computation when updating [bytes/io]_disp is incorrect=
.
> And if the sq->nr_queued is empty, we may not update tg->[bytes/io]_disp =
to
> 0 in tg_update_carryover(). We should set it to 0 in non carryover case.
> This patch fixes the issue.
>
> Fixes: 6cc477c36875 ("blk-throttle: carry over directly")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>  block/blk-throttle.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 91dab43c65ab..8ac8db116520 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -644,6 +644,18 @@ static void __tg_update_carryover(struct throtl_grp =
*tg, bool rw,
>         u64 bps_limit =3D tg_bps_limit(tg, rw);
>         u32 iops_limit =3D tg_iops_limit(tg, rw);
>
> +       /*
> +        * If the queue is empty, carryover handling is not needed. In su=
ch cases,
> +        * tg->[bytes/io]_disp should be reset to 0 to avoid impacting th=
e dispatch
> +        * of subsequent bios. The same handling applies when the previou=
s BPS/IOPS
> +        * limit was set to max.
> +        */
> +       if (tg->service_queue.nr_queued[rw] =3D=3D 0) {
> +               tg->bytes_disp[rw] =3D 0;
> +               tg->io_disp[rw] =3D 0;
> +               return;
> +       }
> +
>         /*
>          * If config is updated while bios are still throttled, calculate=
 and
>          * accumulate how many bytes/ios are waited across changes. And
> @@ -656,8 +668,8 @@ static void __tg_update_carryover(struct throtl_grp *=
tg, bool rw,
>         if (iops_limit !=3D UINT_MAX)
>                 *ios =3D calculate_io_allowed(iops_limit, jiffy_elapsed) =
-
>                         tg->io_disp[rw];
> -       tg->bytes_disp[rw] -=3D *bytes;
> -       tg->io_disp[rw] -=3D *ios;
> +       tg->bytes_disp[rw] =3D -*bytes;
> +       tg->io_disp[rw] =3D -*ios;
>  }
>
>  static void tg_update_carryover(struct throtl_grp *tg)
> @@ -665,10 +677,8 @@ static void tg_update_carryover(struct throtl_grp *t=
g)
>         long long bytes[2] =3D {0};
>         int ios[2] =3D {0};
>
> -       if (tg->service_queue.nr_queued[READ])
> -               __tg_update_carryover(tg, READ, &bytes[READ], &ios[READ])=
;
> -       if (tg->service_queue.nr_queued[WRITE])
> -               __tg_update_carryover(tg, WRITE, &bytes[WRITE], &ios[WRIT=
E]);
> +       __tg_update_carryover(tg, READ, &bytes[READ], &ios[READ]);
> +       __tg_update_carryover(tg, WRITE, &bytes[WRITE], &ios[WRITE]);
>
>         /* see comments in struct throtl_grp for meaning of these fields.=
 */
>         throtl_log(&tg->service_queue, "%s: %lld %lld %d %d\n", __func__,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

