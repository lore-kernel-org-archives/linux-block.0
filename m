Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDD83597C
	for <linux-block@vger.kernel.org>; Mon, 10 Feb 2025 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739151746; cv=none; b=S5aFYb7byfg68WZ6vHf5yKdwbdDrAfo/zLJoHq3XHbqC+hBaxPiKfjb/Y0TK7nf3EueMrXnEC4O5YUTI8iyk2uL4lzqA141Ao8OiDd+azSp5E40rszyhWyH9r+iWPzORILS1QifWWhtQrpSRgYNvSpe6J+Z8bBoSVAPFQ4iEVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739151746; c=relaxed/simple;
	bh=oisH/cV01qxjA5ir/ZXGFTLQqj1Etn1mNX9SNX2/7is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BuN4Hu/rpZVWDHggWxd3tQrWShFR5iOR8BWPq0lb+q+APdOoPVIGErk6/+qdjS2WnR2fj1sUCHWXu1c8FjDg1ehKF7dF3ksczXU9wBYGemrzTewfAa2ozB7b0+/Dl6YAf/1D6aVBaFttiWGpt1zkpheXzbts2qp+jnsuP0g1l74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPovvx+R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPovvx+R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739151743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XEJMrPU9FXPzob3+YpmZoBRUA6MV+tw7A+2TvLVtX6s=;
	b=ZPovvx+RAAibUFvQNgOfkrDMSmZWaR3bnwIPw3pmdOTb58tRc1gdlgpI4+nRfZR1FM/DuL
	XNZDhOVe0e6kfP6PcBhHSvDCDPMldCEIsvX+sIemskb0nn5QFdSEAvIDK+3C8gIQucG+D4
	ELpEDnSAIVkzbCgjD1uYQKsTJPi+pUc=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-6L19XM7YPpuvH6nWhhXy3g-1; Sun, 09 Feb 2025 20:42:21 -0500
X-MC-Unique: 6L19XM7YPpuvH6nWhhXy3g-1
X-Mimecast-MFC-AGG-ID: 6L19XM7YPpuvH6nWhhXy3g
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5203a29c9fdso89538e0c.0
        for <linux-block@vger.kernel.org>; Sun, 09 Feb 2025 17:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739151741; x=1739756541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEJMrPU9FXPzob3+YpmZoBRUA6MV+tw7A+2TvLVtX6s=;
        b=ovWvafCGppYphkr3/lh6TA2tUyqAdIhHacrs+jia412fZkeNKNgNHb3FyRphdNoa7a
         5jHb23qfsjCXht+pqe3+ykxAbECnkbolRUcf+iF/2SlavoPddxeJPl8Sw7NaGWcoS2YX
         +d9sLuOf0WiP9pDEJw53xk9X4KJYj508B7V8pUlMYxIHB9qc7qGqJPMvCn06o2XR/GAt
         lJep4D93c4rMJSZWBrXhwUu/1YTgXKi/O3Im/6CRm3WA33dg3G9hMXVynYWIBO59xl3M
         /Ww4ndwKC9BYS5NbYrXMQENHWj7OTxYgFt6iXcuNf8w0obpZ7bM5VJVB+c8oanln1kl6
         4rag==
X-Forwarded-Encrypted: i=1; AJvYcCX6QqHWM20xLR7lZn/L6Uy6g8DUCoETPC2B+tExvJKyfN9qeFN/i+hOAg2wrwG9WzfWURi/z/Tw0PuZmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPC6ryiP70EtVHAFvOTSPh7yAfnL2Cos4JhtqqsaJ32kzzG3GS
	w0sozSFYKbjUzckwBGGZk2FGCBEOkYwRwc2/ZS4rqMOO518Tfg0GRkhnCJMRBjuKYc4ab3qGv0K
	m3rH8IBXBwkpELqeAalsyXujQ2kc36s63/IeW7jCjQwMlOM+0WHuOtqkBjGIMuFhQqJm5p8SEx/
	duJ4VKCB/1x/nMGdexlvUwOyo27c3xZA2R9S8=
X-Gm-Gg: ASbGncue/IlSFdyuvScH4Gxoin+T/lI0R3HelhUwyow/4qvHM4UxIrCiSRDTO7IcmR6
	gL0sDvB9VZ1qwggCDgENSnX6fJR9j+llGq/ui017itrq9CvfRJoJXt36HYg2PnpU=
X-Received: by 2002:a05:6102:c13:b0:4bb:d394:46ce with SMTP id ada2fe7eead31-4bbd39455b1mr274350137.3.1739151741205;
        Sun, 09 Feb 2025 17:42:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGeuR4ww1Gd8y1p0PVitbiaJL/aub9S3uQxvzOXUqaXgVW4whvgf2AyWTEkU+rughhzzLYCkcTMZ0A3bqzrr0=
X-Received: by 2002:a05:6102:c13:b0:4bb:d394:46ce with SMTP id
 ada2fe7eead31-4bbd39455b1mr274345137.3.1739151740936; Sun, 09 Feb 2025
 17:42:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209122035.1327325-1-ming.lei@redhat.com> <20250209122035.1327325-8-ming.lei@redhat.com>
 <vc2tk5rrg4xs4vkxwirokp2ugzg6fpbmhlenw7xvjgpndkzere@peyfaxxwefj3>
In-Reply-To: <vc2tk5rrg4xs4vkxwirokp2ugzg6fpbmhlenw7xvjgpndkzere@peyfaxxwefj3>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 10 Feb 2025 09:42:10 +0800
X-Gm-Features: AWEUYZktSi8A78nXzM3WHAjr1EtuSsw4lsV5HaRK5uEPmlgX6IOL1mk3DcggczU
Message-ID: <CAFj5m9+-CMU52E1hpNsG+eXC4HsG82Ny7f=iJrdAfGScTFPD4Q@mail.gmail.com>
Subject: Re: [PATCH 7/7] block: don't grab q->debugfs_mutex
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, hch <hch@lst.de>, 
	Nilay Shroff <nilay@linux.ibm.com>, Ming Lei <minlei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 8:52=E2=80=AFAM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Feb 09, 2025 / 20:20, Ming Lei wrote:
> > All block internal state for dealing adding/removing debugfs entries
> > have been removed, and debugfs can sync everything for us in fs level,
> > so don't grab q->debugfs_mutex for adding/removing block internal debug=
fs
> > entries.
> >
> > Now q->debugfs_mutex is only used for blktrace, meantime move creating
> > queue debugfs dir code out of q->sysfs_lock. Both the two locks are
> > connected with queue freeze IO lock.  Then queue freeze IO lock chain
> > with debugfs lock is cut.
> >
> > The following lockdep report can be fixed:
> >
> > https://lore.kernel.org/linux-block/ougniadskhks7uyxguxihgeuh2pv4yaqv4q=
3emo4gwuolgzdt6@brotly74p6bs/
> >
> > Follows contexts which adds/removes debugfs entries:
> >
> > - update nr_hw_queues
> >
> > - add/remove disks
> >
> > - elevator switch
> >
> > - blktrace
> >
> > blktrace only adds entries under disk top directory, so we can ignore i=
t,
> > because it can only work iff disk is added. Also nothing overlapped wit=
h
> > the other two contex, blktrace context is fine.
> >
> > Elevator switch is only allowed after disk is added, so there isn't rac=
e
> > with add/remove disk. blk_mq_update_nr_hw_queues() always restores to
> > previous elevator, so no race between these two. Elevator switch contex=
t
> > is fine.
> >
> > So far blk_mq_update_nr_hw_queues() doesn't hold debugfs lock for
> > adding/removing hctx entries, there might be race with add/remove disk,
> > which is just fine in reality:
> >
> > - blk_mq_update_nr_hw_queues() is usually for error recovery, and disk
> > won't be added/removed at the same time
> >
> > - even though there is race between the two contexts, it is just fine,
> > since hctx won't be freed until queue is dead
> >
> > - we never see reports in this area without holding debugfs in
> > blk_mq_update_nr_hw_queues()
> >
> > Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
>
> Ming, thank you for this quick action. I applied this series on top of
> v6.14-rc1 kernel and ran the block/002 test case. Unfortunately, still if=
 fails
> occasionally with the lockdep "WARNING: possible circular locking depende=
ncy
> detected" below. Now debugfs_mutex is not reported as one of the dependen=
t
> locks, then I think this fix is working as expected. Instead, eq->sysfs_l=
ock
> creates similar dependency. My mere guess is that this patch avoids one
> dependency, but still another dependency is left.

Indeed, this patch cuts dependency on both q->sysfs_lock and q->debugfs_loc=
k,
but elevator ->sysfs_lock isn't covered, :-(

Thanks,
Ming

