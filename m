Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/9] blk-mq: expose write hints through debugfs
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 martin.petersen@oracle.com
References: <1498491480-16306-1-git-send-email-axboe@kernel.dk>
 <1498491480-16306-4-git-send-email-axboe@kernel.dk>
 <20170627151725.GA28403@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b4dad806-8bc9-f414-6d4f-c486e9b23a58@kernel.dk>
Date: Tue, 27 Jun 2017 09:20:27 -0600
MIME-Version: 1.0
In-Reply-To: <20170627151725.GA28403@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/27/2017 09:17 AM, Christoph Hellwig wrote:
> On Mon, Jun 26, 2017 at 09:37:54AM -0600, Jens Axboe wrote:
>> Useful to verify that things are working the way they should.
>> Reading the file will return number of kb written with each
>> write hint. Writing the file will reset the statistics. No care
>> is taken to ensure that we don't race on updates.
>>
>> Drivers will write to q->write_hints[] if they handle a given
>> write hint.
> 
> How about moving the accounting itself to blk-mq as well?  Just noticed
> that it's completely generic while looking over the nvme patch.

I didn't want to do it, unless the driver is using streams.


-- 
Jens Axboe
