Return-Path: <hch@lst.de>
Date: Tue, 3 Oct 2017 17:19:57 +0200
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH 2/2] block: fix peeking requests during PM
Message-ID: <20171003151957.GA5995@lst.de>
References: <20171003084701.19346-1-hch@lst.de> <20171003084701.19346-3-hch@lst.de> <1507043621.2702.4.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507043621.2702.4.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Oct 03, 2017 at 03:13:43PM +0000, Bart Van Assche wrote:
> > +	switch (rq->q->rpm_status) {
> > +	case RPM_SUSPENDED:
> > +		return false;
> > +	case RPM_ACTIVE:
> > +		return rq->rq_flags & RQF_PM;
> > +	default:
> > +		return true;
> > +	}
> >  }
> 
> Hello Christoph,
> 
> The old code does not process non-PM requests in the RPM_SUSPENDING mode nor
> in the RPM_RESUMING code. I think the new code processes all requests in
> these two modes. Was that behavior change intended?

Yeah, looks like this version has the RPM_ACTIVE and default cases
switched.  Back to the drawing board.
