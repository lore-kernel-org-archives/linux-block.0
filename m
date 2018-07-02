Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Mon, 2 Jul 2018 15:08:05 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org,
        Douglas Gilbert <dgilbert@interlog.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] scsi: scsi_debug: introduce module parameter of
 'use_blk_mq'
Message-ID: <20180702130805.e2glvr5rx5vcnmzl@linux-x5ow.site>
References: <20180702050642.26265-1-ming.lei@redhat.com>
 <20180702125422.GA600@infradead.org>
 <20180702125652.jxjcig63xvljfqow@linux-x5ow.site>
 <20180702130310.GA19610@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180702130310.GA19610@infradead.org>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 02, 2018 at 06:03:10AM -0700, Christoph Hellwig wrote:
> Yes, totally.  We'll just need to sort out the error handling with
> scsi and mq first (for 4.18 in fact).

Sure.

	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
