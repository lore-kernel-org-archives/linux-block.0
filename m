Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F230E826
	for <linux-block@vger.kernel.org>; Thu, 19 Jun 2025 23:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375603; cv=none; b=jr8JcFcStD3LqniprDMI2aMlF96DpueXKqB05CDI1hCT47FTQk0EALKbKzRAaS0pflOKWnLd+L58upSXTTwM48a4FzNZuN6RUGvR52ANOiqWOt+yWQS9wcHt09EuVonVIOcmfzbHCHrJ0n7Itegx2duHxoNp9gbtb0ltILko9co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375603; c=relaxed/simple;
	bh=vaOiOtid8lLVE8a1nQebbSlbaDX/Av09lbQaJaMgZP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfUka9ciOdtHnsjWdoWL8aeSfsRrO1RmkAUo3v7MS7c3eXmqZxz9X/DtWozWeYsAsIHJV0kIQdcYWo6hutVDO9sanE2GL1zBKnHNhAPLotEyzK9u9MXptFmJHTg6tl13TRpX5KFhEzs7y3ml36eC6fqEw5cSgykZ0O/64nVeIqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RCMI2nHW; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RCMI2nHW"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso2397287a12.2
        for <linux-block@vger.kernel.org>; Thu, 19 Jun 2025 16:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750375595; x=1750980395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DLF2KyJJhBwh40yPF44RSA+57La9P/JoqgJ7v72eKE4=;
        b=RCMI2nHWDoLt/hBrSBGbCB+3tt2UplYqzvFDNL+NioAAoODwj2Ew/jeVqkAPSx6W7C
         KuQByjqYMp4AApdY/1utu4VPskxRNQJ0WEA+wLIpt/QGF7AfF3C89LVFcTS4cwB5eLau
         R2VXO7ulGLg0umL/KA7s7LQv+WvnZe93RgDqlLOumuIt3ERn4/dUHRptq6xjNDGiXpJP
         EmlSFFFu3MUFQDo2JktSsJS0kQwVvWW50SmrFlNqskrV4v+ReSEi/I9vwIPUtiD8Dt3A
         /LZ1a/irL2fT5QRR/NpqBDBeYzk//fSF4OYHkUTC0G1SgXNIHGz7xEXfbgOE+NMfKVz6
         PIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750375595; x=1750980395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLF2KyJJhBwh40yPF44RSA+57La9P/JoqgJ7v72eKE4=;
        b=YR6Y3sCheGRIfHt17VaIxHE4XYi4rGuBJMF67g+dChBbAJhdmDI8bcduheUhz6niHl
         SnhN/eJ0YAe7p769PdFdc1souFB66GP8I5JbBxV0fu7ilYgebQ8e5rlsKKTYpPKGt0vV
         tJaoxPAfUOIToYzkej8f8d5p0Tm+EMPYbhnUmcQZZbaQVCRxGh8DO9/RH5vV3ye0EcR2
         OgMrvLcujtr5AH5mQW36YQ3NEiqDO2oRsasKe/CpviGB7WOxkjnxYouL1qhglona7Rjd
         JjgeadY2pyCMWXew52yPMFpHdUWXk2PytacPcPbjnO+EDdNbbYaiFfGRL1xxXE0wDUE3
         /aJA==
X-Forwarded-Encrypted: i=1; AJvYcCWhkwlazTOcHHRdSqciwu1Fb/bN5cuc4vj1mISk8WoMVHUcafmu9LX6TvPziCzCjE//dwm/ZZiPFQBl1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCSwXApObzC4pC9RRjkZ4pdsDj7x4wCX4OPbWpH0i/VP2m/tMs
	TdWOepYVPsxdt2ADDq87kRNhTAsITXHlkQNiyflvWqoGoE2Y+a8LPaPzEDR3xvQc+O0=
X-Gm-Gg: ASbGncshO4wEZwBIhLrqE+FtMnYZDrG541putn4vrHsOsQC+UHz5mVwZASGpyKGQ8aO
	sT8nPzU6f8GaTOiVeHAH6X4zuhbLXS4WzE+OTrvgACk9jejVY+7fcdzp4BJQng92KkpyRFQxMka
	WYcyXiMjipRvuZXBN3UXHBVAJNKZ0bnr9+Z57/ZFl16wsEYo7mt3SFs/cOy0B8z72jRvsydWWK4
	Tm9cYDY73R2W+62s/Kn3D/OngjZBZHasB8GN7DW4jLhaOiN1As9I6uGHZ4i/Y5T9cwk2AHtzu+u
	GVR35mPJ+rtMrCPe2LTVyqxWO6Qr6Wfdr5k3KmkfldgcXJ7Pl5s4kPwW5RBvV3orbpo=
X-Google-Smtp-Source: AGHT+IFDcBAz0Prwi18O9lktmnQoZWKG+Vt65vArznVVTF+ps5Y4p3Qbztb3WtwQrOb7sbWxAJaZIw==
X-Received: by 2002:a05:6402:2693:b0:608:155c:bf81 with SMTP id 4fb4d7f45d1cf-60a1cf3671emr548175a12.31.1750375595452;
        Thu, 19 Jun 2025 16:26:35 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60a18525151sm537753a12.16.2025.06.19.16.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 16:26:34 -0700 (PDT)
Date: Fri, 20 Jun 2025 01:26:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Roland Sommer <r.sommer@gmx.de>
Cc: 1107479@bugs.debian.org, Salvatore Bonaccorso <carnil@debian.org>, 
	Chris Hofstaedtler <zeha@debian.org>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
Message-ID: <fxg6dksau4jsk3u5xldlyo2m7qgiux6vtdrz5rywseotsouqdv@urcrwz6qtd3r>
References: <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
 <aEVzB6qYlMoViGMh@per.namespace.at>
 <aEaMawE-Nn8QSjgS@eldamar.lan>
 <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
 <1M9Wyy-1uRqo614XE-00Glyf@mail.gmx.net>
 <gbw7aejkbspiltkswpdtjimuzaujmzhdqpjir2t4rbvft5o777@faodorf33bev>
 <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
 <1MmlXK-1v85592aXe-00ciKz@mail.gmx.net>
 <zdclth6piuowqyvx4bn6es5s3zzcwbs6h2hheuswosbn4wty5a@blhozid4bx6q>
 <1MGQnP-1uY1yz0lQr-00EvjN@mail.gmx.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lygwirir54lmfsj2"
Content-Disposition: inline
In-Reply-To: <1MGQnP-1uY1yz0lQr-00EvjN@mail.gmx.net>


--lygwirir54lmfsj2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
MIME-Version: 1.0

Hello Roland,

[adding upstream to Cc: so adding some context first:]

In Debian bug #1107479 you report that inserting a DVD-RAM reliably
makes blkid (which is triggered by udev) result in a process hang.

On Thu, Jun 19, 2025 at 05:05:07PM +0200, Roland Sommer wrote:
> > Can you easily tell if this happens for several DVD-RAMs or just a
> > single one? (That might affect how good this is reproducible for
> > upstream.)
>=20
> I've tested 3 different DVD-RAMs, thus, 3 traces below.
>=20
> > Usually only the first one is interesting. After that the state of the
> > system is broken and the info from later traces is unreliable.
> >=20
> > So yes, please provide (at least) the first trace output.
>=20
> [  330.049632] pktcdvd: pktcdvd0: writer mapped to sr0
> [...]
> [  484.389280]  </TASK>

Translating the addresses here to line numbers yields:

[  330.049632] pktcdvd: pktcdvd0: writer mapped to sr0
[  330.074390] sr0: detected capacity change from 8946816 to 8946812
[  484.388532] INFO: task blkid:1979 blocked for more than 120 seconds.
[  484.388562]       Tainted: G          I        6.1.0-37-amd64 #1 Debian =
6.1.140-1
[  484.388577] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[  484.388585] task:blkid           state:D stack:0     pid:1979  ppid:1768=
   flags:0x00004002
[  484.388610] Call Trace:
[  484.388618]  <TASK>
[  484.388634] __schedule (kernel/sched/core.c:5244 kernel/sched/core.c:656=
1)
[  484.388682] schedule (arch/x86/include/asm/bitops.h:207 (discriminator 1=
) arch/x86/include/asm/bitops.h:239 (discriminator 1) include/asm-generic/b=
itops/instrumented-non-atomic.h:142 (discriminator 1) include/linux/thread_=
info.h:118 (discriminator 1) include/linux/sched.h:2230 (discriminator 1) k=
ernel/sched/core.c:6639 (discriminator 1))
[  484.388706] schedule_preempt_disabled (arch/x86/include/asm/preempt.h:80=
 kernel/sched/core.c:6697)
[  484.388728] __mutex_lock.constprop.0 (kernel/locking/mutex.c:197 kernel/=
locking/mutex.c:681 kernel/locking/mutex.c:747)
[  484.388761] pkt_ioctl (drivers/block/pktcdvd.c:2590) pktcdvd
[  484.388813] pkt_ioctl (drivers/block/pktcdvd.c:2610) pktcdvd
[  484.388853] ? tomoyo_init_request_info (security/tomoyo/util.c:1026)
[  484.388876] blkdev_ioctl (block/ioctl.c:620)
[  484.388896] __x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:870 fs/ioctl.c:856=
 fs/ioctl.c:856)
[  484.388920] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/com=
mon.c:81)
[  484.388947] ? mutex_lock (arch/x86/include/asm/atomic64_64.h:190 include=
/linux/atomic/atomic-long.h:443 include/linux/atomic/atomic-instrumented.h:=
1781 kernel/locking/mutex.c:171 kernel/locking/mutex.c:285)
[  484.388969] ? pkt_ioctl (drivers/block/pktcdvd.c:2619) pktcdvd
[  484.389013] ? blkdev_ioctl (block/ioctl.c:620)
[  484.389030] ? exit_to_user_mode_prepare (arch/x86/include/asm/entry-comm=
on.h:57 kernel/entry/common.c:212)
[  484.389053] ? syscall_exit_to_user_mode (kernel/entry/common.c:306)
[  484.389067] ? do_syscall_64 (arch/x86/entry/common.c:88)
[  484.389089] ? handle_mm_fault (mm/memory.c:5295)
[  484.389117] ? do_user_addr_fault (arch/x86/mm/fault.c:1369)
[  484.389141] ? exit_to_user_mode_prepare (arch/x86/include/asm/entry-comm=
on.h:57 kernel/entry/common.c:212)
[  484.389161] entry_SYSCALL_64_after_hwframe (/build/reproducible-path/lin=
ux-6.1.140/arch/x86/entry/entry_64.S:121)
[  484.389181] RIP: 0033:0x7fce32c8ed1b
[  484.389196] RSP: 002b:00007ffd2857ee10 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[  484.389215] RAX: ffffffffffffffda RBX: 0000557da4646b40 RCX: 00007fce32c=
8ed1b
[  484.389226] RDX: 00007ffd2857ee90 RSI: 0000000000005395 RDI: 00000000000=
00006
[  484.389235] RBP: 0000000000000006 R08: 0000000000000007 R09: 0000557da46=
46a50
[  484.389245] R10: 525ee8f48e4e6f05 R11: 0000000000000246 R12: 00000000000=
00000
[  484.389255] R13: 0000000000000000 R14: 0000000000000000 R15: 80000000685=
41db5
[  484.389280]  </TASK>

blkdev_ioctl calls:

	bdev->bd_disk->fops->ioctl(bdev, mode, cmd, arg);

Obviously we have bdev->bd_disk->fops->ioctl =3D=3D pkt_ioctl and this
function then calls itself in line 2610 with:

	ret =3D bdev->bd_disk->fops->ioctl(bdev, mode, cmd, arg);

So this explains the hang as the second instance of pkt_ioctl wants to
grab the mutex that the first is already holding.

A quick look over the commits since 6.1 to current mainline shows no
change that looks relevant.

In current linus/master (5c8013ae2e86) both functions still have these
calls, so I assume newer kernels are affected in the same way.

Best regards
Uwe

--lygwirir54lmfsj2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhUnKUACgkQj4D7WH0S
/k4fwggAkXpq3xIbcF1rMBljBGQRqgTvUNpLgQSzo61pRQPTp+U+vUhtrTjIHps4
mIXRieRApBFWgdLgYWdunxPITT1id/+t7jsrtqCspddB16JZgz0R8NlOSu0KHVZk
CUy9curWEust4I+aaVFr2td4TQqK6thHPrFz8nPozibT0Ymzg4PcYcv1QcHi4Vjg
1OBMZDq91ninYuxoUycwu7ceAoCidvxUrtI4us+N+fvetinltUZjwREo5Cyc/OAy
xGrv3orAZuM3JUDwg8qoEcl1m4vUpeURNVzOiCEGpTymcVr84ab+ouCDNknX5jFR
MagBrKMbW8SS45jx/WyP9Dhr3/VPug==
=1A0z
-----END PGP SIGNATURE-----

--lygwirir54lmfsj2--
