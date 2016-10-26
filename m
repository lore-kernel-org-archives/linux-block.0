Return-Path: <BATV+31c1bd2ad9e9d76aef3a+4812+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 26 Oct 2016 03:19:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, linus.walleij@linaro.org,
	broonie@kernel.org, hare@suse.de, arnd@arndb.de,
	bart.vanassche@sandisk.com, grant.likely@secretlab.ca, jack@suse.cz,
	James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra
 scheduler
Message-ID: <20161026101903.GA22361@infradead.org>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Just as last time:

big NAK for introducing giant new infrastructure like a new I/O scheduler
for the legacy request structure.

Please direct your engergy towards blk-mq instead.
