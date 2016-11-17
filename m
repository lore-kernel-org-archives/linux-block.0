Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET] Add support for simplified async direct-io
To: Christoph Hellwig <hch@infradead.org>
References: <4f30a528-9996-4c6a-9513-8aa2054e4d4b@fb.com>
 <20161114180503.GA31126@infradead.org>
 <d9baad75-d105-2968-1b59-608a8598e3bb@fb.com>
 <20161114181119.GA9396@infradead.org>
 <f8c29e81-7323-7362-b507-1b7c61e8a19a@fb.com>
 <20161116163147.GA25038@infradead.org>
 <72b1725a-0363-d33e-f890-251b1ac88998@kernel.dk>
 <20161116171652.GA30008@infradead.org>
 <c46c5e60-a5eb-2862-2b1b-f994fd0d3fe3@kernel.dk>
 <c2e20890-16ce-a3bd-c696-c53ae14a583a@kernel.dk>
 <20161117125037.GB14814@infradead.org>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <204d4a18-e5da-1806-433e-a3ff1b6ca575@kernel.dk>
Date: Thu, 17 Nov 2016 06:25:32 -0700
MIME-Version: 1.0
In-Reply-To: <20161117125037.GB14814@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/17/2016 05:50 AM, Christoph Hellwig wrote:
> On Wed, Nov 16, 2016 at 09:43:57PM -0700, Jens Axboe wrote:
>> OK, I'm getting reasonably happy with it now:
>>
>> http://git.kernel.dk/cgit/linux-block/log/?h=for-4.10/hch-dio
>>
>> Sharing the FUA setting to avoid the manual flush between the two, and
>> removing the remnants of SYNC support from __blkdev_direct_IO().
>>
>> I'll fire off some overnight testing now and leave it for the day.
>
> This looks reasonable, a couple questions and comments:
>
>  - why the 8 * BIO_MAX_PAGES in the call to iov_iter_npages,
>    that probably needs a comment

Looks like I forgot to push out the latest changes, that is gone. We're
just using + 1 now to see if we should use the multibio function or not.

>  - I'll probably need to write up a proper changelog and fold
>    in at least the multi_bio patch.

That's fine.

>  - I'd just return the op from dio_bio_set_write_op instead of
>    passing the bio, that reads a lot easier.

Fine with me.

>  - I should probably get rid of blkdev_dio_pool in favour
>    of bio_kmalloc

Agree, though not a requirement imho.

> I can look into doing these fixups this afternoon and prepare a tre
> for you.

Sounds good.

-- 
Jens Axboe
