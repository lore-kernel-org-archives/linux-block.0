Return-Path: <hch@lst.de>
Date: Fri, 26 May 2017 07:15:40 +0200
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 02/15] scsi/osd: don't save block errors into
	req_results
Message-ID: <20170526051540.GA17709@lst.de>
References: <20170518131812.22956-1-hch@lst.de> <20170518131812.22956-3-hch@lst.de> <1495641879.2823.7.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1495641879.2823.7.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 24, 2017 at 04:04:40PM +0000, Bart Van Assche wrote:
> Are you sure that that code is not necessary? From osd_initiator.c:
> 
> static void _put_request(struct request *rq)
> {
> 	/*
> 	 * If osd_finalize_request() was called but the request was not
> 	 * executed through the block layer, then we must release BIOs.
> 	 * TODO: Keep error code in or->async_error. Need to audit all
> 	 *�������code paths.
> 	 */
> 	if (unlikely(rq->bio))
> 		blk_end_request(rq, -ENOMEM, blk_rq_bytes(rq));
> 	else
> 		blk_put_request(rq);
> }

Which isn't using it at all.  It has a ten year old comment to pass
on some error, but even then ORing two different error types together
would no be very helpful.

> 
> Bart.---end quoted text---
