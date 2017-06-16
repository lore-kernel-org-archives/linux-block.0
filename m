Return-Path: <axboe@kernel.dk>
Subject: Re: streamline blk-mq I/O scheduler interaction
To: Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>,
 Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org
References: <20170616161527.17649-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <448722b3-b1ec-2854-f4fc-b20ce95c9db8@kernel.dk>
Date: Fri, 16 Jun 2017 14:30:45 -0600
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

Most of these look straight forward and are good cleanups. I'll throw
some testing at it, too.

-- 
Jens Axboe
