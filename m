Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F5C1548C
	for <linux-block@vger.kernel.org>; Fri, 19 Jun 2026 02:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781834838; cv=pass; b=kHVWGO+L5OOrMEh+/DLArErMXWiUFdvAfZ+0LV+JckDrNSvsg9mlxwRaR9aGJnQ+Qce1IEeMB/z3XvQIjcWvrTlB7X/U+A0j63vGITOqw8h9mltwG3vtRrm8GAw48JFr+uugDVSYOBAXWNVoVIeQGlJaF7F0sbb60dlbcDf3Sf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781834838; c=relaxed/simple;
	bh=+lAwZdOEr368mWww2qJWPQl/+LHxqo2IoMsWTLJ8lbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPyXJdVpSihG0O8FQYgythRhYXHrrHW13gR3dXy95tnbZt3sMiFcInk7GIkPKbuVcFlUxFYXuo2y/UqCL+FznHql3c3hSkKcd9Xqai92h8NcDMYtZQVflhj+IMedSnz9ffSslHjjHBGlVEfb8ve6L+Fy8b8vDeH2MbD59lRDh0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rk2TpAeq; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rk2TpAeq"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3997264fc55so2407211fa.3
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2026 19:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781834835; cv=none;
        d=google.com; s=arc-20240605;
        b=PgtlPiVXzsTf6aWmrlX56kVEu5svfzRnUy0c7kT9vr2SSaZ++KbEi1eIl0ddGpNeqm
         LxyjvshXXIPyHdWrZnHIBEhiF1f6kQPNvMg/9w0TC0u+Njy0lGZBTxaif4qaWC23YjnC
         haR2t3MuvwE6Y2jUsgTcLXFuf+PDfN/71UA5OI26Z1LaPFiwTiQY9hVJiZH1XW0gbbrB
         RowbQyHrFfynEuE3ROvbN3mfDYPNDJOCR+2rquSOL2oLOE0seWACF2Vun4OME9FfiOWF
         2WtNQVZa9D4Xmp85NLmKc97Qu2TYr4s4Lps4TkaWEylGuf//DRiLoWIfV3KPHFf69T2n
         kCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QN90U2KCqArXMqHd53Vv9g008WAQGYM7QLU+yCipKHQ=;
        fh=0LwI8Vn1rie3ymYGhd/61WVerHs2GihLwQIuNVG0iy8=;
        b=Dl2iKfFgnEpvYXRgM1BW3unlb3SBm5KX1EPRav78uJWGcSgWRNPP2JKt5AiM5ozNde
         irVdCDTv4dJ41q6wlR/YEuSE3NCg7fDgQYWxEmcjjH1m4uDEPSh1ny+mBwTl4gV1osd/
         0c5f0CkJbgvVU6Vx3L3lO6mVmhGuVsra2PCwpSrHgar247x6D0r+0L/ClBs/9huLTY6L
         X1/Arz1eUZPt/9nxiNtJhHGbKbJQDXPu+LUhhrnxhNVfOVKwhA3IfWQkQRPuSPXDEZk7
         ldu0nsJ9zn4dyFfpdHle2snbv+GbB2j7f8OVeEp3WW74g8U/+BYapiXItKF4M0tbq5v9
         cf5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781834835; x=1782439635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QN90U2KCqArXMqHd53Vv9g008WAQGYM7QLU+yCipKHQ=;
        b=rk2TpAeqviYZ83/pIsNcDlcHUdDbEe6uv6tzzOIztjLo/RTVf6gHso0VnKElijLHtO
         Z+MV7EbSf7lhaoBIIJ2KvhFYAETIaxpUh5RjplaOKj6wA3n2gmjUxdUl+L8t01Z61HcE
         fCNdRYK8fPwhOtQGnupA1j5I7BG8BAVn/gPLspy1PonsHzAjizW9AEwI8+uqDkEBBo6V
         S2c32CJLzsgYqizcJoTmK+RYY+1GMTS8Zv595VocFHBg0DuT3nv5ZiT86sBqhmjcDw3e
         SahYNHLkHs3Cssew1UYQCDTv9P0tDd72PcKf8QSkrCQDg/5ugaSSPh6erLo0RJeme9TY
         m8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781834835; x=1782439635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QN90U2KCqArXMqHd53Vv9g008WAQGYM7QLU+yCipKHQ=;
        b=Xx2DeBfjuXGCxBR48/t+SQS9h/qxUmUxArtzj5Ty6fa9WxRnLlTpbe0p/7etCvdaW2
         31BRd3LUg++tCGGcrAMqtFpJLZLekiqEBGWRPpDJ9w7/bt6LNnmq11vkKCDlymu+64DR
         vJWYO3BkYnHdE4SqwZJAZU3QqoYLHLa8O5OhpnDbN7TyLp7psB8bog/hDl1gn7P14wcH
         uvBY4y2JsywPQdwvmznCG+cmQ3zmJlqzAe4ZeR8bAkDpU/ef2ZVITp1RQGjpIOxuD2+O
         wfSPPslYhp791uSBtVoPVli7EWoZsgoiNKRKeidjAXCGaSpDUC4f2BFadTSTu+MRSugb
         lnZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fF9t1D1lcNDud0aDDEN3gEp+FEB8AWhy4yqrJYFSciun9HsT8QmzdR31v4/mRNLpbagaJ5Q2oDr9icw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1HW6mAszxO/tBCdVfzaRN4783pf25g4/aLCFjKvdnKVsPuBrD
	YObm2Rm6pk60Pz9qQgeiWrDRaRaf4zLluPFLJoREnCKFH2r05p+FxTmFrR7Q2TsY1B/M2y6jnKW
	FUAIwFQY/8uj4uclYZ4mUX5hh+Wmfik8=
X-Gm-Gg: AfdE7ck+vMRA5l6wgfJ9rY8+7cUkm7WJncJnB7kj8GvaaVzuOTfPXMT31I1/4OHWvU1
	puiCafoHhNGi5NudT+JYFPN6g8j99J+OqZbU+HW+/LJYPVIeNfn9io/1s+gezkfF+xX7FI7kuqw
	bzB42nPGNXgT1ZMbVca644Da6lqqya9lVqbi7NhQ7klcJUqHjTRxnp2g+nC5/Chg2/EPBoe2DIC
	PCzUpqQZIkiWBejuuPcjgSor8V18kZ7PvEwR626/W941tRx6PG/rPpSgAnHYKTG1s5sWEsvsJX1
	nYbTQ0jxnyUx9aUKZec9J3D5x+4bKw==
X-Received: by 2002:a05:6512:3d0e:b0:5ad:d4f:4088 with SMTP id
 2adb3069b0e04-5ad562ebe8emr245066e87.5.1781834834988; Thu, 18 Jun 2026
 19:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616150554.1686662-1-kbusch@meta.com> <20260616150554.1686662-2-kbusch@meta.com>
 <ajGN1OKun3qyvqMc@gallifrey> <ajGacnaCZ6v6VE1B@kbusch-mbp>
 <ajGtbuJ2kXo1GZ1d@gallifrey> <ajK4YacvP7eQ-S2o@kbusch-mbp>
 <ajK-Y7uoK0QT5PVl@gallifrey> <ajLJiOwim7qBp_0P@kbusch-mbp>
 <ajLO80kZmFnyR2mH@gallifrey> <ajLRTkSZJ0WCYNk4@kbusch-mbp> <ajLSaiKXWIekcA97@gallifrey>
In-Reply-To: <ajLSaiKXWIekcA97@gallifrey>
From: Vjaceslavs Klimovs <vklimovs@gmail.com>
Date: Thu, 18 Jun 2026 19:07:03 -0700
X-Gm-Features: AVVi8CcwrDXFH9lG8MvQYBwBXKdIimW6ILBVKjqonKiYaALRjDRi14XoN5Nro2Y
Message-ID: <CAC_j7i3uL8mHgS=QRYwuD3DMK9_VasSyBmQ10igKvFP2kwKtXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dm-raid1: don't fail the mirror for invalid I/O errors
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Keith Busch <kbusch@kernel.org>, regressions@leemhuis.info, 
	Keith Busch <kbusch@meta.com>, dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	mpatocka@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 08:05:53AM -0700, Keith Busch wrote:
> For DM_IO_BIO requests, do_region() built each destination bio by walking
> the source bio's biovec and re-adding the pages one at a time, tracking
> the remaining transfer in sectors.

Thanks Keith, this clears the dm-mirror hang for me.

I reproduced the original regression in a nested-QEMU harness: an LVM
legacy mirror LV (lvcreate --type mirror -m1, core log) on virtio-blk
PVs, used as the backing disk of a nested guest that issues misaligned
O_DIRECT reads via virtio-blk with cache=3Dnone,aio=3Dnative.

Without this series, on v7.1-rc7 (424280953322), the mirror read path
splats and then wedges:

  device-mapper: raid1: Mirror read failed from 252:0. Trying
alternative device.
  WARNING: block/bio.c:1044 at bio_add_page+0x108/0x200, CPU#1: kworker/1:1
  Workqueue: kmirrord do_mirror
  RIP: 0010:bio_add_page+0x108/0x200

kmirrord then stays stuck in do_mirror and the I/O never completes (the
guest hangs indefinitely).

With 1/2 and 2/2 applied on the same base, the WARN is gone, kmirrord no
longer wedges, the array is not degraded, and the misaligned O_DIRECT
read now completes normally instead of hanging. The --type raid1 (dm-raid
on md/raid1) variant of the same test is also clean.


On Wed, Jun 17, 2026 at 9:59=E2=80=AFAM Dr. David Alan Gilbert
<linux@treblig.org> wrote:
>
> * Keith Busch (kbusch@kernel.org) wrote:
> > On Wed, Jun 17, 2026 at 04:44:35PM +0000, Dr. David Alan Gilbert wrote:
> > > (It's a bit scary you're having to go around quite
> > > a few places and make similar fixes; I assume there
> > > are others that do similar things).
> >
> > Yes, I understand that. I'm looking into a common way to validate this.
> > The md raid doesn't have this problem because they always call
> > bio_split_to_limits() first, but that's not an optimal thing to do for
> > dm raid in the normal read/write path, so perhaps a common checker need=
s
> > to happen generically in the block layer. Yeah, I know I removed the
> > previous higher level validation ... I'll try find something less costl=
y
> > than what we had before.
>
> OK, thanks again
> (and to Thomas for gluing my query to those other two which got this
> moving!)
>
> Dave.
> --
>  -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
