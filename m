Return-Path: <hch@lst.de>
Date: Thu, 18 May 2017 11:40:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paolo Valente <paolo.valente@linaro.org>
Subject: Re: Outstanding MQ questions from MMC
Message-ID: <20170518094042.GA10016@lst.de>
References: <CACRpkdbZrkAqEdP1-QqDww0ZuFcY47Jgj9dPqkG_whrx7pwC-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACRpkdbZrkAqEdP1-QqDww0ZuFcY47Jgj9dPqkG_whrx7pwC-w@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Mar 29, 2017 at 05:09:37AM +0200, Linus Walleij wrote:
> 2. When MMC cards are ejected a serious error condition occurs. So for this
> reason we spool out the queue with
> 
> req->rq_flags |= RQF_QUIET;
> blk_end_request_all(req, -EIO);
> 
> This will shut up a huge amount of console errors for example.
> I have no clue on how to manage this with MQ. I am currently using
> 
> blk_mq_complete_request(mq_rq->req, -EIO);
> 
> and nothing else, and it will hit all requests for the ejected card coming
> in from this point. Is this the right solution? Or is there some medium
> eject handling I'm not aware of inside the MQ layer? It seems like something
> that can happen on pluggable harddrives and CDROMS and what not.

Hot unplug handling currently is a mess in the block layer (not just the
mq case).  Especially if you ever requeue an I/O there is tons of
boilerplate code.  I wish we could move a little more of this into the
core, but right now I don't have a good idea on how to.

> 3. Sometimes a read or write gets partially completed. Say we read 12 out
> of 15 sectors or somthing like that. I have no idea how often this occurs in
> practice. With the old block layer we did this:
> 
> blk_end_request(req, 0, bytes_xfered);

You can still do this with mq, but you have to open code it.  Take a look
at scsi_end_request which has opencoded versions of the mq and non-mq
end_request routines.  Currently it's the only example of blk-mq partial
completions.
