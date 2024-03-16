Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BB446AF
	for <linux-block@vger.kernel.org>; Sat, 16 Mar 2024 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710556215; cv=none; b=Gi9pFWpLXMuEWVLBucxZ3E5BKNIEw8+xrvHWHtYhTiO/U+oCybEBzSyR9zC6OoB1sg85YULHFQmQnzb9+fL6hCJQKo4PNPQSvxPcVUFxz3Hyfb6jSPiBR25s8my5qXZqzEv8okz1nBCsNeUZl7afkbW9w1avMHH2/vKnKkNc9W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710556215; c=relaxed/simple;
	bh=9/jjR3U5q/i59Ny9aGyCYLFbY6vTcnXGlOKdKAfuHxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkHdHNJ+cZbv7TOkrrmi/JRV9PY8OZlJtK8BuzmEnFOaNs3pHcEyKsPeJMviIAyBoH6SGPWu1Rj4W/9imq8xS1ZNKIVdGiS3AvmVvpKB14dfarsC/lbVg8CmLbGO+WAmA00R+sh5duytT6GMhlLTK3L4/HUGVXU9k54HSaQHIPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHhXSa4k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHhXSa4k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710556212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LL2aiOudT2QmtdIqb/ELukW8Oe9P5VE/7KMlCFGljw4=;
	b=SHhXSa4kHvYp4TKiIl0Vq7DsbDgCTc37sUHK+ESYQGAmQRn+8CkX4Qv6/0gYFrIExiMHa+
	8p1n/j70GnJHpM3zcY2W9maVbT3dZpcZZwAUBczIe42xgU7IXFld4n40XaauOfo1ctWioJ
	ATP7FTnqOVcBrBztwsgSEZRshh6S+jY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-oCFFfNeQOz63PRLK0HtgFw-1; Fri, 15 Mar 2024 22:30:10 -0400
X-MC-Unique: oCFFfNeQOz63PRLK0HtgFw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6912513fc7bso14262756d6.1
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 19:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710556210; x=1711161010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LL2aiOudT2QmtdIqb/ELukW8Oe9P5VE/7KMlCFGljw4=;
        b=qXXoL9hb4XzJdwYsdL7MMRxBJMj764Azvm20EbuOERf2UyPEHFRAfWO+80r1FS7GFg
         V9sfhQg+qNQI6G2q/jn7ZHydXxvyxbo3VmIY7ZvDnk+0fMwUl0b3yLUb6lKx20Jrfngc
         lq702AXB4YQQsBXKtk6FAFZm9Xaa3j6Q/jOYQMRBaYXhLpnmpQLBlLBJyzY+VNg8GGuP
         M2TZPAZVMP2xC0gzB2YCYD5YdUR0QdDgf4eajC4kfSwK4sBmGoMV7jVpGqZRi5h8cG8P
         RofDAEuebdwB0Ohnp2c1JIJg9kUM51kr36KloknWeLg9nWiXY9QWC4pOrkogHjeyGwHa
         dDrw==
X-Forwarded-Encrypted: i=1; AJvYcCX0v9kz82KQ8kUrnr/i8N+3tn2c0xAoyHqCU0IsEoHdzt/Ltku4pi0BHGn0+mWzvswe9UdY4LUCd/ScaqcTpYSvK3wuHNnC0wEhwck=
X-Gm-Message-State: AOJu0Yz1pVXyEi5H10VyV6V+YFWNsV8PNqaNah0lKaLI4E5/GKXwn/aV
	kjGXSUOJ6GHfyTOq705qmV2E73oOSspBfuOoxBnxytr2hJmZal7+M/o2R1yw/CJn7+DniORVNst
	QPn7DYuKfi2k+UtBWBICDQTBB1qvHpNxIjUpFTxTH2PYh/iY+y9Npio5PSmo64Yjk+qB6MaHvhm
	3GsEbOw0f54FBbw7qFu5dDxOD4uSovajMJC28=
X-Received: by 2002:a05:620a:1a27:b0:789:d106:1dae with SMTP id bk39-20020a05620a1a2700b00789d1061daemr7394681qkb.5.1710555879672;
        Fri, 15 Mar 2024 19:24:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHykChZCjA10Rbu6b79SKOfaxiB0J3C+wqart0s2xWfsFik70q8LOk3+PFj74HrJ2XySwQA9h3yebMNvJG8A60=
X-Received: by 2002:a05:620a:1a27:b0:789:d106:1dae with SMTP id
 bk39-20020a05620a1a2700b00789d1061daemr7394673qkb.5.1710555879326; Fri, 15
 Mar 2024 19:24:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710514702.git.asml.silence@gmail.com> <171054320158.386037.13510354610893597382.b4-ty@kernel.dk>
 <ZfT+CDCl+07rlRIp@fedora>
In-Reply-To: <ZfT+CDCl+07rlRIp@fedora>
From: Ming Lei <ming.lei@redhat.com>
Date: Sat, 16 Mar 2024 10:24:28 +0800
Message-ID: <CAFj5m9LXFxaeVyWgPGMiJLaueXkpcLz=506Bp_mhpjKU59eEnw@mail.gmail.com>
Subject: Re: (subset) [PATCH 00/11] remove aux CQE caches
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, 
	linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 10:04=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> On Fri, Mar 15, 2024 at 04:53:21PM -0600, Jens Axboe wrote:
> >
> > On Fri, 15 Mar 2024 15:29:50 +0000, Pavel Begunkov wrote:
> > > Patch 1 is a fix.
> > >
> > > Patches 2-7 are cleanups mainly dealing with issue_flags conversions,
> > > misundertsandings of the flags and of the tw state. It'd be great to =
have
> > > even without even w/o the rest.
> > >
> > > 8-11 mandate ctx locking for task_work and finally removes the CQE
> > > caches, instead we post directly into the CQ. Note that the cache is
> > > used by multishot auxiliary completions.
> > >
> > > [...]
> >
> > Applied, thanks!
>
> Hi Jens and Pavel,
>
> Looks this patch causes hang when running './check ublk/002' in blktests.

Not take close look, and  I guess it hangs in

io_uring_cmd_del_cancelable() -> io_ring_submit_lock

[root@ktest-36 ~]# cat /proc/1420/stack
[<0>] io_uring_cmd_done+0x161/0x1c0
[<0>] ublk_stop_dev+0x10e/0x1b0 [ublk_drv]
[<0>] ublk_ctrl_uring_cmd+0xbc9/0x11e0 [ublk_drv]
[<0>] io_uring_cmd+0x9e/0x130
[<0>] io_issue_sqe+0x2d3/0x730
[<0>] io_wq_submit_work+0xd2/0x350
[<0>] io_worker_handle_work+0x12a/0x4b0
[<0>] io_wq_worker+0x101/0x390
[<0>] ret_from_fork+0x31/0x50
[<0>] ret_from_fork_asm+0x1a/0x30

(gdb) l *(io_uring_cmd_done+0x161)
0xffffffff817ed241 is in io_uring_cmd_done (./include/linux/list.h:985).
980 return !READ_ONCE(h->first);
981 }
982
983 static inline void __hlist_del(struct hlist_node *n)
984 {
985 struct hlist_node *next =3D n->next;
986 struct hlist_node **pprev =3D n->pprev;
987
988 WRITE_ONCE(*pprev, next);
989 if (next)


Thanks,

