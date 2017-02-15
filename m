Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: do not allow updates through sysfs until
 registration completes
To: Tahsin Erdogan <tahsin@google.com>, linux-block@vger.kernel.org
References: <20170215032738.22689-1-tahsin@google.com>
Cc: linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <95afa7b1-86c2-34ff-3870-8a32412a3a45@kernel.dk>
Date: Wed, 15 Feb 2017 08:41:13 -0700
MIME-Version: 1.0
In-Reply-To: <20170215032738.22689-1-tahsin@google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/14/2017 08:27 PM, Tahsin Erdogan wrote:
> When a new disk shows up, sysfs queue directory is created before elevator
> is registered. This allows a user to attempt a scheduler switch even though
> the initial registration hasn't completed yet.
> 
> In one scenario, blk_register_queue() calls elv_register_queue() and
> right before cfq_registered_queue() is called, another process executes
> elevator_switch() and replaces q->elevator with deadline scheduler. When
> cfq_registered_queue() executes it interprets e->elevator_data as struct
> cfq_data even though it is actually struct deadline_data.
> 
> Grab q->sysfs_lock in blk_register_queue() to synchronize with sysfs
> callers.

Thanks, this looks good to me - both the grabbing of the lock, and
the ordering wrt UDEV_ADD. Queued up.

-- 
Jens Axboe
