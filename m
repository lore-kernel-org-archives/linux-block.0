Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Tue, 24 Jan 2017 08:06:39 -0700
From: Jens Axboe <axboe@fb.com>
To: Christoph Hellwig <hch@lst.de>
CC: Mike Snitzer <snitzer@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <dm-devel@redhat.com>
Subject: Re: [PATCH 01/16] block: fix elevator init check
Message-ID: <20170124150639.GA22198@kernel.dk>
References: <1485185361-29786-1-git-send-email-hch@lst.de>
 <1485185361-29786-2-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1485185361-29786-2-git-send-email-hch@lst.de>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 23 2017, Christoph Hellwig wrote:
> We can't initalize the elevator fields for flushes as flush share space
> in struct request with the elevator data.  But currently we can't
> commnicate that a request is a flush through blk_get_request as we
> can only pass READ or WRITE, and the low-level code looks at the
> possible NULL bio to check for a flush.
> 
> Fix this by allowing to pass any block op and flags, and by checking for
> the flush flags in __get_request.

We check for REQ_PREFLUSH | REQ_FUA in so many places though, might not
be a bad idea to keep the helper but just make it take the opf and fix
up the other locations too. The fact that PREFLUSH|FUA is the magic to
check for is somewhat tribal knowledge.

-- 
Jens Axboe

