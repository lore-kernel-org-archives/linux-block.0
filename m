Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET v2] Add support for write life time hints
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
 <yq160fyvah7.fsf@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d3e724ea-38f8-213f-a9ce-f78adc028e47@kernel.dk>
Date: Wed, 14 Jun 2017 09:53:05 -0600
MIME-Version: 1.0
In-Reply-To: <yq160fyvah7.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/14/2017 09:45 AM, Martin K. Petersen wrote:
> 
> Jens,
> 
>> A new iteration of this patchset, previously known as write streams.
>> As before, this patchset aims at enabling applications split up
>> writes into separate streams, based on the perceived life time
>> of the data written. This is useful for a variety of reasons:
>>
>> - With NVMe 1.3 compliant devices, the device can expose multiple
>>   streams. Separating data written into streams based on life time
>>   can drastically reduce the write amplification. This helps device
>>   endurance, and increases performance. Testing just performed
>>   internally at Facebook with these patches showed up to a 25%
>>   reduction in NAND writes in a RocksDB setup.
>>
>> - Software caching solutions can make more intelligent decisions
>>   on how and where to place data.
>>
>> Contrary to previous patches, we're not exposing numeric stream values
>> anymore.  I've previously advocated for just doing a set of hints that
>> makes sense instead. See the coverage from the LSFMM summit this year:
> 
> I am all for having these write hints. But one request I would like to
> make is that we just make them flags and abolish all notions of the term
> "streams" from block for this particular use case (since it is more
> hinty than streamy).
> 
> There are devices coming where a proper stream ID is prerequisite to
> separate data streams for other reasons than bucketing based on data
> lifetime. So my preference would be that we make the lifetime hints be
> flags in block. That does not preclude using Streams Directives to
> implement them in the NVMe NAND flash case. But it does not cause
> conflicts with the use cases that need "proper" stream IDs for QoS or
> colocation avoidance purposes in SCSI.

So how about we just call it "write_hint"? It sounds mostly like a
naming issue to me, as you would then map that to some specific stream
in your driver. You're free to do that right now. They are all flags,
it's just packed as a value to not waste too much space.

-- 
Jens Axboe
