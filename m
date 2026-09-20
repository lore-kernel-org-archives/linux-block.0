Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895FA418363
	for <linux-block@vger.kernel.org>; Sun, 20 Sep 2026 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789904124; cv=none; b=Q+EZ+0DaPN31GIVWJ0HaVhXbGzVd9v80UdrBOKJThQkJuajANkA44C3NeRCP9SYxVzvoPt/dC3ozDBWPeHeepg7f/ZPBa9XiSrLK+wst1efGdTWFWWY40zoav9V0h+cTOLDJPcTs7gBheHkPJzsLArSMnbRNSYu5x1q/n3T3knA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789904124; c=relaxed/simple;
	bh=4YHIigWkF9a5Jv7iJgamRA5tV52bAV/n0ACpMqozVw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQeAhFitQbsmbmNKI47tDABbHRVVldNOXN/5MI6rmddCbI3LEuRwRcllpIOf+WQSkQKN8UG9XsYFZUkrhqVPLu6yVBqH1D/tBfV93x7K58WVs52qreKEt5jw/V+H+OjNCfWhl4KJbupGqUy7Fu/1oIbUyQhwFGycz7r2T24USoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y44ONVtW; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y44ONVtW"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-80032c08611so1462502a34.3
        for <linux-block@vger.kernel.org>; Sun, 20 Sep 2026 04:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789904117; x=1790508917; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LF4c2IX0PuWCqHGJHWTgMYep+t831LFkVRZbjTIZtkU=;
        b=Y44ONVtWajdOU0bNfOt607H71HYOswjvGNcuVYfTmoVL356v5HafvqDBg+7ypJPccd
         31bTfVDhrQ+lkXdEiTT3ZwieKFgcg5JCg99ikgmgdEB6SICviK5rGh01eIfg+2tDuSB8
         /TuvM6TVEjPCk3YgwGKmi2vV7aHmChfVeIVWyIqvS5mJ5TnoyN8LHtNRKfmnYtyW8vWB
         0nczept2HAevNjPtbshkMfE+pkpKU/yEtthoBqKqnvbnlRfPZwx1DvYr4lHIN4+esmjC
         mDHmRM+S1PYEK4eZbbqnTmyHbZ0axcZa5AN2NFbP7XYK/vuNCpIVR2BM5LJn9cGd6qxm
         Lviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789904117; x=1790508917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LF4c2IX0PuWCqHGJHWTgMYep+t831LFkVRZbjTIZtkU=;
        b=Dc9Rj9Hm9cuL2PcSs8OMtUp7399ctntMkFb6tEptmQBBM6RvQcsDY6Id6/A6V6/GbB
         kI8D4rqmMl6h31xyOF24yf6yCSjE8x4ADTMguqGQ+gmGioPMvQFcVVJQ14szbEIOP0az
         t+ekAPyZJFQ3N9Ezk8OTJPfR39xhj9/h3bt5Udn+8qcmN2Iva0mO9kIzrilW8Fn5UfHS
         kTVFR/yipM7rDdNtGFq4u+uTbl5i2KMTfsGEz/qSlTaWKqjZzQmjOb4WPAGrhMhlMlIG
         bK/N0Ufq1znAKmIgO7A4p3xxK9noVAJzbg1AQOXNNbmM9VYKwSp8veqUXgtM1DJ+IN/U
         Z1qA==
X-Forwarded-Encrypted: i=1; AKwUvBzMBkhExXgWUGN5gSS85cpGSYidaCwS+zQdpJ5b82kYk9BS0Xml7nb4TsRtv47mBkwIU2l0mGhzByuebA==@vger.kernel.org
X-Gm-Message-State: AFuF++kOE8oEgazmOYKo8zLppcC2M5ecmZLxFsmutDt2xTd6ElSANRMt
	gXN1disuglHuSmYzkreWHB+b2PeBfi87xCs5hMHuF8KEmiC+evtR7ZXU
X-Gm-Gg: AYBFou0Z8hfwOdhmSAoa/SsxqF72IKjmuYJQPK5LqWGFatHErgkqMg6FXKSqF7RMAVE
	aYCxpmv2oR3Ctp8NejM3cbI44xX8QzaoAssDlpZMKVoe4ef8BUtNOsbSEnVUok3qgCUDWV/5pKf
	JuCT7zRtLQfmpU2nJ7AmT4g3wWQldQ+woM+h/B4puP/VERX7db+ejei9rL8pS/78cjGPxvElEid
	Y9WBeeICGFfBIK1P6k4oXRWCz8FbfQiapmx7Nj2PwFTC/0+LVfqbEmx+XA8lAcin/5LRH4UbO4d
	5U89Qc3nnYp/wdYbb0eYq+UN9tDEYzXill2vqKlfJ8LtsM8FkXkdT8O1swelg0Dop9HLHFY1iVG
	4eqimYRw6MdCUHEOq49my9kks01jrQ/xQ0+UZPogg++cShtUuNjNywjpE1dZw5YBiiXxiQtSw28
	yYvMEOqVPAijRcPSTdMpwG3Ry1NMiSKDjgj5kQkrTTjLrGPQRrqmotvu5vPqou4WPgVQgBlXTfM
	8Ty507hhI6FFjDgxCzCvAG+YGvKTvQt+l4IErh54okGHUMHaK1rLy8Dlox7zuQNnqdFt0SigkPY
	4N92
X-Received: by 2002:a05:6830:a148:10b0:812:3ec6:58a2 with SMTP id 46e09a7af769-8123ec6662emr648065a34.12.1789904116720;
        Sun, 20 Sep 2026 04:35:16 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8118551d4b3sm2905282a34.1.2026.09.20.04.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 04:35:16 -0700 (PDT)
Date: Sun, 20 Sep 2026 06:35:10 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Chris Mason <mason@kernel.org>
Subject: Re: ublk: consequences of a dead server are only failing on the last
 /dev/ublkcN release
Message-ID: <aq_E7nsEMFKpBlpr@fedora-laptop>
References: <20260918-eisbrecher-toilette-worum-eb11f777c563@brauner>
 <CADUfDZrjhhvKHh=7KoEvczqrRjcwnJC4p8jh5N4kpOS=Q2RTFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrjhhvKHh=7KoEvczqrRjcwnJC4p8jh5N4kpOS=Q2RTFQ@mail.gmail.com>

On Fri, Sep 18, 2026 at 09:34:54AM -0700, Caleb Sander Mateos wrote:
> On Fri, Sep 18, 2026 at 3:47 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Hi,
> >
> > Chris scanned a new series of mine for me and he reported some
> > interesting behavior that I dug into.
> >
> > A ublk request that was handed to the server is only failed once the
> > last reference to /dev/ublkcN is dropped. So holding the file open keeps
> > the request alive.
> >
> > This causes any waiter to be stuck in D state and blocks STOP_DEV.
> >
> > I'm attaching two reproducers:
> >
> > (1) ublk_inherited_fd_test.c   the general case, no vfork involved
> > (2) vfork_ublk_test.c          the holder of the reference is the waiter itself
> >
> > Re (1):
> >
> > A single-threaded ublk server fork()s a helper. The helper inherits the
> > fdtable including /dev/ublkcN. Now another process opens /dev/ublkbN and
> > writes 4 kb then fsync()s. The servers gets a WRITE and _exit()s without
> > completing it - say it crashes:
> >
> >   - The writer sleeps in folio_wait_writeback() in D state.
> >   - STOP_DEV issued from another process never returns.
> >
> >     The control command runs on an io-wq worker of that process, which
> >     calls ublk_stop_dev() -> del_gendisk() -> bdev_mark_dead() ->
> >     filemap_write_and_wait_range() and ends up waiting on the page that
> >     won't be written back.
> >
> >     Said process can't exit and io_wq_put_and_exit() waits for the
> >     worker.
> >
> > This can only be undone if the helper is SIGKILLed:
> >
> >   # ublk0 up, server 119
> >   # helper 123 forked by the server, holds the inherited fds
> >   # WRITER fsync
> >   # server 119 died with the WRITE in hand
> >   # 2s after the server died:
> >   # writer pid 124, state D:
> >   #   folio_wait_bit_common
> >   #   folio_wait_writeback
> >   #   __filemap_fdatawait_range
> >   #   file_write_and_wait_range
> >   #   blkdev_fsync
> >   #   do_fsync
> >   # STOP_DEV from pid 125 has not returned after 5s:
> >   # STOP_DEV issuer thread 126:
> >   #   folio_wait_bit_common
> >   #   folio_wait_writeback
> >   #   __filemap_fdatawait_range
> >   #   filemap_write_and_wait_range
> >   #   bdev_mark_dead
> >   #   blk_report_disk_dead
> >   #   __del_gendisk
> >   #   del_gendisk
> >   #   ublk_stop_dev_unlocked.part.0
> >   #   ublk_ctrl_uring_cmd
> >   #   io_uring_cmd
> >   #   io_wq_submit_work
> >   #   io_worker_handle_work
> >   #   io_wq_worker
> >   # killing helper 123
> >   # WRITER fsync returned -1 errno 5
> >   # STOP_DEV returned after the helper died
> >
> > What happens to a device after a server crash depends on whoever else
> > holds /dev/ublkcN open: A forked helper, a process that got the fd via
> > SCM_RIGHTS, or a vfork child.
> >
> > I'm not sure whether that's intended semantics but it surely has
> > confusion potential and should probably be at least documented.
> >
> > I suppose failing outstanding requests on server crash is intentionally
> > not done for recover reasons or whatever. But maybe STOP_DEV should be
> > made to work.
> >
> > Re (2):
> >
> > vfork() makes it really ugly. Say a single-threaded ublk server vfork()s
> > a child. The child opens /dev/ublkbN, writes some stuff and closes the
> > fd. Since close(2) runs bdev_release() -> sync_blockdev() it waits for
> > the write.
> >
> > The write gets dispatched to the server's task work. But the server
> > sleeps in wait_for_vfork_done() until the child execs or exits.
> >
> > But the child cannot exec or exit because close(2) doesn't return.
> >
> > ublk makes this more hairy though. Even a SIGKILL sent to the server aka
> > the parent won't help. The vfork()ed child hangs on the close(2).
> >
> > So that stays in D state forever with an undeletable device:
> >
> >     server, after SIGKILL: gone
> >     child:
> >       State:  D (disk sleep)
> >       folio_wait_bit_common
> >       folio_wait_writeback
> >       __filemap_fdatawait_range
> >       filemap_write_and_wait_range
> >       bdev_release
> >       blkdev_release
> >       __fput
> >       fput_close_sync
> >       __x64_sys_close
> >
> > Unrelated, but also a potential issue:
> >
> > The commit 7fc4da6a304b ("ublk: scan partition in async way") made
> > partition scans run from a workqueue that holds disk->open_mutex while
> > the server serves its reads and START_DEV returns before it's finished.
> >
> > Any server that treats START_DEV's return as a signal that the disk is
> > ready and doesn't serve requests hangs every open() of /dev/ublkbN on
> > uninterruptible on open_mutex. You can combine that with (1) and (2).
> 
> Indeed, we've also encountered this issue in our ublk server that was
> opening /dev/ublkb* to call ioctl(BLKROSET). (UBLK_ATTR_READ_ONLY only
> works to configure the read-only status *before* a ublk device is
> started, so the ioctl is needed to configure it when recovering a ublk
> device.)

It is supposed that ublk server doesn't deal with /dev/ublkbN directly.

We can add control commands for updating parameter runtime, or UBLK_CMD_SET_PARAMS
may be enough before ublk device is started.


Thanks, 
Ming
