Return-Path: <BATV+6506708c052d87f84ad0+5426+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 2 Jul 2018 06:41:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Linux SCSI List <linux-scsi@vger.kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block <linux-block@vger.kernel.org>,
	Douglas Gilbert <dgilbert@interlog.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] scsi: scsi_debug: introduce module parameter of
 'use_blk_mq'
Message-ID: <20180702134134.GA15401@infradead.org>
References: <20180702050642.26265-1-ming.lei@redhat.com>
 <20180702125422.GA600@infradead.org>
 <CACVXFVPn5VJraoidihjA5_hzuRBU_JBJAtRsNr_x9Cc3iWwaAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVPn5VJraoidihjA5_hzuRBU_JBJAtRsNr_x9Cc3iWwaAw@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 02, 2018 at 09:13:35PM +0800, Ming Lei wrote:
> On Mon, Jul 2, 2018 at 8:54 PM, Christoph Hellwig <hch@infradead.org> wrote:
> > On Mon, Jul 02, 2018 at 01:06:42PM +0800, Ming Lei wrote:
> >> With the introduced module parameter of 'use_blk_mq', it is easy
> >> to switch between 'blk_mq' and 'non_blk_mq' by reloading scsi_debug
> >> module, so that we can test scsi_mq/blk_mq related regressions easily.
> >
> > No.  We should not make a per driver choice.
> 
> Could you share us why we can't?

Because it really is not a driver propery what code we use, it
is one of the core scsi code.  And intended as a temporary one,
although it already has lasted far too long.
