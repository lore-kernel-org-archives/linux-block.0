Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET v2] Add support for write life time hints
To: Andreas Dilger <adilger@dilger.ca>
Cc: Martin Petersen <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@infradead.org>,
 fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
 <yq160fyvah7.fsf@oracle.com> <d3e724ea-38f8-213f-a9ce-f78adc028e47@kernel.dk>
 <20170614160127.GA30644@infradead.org> <yq1shj2tv1z.fsf@oracle.com>
 <20382261-3180-41F0-B959-9181C2FF4BAA@dilger.ca>
 <9e152ed7-ed49-bb62-902c-0daac7646a86@kernel.dk>
 <48A74D71-9765-4881-B337-761FE66757BB@dilger.ca>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d83b67c8-e4d6-d450-5cc2-4f0f56961443@kernel.dk>
Date: Wed, 14 Jun 2017 21:57:51 -0600
MIME-Version: 1.0
In-Reply-To: <48A74D71-9765-4881-B337-761FE66757BB@dilger.ca>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 06/14/2017 09:53 PM, Andreas Dilger wrote:
> On Jun 14, 2017, at 9:26 PM, Jens Axboe <axboe@kernel.dk> wrote:
>> On Wed, Jun 14, 2017 at 5:39 PM, Andreas Dilger <adilger@dilger.ca> wrote:
>>> On Jun 14, 2017, at 10:04 AM, Martin K. Petersen <martin.petersen@oracle.com> wrote:
>>>> Christoph,
>>>>
>>>>> I think what Martin wants (or at least what I'd want him to want) is
>>>>> to define a few REQ_* bits that mirror the RWF bits, use that to
>>>>> transfer the information down the stack, and then only translate it
>>>>> to stream ids in the driver.
>>>>
>>>> Yup. If we have enough space in the existing flags that's perfect (I
>>>> lost count after your op/flag shuffle).
>>>
>>> Just to clarify, does this mean that Jens' "lifetime" hints are going to
>>> be independent of separate "stream ID" values in the future (needing a
>>> similar, but independent, set of fields for stream IDs, or will they
>>> both be implemented using a common transport in the kernel (i.e. both
>>> share a single set of fields in the inode/bio/etc?
>>
>> There's no reason they can't coexist. Now that bio->bi_stream is gone
>> and we just have the flags, if we want to expose separate "real" stream
>> IDs, then we could later re-introduce that. It'd be pretty trivial to
>> just use the most pertinent information on the driver side.
>>
>> From my perspective, all I really care about is the 4 hints. It's a
>> simple enough interface that applications can understand and use it, and
>> we don't need any management of actual stream IDs. I think that has the
>> highest chance of success. Modifying an application to use it is
>> trivial, even something like RocksDB (if you havehad to make changes
>> to RocksDB, you'll get this).
> 
> If this is really to be only flags, rather than a hybrid of flags and IDs
> (as I had thought), then it probably makes sense to limit the inode usage
> to a few bits in i_flags using S_LIFETIME_* values rather than a separate
> 16-bit i_stream field, which can be used for the actual stream IDs later.

Christoph alluded to that as well. And yes, if we are contemplating
something else later on, then that does make more sense. I'll make that
change.

-- 
Jens Axboe
