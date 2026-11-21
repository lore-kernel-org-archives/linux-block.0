Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795283587;
	b=ltxFrwLB2L8NZvWe5xovlVAKOfI0ipgmovAIFrIPgNYLEE2FfzC8qIxpOCJswrOqAA2a
	 zpxCCSlWleyCMY7IJPBq1kTawDc51wm62p65/dKRrrkwgMAQ9fwbjS6nj1g9xUBhBB3m7
	 szhGPnO7VMvAnpyLiF+pPpjvzbEqNfcY6TEg3A8+IKfTwDVnXNgeUr7HISRvURWl4FH5a
	 Egq0HjDLHHah8XpeUh/IeWyFiE4Rb9cDz9b9ojxCLe85vjAUuIzMNulnrxfV2u9OYbccL
	 b6zIW1uSSqmZ0mqXUjfu5ALV3iRa1nIxR9Hf1gP/0VIl+8Ebaf/Bzj5Qs/CaI/Xpunw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795283587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3GVBKnEvVzO5eniKkH3p5YWrA2bZ/HsDBEwwsELK9/s=;
	b=WGP0GLRfFVdRyjn/Fz6uauB2Ow9s6Jab0x5dWtNbFkf+2bZA7g902J/MZuOrMoD1PPhh
	 6eG7WfxgPvlMA2BAxCXC+jbnu6kDLpk0APg4ILBK97nvnmSTexNCn9AKSv6cjltfB5eTq
	 hEXEX9vlD/59caktKFJwAqTcf2WH/CC8cEChMz5gB3P5SxlvHg5hEow9T4++O+KEPPMQA
	 4YVfHDc1hxVzf3mZtF1tMtbuJ7LcfOlm8VgCewl21hIjBlNdCTy0mx5j0GYAK42jo6NPw
	 5N3y9Dut6htw7ZdwWg0XyDMKBaH+xh9skAwDgIQ1qFKYoo3BYY6h3DfsOTEpT/rhhkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O27CPOga;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE48606A32C
	for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 17:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FE48606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O27CPOga
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67db8985419so2620848d50.1
        for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 09:53:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795283585; cv=none;
        d=google.com; s=arc-20260327;
        b=R1fwC5bZIEzL18tIvcc4rpNGsq3DsUgrllFPEIyEcXEEvFB3lR1kjbzGLjF8DWARMc
         dafm2AMKHtSTzW52h4YgNiTh/buLZSDhRDpZwnVbmG012lpjNgIRBCJCqkwAxKE9FpHd
         uPBQbrsvUsiXj6eQbvC8Z6/yyAjAAabE/A16bDC//JwNNUYE/7iMAzJpqhFVX15d2nUq
         4VW1cmY+qbd2QDpuU5Coa1Rj2xDEAUIBVyZCFCMYwH+y573PHpH0Ug+Dz+3w+zwrVygb
         X0Z0gEp1AHsBxdW86HLOvy7zsnxTnVAgvIdR/6Ibh94lXHho3xN9sxi9eE8ysR1AVkUo
         l/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3GVBKnEvVzO5eniKkH3p5YWrA2bZ/HsDBEwwsELK9/s=;
        fh=Limg5txgyYndrpjgkEs4l+iECsBZfc1FrCLWw9c5Yzs=;
        b=juRJzhxvNl2ffYb035xCPdNNb8CTMvKzwLQiFlBBL1IllnTA1FYtkhofpTrHcrL6wJ
         z1xn/5l6bTMXpj9dyhv8pUNSlRgUKp+E55XPW9wOQmJkNHR3XzyhcDnfGG5JAerV/iEk
         K3rbjAus5NXPuh+PdghnI5CTeLaDprAVAJpll/CsJK/91aNxbHV/lEmrwQI+pp68/44/
         vDruyfGIGyCqVuZEjfBLjXrhZGjl2zQVWse1qt0eq2+XdOstMTKs+oniGJWoQJU2sLAX
         +XKozYqK9FIvPcP+5SNeEan0dGJj7L9QhxYID6DJnIg3B2JoQW5jDz/J54edkEHD51Nt
         iJfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795283585; x=1795888385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3GVBKnEvVzO5eniKkH3p5YWrA2bZ/HsDBEwwsELK9/s=;
        b=O27CPOgazpi+ot4rkSp+v6GIl48Qj6qPbHEZ1L3s7f8nxgIIPLxDM+jilS+4vnDg1i
         aK3/pjC2x1lDW6ZBY8CQetOXM84GfYalftdbuMMUC9mY05o90uuLS3F/HlgriZmdIaXk
         h66+8Bq/PIOKS7ELMBQY1HrKmcX8RC65X8Y4zNEhBgmVTbEN/8xp6ptbRPXZtDGpyZRb
         VgQRI67zb+GBYBSXg3+bnkAxutQYUXFdCWrdJdP85dcx2A6FY7qaTF7lY+0106qt7Bue
         b60lg2EzBpKNHF3TwKddXjibkCRx5s42qdsKoHV+E2JaECba+xf03OpomnqCVnzYR/8u
         oUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795283585; x=1795888385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3GVBKnEvVzO5eniKkH3p5YWrA2bZ/HsDBEwwsELK9/s=;
        b=dL4+Ym3RmiZzshCXlf5xweleuE6eekUBzrXU7SGzjZc2wg4f4KXsChRPdGYgzfivu4
         51bg3HH//v3eBGHQXcyXtxR2JHheTICSfo3Nl6ufAcRNmLWTYfOiyYQfm3H4XrcsdBUz
         URgksMo1Fzm0UZurki0AL8ZLutmOyGtm8QQw02ogmzm2+OdhJhClBSPPjNnmH+QXEads
         RFlipKpjuMtpf+rglU+IdQ3J3rFDr1jZuT70AdkU0SAW6YVyzUSmFvjsjhYUa5DsKozB
         yHdPat5GIVTN2sV/5bX5ICyq2NVq4Qy6SnQiirLoSP3QkGKPJFRT9ApR5ztknuWuxqnH
         8hCg==
X-Forwarded-Encrypted: i=1; AL+hErHG25iacj0Gz6lNwgA9G3GQ8eF1gv4H+5i0uhtHJ5kF1Ja+7Pfu+3JCJEVfd89Vd7/S0bNUwmNTgP2nDA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+BuMfxfARILlAUrDbmZTcQrnBVuOqnAGR8dbvT3EKab72v/mrh
	IXxvZiOpvuSCdFWFEAgdOJs2FLrXt7wMvbwRMDH7BCYBEjkVT5RuxDDFNFceOtCMgC+/4a6Ogav
	WR31B99kgoQmcgHPrXyzhjRLVOq9iA/s=
X-Gm-Gg: AZFdTZdb+ic2iLb5XSm9Y2nVh45YzkX4gQg7AU2RHTuzTZSFeazTUnxAT6as3gqBHvx
	95VCMWOnvV21Yu07SMWBKPbNj8SO7leEsXtwOScLAXFxdd6MRj4gxWwHLvt5f7hS+EwxrSpMdy4
	ZGsRZiJRGY3hdB4GOX7j8ErnF/RbDFiy13+ZVhyPWEBQwVq8K72gLl6i/7AmeMDOCJ5u38YvAcl
	jeEhgkjadcAMoZ9TovVPgiLXyfctMo/SjWtwn+TxPHrAB25JpJRTLZ8ED1NlIQvf1jGZURDx31S
	vACg4aJz8zJQheiXbKYyTnfRehvyC1oa0peJfdABUHMHL/WIdyBOtbaNnta2xJe0/XO9PuYhp4l
	2UmCWMRK8zAPIrsqQGN0554mM/dXM4BEd5oI=
X-Received: by 2002:a05:690e:419c:b0:679:f97f:fdf6 with SMTP id
 956f58d0204a3-67df448c769mr2372917d50.66.1795283585556; Sat, 21 Nov 2026
 09:53:05 -0800 (PST)
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
 <CAFS5DSEsdz8Eu1vmeCkE+6eeXgk+9yS6EwqyHSeD2jkq90DZaA@mail.gmail.com> <CACVXFVPEaJ6oPOaoZZo_XMpywHCzFWSYCrKG=srEDpCqPRp=Dw@mail.gmail.com>
In-Reply-To: <CACVXFVPEaJ6oPOaoZZo_XMpywHCzFWSYCrKG=srEDpCqPRp=Dw@mail.gmail.com>
From: Luciano Lo Giudice <lmlogiudice@gmail.com>
Date: Sat, 21 Nov 2026 14:52:53 -0300
X-Gm-Features: Aa3M54r6reYAtN06M1ZwSGTa3uJCDCA6gB7GWyRDqP3xh-2RmbBELTckYCoPkTg
Message-ID: <CAFS5DSEp13YPLwRut2OiQfQqO70s6whbLWmEQ14mt8_JjBfBRw@mail.gmail.com>
Subject: Re: [REGRESSION] ublk: dispatched IO intermittently never posts its
 fetch completion (v7.0)
To: Ming Lei <tom.leiming@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, linux-block@vger.kernel.org, 
	io-uring@vger.kernel.org, regressions@lists.linux.dev, axboe@kernel.dk, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ming,

Thank you for confirming the apparent fix in 7.4 as well. Do I
understand correctly that no fixes to address this problem will be
backported to 7.0?

All the best,
Luciano.

On Sat, Nov 21, 2026 at 2:23=E2=80=AFAM Ming Lei <tom.leiming@gmail.com> wr=
ote:
>
> On Fri, Nov 20, 2026 at 8:26=E2=80=AFPM Luciano Lo Giudice
> <lmlogiudice@gmail.com> wrote:
> >
> > Hello everyone,
> >
> > Using Bernd's repo, I was _unable_ to reproduce the bug after several
> > runs (it used to hang in about 1 out of 3 runs). I had to add a small
> > compat layer to make the module build in 7.0, but it was overall
> > pretty easy. I will be now using this module for any development on
> > 7.0 (thanks, Bernd!) and will report if any other issues arise.
>
> I can't reproduce it on 7.4-rc, and we did merge many similar fixes recen=
tly.
> Unfortunately, 7.0 isn't a stable release, so can you move to 7.3
> stable release?
> Otherwise, you may have to sort out the backport by yourself.
>
> Thanks,
> Ming
>
>
> >
> > All the best,
> > Luciano.
> >
> > On Fri, Nov 20, 2026 at 8:40=E2=80=AFPM Luciano Lo Giudice
> > <lmlogiudice@gmail.com> wrote:
> > >
> > > Hello Bernd,
> > >
> > > Yes, I can do that. I'll go ahead and compile ublk_drv from your repo
> > > for the 7.0 backport and see how that goes.
> > >
> > > All the best,
> > > Luciano.
> > >
> > > On Fri, Nov 20, 2026 at 8:27=E2=80=AFPM Bernd Schubert <bernd@bsbernd=
.com> wrote:
> > > >
> > > >
> > > >
> > > > On 11/20/26 23:55, Luciano Lo Giudice wrote:
> > > > > From: Luciano Lo Giudice <lmlogiudice@gmail.com>
> > > > > To: linux-block@vger.kernel.org, io-uring@vger.kernel.org
> > > > > Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
> > > > >     stable@vger.kernel.org, regressions@lists.linux.dev
> > > > > Subject: [REGRESSION] ublk: dispatched IO intermittently never po=
sts its
> > > > >  fetch completion (v7.0)
> > > > >
> > > > > Hello everyone,
> > > > >
> > > > > I'm writing a library that implements various block devices in us=
erspace by
> > > > > utilizing the ublk framework. Every so often, I'm hitting a compl=
etion loss on
> > > > > Linux 7.0, in which an inflight request is lost forever, which le=
ads to an
> > > > > unkillable process and a ublk block device that cannot be torn do=
wn, and so the
> > > > > machine needs to be rebooted to remedy this. I've tested the atta=
ched reproducer
> > > > > on 6.8, but found no hangs after many runs. Details of the bug ar=
e below.
> > > >
> > > > Hi Luciano,
> > > >
> > > > I just scanned the io-uring list and found this by accident. I have=
 been
> > > > working on this for a couple of month.
> > > >
> > > >
> > > > Would you be open to test a specific branch or dkms module? I actua=
lly
> > > > wanted to send this to upstream last months already, but then found=
 and
> > > > fixed (with a lot of AI help) more issues and also got busy with ot=
her
> > > > tasks.
> > > >
> > > > https://github.com/bsbernd/linux/tree/ublk-stop-races-with-tests-fo=
r-7.3
> > > >
> > > > and here the backports, that also work on 7.0 (with a compat patch)=
 and
> > > > that is used for our dkms module
> > > >
> > > > https://github.com/bsbernd/linux/tree/niova-ublk-7.1-fix-backports
> > > >
> > > > The 7.3 patches are actually verified through tla+ and an ublk bran=
ch
> > > > for https://github.com/brauner/linux-formal
> > > >
> > > >
> > > > @Ming the patches for 7.3 include heavy ublk state changes (it is n=
ow a
> > > > bit closer to what fuse-io-uring does) and also adds debugfs that c=
an be
> > > > used understand state issues.
> > > >
> > > >
> > > > Thanks,
> > > > Bernd
> > > >
> > > >
> > > > >
> > > > > 1. Environment
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > - Breaks on 7.0.0-31-generic and 7.0.0-43-generic using the kerne=
ls that ship
> > > > >   with Ubuntu. Tested on amd64 and the ublk_drv module.
> > > > > - An identical binary was run on 6.8.0-117-generic but no hangs w=
ere reproduced.
> > > > > - This was run on virtual machines provisioned with LXD and with =
4 CPUs.
> > > > > - After reading the code, I suspect the issue arises due to the 2=
025 rework (the
> > > > >   list batching first appeared in 6.15 and the per-IO task tracki=
ng in 6.16).
> > > > >   I have not run any kernels between 6.8 and 7.0
> > > > >
> > > > > 2. About the attached reproducer
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > - It's a single C file that requires only liburing.
> > > > > - 3 devices are loaded (2 are file-backed, the other memory-backe=
d).
> > > > > - A fourth device is added, started, loaded (briefly), stopped an=
d
> > > > >   deleted in a loop while the others are under loaded. This is th=
e
> > > > >   fastest way I found to reproduce the issue.
> > > > > - On 7.0, this hangs within the first 2 runs. On 6.8, no hangs we=
re
> > > > >   observed after more than 10 runs. When the issue is detected, t=
he
> > > > >   program prints what evidence it can gather (per-device inflight
> > > > >   operation numbers, the running threads' waiting channels and th=
e
> > > > >   io_uring's pending CQE counts).
> > > > > - Bonus: 2 additional bugs where found when shrinking the workloa=
d:
> > > > >   A queue was leaking its io_uring (keeping the chardev pinned), =
and
> > > > >   START_DEV issued for a queued that had died before arming. Both=
 stalled
> > > > >   the program identically on 6.8 and both were fixed in the attac=
hed version.
> > > > >
> > > > > 3. What indicates a failure (from userspace's POV)
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > > >
> > > > > - The issue is always connected to a READ request:
> > > > >   /sys/block/ublkb$N/inflight yields "1 0" and is never modified =
again.
> > > > > - The thread that handles the queue is blocked in io_cqring_wait =
(as seen by
> > > > >   inspecting /proc/$TID/wchan), byt the ring has no entries to co=
nsume.
> > > > > - The ublksrv_io_desc for the corresponding tag was written by th=
e kernel
> > > > >   at dispatch. The server reads descriptors after a CQE is posted=
, but
> > > > >   this never happens.
> > > > > - There is no way (AFAIK) to recover the tag. The lost completion=
 is the
> > > > >   one that would set UBLK_IO_FLAG_OWNED_BY_SRV so a COMMIT_AND_FE=
TCH for
> > > > >   the tag is rejected (returns -EINVAL).
> > > > > - Something very similar also shows on the control plane, which i=
s why I
> > > > >   suspect shared implementation details rather than something que=
ue-specific.
> > > > > - START_DEV, STOP_DEV and DEL_DEV will occassionnally never post =
their CQE
> > > > >   after the kernel provably completes. In one capture, the delete=
d block
> > > > >   device was already gone from /sys/block when the caller's 30 se=
conds
> > > > >   time bound fired. Repeated re-enters never produced the complet=
ion.
> > > > > - DEL_DEV was seen stalling 30-90 seconds on the kernel for opera=
tions that
> > > > >   should complete instantly. The io-wq worker thread was blocked =
in:
> > > > >
> > > > >   ublk_ctrl_del_dev
> > > > >     del_gendisk
> > > > >       blk_mq_freeze_queue_wait
> > > > >
> > > > >   the device was stuck half-deleted, and it reacted to ADD_DEV by=
 returning
> > > > >   -EEXIST for minutes. In the worst instance it survivied its own=
 server
> > > > >   exiting and stayed un-deletable (needed a reboot).
> > > > > - A START_DEV completed with -EINTR. The process was detached and=
 arms no
> > > > >   signal sources. I didn't capture the pending signal set in that=
 instance,
> > > > >   so I cannot rule out a spurious signal, but the same op's immed=
iate retry
> > > > >   stalled for a full 30 seconds.
> > > > > - Not needed to repro the bug: COOP_TASKRUN, readahead bursts, ev=
entfd wakeups.
> > > > >
> > > > > 4. Aftermath
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > - AFter the request is lost, teardown hangs and takes the control=
 plane with
> > > > >   it. Looking at /proc/*/wchan and dmesg of a hanged instance sho=
ws that the
> > > > >   teardown uring command (running in an io-wq worker) is stucj in
> > > > >
> > > > >   ublk_stop_dev/ublk_ctrl_del_dev
> > > > >     del_gendisk
> > > > >       blk_unregister_queue
> > > > >         elevator_set_none
> > > > >           blk_mq_freeze_queue_wait
> > > > >
> > > > >   And the message printed by the kernel is:
> > > > >
> > > > >     INFO: task iou-wrk-2115:2118 blocked for more than 122 second=
s.
> > > > >     [...]
> > > > >      ublk_stop_dev_unlocked.part.0+0x38/0x160 [ublk_drv]
> > > > >      ublk_ctrl_uring_cmd+0x629/0x830 [ublk_drv]
> > > > >
> > > > > - Subsequent control command hangs on the control mutex:
> > > > >     task iou-wrk-12720:12721 is blocked on a mutex likely owned b=
y task
> > > > >     iou-wrk-12626:12629.
> > > > >     [...]
> > > > >      ublk_ctrl_get_params+0x8b/0x190 [ublk_drv]
> > > > >
> > > > > - Killing the process doesn't help. The worker thread keeps waiti=
ng on the
> > > > >   queue and the frozen queue waits for a request whose owner (the=
 server) is
> > > > >   gone. On 7.0, ublk_timeout(...) only takes action for unprivile=
ged devices by
> > > > >   SIGKILL'ing the server. On privileged processes it retursn BLK_=
EH_RESET_TIMER
> > > > >   so a lost request is re-armed forever and never aborted, even w=
hen the
> > > > >   server is dead.
> > > > >
> > > > > - When the process exits, the io_uring io-wq teardown warns while=
 a worker is
> > > > >   still stuck and the process remains a zombie. The following mes=
sage is
> > > > >   printed by the kernel:
> > > > >
> > > > >     WARNING: io_uring/io-wq.c:1370 at io_wq_put_and_exit+0x10d/0x=
2e0,
> > > > >     CPU#3: live_server_ram/2115
> > > > >
> > > > > 5. Where I suspect is the problem
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > - Evidence points at the completion side of the 2025 rework.
> > > > > - per-IO task tracking ( ("ublk: require unique task per io inste=
ad of
> > > > >   unique task per queue", Pure Storage, 04/2025,
> > > > >   https://patchew.org/linux/20250416-ublk._5Ftask._5Fper._5Fio-v5=
-0-9261ad7bff20@purestorage.com/):
> > > > >   our fetches are all submitted by the queue's own thread, so io-=
>task
> > > > >   should always match at dispatch time;
> > > > > - rq_list batching: ublk_queue_rqs() coalesces same-<ctx_handle, =
task>
> > > > >   requests into one list and queues a single
> > > > >   io_uring_cmd_complete_in_task(io->cmd, ublk_cmd_list_tw_cb) for=
 the
> > > > >   whole batch. If that single task work is lost, every request in=
 the
> > > > >   list strands - the observations are consistent with one lost re=
quest per
> > > > >   occurrence.
> > > > >
> > > > > 6. Follow-ups
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > - Does this ring any bells in the 7.0 completion rework (lost tas=
k work
> > > > >   for ublk_cmd_list_tw_cb / ublk_cmd_tw_cb, or io->task mismatch =
taking
> > > > >   a path that neither completes nor aborts)? Is a fix already in
> > > > >   flight?
> > > > > - Independently of the completion loss: should ublk_timeout() for
> > > > >   privileged daemons fail a request whose ublk server is gone? To=
day
> > > > >   BLK_EH_RESET_TIMER keeps a lost request - and with it the del_g=
endisk
> > > > >   freeze and the control mutex - stuck forever after server's dea=
th,
> > > > >   which turns a single lost completion into a machine-level hang.
> > > > >
> > > > > I can test candidate patches on 7.0.0-43 or bisect across 6.15-7.=
0 on a
> > > > > VM, or capture the trace of a missing completion.
> > > > >
> > > > > #regzbot introduced: v6.8..v7.0
> > > > >
> > > > > Best regards,
> > > > > Luciano
> > > >
>
>
>
> --
> Ming Lei
