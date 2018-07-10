Return-Path: <mpatocka@redhat.com>
Date: Mon, 9 Jul 2018 21:10:01 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: linux-block@vger.kernel.org, Zdenek Kabelac <zkabelac@redhat.com>,
        Mike Snitzer <msnitzer@redhat.com>, dm-devel@redhat.com
Subject: Re: [PATCH] block: make discard killable
In-Reply-To: <8163a50c-06a1-1b56-7927-7d5cc56d1038@kernel.dk>
Message-ID: <alpine.LRH.2.02.1807092031450.30863@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1807031334400.22443@file01.intranet.prod.int.rdu2.redhat.com> <8163a50c-06a1-1b56-7927-7d5cc56d1038@kernel.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>



On Fri, 6 Jul 2018, Jens Axboe wrote:

> On 7/3/18 11:35 AM, Mikulas Patocka wrote:
> > Discarding can take very long time for some device mapper targets, this
> > patch makes it possible to kill a process that issues the BLKDISCARD
> > ioctl.
> > 
> > Note that some filesystems call blkdev_issue_discard or
> > __blkdev_issue_discard directly, they may not be prepared to handle the
> > failure, so this patch introduces a flag BLKDEV_DISCARD_KILLABLE that is
> > only set when the discard is initiated by an ioctl.
> 
> This might be cleaner as a regular request flag, since killable can
> apply to other types of IO as well - like readahead.
> 
> -- 
> Jens Axboe

blkdev_issue_discard and __blkdev_issue_discard doesn't take flags for the 
request - it has a "flags" argument which could only contain one flag - 
BLKDEV_DISCARD_SECURE.

Do you want to copy the "flags" argument from blkdev_issue_discard to the 
bio and check the bio flag in generic_make_request?

Mikulas
