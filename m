Return-Path: <BATV+8b936f0259a3f6fbcbd3+5432+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sun, 8 Jul 2018 12:18:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Mikulas Patocka <mpatocka@redhat.com>, linux-block@vger.kernel.org,
	Mike Snitzer <msnitzer@redhat.com>, dm-devel@redhat.com,
	Zdenek Kabelac <zkabelac@redhat.com>
Subject: Re: [dm-devel] [PATCH] block: make discard killable
Message-ID: <20180708191857.GA16756@infradead.org>
References: <alpine.LRH.2.02.1807031334400.22443@file01.intranet.prod.int.rdu2.redhat.com>
 <8163a50c-06a1-1b56-7927-7d5cc56d1038@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8163a50c-06a1-1b56-7927-7d5cc56d1038@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 06, 2018 at 07:51:30AM -0600, Jens Axboe wrote:
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

He doesn't actually make the request killable, but just the
synchronous submission loop.  I have an actually killable version
of blk_execute_rq on m short-term todo plate as we want it for the
nvme passthrough ioctls.  That might be useful for discard as well.
