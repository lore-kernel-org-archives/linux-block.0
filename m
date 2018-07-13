Return-Path: <axboe@kernel.dk>
Subject: Re: Silent data corruption in blkdev_direct_IO()
To: Ming Lei <tom.leiming@gmail.com>, Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Martin Wilck <mwilck@suse.com>
References: <e36f28d8-0eb8-1600-f327-8b066eeaf45c@suse.de>
 <CACVXFVPVb_8pUkGXPt5joDE4JRu0b4kgTQy7Pd0sL+kXDwys+A@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c5073ab4-6b06-16bd-f358-d4c18e18b3e0@kernel.dk>
Date: Fri, 13 Jul 2018 12:54:52 -0600
MIME-Version: 1.0
In-Reply-To: <CACVXFVPVb_8pUkGXPt5joDE4JRu0b4kgTQy7Pd0sL+kXDwys+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/12/18 5:29 PM, Ming Lei wrote:
> On Thu, Jul 12, 2018 at 10:36 PM, Hannes Reinecke <hare@suse.de> wrote:
>> Hi Jens, Christoph,
>>
>> we're currently hunting down a silent data corruption occurring due to
>> commit 72ecad22d9f1 ("block: support a full bio worth of IO for
>> simplified bdev direct-io").
>>
>> While the whole thing is still hazy on the details, the one thing we've
>> found is that reverting that patch fixes the data corruption.
>>
>> And looking closer, I've found this:
>>
>> static ssize_t
>> blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>> {
>>         int nr_pages;
>>
>>         nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES + 1);
>>         if (!nr_pages)
>>                 return 0;
>>         if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_PAGES)
>>                 return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
>>
>>         return __blkdev_direct_IO(iocb, iter, min(nr_pages, BIO_MAX_PAGES));
>> }
>>
>> When checking the call path
>> __blkdev_direct_IO()->bio_alloc_bioset()->bvec_alloc()
>> I found that bvec_alloc() will fail if nr_pages > BIO_MAX_PAGES.
>>
>> So why is there the check for 'nr_pages <= BIO_MAX_PAGES' ?
>> It's not that we can handle it in __blkdev_direct_IO() ...
>>
>> Thanks for any clarification.
> 
> Maybe you can try the following patch from Christoph to see if it makes a
> difference:
> 
> https://marc.info/?l=linux-kernel&m=153013977816825&w=2

That's not a bad idea.

-- 
Jens Axboe
