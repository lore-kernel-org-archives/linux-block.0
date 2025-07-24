Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A5523BD1A
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350242; cv=none; b=jtTDnXFBWNdjscIRC1zzMh1pczqSM3Fe6mNTAeWUPRD5v6ZBVtXvMsPKLm44gOZ1hy2gyujtxJV2S6bZCjbTq9RI6fLBFTrgBfUZEkp0JpvN4FiAc9wMeFpnBPOpxTsIXsl18sqGgm8wxKwzCZmz19xoxuueYDJNfpH9f/vcm2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350242; c=relaxed/simple;
	bh=1RsW6TkQHbPLtqeFzWRPPpTD1CLBeW1m9UMNqDJ4yFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiC3XpnpAyw+BxNpLj1BOxiZE3dfzxIQZiIFhWqU+RpukAZpbkugdBEjsU9cSqHfhJfTcCo8u3vsHwD/jEufWowDAVCemJ7DCSN5kMMbLsXmliGT+yysI2kvlYOm7pbXL5fgDQ4i5/7cteSO+C60rQEmNuHsBOv6DCyL470PW3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZBdwaST; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZBdwaST"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753350237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uVu8UqJY2rILvYiLxcmHt2uP5c2QlGcySH4tysmwV8=;
	b=LZBdwaSTTJ1aegeGZm6YYt5Zy1AM4SN7ZLun3iAvWyMTTNuMHwoC68CsRiAHlrj8ECMQYx
	zzFfoTVncIdFQtUNMUaTRJ8lUlS446fcmIfBT+wu4G35n6bzmx+WRaGfkl+IhcHJWLSTHw
	4OxY6fxLzKXxAE1/oyR7beVPauHRlgc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-OAvielBKOZORNsjfqrs_0Q-1; Thu, 24 Jul 2025 05:43:53 -0400
X-MC-Unique: OAvielBKOZORNsjfqrs_0Q-1
X-Mimecast-MFC-AGG-ID: OAvielBKOZORNsjfqrs_0Q_1753350232
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5561bcb924bso346052e87.0
        for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 02:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753350232; x=1753955032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uVu8UqJY2rILvYiLxcmHt2uP5c2QlGcySH4tysmwV8=;
        b=f9gM2qzMtRn1Q+ktUdW69lPifFCvbGTsN/CG9vceMgIdZufnDr7RXhfnImGLGvd84x
         S4bYGfE5pq3fIUG0X0o+Kx3XBCoZ4Jb+W5076PopZzzQD1uz4pqwddcIDAvOrWtc+103
         GnyQptRKDGkWSMGprzKuZlFUs35WjHUd9q1MWUdIt4R6+WuLv9Kmmp3Wa6jDjBpfJkOG
         C5UDW1WHa7lbY3ISiUKA1ekTDQ197OtYzbt4WwY4Uf0B7HYRu8NeIYL1dubOlQPP0bJb
         kP+sY+/yw5EVpY09FFb8eb+haU2Uw5RTwheHNgwWtm1pvEIuSq+X9iC6K9+Z30i18M/1
         3P5g==
X-Gm-Message-State: AOJu0YxOwzHm4bgazvAj3Catjl+EwfVJbEab0OxXpVVUZ4YoOyPgUGJx
	iVLqDwIycjMPOgzCA/b+EgkSkHHmXH5WgXvO/986uhzGIw4+ADet2eJjOvknwESIYOIaQAqRABu
	QwxdwAjgnh3A8yiWNoRjBpULlHP6dlNRFg9/vr5Nq2xKfoH8xg+yIVub0Ns+3MmkXt7vGQlININ
	Gr+GR06d8liThsES37Q29hxEAR+jiOkFEdmDWtSyE=
X-Gm-Gg: ASbGncsnkwrU/9y7EuHpZDFRZ45wmdK+ST+E+EBlYvAggRorihLm/u8mFrD4A7fYXlw
	aenP/S6en+wN5PP5rBfUDS5xXwLxHMnXaWybqmUr8fnzSWKOC8xelMBtp9eeZyK4kdK8LfokaPr
	VUcBA2jeUbARvkzybNhIR3xA==
X-Received: by 2002:a05:6512:24c2:10b0:553:3892:5ecc with SMTP id 2adb3069b0e04-55a513de6d9mr1469788e87.36.1753350231657;
        Thu, 24 Jul 2025 02:43:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNxawjYjUKLHdRCl0oaMlA657BHnzVrGFgD43ZuQRZcdLd3BVs8Uc+KgukbnjyBzZ0CU7JsvInvhbJa0Eednw=
X-Received: by 2002:a05:6512:24c2:10b0:553:3892:5ecc with SMTP id
 2adb3069b0e04-55a513de6d9mr1469775e87.36.1753350231225; Thu, 24 Jul 2025
 02:43:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+X8GYS7yKkq-qxJ5hpTL=vHMBgG=wuSsNJZ0VrjQeMA6w@mail.gmail.com>
 <CALTww2-_9saPOtLC0dXUhQiK+2eV739rjwX3K3KDAz6AgbE6Ug@mail.gmail.com> <CAGVVp+XfxgMDJ=JX6nLtieyco=PajfqhoKZBb0Qrs7bndUEk_Q@mail.gmail.com>
In-Reply-To: <CAGVVp+XfxgMDJ=JX6nLtieyco=PajfqhoKZBb0Qrs7bndUEk_Q@mail.gmail.com>
From: Xiao Ni <xni@redhat.com>
Date: Thu, 24 Jul 2025 17:43:38 +0800
X-Gm-Features: Ac12FXwcVG0omWbb12mwc3CHvnCyZE2x-xhiu5sbpejBKE3eh2PymZSwJKRQ7sI
Message-ID: <CALTww2-sdV1gDGAcfPSHWJOoycb=aMrT9-XFDayNKeEaDeE7og@mail.gmail.com>
Subject: Re: [bug report] mdadm: Unable to initialize sysfs
To: Changhui Zhong <czhong@redhat.com>
Cc: Linux Block Devices <linux-block@vger.kernel.org>, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Changhui

Thanks for confirming this.

md raid has a change which guarantee device node (/dev/md0) can be
removed when stopping array
9e59d609763f (md: call del_gendisk in control path)

The change is good, but this change introduces a problem as you see.
So I fixed the problem by
https://github.com/md-raid-utilities/mdadm/pull/182. Now we don't need
any change.

Regards
Xiao

On Thu, Jul 24, 2025 at 3:53=E2=80=AFPM Changhui Zhong <czhong@redhat.com> =
wrote:
>
> Hi,Xiao
>
> yes,  succeed assemble  RAID array with the latest upstream mdadm,
> # mdadm -A /dev/md0 /dev/sda /dev/sdb
> mdadm: /dev/md0 has been started with 2 drives.
> # mdadm -V
> mdadm - v4.4-55-g787cc1b6 - 2025-07-09
>
> if not install the latest upstream mdadm,
> this issue will be hit in the upstream kernel git/axboe/linux-block.git=
=EF=BC=8C
> but not triggered in git/torvalds/linux.git=EF=BC=8C
>
> is there anything that need to be fixed in git/axboe/linux-block.git?
>
> Thanks=EF=BC=8C
>
> On Thu, Jul 24, 2025 at 3:18=E2=80=AFPM Xiao Ni <xni@redhat.com> wrote:
> >
> > Hi Changhui
> >
> > I guess you need to use the latest upstream mdadm. Could you have a
> > try with https://github.com/md-raid-utilities/mdadm/
> >
> > Regards
> > Xiao
> >
> > On Thu, Jul 24, 2025 at 3:07=E2=80=AFPM Changhui Zhong <czhong@redhat.c=
om> wrote:
> > >
> > > Hello,
> > >
> > > mdadm fails to initialize the sysfs interface while attempting to
> > > assemble a RAID array,
> > > please help check and let me know if you need any info/test, thanks.
> > >
> > > repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-blo=
ck.git
> > > branch: for-next
> > > INFO: HEAD of cloned kernel
> > > commit a8fa1731867273dd09125fd23cc1df4c33a7dcc3
> > > Merge: b41d70c8f7bf 5ec9d26b78c4
> > > Author: Jens Axboe <axboe@kernel.dk>
> > > Date:   Tue Jul 22 19:10:37 2025 -0600
> > >
> > >     Merge branch 'for-6.17/block' into for-next
> > >
> > > reproducer:
> > > # mdadm -CR /dev/md0 -l 1 -n 2 /dev/sdb /dev/sdc -e 1.0
> > > mdadm: array /dev/md0 started.
> > > # mdadm -S /dev/md0
> > > mdadm: stopped /dev/md0
> > > # mdadm -A /dev/md0 /dev/sdb /dev/sdc
> > > mdadm: Unable to initialize sysfs
> > > # rpm -qa | grep mdadm
> > > mdadm-4.4-2.el10.x86_64
> > >
> > > and not hit this issue with upstream kernel
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >
> > >
> > > Best Regards,
> > > Changhui
> > >
> >
>

