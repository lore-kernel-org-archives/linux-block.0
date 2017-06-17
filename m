Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 05/10] blk-mq: simplify blk_mq_free_request
To: Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>,
 Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org
References: <20170616161527.17649-1-hch@lst.de>
 <20170616161527.17649-6-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c077675d-5ff0-a3e4-1caa-23554e0e246d@kernel.dk>
Date: Sat, 17 Jun 2017 15:50:40 -0600
MIME-Version: 1.0
In-Reply-To: <20170616161527.17649-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/16/2017 10:15 AM, Christoph Hellwig wrote:
> Merge three functions only tail-called by blk_mq_free_request into
> blk_mq_free_request.

This doesn't compile, as blk_mq_merge_queue_io() has a call to
__blk_mq_finish_request().


-- 
Jens Axboe
