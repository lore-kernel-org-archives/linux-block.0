Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3 0/2] block: enforce ioctl(BLKROSET) and set_disk_ro()
To: Ilya Dryomov <idryomov@gmail.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>,
 David Disseldorp <ddiss@suse.de>, Sagi Grimberg <sagi@grimberg.me>
References: <1515676152-18476-1-git-send-email-idryomov@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <afcccb72-b986-d39d-4bf3-a7b9476db0b0@kernel.dk>
Date: Thu, 18 Jan 2018 12:57:47 -0700
MIME-Version: 1.0
In-Reply-To: <1515676152-18476-1-git-send-email-idryomov@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/11/18 6:09 AM, Ilya Dryomov wrote:
> Hello,
> 
> I was doing some cleanup work on rbd BLKROSET handler and discovered
> that we ignore partition rw/ro setting (hd_struct->policy) for pretty
> much everything but straight writes.
> 
> David (CCed) has blktests patches standing by.
> 
> (Another aspect of this is that we don't enforce open(2) mode.  Tejun
> took a stab at this a few years ago, but his patch had to be reverted:
> 
>   75f1dc0d076d ("block: check bdev_read_only() from blkdev_get()")
>   e51900f7d38c ("block: revert block_dev read-only check")
> 
> It is a separate issue and refusing writes to read-only devices is
> obviously more important, but perhaps it's time to revisit that as
> well?)

Applied for 4.16, thanks.

-- 
Jens Axboe
