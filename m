Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: fix schedule-under-preempt for blocking drivers
To: Christoph Hellwig <hch@lst.de>
References: <b298fcf4-47bc-b2e1-7c8f-b4affe347501@kernel.dk>
 <20170330182825.GA25277@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Josef Bacik <josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <99c16b2f-53a8-12c3-f590-bdc4d2abb3ed@kernel.dk>
Date: Thu, 30 Mar 2017 12:30:10 -0600
MIME-Version: 1.0
In-Reply-To: <20170330182825.GA25277@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/30/2017 12:28 PM, Christoph Hellwig wrote:
> Oh, I need to add one of the blocking drivers to my test runs..

I was just thinking that too. The easiest would be to add a BLOCKING
mode to null_blk.

-- 
Jens Axboe
