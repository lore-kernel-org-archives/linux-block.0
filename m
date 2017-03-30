Return-Path: <msnitzer@redhat.com>
Date: Thu, 30 Mar 2017 09:49:57 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, agk@redhat.com,
	shli@kernel.org, philipp.reisner@linbit.com,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	drbd-dev@lists.linbit.com, dm-devel@redhat.com,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH 22/23] drbd: implement REQ_OP_WRITE_ZEROES
Message-ID: <20170330134957.GA508@redhat.com>
References: <20170323143341.31549-1-hch@lst.de>
 <20170323143341.31549-23-hch@lst.de>
 <20170330100641.GI5939@soda.linbit>
 <20170330114408.GA15777@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170330114408.GA15777@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 30 2017 at  7:44am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Mar 30, 2017 at 12:06:41PM +0200, Lars Ellenberg wrote:
> 
> > Will it make an fstrim cause thinly provisioned
> > devices to suddenly be fully allocated?
> 
> Not for SCSI devices.  Yes for dm-thinp until it implements
> REQ_OP_WRITE_ZEROES, which will hopefully be soon.

I can work on this now.  Only question I have is: should DM thinp take
care to zero any misaligned head and tail?  (I assume so but with all
the back and forth between Bart, Paolo and Martin I figured I'd ask
explicitly).
