Return-Path: <BATV+31c1bd2ad9e9d76aef3a+4812+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 26 Oct 2016 08:29:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>,
	Paolo Valente <paolo.valente@linaro.org>,
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, linus.walleij@linaro.org,
	broonie@kernel.org, hare@suse.de, grant.likely@secretlab.ca,
	James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra
 scheduler
Message-ID: <20161026152955.GA21262@infradead.org>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org>
 <20161026113443.GA13587@quack2.suse.cz>
 <4ed3e291-b3e5-5ee3-6838-58644bd3d99b@sandisk.com>
 <12386463.fJy0cVexVD@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12386463.fJy0cVexVD@wuerfel>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 26, 2016 at 05:13:07PM +0200, Arnd Bergmann wrote:
> The question to ask first is whether to actually have pluggable
> schedulers on blk-mq at all, or just have one that is meant to
> do the right thing in every case (and possibly can be bypassed
> completely).

That would be my preference.  Have a BFQ-variant for blk-mq as an
option (default to off unless opted in by the driver or user), and
not other scheduler for blk-mq.  Don't bother with bfq for non
blk-mq.  It's not like there is any advantage in the legacy-request
device even for slow devices, except for the option of having I/O
scheduling.
