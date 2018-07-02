Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Mon, 2 Jul 2018 05:54:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org,
        Douglas Gilbert <dgilbert@interlog.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] scsi: scsi_debug: introduce module parameter of
 'use_blk_mq'
Message-ID: <20180702125422.GA600@infradead.org>
References: <20180702050642.26265-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180702050642.26265-1-ming.lei@redhat.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 02, 2018 at 01:06:42PM +0800, Ming Lei wrote:
> With the introduced module parameter of 'use_blk_mq', it is easy
> to switch between 'blk_mq' and 'non_blk_mq' by reloading scsi_debug
> module, so that we can test scsi_mq/blk_mq related regressions easily.

No.  We should not make a per driver choice.
