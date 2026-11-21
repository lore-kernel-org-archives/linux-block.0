Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795238629;
	b=I2El8pTB0Awm87V4O287Y8/QX72tcSyyJZL57nXXB2ByWpVsaHllQobSuqfFM2/om7c5
	 ncb91rUoh+lRiXKI7RK6hpAil/E/wJeeqv+0Gv74HBEypYkXFZTlqbJRwgFnX9r1bMNFU
	 y0rrdrg8OIo5TcMD7yZz7qAGs3K1PpGXnFB9m404zwhSNwqAEQWV5mhjZaG0v91tA9DjG
	 JGNQhDFu7QLNbqcgwa2k3I14f7zLG2fQh0xCk51yhVlTdx4ZuPULPmN3TX+CA+BJs+Rg0
	 a3qSRg9ZZd8fwYh0ye/cjO5BUeFWbW/zI9hSiJGOCFNsBjk99HN/TljRxm5kJQtkLQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795238629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZxgWGW3Jd0IDrSARARfAMJtvz5q15JiqcmzOCWYp1E0=;
	b=m+7w3Y4KreKkVDLZooS4NVIbRrczvvXc/KFIMwHRPXTA+f3AETx89KipuMkQxCsbfh9k
	 bnWHVbt8cV4iNIUNWDN69GFuKeFE2ibjcVo1jvinCh0I19XU99y/kjRsr/V01DM/HWErB
	 V9dV1B+qWp0hQbYmHcepAF2+zayqbkaAJI6ig5+xR9V7EZzCc3ix1quWPJfVskSSu8Zck
	 cvnKoMRFCqrW67N5uq6SJW7PI48S/Xfnw7C0FqNuZ/6FReLZExwu6E3qD7uoHOExmbZ0K
	 8YLhHCZAtPnaoMNzqlWHtmmB8DN9VvHMCHCmecqWeRg9e8CD1a1lJ9iy/8F8olbbMKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zze3KQLN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.179
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A7B606A682
	for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 05:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35A7B606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zze3KQLN
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4e4a4d77e5bso1917553b6e.0
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 21:23:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795238628; cv=none;
        d=google.com; s=arc-20260327;
        b=pmc0c+ODMu1BlYecuF9ErDiTLRUyUX/QBUu4GaPhOIkY4umNlXXLLgoA+Q8zkwnOcB
         ZGOvDVCUcH1yihYdRsY156hX//v2Sv5RMOylNiJNDIx1Xg0VaJZ5anQTocnZn1HEGEZ5
         glXZeavtgqmSiWOBoHuFeCVpZGES1Z0jdLsqvi0zjOBMy8Q8H6ksQP/zoCKEK8ggFzaL
         MeubDdrrmkAOnT3KuU5fZM5wCY+yCKzrNY25eEhymIuwDNZ2kZ8z5tD+m9MVWQPFJDEk
         mvswRHPdH7bx8R+O7pF4q/MhXeOnyxBSqGKepA2TXyuQQPK4/5kO2H5FSeJNJo2OCDo5
         eGWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZxgWGW3Jd0IDrSARARfAMJtvz5q15JiqcmzOCWYp1E0=;
        fh=9+29bCqgU4BTx69UJQfsxGesmT+kGkZIIi6UKy8L5pQ=;
        b=oPhwl24e3G/KsvsdUstTQAdQjo/FEqJArDgrwyACuF19gseDJw6tz8i+v2c71HkI50
         N0GVwbfJG5l93olLqIxw1izyHW10gDlnXSG3eLzoPAuKzvqKdG8vloQEiHvslPaKu9DD
         NlQmVeNKQQqgBpDV7XdsCrEIkqqSGYxrmHRdqg/OeiRyjEPLyPn/r5cUxjqHNvTWzJrP
         Tk/BSV6lIs9YLLow8zDxiM9nKFYzqiPXj6uOTb56dIkbAuraI4IjSChycvfEZMuaBVdG
         fcYdM/95a56yQ46wrjoPQbtvNRDkZd60u9fIp+r55dOtvIHuWM0zURSE1KZMfJAislQc
         Jizg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795238628; x=1795843428; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZxgWGW3Jd0IDrSARARfAMJtvz5q15JiqcmzOCWYp1E0=;
        b=zze3KQLNaSvxYJtnBiO+GQXybRXr9oyo5bl9FFqDF+LCPMI/1jE03nRdBhxHTqt+Bi
         jMnZ61FpvuQdoJ7LRdNESJkweJwJ+gbLjyGYv0ilZoAg/v2aVfiSgd3tqqMC/xwbrN5m
         4kdEB0IIBEYQnBiLvDBKcwWc+NmDqYMYw+7bete4cdcUBKQ0V5cJhZ3/1+wQAp/fZDgx
         aEDYjtLDYldqRdl10epdRGZQ3P/dBxTP03p2p7W8l96vtuM49LxSEQ1cpaeMbfp3JvQH
         uC6PofkIyK1c1UQUPLldOXUWE3Gv/RbQpWhi+wiXrFmqWvQaNkPaRxEofg9VOGpgt3sV
         xsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795238628; x=1795843428;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZxgWGW3Jd0IDrSARARfAMJtvz5q15JiqcmzOCWYp1E0=;
        b=GXYO4KG5l0Saz58D4qn9EHWYsX5YNutAB1C2fZgcjsekqHKnZFuGlbtg0llYVyOu9G
         V40NRu3ZlKDfsWDjary080+6cVlbVv4ppHR0Cc++kVpcJLdH9orsYp9UG8GbXnqeF7HF
         Sqs9X0WBzuzs66kQgQtbX2nwxEOGzbYmBSWPjqo7oLDDxabblqV4GmZx4HxVUWZjykEN
         tvyGh0IpR6DoHaIPy8F+V0OpzXX6nxUCn/gtDrF8/VN2Yoo07kNJAJZ+Zb4/CdrfuOv8
         qfWm4WnuducYwE+u6l2ni3TwIapFqrlb1jtdYmGygyT4vWFCndr41u/qp2PjZvmYvX5r
         Aiqg==
X-Forwarded-Encrypted: i=1; AL+hErGaGi7l7OWGu7/8c5L9KX/K+uP7BLCDsJg9hB2oOCS0MdyrXyGTRQNdmeM9rkZ987YNMxdJ6yVMlJq1Ew==@vger.kernel.org
X-Gm-Message-State: APuU4Z8bjDMRgz0sgBDOS5d0cCJy7eTPpx32mWv/uvuliq1iKD5xIq4g
	XQrsEjn8mKzZXS3hjCFWUrX6vdzImZY+OizcBsWlz7qxuBFy+WzfhrofHAYHtjsWTwEZ986PDzu
	UJXmUVFYW2S27dSznQl08RrFPU/8oyZg=
X-Gm-Gg: AYBFou2hFckv169CKgobiVzzT4RfVJqqHvDQ3UFDmnrsYf7cMTP1IgaEns8uiN1UXn8
	sQRbcAboYxEZH2cHWbxCi6KWb9RSUgSITWjAQV/2z2LYM4xxpcySXy+Jc/HGAz5j7v7qMZQtxO1
	ejnHl4RMN1ywNup7IwM/BmG14DrQ9eGtC6ptNa6YjKQyRDMR4bvyoW4/IpHXMP4S53+2OZpTUVL
	sjXkLpTdzAg+S83rVM1Z2Wk96YrGZF+RjT+AAr5YkyXJtD1jcWANwXNdicxoGEwC/awR+dIG2fk
	WYysyc1iMC47Ox2raI7+kCnVWAJm+2WlSLI+LGZWWmI2O5Ei6S3fX+S3tBZAKK7Z3W9E7n7A+xg
	j0nHKbIsq6KareNo/H4EJe0gLag5NZGgdZs12T5CGx7PB1McyTPTbBed9v1881LNh+TSiJB0d43
	cwPkp8ob7Gpi9xSuIFU9LY4ZyMsV7BkRc0JG9MIyei8b6qfWzPAfn4+yszWA==
X-Received: by 2002:a05:6808:4f0f:b0:4f5:dc0d:e013 with SMTP id
 5614622812f47-579789cf52cmr6048212b6e.4.1795238628066; Fri, 20 Nov 2026
 21:23:48 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAFS5DSFUi28HgX8t5bRRGVqPkOZ+VqrP+LtyMiwPQhyRpTxFTg@mail.gmail.com>
 <556c4720-0159-4874-8d5b-6379566f6d4a@bsbernd.com> <CAFS5DSEhgk8fJgAwEn+-U-7vnBchCrx6L1uReT3Upm+AA22=Wg@mail.gmail.com>
 <CAFS5DSEsdz8Eu1vmeCkE+6eeXgk+9yS6EwqyHSeD2jkq90DZaA@mail.gmail.com>
In-Reply-To: <CAFS5DSEsdz8Eu1vmeCkE+6eeXgk+9yS6EwqyHSeD2jkq90DZaA@mail.gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 20 Nov 2026 23:23:35 -0600
X-Gm-Features: Aa3M54r-1Qm2wOa9Pkp5dJnwKyl6aDgAycS9C5SRiXFExx6r8aHR9F25Y7zOCvQ
Message-ID: <CACVXFVPEaJ6oPOaoZZo_XMpywHCzFWSYCrKG=srEDpCqPRp=Dw@mail.gmail.com>
Subject: Re: [REGRESSION] ublk: dispatched IO intermittently never posts its
 fetch completion (v7.0)
To: Luciano Lo Giudice <lmlogiudice@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, linux-block@vger.kernel.org, 
	io-uring@vger.kernel.org, regressions@lists.linux.dev, axboe@kernel.dk, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 8:26=E2=80=AFPM Luciano Lo Giudice
<lmlogiudice@gmail.com> wrote:
>
> Hello everyone,
>
> Using Bernd's repo, I was _unable_ to reproduce the bug after several
> runs (it used to hang in about 1 out of 3 runs). I had to add a small
> compat layer to make the module build in 7.0, but it was overall
> pretty easy. I will be now using this module for any development on
> 7.0 (thanks, Bernd!) and will report if any other issues arise.

I can't reproduce it on 7.4-rc, and we did merge many similar fixes recentl=
y.
Unfortunately, 7.0 isn't a stable release, so can you move to 7.3
stable release?
Otherwise, you may have to sort out the backport by yourself.

Thanks,
Ming


>
> All the best,
> Luciano.
>
> On Fri, Nov 20, 2026 at 8:40=E2=80=AFPM Luciano Lo Giudice
> <lmlogiudice@gmail.com> wrote:
> >
> > Hello Bernd,
> >
> > Yes, I can do that. I'll go ahead and compile ublk_drv from your repo
> > for the 7.0 backport and see how that goes.
> >
> > All the best,
> > Luciano.
> >
> > On Fri, Nov 20, 2026 at 8:27=E2=80=AFPM Bernd Schubert <bernd@bsbernd.c=
om> wrote:
> > >
> > >
> > >
> > > On 11/20/26 23:55, Luciano Lo Giudice wrote:
> > > > From: Luciano Lo Giudice <lmlogiudice@gmail.com>
> > > > To: linux-block@vger.kernel.org, io-uring@vger.kernel.org
> > > > Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
> > > >     stable@vger.kernel.org, regressions@lists.linux.dev
> > > > Subject: [REGRESSION] ublk: dispatched IO intermittently never post=
s its
> > > >  fetch completion (v7.0)
> > > >
> > > > Hello everyone,
> > > >
> > > > I'm writing a library that implements various block devices in user=
space by
> > > > utilizing the ublk framework. Every so often, I'm hitting a complet=
ion loss on
> > > > Linux 7.0, in which an inflight request is lost forever, which lead=
s to an
> > > > unkillable process and a ublk block device that cannot be torn down=
, and so the
> > > > machine needs to be rebooted to remedy this. I've tested the attach=
ed reproducer
> > > > on 6.8, but found no hangs after many runs. Details of the bug are =
below.
> > >
> > > Hi Luciano,
> > >
> > > I just scanned the io-uring list and found this by accident. I have b=
een
> > > working on this for a couple of month.
> > >
> > >
> > > Would you be open to test a specific branch or dkms module? I actuall=
y
> > > wanted to send this to upstream last months already, but then found a=
nd
> > > fixed (with a lot of AI help) more issues and also got busy with othe=
r
> > > tasks.
> > >
> > > https://github.com/bsbernd/linux/tree/ublk-stop-races-with-tests-for-=
7.3
> > >
> > > and here the backports, that also work on 7.0 (with a compat patch) a=
nd
> > > that is used for our dkms module
> > >
> > > https://github.com/bsbernd/linux/tree/niova-ublk-7.1-fix-backports
> > >
> > > The 7.3 patches are actually verified through tla+ and an ublk branch
> > > for https://github.com/brauner/linux-formal
> > >
> > >
> > > @Ming the patches for 7.3 include heavy ublk state changes (it is now=
 a
> > > bit closer to what fuse-io-uring does) and also adds debugfs that can=
 be
> > > used understand state issues.
> > >
> > >
> > > Thanks,
> > > Bernd
> > >
> > >
> > > >
> > > > 1. Environment
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > - Breaks on 7.0.0-31-generic and 7.0.0-43-generic using the kernels=
 that ship
> > > >   with Ubuntu. Tested on amd64 and the ublk_drv module.
> > > > - An identical binary was run on 6.8.0-117-generic but no hangs wer=
e reproduced.
> > > > - This was run on virtual machines provisioned with LXD and with 4 =
CPUs.
> > > > - After reading the code, I suspect the issue arises due to the 202=
5 rework (the
> > > >   list batching first appeared in 6.15 and the per-IO task tracking=
 in 6.16).
> > > >   I have not run any kernels between 6.8 and 7.0
> > > >
> > > > 2. About the attached reproducer
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > - It's a single C file that requires only liburing.
> > > > - 3 devices are loaded (2 are file-backed, the other memory-backed)=
.
> > > > - A fourth device is added, started, loaded (briefly), stopped and
> > > >   deleted in a loop while the others are under loaded. This is the
> > > >   fastest way I found to reproduce the issue.
> > > > - On 7.0, this hangs within the first 2 runs. On 6.8, no hangs were
> > > >   observed after more than 10 runs. When the issue is detected, the
> > > >   program prints what evidence it can gather (per-device inflight
> > > >   operation numbers, the running threads' waiting channels and the
> > > >   io_uring's pending CQE counts).
> > > > - Bonus: 2 additional bugs where found when shrinking the workload:
> > > >   A queue was leaking its io_uring (keeping the chardev pinned), an=
d
> > > >   START_DEV issued for a queued that had died before arming. Both s=
talled
> > > >   the program identically on 6.8 and both were fixed in the attache=
d version.
> > > >
> > > > 3. What indicates a failure (from userspace's POV)
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > >
> > > > - The issue is always connected to a READ request:
> > > >   /sys/block/ublkb$N/inflight yields "1 0" and is never modified ag=
ain.
> > > > - The thread that handles the queue is blocked in io_cqring_wait (a=
s seen by
> > > >   inspecting /proc/$TID/wchan), byt the ring has no entries to cons=
ume.
> > > > - The ublksrv_io_desc for the corresponding tag was written by the =
kernel
> > > >   at dispatch. The server reads descriptors after a CQE is posted, =
but
> > > >   this never happens.
> > > > - There is no way (AFAIK) to recover the tag. The lost completion i=
s the
> > > >   one that would set UBLK_IO_FLAG_OWNED_BY_SRV so a COMMIT_AND_FETC=
H for
> > > >   the tag is rejected (returns -EINVAL).
> > > > - Something very similar also shows on the control plane, which is =
why I
> > > >   suspect shared implementation details rather than something queue=
-specific.
> > > > - START_DEV, STOP_DEV and DEL_DEV will occassionnally never post th=
eir CQE
> > > >   after the kernel provably completes. In one capture, the deleted =
block
> > > >   device was already gone from /sys/block when the caller's 30 seco=
nds
> > > >   time bound fired. Repeated re-enters never produced the completio=
n.
> > > > - DEL_DEV was seen stalling 30-90 seconds on the kernel for operati=
ons that
> > > >   should complete instantly. The io-wq worker thread was blocked in=
:
> > > >
> > > >   ublk_ctrl_del_dev
> > > >     del_gendisk
> > > >       blk_mq_freeze_queue_wait
> > > >
> > > >   the device was stuck half-deleted, and it reacted to ADD_DEV by r=
eturning
> > > >   -EEXIST for minutes. In the worst instance it survivied its own s=
erver
> > > >   exiting and stayed un-deletable (needed a reboot).
> > > > - A START_DEV completed with -EINTR. The process was detached and a=
rms no
> > > >   signal sources. I didn't capture the pending signal set in that i=
nstance,
> > > >   so I cannot rule out a spurious signal, but the same op's immedia=
te retry
> > > >   stalled for a full 30 seconds.
> > > > - Not needed to repro the bug: COOP_TASKRUN, readahead bursts, even=
tfd wakeups.
> > > >
> > > > 4. Aftermath
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > - AFter the request is lost, teardown hangs and takes the control p=
lane with
> > > >   it. Looking at /proc/*/wchan and dmesg of a hanged instance shows=
 that the
> > > >   teardown uring command (running in an io-wq worker) is stucj in
> > > >
> > > >   ublk_stop_dev/ublk_ctrl_del_dev
> > > >     del_gendisk
> > > >       blk_unregister_queue
> > > >         elevator_set_none
> > > >           blk_mq_freeze_queue_wait
> > > >
> > > >   And the message printed by the kernel is:
> > > >
> > > >     INFO: task iou-wrk-2115:2118 blocked for more than 122 seconds.
> > > >     [...]
> > > >      ublk_stop_dev_unlocked.part.0+0x38/0x160 [ublk_drv]
> > > >      ublk_ctrl_uring_cmd+0x629/0x830 [ublk_drv]
> > > >
> > > > - Subsequent control command hangs on the control mutex:
> > > >     task iou-wrk-12720:12721 is blocked on a mutex likely owned by =
task
> > > >     iou-wrk-12626:12629.
> > > >     [...]
> > > >      ublk_ctrl_get_params+0x8b/0x190 [ublk_drv]
> > > >
> > > > - Killing the process doesn't help. The worker thread keeps waiting=
 on the
> > > >   queue and the frozen queue waits for a request whose owner (the s=
erver) is
> > > >   gone. On 7.0, ublk_timeout(...) only takes action for unprivilege=
d devices by
> > > >   SIGKILL'ing the server. On privileged processes it retursn BLK_EH=
_RESET_TIMER
> > > >   so a lost request is re-armed forever and never aborted, even whe=
n the
> > > >   server is dead.
> > > >
> > > > - When the process exits, the io_uring io-wq teardown warns while a=
 worker is
> > > >   still stuck and the process remains a zombie. The following messa=
ge is
> > > >   printed by the kernel:
> > > >
> > > >     WARNING: io_uring/io-wq.c:1370 at io_wq_put_and_exit+0x10d/0x2e=
0,
> > > >     CPU#3: live_server_ram/2115
> > > >
> > > > 5. Where I suspect is the problem
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > - Evidence points at the completion side of the 2025 rework.
> > > > - per-IO task tracking ( ("ublk: require unique task per io instead=
 of
> > > >   unique task per queue", Pure Storage, 04/2025,
> > > >   https://patchew.org/linux/20250416-ublk._5Ftask._5Fper._5Fio-v5-0=
-9261ad7bff20@purestorage.com/):
> > > >   our fetches are all submitted by the queue's own thread, so io->t=
ask
> > > >   should always match at dispatch time;
> > > > - rq_list batching: ublk_queue_rqs() coalesces same-<ctx_handle, ta=
sk>
> > > >   requests into one list and queues a single
> > > >   io_uring_cmd_complete_in_task(io->cmd, ublk_cmd_list_tw_cb) for t=
he
> > > >   whole batch. If that single task work is lost, every request in t=
he
> > > >   list strands - the observations are consistent with one lost requ=
est per
> > > >   occurrence.
> > > >
> > > > 6. Follow-ups
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > - Does this ring any bells in the 7.0 completion rework (lost task =
work
> > > >   for ublk_cmd_list_tw_cb / ublk_cmd_tw_cb, or io->task mismatch ta=
king
> > > >   a path that neither completes nor aborts)? Is a fix already in
> > > >   flight?
> > > > - Independently of the completion loss: should ublk_timeout() for
> > > >   privileged daemons fail a request whose ublk server is gone? Toda=
y
> > > >   BLK_EH_RESET_TIMER keeps a lost request - and with it the del_gen=
disk
> > > >   freeze and the control mutex - stuck forever after server's death=
,
> > > >   which turns a single lost completion into a machine-level hang.
> > > >
> > > > I can test candidate patches on 7.0.0-43 or bisect across 6.15-7.0 =
on a
> > > > VM, or capture the trace of a missing completion.
> > > >
> > > > #regzbot introduced: v6.8..v7.0
> > > >
> > > > Best regards,
> > > > Luciano
> > >



--=20
Ming Lei
