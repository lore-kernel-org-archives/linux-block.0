Return-Path: <hch@lst.de>
Date: Thu, 23 Mar 2017 15:43:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
	martin.petersen@oracle.com, axboe@kernel.dk,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: support ranges TRIM for libata
Message-ID: <20170323144330.GA31447@lst.de>
References: <20170320204319.12628-1-hch@lst.de> <20170321185901.GB3706@htj.duckdns.org> <20170322181947.GA4733@lst.de> <1490276861.2202.8.camel@HansenPartnership.com> <20170323135521.GA30361@lst.de> <1490279706.2202.17.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490279706.2202.17.camel@HansenPartnership.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 23, 2017 at 10:35:06AM -0400, James Bottomley wrote:
> I'm certainly not saying we blindly follow t10, but I believe their
> intent is to issue the next command from the completion of the first
> (we can do this using qc->complete_fn, like atapi_request_sense).  That
> way we don't get any tag problems because there's only one command
> outstanding at once; reusing the qc means no allocation issues either.
> 
> The t10 approach does mean the SG_IO problem is actually fixable rather
> than simply erroring out.

It would be sort of fixable, but with a lot of hackery.

> That's up to you ... from the point of view of code documenting itself,
> forming the ATA_16 TRIM in sd and not doing any satl transformation is
> easier for others to follow, but if it's going to cause more code, I'm
> only marginal on the advantages of easier to follow code.

I tried this earlier before giving up on it because it looked to ugly.
But I can complete that version of it and post it for people to compare.
