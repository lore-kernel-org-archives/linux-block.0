Return-Path: <BATV+968ece990c153ae608a0+4733+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 8 Aug 2016 06:19:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, linus.walleij@linaro.org,
	broonie@kernel.org
Subject: Re: [PATCH V2 00/22] Replace the CFQ I/O Scheduler with BFQ
Message-ID: <20160808131954.GA12647@infradead.org>
References: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Again,

please don't spend more time on the legacy request interface.  If you
want your work included and make an impact add it to blk-mq.
