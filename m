Return-Path: <James.Bottomley@hansenpartnership.com>
Message-ID: <1490276861.2202.8.camel@HansenPartnership.com>
Subject: Re: support ranges TRIM for libata
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>
Cc: martin.petersen@oracle.com, axboe@kernel.dk, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Date: Thu, 23 Mar 2017 09:47:41 -0400
In-Reply-To: <20170322181947.GA4733@lst.de>
References: <20170320204319.12628-1-hch@lst.de>
	 <20170321185901.GB3706@htj.duckdns.org> <20170322181947.GA4733@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-03-22 at 19:19 +0100, Christoph Hellwig wrote:
> On Tue, Mar 21, 2017 at 02:59:01PM -0400, Tejun Heo wrote:
> > I do like the fact that this is a lot simpler than the previous
> > implementation but am not quite sure we want to deviate 
> > significantly from what we do for other commands (command 
> > translation).  Is it because fixing the existing implementation 
> > would involve invaisve changes including memory allocations?
> 
> The current implementation already has the issue of that it does
> corrupt user data reliably if the using SG_IO for WRITE SAME
> commands.

That does need fixing.

> Doing ranges using translation would turn into a nightmare because
> ATA TRIM ranges are 16 bits long while SCSI UNAMP ranges are 32-bit,
> so we effectively can't translated them without introducing a
> non-standard hook between libata and scsi to communicate that
> limit.

Why can't we do what the t10 sat document recommends: if the ATA device
doesn't support the XL version (32 bit ranges) then translate unmap to
multiple non-XL commands?

I don't necessarily object to the vendor specific 1<->1 approach, it's
just it won't fix the problem you cited above (SG_IO WRITE SAME), its
just that now we error the command, which may cause some surprise.  I
also wonder if we couldn't simply do an ATA_16 TRIM if we're already
going to all the trouble of recognising ATA devices in the sd discard
path?

James

>   And once we're down that path we might as well just do the
> right thing directly.
