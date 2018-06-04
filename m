Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
References: <11b01169-8e11-34ed-8137-aa5cd50a39c2@kernel.dk>
 <CA+55aFy6_+90WKyDAbhh0NcN22N11AyaCaJu0nrafmf49+h6tQ@mail.gmail.com> <52aaf207-ef5d-a886-66fe-566de9d9bbee@kernel.dk>
In-Reply-To: <52aaf207-ef5d-a886-66fe-566de9d9bbee@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 4 Jun 2018 09:24:28 -0700
Message-ID: <CA+55aFz_iLabbCcCEWY8j5KcKCDsC7074f4EDi8mxB7-FrBHwA@mail.gmail.com>
Subject: Re: [GIT PULL] Block changes for 4.18-rc
To: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>, linux-block <linux-block@vger.kernel.org>,
	NeilBrown <neilb@suse.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 4, 2018 at 8:54 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 6/4/18 9:51 AM, Linus Torvalds wrote:
> >
> > Why the hell doesn't it just do bioset_exit() on the originals instead,
> > before freeing the mddev?
>
> CC'ing Neil to get his input on how best to clean that up, I'd
> be much more comfortable with that logic improved rather than
> just catering to the stack usage issue. Also include Arnd, as
> he had a test patch for it.

Also adding Tejun, because the only reason for that odd sequencing
seems to be that

 - we want to queue the deletion work *inside* the spinlock, because
it actually has synchronization between the workqueue and the
'all_mddevs_lock' spinlock.

 - we want to bioset_exit() the fields *outside* the spinlock.

So what it does now is to copy those big 'struct bio_set' fields
because they might go away from under it.

Tejun, the code in question is mddev_put() in drivers/md/md.c, and it
basically does

                INIT_WORK(&mddev->del_work, mddev_delayed_delete);
                queue_work(md_misc_wq, &mddev->del_work);

inside a spinlock, but then wants to do some stuff *outside* the
spinlock before that mddev_delayed_delete() thing actually gets
called.

Is there some way to "half-queue" the work - enough that a
flush_workqueue() will wait for it, but still guaranteeing that it
won't actually run until released?

IOW, what I think that code really wants to do is perhaps something like

        /* under  &all_mddevs_lock spinlock */
        .. remove from all lists so that it can't be found ..

        .. but add it to the md_misc_wq so that people will wait for it ..

                INIT_WORK_LOCKED(&mddev->del_work, mddev_delayed_delete);
                queue_work(md_misc_wq, &mddev->del_work);
        ...

        spin_unlock(&all_mddevs_lock);

        /* mddev is still guaranteed live */
        bioset_exit(&mddev->bio_set);
        bioset_exit(&mddev->sync_set);

        /* NOW we can release it */
        if (queued)
                unlock_work(&mddev->del_work);
        else
                kfree(mddev);

or something like that?

The above is *ENTIRELY* hand-wavy garbage - don't take it seriously
per se, consider it just pseudo-code for documentation reasons, not
serious in any other way.

             Linus
