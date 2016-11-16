Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] mm: don't cap request size based on read-ahead setting
To: Hillf Danton <hillf.zj@alibaba-inc.com>,
 'Andrew Morton' <akpm@linux-foundation.org>
References: <6e2dec0d-cef5-60ac-2cf6-a89ded82e2f4@kernel.dk>
 <000701d23fd9$805dcdd0$81196970$@alibaba-inc.com>
 <7b150e70-66ef-f42f-a0b9-2ddb7b739076@kernel.dk>
Cc: linux-mm@kvack.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 'Linus Torvalds' <torvalds@linux-foundation.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <329d2991-cbcf-612e-7bf6-4fa5b5225643@kernel.dk>
Date: Wed, 16 Nov 2016 11:38:20 -0700
MIME-Version: 1.0
In-Reply-To: <7b150e70-66ef-f42f-a0b9-2ddb7b739076@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/16/2016 08:12 AM, Jens Axboe wrote:
> On 11/16/2016 12:17 AM, Hillf Danton wrote:
>> On Wednesday, November 16, 2016 12:31 PM Jens Axboe wrote:
>>> @@ -369,10 +369,25 @@ ondemand_readahead(struct address_space *mapping,
>>>              bool hit_readahead_marker, pgoff_t offset,
>>>              unsigned long req_size)
>>>   {
>>> -    unsigned long max = ra->ra_pages;
>>> +    unsigned long io_pages, max_pages;
>>>       pgoff_t prev_offset;
>>>
>>>       /*
>>> +     * If bdi->io_pages is set, that indicates the (soft) max IO size
>>> +     * per command for that device. If we have that available, use
>>> +     * that as the max suitable read-ahead size for this IO. Instead of
>>> +     * capping read-ahead at ra_pages if req_size is larger, we can go
>>> +     * up to io_pages. If io_pages isn't set, fall back to using
>>> +     * ra_pages as a safe max.
>>> +     */
>>> +    io_pages = inode_to_bdi(mapping->host)->io_pages;
>>> +    if (io_pages) {
>>> +        max_pages = max_t(unsigned long, ra->ra_pages, req_size);
>>> +        io_pages = min(io_pages, max_pages);
>>
>> Doubt if you mean
>>         max_pages = min(io_pages, max_pages);
>
> No, that is what I mean. We want the maximum of the RA setting and the
> user IO size, but the minimum of that and the device max command size.

Johannes pointed out that I'm an idiot - a last minute edit introduced
this typo, and I was too blind to spot it when you sent that email this
morning. So yes, it should of course be:

	max_pages = min(io_pages, max_pages);

like the first version I posted. I'll post a v3...

-- 
Jens Axboe
