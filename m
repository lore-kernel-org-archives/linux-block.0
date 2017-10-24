Return-Path: <hch@lst.de>
Date: Tue, 24 Oct 2017 16:45:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2] block: fix peeking requests during PM
Message-ID: <20171024144550.GA23387@lst.de>
References: <20171020144523.4585-1-hch@lst.de> <20171023104315.GA30252@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171023104315.GA30252@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 23, 2017 at 06:43:16PM +0800, Ming Lei wrote:
> On Fri, Oct 20, 2017 at 04:45:23PM +0200, Christoph Hellwig wrote:
> > We need to look for an active PM request until the next softbarrier
> > instead of looking for the first non-PM request.  Otherwise any cause
> > of request reordering might starve the PM request(s).
> 
> Hi Christoph,
> 
> Could you share us how the starve is caused? Looks all PM
> request is run via scsi_execute(), and the caller is always
> waiting for the completion of PM request.
> 
> Especially PM request is run after SCSI device is in quiesce
> state, during that time, no normal(non-preempt) request can
> enter queue after the making quiesce safe patchset is merged.

I thought I stated that the issue is more theoretical, and the
real reason is to refactor this code for later additions.

Seems like that was only in the cover letter of the previous version,
though.
