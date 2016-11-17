Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET] Add support for simplified async direct-io
To: Christoph Hellwig <hch@infradead.org>
References: <20161114173728.GA22167@infradead.org>
 <71ce9ae3-214d-b248-3507-cc96bea41a9b@fb.com>
 <20161114180052.GA24476@infradead.org>
 <4f30a528-9996-4c6a-9513-8aa2054e4d4b@fb.com>
 <20161114180503.GA31126@infradead.org>
 <d9baad75-d105-2968-1b59-608a8598e3bb@fb.com>
 <20161114181119.GA9396@infradead.org>
 <f8c29e81-7323-7362-b507-1b7c61e8a19a@fb.com>
 <20161116163147.GA25038@infradead.org>
 <72b1725a-0363-d33e-f890-251b1ac88998@kernel.dk>
 <20161116171652.GA30008@infradead.org>
 <c46c5e60-a5eb-2862-2b1b-f994fd0d3fe3@kernel.dk>
 <ee72e7d0-e885-7b0a-b9cc-6572b0614c20@kernel.dk>
 <9b842e83-1f2f-a614-3783-6b0629b3ada7@kernel.dk>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <495b1807-5936-0891-8feb-1ac16bc67709@kernel.dk>
Date: Wed, 16 Nov 2016 20:44:35 -0700
MIME-Version: 1.0
In-Reply-To: <9b842e83-1f2f-a614-3783-6b0629b3ada7@kernel.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/16/2016 01:51 PM, Jens Axboe wrote:
> On 11/16/2016 01:36 PM, Jens Axboe wrote:
>> On 11/16/2016 01:02 PM, Jens Axboe wrote:
>>> On 11/16/2016 10:16 AM, Christoph Hellwig wrote:
>>>> I've pushed out a new version of my code that avoids atomic ops
>>>> for the single bio case:
>>>>
>>>> http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/new-dio
>>>>
>>>>
>>>> I think we should take your extension of the existing
>>>> __blkdev_direct_IO_simple to kmalloc up to BIO_MAX_PAGES and then use
>>>> the above implementation for AIO and large synchronous I/O.
>>>>
>>>> I think I can also kill of blkdev_dio_pool by simply using bio_kmalloc
>>>> as we're only doing the allocation at the beginning of the call,
>>>> but I'd like to agree on an approach before spending too much time on
>>>> it.
>>>>
>>>
>>> I'm fine with this approach, but I would still REALLY like to see
>>> blkdev_bio_end_io() split in two, once for sync and once for async. That
>>> would be a lot cleaner, imho.
>>>
>>> Let me know how you want to do it. I added SYNC support for mine here,
>>> the branch is here:
>>>
>>> http://git.kernel.dk/cgit/linux-block/log/?h=for-4.10/dio
>>
>> Attaching two patches here that add the BIO_MAX_PAGES extension, and the
>> SYNC support for your branch. Latter is untested... You can add my
>> reviewed-by to:
>>
>> 7bed5be4f28cc86e3929c0c0fbba24ca0344f36c
>> 57c2cf5c2595c0054855d7402d3796b5924fd05c
>>
>> I'd like to get this in for 4.10.
>
> Tested the cache flush part, seems to work fine as well for both sync
> and async O_DIRECT.

Updated the last patch, since it had both a typo in the subject line and
some duplicated code after I added the dio_should_flush_cache() helper.

Top two patches here:

http://git.kernel.dk/cgit/linux-block/log/?h=for-4.10/hch-dio

which is on top of your dio branch.

-- 
Jens Axboe
