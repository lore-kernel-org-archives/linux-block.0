Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "jth@kernel.org" <jth@kernel.org>,
	"hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH] genhd: Do not hold event lock when scheduling workqueue
 elements
Date: Tue, 31 Jan 2017 00:31:01 +0000
Message-ID: <1485822639.2669.16.camel@sandisk.com>
References: <1484732896-22941-1-git-send-email-hare@suse.de>
In-Reply-To: <1484732896-22941-1-git-send-email-hare@suse.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-01-18 at 10:48 +0100, Hannes Reinecke wrote:
> @@ -1488,26 +1487,13 @@ static unsigned long disk_events_poll_jiffies(str=
uct gendisk *disk)
> =A0void disk_block_events(struct gendisk *disk)
> =A0{
> =A0=A0=A0=A0=A0=A0=A0=A0struct disk_events *ev =3D disk->ev;
> -=A0=A0=A0=A0=A0=A0=A0unsigned long flags;
> -=A0=A0=A0=A0=A0=A0=A0bool cancel;
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0if (!ev)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> =A0
> -=A0=A0=A0=A0=A0=A0=A0/*
> -=A0=A0=A0=A0=A0=A0=A0 * Outer mutex ensures that the first blocker compl=
etes canceling
> -=A0=A0=A0=A0=A0=A0=A0 * the event work before further blockers are allow=
ed to finish.
> -=A0=A0=A0=A0=A0=A0=A0 */
> -=A0=A0=A0=A0=A0=A0=A0mutex_lock(&ev->block_mutex);
> -
> -=A0=A0=A0=A0=A0=A0=A0spin_lock_irqsave(&ev->lock, flags);
> -=A0=A0=A0=A0=A0=A0=A0cancel =3D !ev->block++;
> -=A0=A0=A0=A0=A0=A0=A0spin_unlock_irqrestore(&ev->lock, flags);
> -
> -=A0=A0=A0=A0=A0=A0=A0if (cancel)
> +=A0=A0=A0=A0=A0=A0=A0if (atomic_inc_return(&ev->block) =3D=3D 1)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0cancel_delayed_work_sync(=
&disk->ev->dwork);
> =A0
> -=A0=A0=A0=A0=A0=A0=A0mutex_unlock(&ev->block_mutex);
> =A0}

Hello Hannes,

I have already encountered a few times a deadlock that was caused by the
event checking code so I agree with you that it would be a big step forward
if such deadlocks wouldn't occur anymore. However, this patch realizes a
change that has not been described in the patch description, namely that
disk_block_events() calls are no longer serialized. Are you sure it is safe
to drop the serialization of disk_block_events() calls?

Thanks,

Bart.=
