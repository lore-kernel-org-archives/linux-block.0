Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 11/11] nvme: add support for streams and directives
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497633883-21230-1-git-send-email-axboe@kernel.dk>
 <1497633883-21230-12-git-send-email-axboe@kernel.dk>
 <20170616180942.GD27996@infradead.org>
 <9811b106-a954-2481-8a66-afb25df76812@kernel.dk>
 <20170617122106.GB8320@infradead.org>
 <1ede2083-69db-a86f-8e32-43ca293e9c8e@kernel.dk>
 <20170617150303.GA15290@infradead.org>
 <b159f6cb-a272-cd06-207a-4cce8336c86d@kernel.dk>
Message-ID: <b8b96879-1857-12d2-433a-97166464459e@kernel.dk>
Date: Sat, 17 Jun 2017 09:43:03 -0600
MIME-Version: 1.0
In-Reply-To: <b159f6cb-a272-cd06-207a-4cce8336c86d@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/17/2017 09:11 AM, Jens Axboe wrote:
> On 06/17/2017 09:03 AM, Christoph Hellwig wrote:
>> On Sat, Jun 17, 2017 at 08:20:01AM -0600, Jens Axboe wrote:
>>> We can certainly go that route. So you'd be fine with allocating 4
>>> streams controller wide by default, and dump the lazy alloc? We can make
>>> this depend on the streams module parameter, so people could turn it
>>> off, if needed.
>>
>> We don't even need to allocate the streams - streams are implicitly
>> allocated on first use:
>>
>> "Stream resources that are not allocated for the exclusive use of any
>>  namespace are available NVM subsystem stream resources as reported in
>>  NVM Subsystem Streams Available (NSSA) and may be used by any namespace
>>  that has the Streams Directive enabled and has not been allocated
>>  exclusive stream resources in response to an Allocate Resources
>>  operation."
>>
>> so the only thing you need to do is to enable streams on the namespace,
>> or just for whole whole controller using nsid=0xffffffff
> 
> I have two samples here, and I just tested, and both of them want it
> assigned with nsid=0xffffffff or they will fail the writes... So I'd say
> we're better off ensuring we do allocate them globally.
> 
> For the IO limits, are you sure you want those exposed? SWS is a write
> setting, exposing it as io_min may not make sense. For discard,
> SWS * SGS * block_size ends up being huge, but I guess at least that
> setting does make sense.

http://git.kernel.dk/cgit/linux-block/commit/?h=write-stream&id=7c36ee9b7da9fdd26a9663870f49a30ca34d36af

I think that should cover all the comments.

-- 
Jens Axboe
