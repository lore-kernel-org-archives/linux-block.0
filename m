Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 02/12] blk-mq: expose stream write stats through debugfs
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, hch@infradead.org
References: <1497544930-19174-1-git-send-email-axboe@kernel.dk>
 <1497544930-19174-3-git-send-email-axboe@kernel.dk>
 <yq1mv97q44g.fsf@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9c196af4-c7c7-6b9e-8ccf-166b5f0751c2@kernel.dk>
Date: Fri, 16 Jun 2017 10:41:45 -0600
MIME-Version: 1.0
In-Reply-To: <yq1mv97q44g.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/16/2017 10:38 AM, Martin K. Petersen wrote:
> 
> Jens,
> 
>> Useful to verify that things are working the way they should.
>> Reading the file will return number of kb written to each
>> stream. Writing the file will reset the statistics. No care
>> is taken to ensure that we don't race on updates.
>>
>> Drivers will write to q->stream_writes[] if they handle a stream.
> 
> s/stream/write_lifetime_bucket/ or something like that.

Yeah, it's the only piece left over. I'll make that change.

-- 
Jens Axboe
