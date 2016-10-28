Return-Path: <BATV+14893e82242582bc6e4d+4814+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 28 Oct 2016 08:29:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
	Paolo Valente <paolo.valente@linaro.org>,
	Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
	linux-block@vger.kernel.org,
	Linux-Kernal <linux-kernel@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra
 scheduler
Message-ID: <20161028152908.GA21341@infradead.org>
References: <38156FA7-9A66-44DC-8D0C-28F149D1E49B@linaro.org>
 <09fc1e06-3fd6-b13d-0dd9-0edfb55b01d1@kernel.dk>
 <CAPDyKFrCNS_ZWzVU9Y=J9q0ewp-7=VFs4LwV69SzgSGHBxTn-g@mail.gmail.com>
 <15ee2d0e-2d3a-81e2-9f83-f875e41bf388@kernel.dk>
 <CAPDyKFoi64Q0H9x2F35oY85PMDNq4hRsmqGYiP+En+qtQ4+Bag@mail.gmail.com>
 <1ac9b794-7e7f-0748-e4c8-a13034aecbc3@kernel.dk>
 <CAPDyKFpLhp0eoS8LWy-jU0_U_cWq4immq2+bPdi-j7=oa24OjA@mail.gmail.com>
 <e792e932-cf16-4272-2388-ae813a0372b6@kernel.dk>
 <CACRpkdbngAKuwDaUwZ=QaW9POb4U2tFJA60aLKD6QZKf60bq6g@mail.gmail.com>
 <CACRpkda0fmPdM2WZ_gtW=T7xvMfP_4ErtNZseExN2AggzZbcDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CACRpkda0fmPdM2WZ_gtW=T7xvMfP_4ErtNZseExN2AggzZbcDQ@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 28, 2016 at 11:32:21AM +0200, Linus Walleij wrote:
> So I'm not just complaining by the way, I'm trying to fix this. Also
> Bartlomiej from Samsung has done some stabs at switching MMC/SD
> to blk-mq. I just rebased my latest stab at a na�ve switch to blk-mq
> to v4.9-rc2 with these results.
> 
> The patch to enable MQ looks like this:
> https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-stericsson.git/commit/?h=mmc-mq&id=8f79b527e2e854071d8da019451da68d4753f71d
> 
> I run these tests directly after boot with cold caches. The results
> are consistent: I ran the same commands 10 times in a row.

A couple comments from a quick look over the patch:

In the changelog you complain:

". Lack of front- and back-end merging in the MQ block layer creating
several small requests instead of a few large ones."

In blk-mq merging is controller by the BLK_MQ_F_SHOULD_MERGE and
BLK_MQ_F_SG_MERGE flags.  You set the former, but not the latter.
BLK_MQ_F_SG_MERGE controls wether multiple physical contiguous pages get
merged into a single segment.  For a dd after a fresh boot that is
probably very common.  Except for the polarity of the merge flags the
basic merge functionality between the legacy and blk-mq path should be
the same, and if they aren't you've found a bug we need to address.

You also say that you disable the pipelining.  How much of a performance
gain did this feature give when added?  How much does just removing that
on it's own cost you?  While I think that features is rather messy and
should be avoided if possible I don't see how it's impossible to
implement in blk-mq.  If you just increase your queue depth and use
the old scheme you should get it - if you currently can't handle the
second command for some reason (i.e. the special request magic) you
can just return BLK_MQ_RQ_QUEUE_BUSY from the queue_rq function.
