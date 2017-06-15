Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 02/11] blk-mq: expose stream write stats through debugfs
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
 <1497498312-17704-3-git-send-email-axboe@kernel.dk>
 <20170615081615.GB10599@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1f08b99a-5e42-38bf-cc77-8ba9973701ab@kernel.dk>
Date: Thu, 15 Jun 2017 08:24:31 -0600
MIME-Version: 1.0
In-Reply-To: <20170615081615.GB10599@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/15/2017 02:16 AM, Christoph Hellwig wrote:
> On Wed, Jun 14, 2017 at 09:45:03PM -0600, Jens Axboe wrote:
>> Useful to verify that things are working the way they should.
>> Reading the file will return number of kb written to each
>> stream. Writing the file will reset the statistics. No care
>> is taken to ensure that we don't race on updates.
>>
>> Drivers will write to q->stream_writes[] if they handle a stream.
> 
> What's blk-mq specific about this?  Seems like this either should
> be generic block or nvme specific, but probably not blk-mq.  And
> of course the name should change with the rest of the names now.

There is nothing blk-mq specific about it, but it's a handy place
to stick some debug data, as we don't have debugfs support for non
blk-mq. I'm fine with even dumping this, but it's useful for debugging
that things are being passed all the way through correctly for now.

-- 
Jens Axboe
