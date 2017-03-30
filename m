Return-Path: <hch@lst.de>
Date: Thu, 30 Mar 2017 20:28:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] blk-mq: fix schedule-under-preempt for blocking drivers
Message-ID: <20170330182825.GA25277@lst.de>
References: <b298fcf4-47bc-b2e1-7c8f-b4affe347501@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b298fcf4-47bc-b2e1-7c8f-b4affe347501@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Oh, I need to add one of the blocking drivers to my test runs..

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
