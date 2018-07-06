Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: make discard killable
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-block@vger.kernel.org, Zdenek Kabelac <zkabelac@redhat.com>,
 Mike Snitzer <msnitzer@redhat.com>, dm-devel@redhat.com
References: <alpine.LRH.2.02.1807031334400.22443@file01.intranet.prod.int.rdu2.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8163a50c-06a1-1b56-7927-7d5cc56d1038@kernel.dk>
Date: Fri, 6 Jul 2018 07:51:30 -0600
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1807031334400.22443@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/3/18 11:35 AM, Mikulas Patocka wrote:
> Discarding can take very long time for some device mapper targets, this
> patch makes it possible to kill a process that issues the BLKDISCARD
> ioctl.
> 
> Note that some filesystems call blkdev_issue_discard or
> __blkdev_issue_discard directly, they may not be prepared to handle the
> failure, so this patch introduces a flag BLKDEV_DISCARD_KILLABLE that is
> only set when the discard is initiated by an ioctl.

This might be cleaner as a regular request flag, since killable can
apply to other types of IO as well - like readahead.

-- 
Jens Axboe
