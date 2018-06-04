Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 4 Jun 2018 11:20:17 -0700
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-block <linux-block@vger.kernel.org>,
	NeilBrown <neilb@suse.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] Block changes for 4.18-rc
Message-ID: <20180604182017.GA1351649@devbig577.frc2.facebook.com>
References: <11b01169-8e11-34ed-8137-aa5cd50a39c2@kernel.dk>
 <CA+55aFy6_+90WKyDAbhh0NcN22N11AyaCaJu0nrafmf49+h6tQ@mail.gmail.com>
 <52aaf207-ef5d-a886-66fe-566de9d9bbee@kernel.dk>
 <CA+55aFz_iLabbCcCEWY8j5KcKCDsC7074f4EDi8mxB7-FrBHwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFz_iLabbCcCEWY8j5KcKCDsC7074f4EDi8mxB7-FrBHwA@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

Hey, Linus.

On Mon, Jun 04, 2018 at 09:24:28AM -0700, Linus Torvalds wrote:
> Tejun, the code in question is mddev_put() in drivers/md/md.c, and it
> basically does
> 
>                 INIT_WORK(&mddev->del_work, mddev_delayed_delete);
>                 queue_work(md_misc_wq, &mddev->del_work);
> 
> inside a spinlock, but then wants to do some stuff *outside* the
> spinlock before that mddev_delayed_delete() thing actually gets
> called.
> 
> Is there some way to "half-queue" the work - enough that a
> flush_workqueue() will wait for it, but still guaranteeing that it
> won't actually run until released?

Such interface doesn't exist, yet anyway.  Workqueue does have the
concept of delayed queueing to handle max concurrency limits and we
can probably piggyback on that to create an interface which queues and
delays the work item and another interface to undelay it.

That said, it feels like a super-niche feature for a weird use case.

> IOW, what I think that code really wants to do is perhaps something like
> 
>         /* under  &all_mddevs_lock spinlock */
>         .. remove from all lists so that it can't be found ..
> 
>         .. but add it to the md_misc_wq so that people will wait for it ..
> 
>                 INIT_WORK_LOCKED(&mddev->del_work, mddev_delayed_delete);
>                 queue_work(md_misc_wq, &mddev->del_work);
>         ...
> 
>         spin_unlock(&all_mddevs_lock);
> 
>         /* mddev is still guaranteed live */
>         bioset_exit(&mddev->bio_set);
>         bioset_exit(&mddev->sync_set);
> 
>         /* NOW we can release it */
>         if (queued)
>                 unlock_work(&mddev->del_work);
>         else
>                 kfree(mddev);
>              Linus

Looking at the code, the fundamental problem seems to be that it's
weaving different parts of sync and async paths.  I don't understand
why it'd punt the destructin of mddev but destroy biosets
synchronously.  Can't it do sth like the following?

	lock;

	if (need to be async) {
		/* async destruction path */
		INIT_WORK(...);
		queue_work(...);	/* the work does bioset_exits */
		unlock;
		return;
	}

	/* sync destructino path */
	do whatever needs to be done under lock;
	unlock;
	bioset_exit(...);
	bioset_exit(...);
	kfree(mddev);

Thanks.

-- 
tejun
