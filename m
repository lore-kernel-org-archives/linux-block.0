Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: do not use interruptible wait anywhere
To: Alan Jenkins <alan.christopher.jenkins@gmail.com>,
 linux-block@vger.kernel.org
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <13e67e1243ebd96f3f56a150d47444ada47ebde0.camel@wdc.com>
 <20180412181158.8884-1-alan.christopher.jenkins@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9111da3e-1b16-3e73-fa3a-940f5a43c545@kernel.dk>
Date: Sat, 14 Apr 2018 13:54:12 -0600
MIME-Version: 1.0
In-Reply-To: <20180412181158.8884-1-alan.christopher.jenkins@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/12/18 12:11 PM, Alan Jenkins wrote:
> When blk_queue_enter() waits for a queue to unfreeze, or unset the
> PREEMPT_ONLY flag, do not allow it to be interrupted by a signal.
> 
> The PREEMPT_ONLY flag was introduced later in commit 3a0a529971ec
> ("block, scsi: Make SCSI quiesce and resume work reliably").  Note the SCSI
> device is resumed asynchronously, i.e. after un-freezing userspace tasks.
> 
> So that commit exposed the bug as a regression in v4.15.  A mysterious
> SIGBUS (or -EIO) sometimes happened during the time the device was being
> resumed.  Most frequently, there was no kernel log message, and we saw Xorg
> or Xwayland killed by SIGBUS.[1]
> 
> [1] E.g. https://bugzilla.redhat.com/show_bug.cgi?id=1553979
> 
> Without this fix, I get an IO error in this test:
> 
> # dd if=/dev/sda of=/dev/null iflag=direct & \
>   while killall -SIGUSR1 dd; do sleep 0.1; done & \
>   echo mem > /sys/power/state ; \
>   sleep 5; killall dd  # stop after 5 seconds
> 
> The interruptible wait was added to blk_queue_enter in
> commit 3ef28e83ab15 ("block: generic request_queue reference counting").
> Before then, the interruptible wait was only in blk-mq, but I don't think
> it could ever have been correct.

Applied, thanks.

Still want that test in blktests, though!

-- 
Jens Axboe
