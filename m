Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180702125422.GA600@infradead.org>
References: <20180702050642.26265-1-ming.lei@redhat.com> <20180702125422.GA600@infradead.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 2 Jul 2018 21:13:35 +0800
Message-ID: <CACVXFVPn5VJraoidihjA5_hzuRBU_JBJAtRsNr_x9Cc3iWwaAw@mail.gmail.com>
Subject: Re: [PATCH] scsi: scsi_debug: introduce module parameter of 'use_blk_mq'
To: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Linux SCSI List <linux-scsi@vger.kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>, linux-block <linux-block@vger.kernel.org>,
	Douglas Gilbert <dgilbert@interlog.com>, Bart Van Assche <bart.vanassche@wdc.com>,
	Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 2, 2018 at 8:54 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Jul 02, 2018 at 01:06:42PM +0800, Ming Lei wrote:
>> With the introduced module parameter of 'use_blk_mq', it is easy
>> to switch between 'blk_mq' and 'non_blk_mq' by reloading scsi_debug
>> module, so that we can test scsi_mq/blk_mq related regressions easily.
>
> No.  We should not make a per driver choice.

Could you share us why we can't?

BTW, this patch can make scsi_mq/blk_mq regression tests to
be implemented very easily, such as, run one test in non-mq mode,
and run it in mq mode, then compare the two.

Thanks,
Ming Lei
