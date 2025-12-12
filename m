Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665CD2E2667
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 04:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765515420; cv=none; b=PXGlp4GURyZ8bYwMgYarsQZihWgAAVvv6z5EGx+wS4F4QBYSU8B+SnvFjzf1bF/uIt9zmQSyUyD+E7evGi0Lfwn7xGq73NeEWYsSIH47cIoJKd8oxr6axBPHtqmnzSq0OMUBcX6LCKEDesTJD9AUguvMibc6/sruUIZ81EjaP1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765515420; c=relaxed/simple;
	bh=ht9Qrn7ywnCaqrMMPlokB3b6Fvy3GjUiAYN3K4HLAVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STzRpQr80kREYUONFpczRcbbieCwSpIQGKfjJpLYDQTF3BwpdEnbsydmyCC/6Z6R9meoL3WXBIJ0S+hW8H6LztBYMM955JyYEaUhUgQyfdwMCbZsY5MyzsV4er5TJVQT6uw5w/+eFW0u+82sHA7oGG4Wa9zx83J76RpdTpyNpVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UrVh9mCI; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UrVh9mCI"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-349e7fe50c3so117400a91.2
        for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 20:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765515418; x=1766120218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMNaDzvbQdZIaQs0GtihAHEDk6X6Chj2lzL1gbHrNpg=;
        b=UrVh9mCIkGtEj6AdxN8gsNInMbmexFXBS/pQC2lsrh/G8n8VQHgj00ZOlh6JxWMKHs
         +WCxmAOW0X/HTA/W9IsrrTZErg3QwT5trn6/auOnG3y590TSc6Fay8IK51iAdMlKhFo3
         ChKluB2liZkzAKfFzzDmfrI39J3qOhZ46SYZ4f8jWXXj/wBsSrEx8jOGhy0vxf4BAOKb
         0NAAOixW89rqFqsj0/YZhAHGWCgRpw4e/CupN/JWp4UUZVXAtN5625PVGLc6AFlr26+Y
         45MD3ISa/5l0uAEQ6+QnlhA8HH+zUbyfjN5C4kyQRSMYer/aQFvcVRNNh5xT2L9TITZ5
         YvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765515418; x=1766120218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IMNaDzvbQdZIaQs0GtihAHEDk6X6Chj2lzL1gbHrNpg=;
        b=lADdjvkIfUBTwCi06g3CSctch0uQNDja9Pe43BtC9k6VxxbcY54GDgLtJ8N06TXVNP
         GaHZWFpOg30LZ2q/xqUOeSRHlmmlJ3ptmCWIXNBJdjqBH9o8TQIoaohvBvDKtqjwgmc3
         o8YWbME/HeBs6vhF8qzUbZn+2bzXCfWfAT3+EdjhaJb5Bnt6QAIX9FJRGlUZylB0MVYP
         FT49RHhjQN+GXC/WrF5nQBu+BD/pdew6Vys8A2Vsz2JTT4nD7YsmbCd17IXaxmxiW8C7
         O9F9TXC85gwdx4SPY4FSM+ZkbLvSD2LD5Rjgk1a9IZcTcdw1m4EGS0uTIHLLsOVqS0Pu
         noRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVge5ng1s5FS1vZ65jbSSxGt7waCLIGjykeNqSjIhfP9NzjgknGCTM0gdTr7mSHjtr+QkU8BZcIacNbhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1KWSw+fsLgjnsMef9HGCWZg0pz1U6TVzwD8wKcHvFyaa6KTg4
	YNmehiTfZhXynbI3dV8dlSUTwW1vBjUgFmk3nz7G4Z3cr7pEDPh5G9taZXEE0b0sNyJSHtA/vf0
	FVKbz0XmJOP1k4yPeze1ADy2UzEjyV3Q/Shqjh5kVPg==
X-Gm-Gg: AY/fxX7Lsr6MPSzdGkhBhisF1xzXf7H+HewCYH9E7BW6kXRaGrzgvXpDHOC6vI8a6bx
	RXgX9UUMu/NGQG+Q8Y4W2KVHWcGuvFYAT1aPIOjTBUsrNSvVX+9e6pbYZ4/wkuIQaVSMyWo25TI
	f8IFADrHuJojnV8BwIhCBA5n63CeaCjIj6/kAuLd837Yn/x8JSNYLz8uqMUmnMR7gaBvAoIvmhQ
	iIqPUA0SI0eOAWuJmBNfF9CufigV82J1b4aRS9MQvn3M+OYN/HUY5RHBJsTvPTLK/TQbXGs
X-Google-Smtp-Source: AGHT+IGGVZcGHlX4JZ8A4LgYM8NQNLn4/FOOZQlE1JTJLTpp7WpqVh+/3Lk8s6hbmfyP+PYfuOl+Kw7LWvnZmyaIWpE=
X-Received: by 2002:a05:7300:2aa6:b0:2ab:ca55:b76b with SMTP id
 5a478bee46e88-2ac3015b4f4mr339361eec.6.1765515417349; Thu, 11 Dec 2025
 20:56:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211083824.349210-1-ming.lei@redhat.com> <CADUfDZrVk_juib6yw8vrrYP0rrhrt7BxQPn89GeDi5q-XHNHOw@mail.gmail.com>
 <aTtFMvlgDvxfF5kN@fedora>
In-Reply-To: <aTtFMvlgDvxfF5kN@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 11 Dec 2025 20:56:46 -0800
X-Gm-Features: AQt7F2ojlVThvGm3xeCZje1Zo823Dz6Wo9wtsvJwVPye07lkkXTdCWG0z5cUwbg
Message-ID: <CADUfDZqh-jdJzK4E9bz0V12W=d4vGZOJMgC0F-EzXvd8dT_+4Q@mail.gmail.com>
Subject: Re: [PATCH] ublk: fix deadlock when reading partition table
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 2:27=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Dec 11, 2025 at 12:30:35PM -0800, Caleb Sander Mateos wrote:
> > On Thu, Dec 11, 2025 at 12:38=E2=80=AFAM Ming Lei <ming.lei@redhat.com>=
 wrote:
> > >
> > > When one process(such as udev) opens ublk block device (e.g., to read
> > > the partition table via bdev_open()), a deadlock[1] can occur:
> > >
> > > 1. bdev_open() grabs disk->open_mutex
> > > 2. The process issues read I/O to ublk backend to read partition tabl=
e
> >
> > I'm not sure I understand how a process could be issuing read I/O to
> > the block device before bdev_open() has returned? Or do you mean that
> > bdev_open() is issuing read I/O for the partition table via
> > blkdev_get_whole() -> bdev_disk_changed() -> blk_add_partitions() ->
> > check_partition()?
>
> Yes, disk->open_mutex is grabbed and waiting for reading partition table.
>
> >
> > > 3. In __ublk_complete_rq(), blk_update_request() or blk_mq_end_reques=
t()
> > >    runs bio->bi_end_io() callbacks
> > > 4. If this triggers fput() on file descriptor of ublk block device, t=
he
> > >    work may be deferred to current task's task work (see fput() imple=
mentation)
> >
> > What is the bi_end_io implementation that results in an fput() call?
>
> libaio calls fput() via ->ki_complete() via bio->bi_end_io(), io-uring ma=
y
> call it from io_free_rsrc_node().
>
> https://github.com/ublk-org/ublksrv/issues/170#issuecomment-3635162644
>
> >
> > > 5. This eventually calls blkdev_release() from the same context
> > > 6. blkdev_release() tries to grab disk->open_mutex again
> > > 7. Deadlock: same task waiting for a mutex it already holds
> > >
> > > The fix is to run blk_update_request() and blk_mq_end_request() with =
bottom
> > > halves disabled. This forces blkdev_release() to run in kernel work-q=
ueue
> > > context instead of current task work context, and allows ublk server =
to make
> > > forward progress, and avoids the deadlock.
> >
> > The idea here seems reasonable, but I can't say I understand all the
> > pieces resulting in the deadlock.
>
> Please see the following scenarios:
>
> 1) task A: fio is running IO over /dev/ublkb0 for 5secs
>
> 2) task B: just when fio is exiting, another task is calling into ioctl(R=
RPART) on
> /dev/ublkb0, waiting for reading partition with disk->open_mutex held.
>
> 3) in ublk server task, for some reason, fput() drops the `struct
> file`'s last reference from task A, so bdev_release() is called from
> task_work_run() in ublk server context. However, task B is holding
> disk->open_mutex, so bdev_release() hangs forever, because this ublk serv=
er
> can't handle IO for task B any more.

Ah okay this makes more sense, I thought the fput() was for the
completion of the partition table read. But I see now it can be for
any other process that happens to have opened the same ublk disk. The
"userspace thread and not in interrupt/softirq" logic in
__fput_deferred() to decide to close the file in task work seems
pretty suspect. The assumption seems to be that blocking a userspace
thread is fine since it won't be blocking any kernel threads, but
that's clearly wrong for a userspace block device. I wonder if any
similar deadlocks are possible with fuse? Pretending the ublk server
thread is in softirq context when completing the seems a bit hacky,
but I can see it may be the simplest fix.

Do the blk_mq_end_request() calls in__ublk_do_auto_buf_reg() and
__ublk_abort_rq() not also need this protection?

Best,
Caleb

>
> Jiri Pospisil has verified this patch and closes https://github.com/ublk-=
org/ublksrv/issues/170.
>
>
> Thanks,
> Ming
>
