Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F7D33688A
	for <linux-block@vger.kernel.org>; Thu,  5 Mar 2026 01:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772675518; cv=pass; b=WTmHtIuGz1mE5Ld+8pXazMpLb3v3HsCQZ56kdH0Hnwx8NalURkXkjoVQ4Q3coFTv1v0QXQSHNibWzSk1D+KwQC9EG+gVUL5aJaHNA8Or+jkKDRlfb3WIh2RF6pHfa92cFhVTxtrCQ4TGSxtHCqZEOdGKm1imf3IF0B4JabRj6a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772675518; c=relaxed/simple;
	bh=P/mzSDUAZ7skUJ1Q+tIkoX9D8ajRKWsVW8nWOMPJ13w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgUMrIdOAic2axSnFP1GaYAYB3ghhNQIJHPfdbstd5T9pE3BLXHsR3ZGWj+SbnIBRaEZT6EL/cJYmg1m5No/8FyPM2+j3JSMsrx84ZDp0rcMZqSUv9kleGRiUhzmCpQmSHnAXT1Tn0ZHBRQ/W4kcmLtxrCr8XrUZVW/OJrFaiuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Od3FKugC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bE9LYIWA; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Od3FKugC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bE9LYIWA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772675516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJ92D5mzVA1JUKmobr7/X0B9JMbc0dufpGCkh7gJPtQ=;
	b=Od3FKugCrfgzJ7ezLZTuGr7ePW59RcWmM9TcadTExY4dveV6GDZC6wg1zPW/NNR+Ts4IvL
	bH1HmrH9UeWnnrwO4PGUg53L16AeHankW076/AVlqZAvzN6cgxqt22nAHT14jNFE0huPzi
	/hA6Lr4X4y6B6QfE0+thGN8fZfWw61o=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-V5N2GwRUP_iySMZMAc3NVg-1; Wed, 04 Mar 2026 20:51:54 -0500
X-MC-Unique: V5N2GwRUP_iySMZMAc3NVg-1
X-Mimecast-MFC-AGG-ID: V5N2GwRUP_iySMZMAc3NVg_1772675513
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-38a1f798464so25570931fa.0
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 17:51:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772675513; cv=none;
        d=google.com; s=arc-20240605;
        b=Ogb8xxnjCFFM33BTTuic4JTcrKR+jhcp3hm+2Q+qAa0K39JGtuKCrplrWaRHESf8QO
         8CG3g4muQQbocH14/gaLzopWS4WtJBoyFbYxuTCIbABIjcZHQpe/EMSj5pZTn/hR8JSG
         cHGHefgv1H7rH2XUoOdp6ENLVf70dJ1BK3e8xpXWrrJEQOI9TXMa0jgLImychHo8XWRS
         Q9OmH/ZdlTUJlFov7FYjBg84xIdIJsrXdpGxlulY9gs1InvUnBMQy8cppzaxReFj+vte
         OuZHUxTirwwlcK8473MGddj/Y7Gnuh5K33cgyRu3AuA0xN3Btp8Wk1jkXgjVtyjCtglx
         ioeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JJ92D5mzVA1JUKmobr7/X0B9JMbc0dufpGCkh7gJPtQ=;
        fh=Z28X3MnNPzyulkEF/nNMmQ7Ph+gZOFhhlgJtSqIoIQw=;
        b=POJJj7KHTk71L2QBBkAZ5HtDRQlGPLFd3pVW6fVeJfcwmQWSKtNkNBc4ZwRLV8OIEM
         olBdllwiWshfbsV1Jm3/WE703howY99/5lPwl9mA6RnRDycUnMpdgvSO8V+70Pvicqz1
         ujYbuiwNllLmLnH6RdaCAizLWb/6/Zx5npfVC4Zte8jdg2zeGV8MSbCyM5rJNiH6tB/c
         iTo8l/wPPzjjvjc3IdBp4qTwVRfXif06pbJS9tCdKkqUtt6iFE6S/hKNLBsNEzo6A2Tt
         etUSBMZZQSuG2g1/MjuB0jLz88gRhB4UqDJ+xVpgAPla386hb+kSxnYDW2TqJZd194eP
         YWsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772675513; x=1773280313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJ92D5mzVA1JUKmobr7/X0B9JMbc0dufpGCkh7gJPtQ=;
        b=bE9LYIWAY7GCi6VFl/Xl2yX16pn290S+TzvVLBTFHQt0lpa3jaAT2F8sCFTJcKW+TU
         F6FnY1flaPn0j7KcDpS2/Lx2lw5qDrX+mTJu4GRXR2+P0UEeBBBqIuLhtj3SdJoehEiu
         ic5+W+q3khAy4L1bgblQbq4srHE/8A3+e1sik+tAiHDxnTDVyrkMXdMRHy46TCKepm3B
         I0gwXOPitBTJ31027BnPwdrqg0H3jScLD+1X6FMfjR9QEyzZoOTn/E5IWf5fpa0wzTwG
         cHTmQ4CxPa0LX94YHpiFQjTJ/ALhGTS+jhdgLpB4qbeuTda0xwKtj4JnT4fV0hqqNYW8
         g3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772675513; x=1773280313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JJ92D5mzVA1JUKmobr7/X0B9JMbc0dufpGCkh7gJPtQ=;
        b=uY7cg3ZjzU5EV0HteDoCNHrf4Ikike/AYCw4krHqXwu/bJ0/MuzxH8SPIkVAlmhyv8
         +h302vhMK29WFBGW76wE2GK55C8vkIz4V/q2/vOjssJh3h9U+KJUzqNsWZXKjiL5DH9s
         1Amy7i2bwWBBezRRJwA7J0P/LPEziBogN9NfJrjetSd4d1dr+fichdWI4XAyQLymPbI4
         VNyxh6STLT3jfCjzklRq/vlWcd7iVMqHOCcZsnD1ukxPy3uDQEz2BdCbfLPY6W3pMC7w
         VmpI/Ehk3HKbcdTH0pCU+1YIVS9gjzhikRdNRBnVIHV3zzVdYDWgHuLREB548IEyBw2L
         IxWA==
X-Gm-Message-State: AOJu0YydKSBnzWbjOquulxEsVGPImMEO7XFs2n44XIbqn5MsJeFRMBoR
	R9qO4RCS2HDc/4sgAV2NI/Ft5yrg8ZyE+trvMaLl3rygWjTWSmwRsLCAVmO4o4LZxskPbunjthq
	yLojZ4AOiIj0EKsNTYyJxt7WCl7QwNGZVxXIe9dmZPSQTA3ivz6kHWqxozqRU4hT4/94xxQg2Hg
	xCOtSOIEvn3IyqG3WcqqgSJiu9TQ27s0gTA7/4+V0=
X-Gm-Gg: ATEYQzzuSEcKNTDEVyNsgk0DbyYRlGlwyx8Rqn9/PcIqF4Uqw9XtfAwNqFaZ41RUaBI
	RttYPinfT00pmY3Wws2Cc/56wRClLazkN/+Zr0QUS4eo6ywhbQwHgpPeT75bBPWgOnJD2CgC34C
	hs9wwacqcRTdPqgcxKGvOW8rNzH/XwaIMen7uGG6DlTz7VVs6+xdHrzLfT3hi5Mv16p3c+1r60B
	qY/IZIKM6ng9T/hMGEdYhJtgAPXP2w2RDWdXu35XM1TO8uOhSQ=
X-Received: by 2002:a05:651c:385:b0:385:f547:1842 with SMTP id 38308e7fff4ca-38a2c7caea1mr22978051fa.30.1772675513175;
        Wed, 04 Mar 2026 17:51:53 -0800 (PST)
X-Received: by 2002:a05:651c:385:b0:385:f547:1842 with SMTP id
 38308e7fff4ca-38a2c7caea1mr22977971fa.30.1772675512744; Wed, 04 Mar 2026
 17:51:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs-em-4acsHabMdT=jJhXkCzjnprD-aQH1OgrZo4nTnmMw@mail.gmail.com>
 <aagGeXqeHnCugRyr@fedora>
In-Reply-To: <aagGeXqeHnCugRyr@fedora>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 5 Mar 2026 09:51:39 +0800
X-Gm-Features: AaiRm53ellv6zKp8uqSsxx4nJpW8-qH1812PGgkH4QmJJqGz0zKN8Ok0MVi11Ec
Message-ID: <CAHj4cs801wkSbOmP9O-UP33Xvmx5uQT3Q0kXRb04tfwrA+_GHw@mail.gmail.com>
Subject: Re: [bug report] blktests block/022 failed with possible circular
 locking dependency detected at: __kernfs_remove+0x275/0x710 and del_gendisk+0xfd/0x190
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 6:16=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Wed, Mar 04, 2026 at 03:10:06PM +0800, Yi Zhang wrote:
> > Hi
> >
> > I found blktests block/022 failed on the latest
> > linux-block/for-next[1], please help check it and let me know if you
> > need any info/testing for it, thanks.
> >
> > [1]
> > commit b82c5e4f1bcb3fa78ba3c95a0d198f55553c0fc1
> > Merge: 187d9a5a18b4 d47f7c173262
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Mon Mar 2 14:04:16 2026 -0700
> >
> >     Merge branch 'for-7.1/block' into for-next
> >
> > dmesg:
> > [ 1329.227229] run blktests block/022 at 2026-03-03 13:51:07
> > [ 1329.838331] null_blk: module loaded
> > --snip--
>
> ...
>
> > [ 1349.822314]  Possible unsafe locking scenario:
> >
> > [ 1349.828232]        CPU0                    CPU1
> > [ 1349.832766]        ----                    ----
> > [ 1349.837296]   rlock(&set->update_nr_hwq_lock);
> > [ 1349.841752]                                lock(kn->active#104);
> > [ 1349.847767]                                lock(&set->update_nr_hwq_=
lock);
> > [ 1349.854647]   lock(kn->active#104);
> > [ 1349.858148]
> >                 *** DEADLOCK ***
>
> Looks one real deadlock risk, can you try the following patch?
>


Yes, the issue was fixed with the patch, thanks.

Tested-by: Yi Zhang <yi.zhang@redhat.com>

>
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index f3b1968c80ce..55a1bbfef7d4 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -78,8 +78,14 @@ queue_requests_store(struct gendisk *disk, const char =
*page, size_t count)
>         /*
>          * Serialize updating nr_requests with concurrent queue_requests_=
store()
>          * and switching elevator.
> +        *
> +        * Use trylock to avoid circular lock dependency with kernfs acti=
ve
> +        * reference during concurrent disk deletion:
> +        *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject=
_del)
> +        *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
>          */
> -       down_write(&set->update_nr_hwq_lock);
> +       if (!down_write_trylock(&set->update_nr_hwq_lock))
> +               return -EBUSY;
>
>         if (nr =3D=3D q->nr_requests)
>                 goto unlock;
> diff --git a/block/elevator.c b/block/elevator.c
> index ebe2a1fcf011..3bcd37c2aa34 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -807,7 +807,16 @@ ssize_t elv_iosched_store(struct gendisk *disk, cons=
t char *buf,
>         elv_iosched_load_module(ctx.name);
>         ctx.type =3D elevator_find_get(ctx.name);
>
> -       down_read(&set->update_nr_hwq_lock);
> +       /*
> +        * Use trylock to avoid circular lock dependency with kernfs acti=
ve
> +        * reference during concurrent disk deletion:
> +        *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject=
_del)
> +        *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
> +        */
> +       if (!down_read_trylock(&set->update_nr_hwq_lock)) {
> +               ret =3D -EBUSY;
> +               goto out;
> +       }
>         if (!blk_queue_no_elv_switch(q)) {
>                 ret =3D elevator_change(q, &ctx);
>                 if (!ret)
> @@ -817,6 +826,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const=
 char *buf,
>         }
>         up_read(&set->update_nr_hwq_lock);
>
> +out:
>         if (ctx.type)
>                 elevator_put(ctx.type);
>         return ret;
>
>
> Thanks,
> Ming
>


--=20
Best Regards,
  Yi Zhang

