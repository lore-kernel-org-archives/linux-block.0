Return-Path: <axboe@kernel.dk>
Subject: Re: streamline blk-mq I/O scheduler interaction
To: Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>,
 Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org
References: <20170616161527.17649-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <925130ff-40f4-c4b6-2a1a-31195c5393c5@kernel.dk>
Date: Sun, 18 Jun 2017 12:35:14 -0600
MIME-Version: 1.0
In-Reply-To: <20170616161527.17649-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/16/2017 10:15 AM, Christoph Hellwig wrote:
> Hi blk-mq І/O scheduler folks,
> 
> I've been trying to re-learn our I/O path after the scheduler additions,
> and when walking through the code the following optimization came to
> my mind.  I've only done basic testing with them, so for now this is
> a bit of a RFC.

Added for 4.13, thanks.

-- 
Jens Axboe
