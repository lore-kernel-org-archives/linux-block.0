Return-Path: <rgoldwyn@suse.de>
Subject: Re: [PATCH v5 1/2] Return bytes transferred for partial direct I/O
To: Jens Axboe <axboe@kernel.dk>
Cc: Andreas Dilger <adilger@dilger.ca>, Goldwyn Rodrigues
 <rgoldwyn@suse.com>, Andi Kleen <ak@linux.intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 darrick.wong@oracle.com
References: <20180119005741.32058-1-rgoldwyn@suse.de>
 <87zi58rmf7.fsf@linux.intel.com>
 <c7661c89-1deb-c967-4b19-c1897937f4a3@suse.de>
 <b6847555-6295-0f28-08f2-ad871bf91332@kernel.dk>
 <C6C37388-622C-451D-B14D-953EBE580995@dilger.ca>
 <175784d7-70e7-3be1-47f0-ae67ab37e921@kernel.dk>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <2b11e24d-d09c-f7c4-db6d-6ecc1ce40719@suse.de>
Date: Mon, 22 Jan 2018 21:18:55 -0600
MIME-Version: 1.0
In-Reply-To: <175784d7-70e7-3be1-47f0-ae67ab37e921@kernel.dk>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>



On 01/22/2018 01:13 PM, Jens Axboe wrote:
> On 1/22/18 12:10 PM, Andreas Dilger wrote:
>>
>>> On Jan 20, 2018, at 8:07 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 1/20/18 7:23 PM, Goldwyn Rodrigues wrote:
>>>>
>>>>
>>>> On 01/20/2018 08:11 PM, Andi Kleen wrote:
>>>>>
>>>>> It's likely there's a lot of code in user space that does
>>>>>
>>>>>     if (write(..., N) < 0) handle error
>>>>>
>>>>> With your change it would need to be
>>>>>
>>>>>     if (write(..., N) != N) handle error
>>>>>
>>>>> How much code is actually doing that?
>>>>>
>>>>> I can understand it fixes your artifical test suite, but it seems to me your
>>>>> change has a high potential to break a lot of existing user code
>>>>> in subtle ways. So it seems to be a bad idea.
>>>>
>>>>
>>>> Quoting 'man 2 write':
>>>>
>>>> RETURN VALUE
>>>> On  success,  the  number  of bytes written is returned (zero indicates
>>>> nothing was written).  It is not an error if  this  number  is  smaller
>>>> than the number of bytes requested; this may happen for example because
>>>> the disk device was filled.  See also NOTES.
>>>
>>> You can quote as much man page as you want - Andi is well aware of how
>>> read/write system call works, as I'm sure all of us are, that is not the
>>> issue. The issue is that there are potentially LOTS of applications out
>>> there that do not check for short writes, they do exactly what Andi
>>> speculated above. If you break it with this change, it doesn't matter
>>> what's in the man page. What matters is previous behavior, and that
>>> you are breaking user space. At that point nobody cares what's in the
>>> man page.
>>
>> Applications that don't handle partial writes are already broken with
>> buffered I/O, this change doesn't really make them more broken.
> 
> Not disagreeing that they are broken, of course they are. But if you've
> been doing direct IO and not seeing short writes, then this could break
> your application. And if that's the case, it doesn't really help to say

I started exploring short writes and how direct I/O behaves on errors
after your suggestion to incorporate short writes in a previous
conversation [1]. I started looking into how midway errors with direct
I/O's are handled now and I stumble upon this issue.

> that their application was "already broken". I'd hate for a kernel
> upgrade to break them.
> 
> I do wish we could make the change, and maybe we can. But it probably
> needs some safe guard proc entry to toggle the behavior, something we
> can drop in a few years when we're confident it won't break real
> applications.

Assuming we call it /proc/sys/fs/dio_short_writes(better names/paths?),
should it be enabled or disabled by default?

[1] https://www.spinics.net/lists/linux-block/msg15910.html



-- 
Goldwyn
