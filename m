Return-Path: <hch@lst.de>
Date: Fri, 26 May 2017 08:02:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 02/19] block: Introduce queue flag QUEUE_FLAG_SCSI_PDU
Message-ID: <20170526060214.GB18424@lst.de>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com> <20170525184327.23570-3-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170525184327.23570-3-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 25, 2017 at 11:43:10AM -0700, Bart Van Assche wrote:
> >From the context where a SCSI command is submitted it is not always
> possible to figure out whether or not the queue the command is
> submitted to has struct scsi_request as the first member of its
> private data. Hence introduce the flag QUEUE_FLAG_SCSI_PDU.

I would call it QUEUE_FLAG_SCSI_PASSTHROUGH, but except for that:

Reviewed-by: Christoph Hellwig <hch@lst.de>
