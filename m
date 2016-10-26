Return-Path: <jack@suse.cz>
Date: Wed, 26 Oct 2016 13:34:43 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
	linus.walleij@linaro.org, broonie@kernel.org, hare@suse.de,
	arnd@arndb.de, bart.vanassche@sandisk.com,
	grant.likely@secretlab.ca, jack@suse.cz,
	James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra
 scheduler
Message-ID: <20161026113443.GA13587@quack2.suse.cz>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org>
 <20161026101903.GA22361@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161026101903.GA22361@infradead.org>
List-ID: <linux-block@vger.kernel.org>

On Wed 26-10-16 03:19:03, Christoph Hellwig wrote:
> Just as last time:
> 
> big NAK for introducing giant new infrastructure like a new I/O scheduler
> for the legacy request structure.
> 
> Please direct your engergy towards blk-mq instead.

Christoph, we will probably talk about this next week but IMO rotating
disks and SATA based SSDs are going to stay with us for another 15 years,
likely more. For them blk-mq is no win, relatively complex IO scheduling
like CFQ or BFQ does is a big win for them in some cases. So I think IO
scheduling (and thus place for something like BFQ) is going to stay with us
for quite a long time still. So are we going to add hooks in blk-mq to
support full-blown IO scheduling at least for single queue devices? Or how
else do we want to support that HW?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
