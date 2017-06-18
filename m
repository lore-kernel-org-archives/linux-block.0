Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 05/10] blk-mq: simplify blk_mq_free_request
To: Christoph Hellwig <hch@lst.de>
Cc: Omar Sandoval <osandov@fb.com>, Paolo Valente <paolo.valente@linaro.org>,
 linux-block@vger.kernel.org
References: <20170616161527.17649-1-hch@lst.de>
 <20170616161527.17649-6-hch@lst.de>
 <c077675d-5ff0-a3e4-1caa-23554e0e246d@kernel.dk>
 <20170618072406.GA25582@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c632d273-e363-d83d-7f3b-5dea0efd3d47@kernel.dk>
Date: Sun, 18 Jun 2017 09:05:41 -0600
MIME-Version: 1.0
In-Reply-To: <20170618072406.GA25582@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/18/2017 01:24 AM, Christoph Hellwig wrote:
> On Sat, Jun 17, 2017 at 03:50:40PM -0600, Jens Axboe wrote:
>> On 06/16/2017 10:15 AM, Christoph Hellwig wrote:
>>> Merge three functions only tail-called by blk_mq_free_request into
>>> blk_mq_free_request.
>>
>> This doesn't compile, as blk_mq_merge_queue_io() has a call to
>> __blk_mq_finish_request().
> 
> Hmm.  The tree I've based my work on certainly doesn't.  But it doesn't
> even have blk_mq_merge_queue_io at all either, as does your for-4.13/block
> block tree.
> 
> What am I missing?

I tossed it into master for testing by mistake. It's fine against
for-4.13/block, my fault.

I ran it through the regular testing and no issues uncovered so far.

-- 
Jens Axboe
