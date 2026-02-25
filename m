Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB42239281E
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014528; cv=pass; b=mdNuJylFgPpCIZ/ARY0ivPVURqlFxwTmr7K2yqlMx2VSHPNbBYd6r8n6D3SHFX9RkT9a+eIby0OmSPMjmU380fMs7A3nZOV0Nv5mFrsB3eB4UmdJAKdkWWmfeVg/UXAWw2w6Q987vx47Fdf3XEqFbiujkxGFtnLhUrDKSSa6qpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014528; c=relaxed/simple;
	bh=cEhN1Iv+3+5AHAwjY+4bbx1KSfiXSQ19i96bxSRH5p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jV5EzN8ioqqP0InfIYUO8PGWJFeNsYTiHl8vjAAdVPLG8PgUuaGs2P5GjHQd+SLntOhjUr1Eo9u7l6tg6sHhfGwQLiVGH/2vntU2wccUG8S+hTcalRz0xJ4M24A7s8mFiwxBh8/jZZbOiq2yuTs5Oy8do1LpQpXtPP4fFszC4Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UwmxbtOV; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UwmxbtOV"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38709888abbso51810551fa.1
        for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 02:15:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772014522; cv=none;
        d=google.com; s=arc-20240605;
        b=RqwpzoljoaxuXXHEkr9Fxh90TiYWV3VXON0o+cU3Aghyv5YoVqfcEWvQ0iBd/c4PrJ
         G+i8Yn/WeRIb2W7UBOHFr9eWrW38hp+vDH5fJvpEwbL7jxu3hcGPwzww9GFZVdN7QZbs
         qJkgoPq30wLI/fdIIXw5qEeh1yrBWRyYBV1brVR7HyDXldYHChv+UTlVl30Cq/bIaJt9
         4AvQoXINbS3lCwZAVc8HsaGnqPXp9ElIdwE3hT4tgD4VRPvEyNJiz/GMfFm1VXFTzwQ6
         Jc06u+gidYEIleLu66MzNT3TmE4TwQlFR/PwgdXfsohQL9826fHlPBu9zEB+CYzfqtlg
         9gtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2wbI3HVGAdmJBOB+Q2PfG58Jqhmlw+640Tj7L991s1k=;
        fh=1PyFGN5c46j4dar3+iKnjtWwaj2ILIXNJHmoHW++gAE=;
        b=io7W6NFi9l8H5h9OnLTB1kEwE71P5pBBRJueGlkiTs1lP0GVNkh6pUHQBWhrVOsEVQ
         3ruxC1czWokNqGQZqr4Ft78DVAYxQ+/3bm2r3+01V+zi5bXSe2SRCpf5iutjO79fgsqh
         JvZQkyvqmemIGB6bFLMCP5f3sbMxkcMdojtB4JW9cV5iRm2yptRnV+Oo5THwr2BTuLkj
         lAyQfYEyDFSrEwY2D43Y018ekF8qEOfC7Zgd7w6PlPf8r6LCetzMy4pytSPnNFn6K1iz
         0koYVKV9Czs1y+hfhqXapm4DpU5R/3dP+K8TjZ96m9dUo/hWqmdaerLmS4CmQxFvCi/B
         Fs9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1772014522; x=1772619322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wbI3HVGAdmJBOB+Q2PfG58Jqhmlw+640Tj7L991s1k=;
        b=UwmxbtOV/nmBYuGKi6UEDOpjEpvqRBEHYzg6GXhGFuCv6F2c0ln5jRhSEuGWXMEIas
         ZGbF66mk1OBxyZTgEzdiq9SqaR6dkIUffoTe3ofa+8HgaJFzpC/yLt32HJBx73UmMB9r
         RlGPIsC6Gt32pLnpp4Ek19kkYGsNPcGCZFrBt+WLj4sBWaioDuOe+1Vh7oBMuIAUmyLX
         2Ss/ANz3rtwZUZsvzXZjGAYkhtTJSKsvR62bhCpCJkMlOXGSPYAgCMgc/ooJRgfRkVTI
         Zp/Sm1X3mB4H/9EnvLBwsS8QH2ewFtV+LLo5BYzDGJiBRc+AyHg042erl0IVfydZyCM7
         1Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772014522; x=1772619322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2wbI3HVGAdmJBOB+Q2PfG58Jqhmlw+640Tj7L991s1k=;
        b=S35UeJiAEb7EzIX7PZXmDAWOCpmVQPCngnz884MFTJzkaJzRGeM9Tf2rmni8XPNsrP
         11XIwIF+yBxZ4rqaSfFnBDBlmxgd8Nml3Gy40BrNpdopY4XKeh1G6K3G/JLu8dzD4EUr
         YE/Cp507J1nv5RoNsJt2ussqFjpJmFewvpyO1G80Jox+KXbpGB9xh+qeDkw3odeyYbxG
         +BklnLCd7So7APR0oK1P4Aogz3T3ewu+bMeEZG3VAYM89updLKlIv6YnWou65eEh52gG
         nNRnojMS0eAZJz+xdmF6MjU1VHEYKWwyuhwBv2xwx7m7+sK9MqEQSfWfrOBlTDvY8Qap
         L5rg==
X-Forwarded-Encrypted: i=1; AJvYcCWalPbLo/aTjSpMUzHRqIXv81lRo+m03r/d0VtheEfHV8dMx7MvaK5+UjYyWfeXngkd+4kft2gQRcNanA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnkMsM4vVxwr4onUXxPTbXJ7hcBeCR/KD+kjlieCghEPxQVfcK
	5v4oAaf8a/p+w3MAXVZKcJH8KKwrgq16UTs99n0MugIr0PqaH3aNbm4r2YI7S22ZS5VmAUcmoyu
	6g9kMwOMPW8YhVbr2n1aYBi4Kd48UD0rzpp7ozKQckw==
X-Gm-Gg: ATEYQzyVzjCS9/vZQpuhSuMWvrEChMUA/RpjCfaQHBKTXHDjK5oQfAUWcR1/xDtzaUL
	IImRwzYt/fyj71UNJ9LaxbRBhUjtX/YGn+Z3Y8zP749w5jNxp0Uj6F+zukxf4KbOGvMeS8Xzbrd
	iZMwa/M7fCf/1KgmjpF5ixsrOwQ02BSTxX+R2nYY3SEoLESiJ/gswKv2IC294j7DA01CoIQzWt8
	wV3MqnhNGuPi8aG13h6URhgnRQpgxgNAzS7wCQfbEC/iHhFt98oLJfKfY+HeGZpwUjYN6ccCDbE
	hTLRBeZU4/KC73bddUJVMsod2+0R6R2qu4s9GDJFhtUilKcdDE9TgiAG9zr4vtGMb2aq
X-Received: by 2002:a05:651c:981:b0:385:9b50:91a8 with SMTP id
 38308e7fff4ca-389a5d4e691mr49137391fa.15.1772014521621; Wed, 25 Feb 2026
 02:15:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local> <aY77ogf5nATlJUg_@shinmob>
 <CAJpMwyis1iZB2dQMC4VC8stVhRhOg0mfauCWQd_Nv8Ojb+X-Yw@mail.gmail.com> <ae47ef06-3f66-4aab-b4ab-f3ae2b634f87@wdc.com>
In-Reply-To: <ae47ef06-3f66-4aab-b4ab-f3ae2b634f87@wdc.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Wed, 25 Feb 2026 11:15:10 +0100
X-Gm-Features: AaiRm526FWUEGWm_hy7H18Kx_R9h0RTFeFOS6FCw0pCWHIRaUmeSA-DegrV6Fgs
Message-ID: <CAJpMwyiys85=WG-EQtsioo3OOiRDToUh1jE18Uj2Be2JdzNXDA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, Bart Van Assche <bvanassche@acm.org>, 
	Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"sagi@grimberg.me" <sagi@grimberg.me>, "tytso@mit.edu" <tytso@mit.edu>, Christian Brauner <brauner@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
	"willy@infradead.org" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	"amir73il@gmail.com" <amir73il@gmail.com>, "vbabka@suse.cz" <vbabka@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 8:44=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 2/15/26 10:18 PM, Haris Iqbal wrote:
> >>  From my view, blktests keep on finding kernel bugs. I think it demons=
trates the
> >> value of this community effort, and I'm happy about it. Said that, I f=
ind what
> >> blktests can improve more, of course. Here I share the list of improve=
ment
> >> opportunities from my view point (I already mentioned the first three =
items).
> > A possible feature for blktest could be integration with something
> > like virtme-ng.
> > Running on VM can be versatile and fast. The run can be made parallel
> > too, by spawning multiple VMs simultaneously.
>
> This is actually rather trivial to solve I have some pre-made things for
> fstests and that can be adopted for blktests as well:
>
> vng \
>      --user=3Droot -v --name vng-tcmu-runner \
>      -a loglevel=3D3 \
>      --run $KDIR \
>      --cpus=3D8 --memory=3D8G \
>      --exec "~johannes/src/ci/run-fstests.sh" \
>      --qemu-opts=3D"-device virtio-scsi,id=3Dscsi0 -drive
> file=3D/dev/sda,format=3Draw,if=3Dnone,id=3Dzbc0 -device
> scsi-block,bus=3Dscsi0.0,drive=3Dzbc0" \
>      --qemu-opts=3D"-device virtio-scsi,id=3Dscsi1 -drive
> file=3D/dev/sdb,format=3Draw,if=3Dnone,id=3Dzbc1 -device
> scsi-block,bus=3Dscsi1.0,drive=3Dzbc1"
>
> and run-fstests.sh is:
>
> #!/bin/sh
> # SPDX-License-Identifier: GPL-2.0
>
> DIR=3D"/tmp/"
> MKFS=3D"mkfs.btrfs -f"
> FSTESTS_DIR=3D"/home/johannes/src/fstests"
> HOSTCONF=3D"$FSTESTS_DIR/configs/$(hostname -s)"
> TESTDEV=3D"$(grep TEST_DEV $HOSTCONF | cut -d '=3D' -f 2)"
>
> mkdir -p $DIR/{test,scratch,results}
> $MKFS $TESTDEV
>
> cd $FSTESTS_DIR
> ./check -x raid
>
> I'm not sure it'll make sense to include this into blktests other than
> maybe providing an example in the README.

You're right. It is pretty trivial to run on VMs, but only after
everything is set up.
Adding it to blktests would allow this setup to be done (and run tests
after that) on any system by running just a couple of commands.

>
>
> Byte,
>
>      Johannes
>
