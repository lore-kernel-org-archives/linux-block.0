Return-Path: <hare@suse.de>
Subject: Re: Silent data corruption in blkdev_direct_IO()
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Martin Wilck <mwilck@suse.com>
References: <e36f28d8-0eb8-1600-f327-8b066eeaf45c@suse.de>
 <3419a3ae-da82-9c20-26e1-7c9ed14ff8ed@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a1679897-ed41-1ceb-f94f-bd1be537ce4e@suse.de>
Date: Thu, 12 Jul 2018 18:14:06 +0200
MIME-Version: 1.0
In-Reply-To: <3419a3ae-da82-9c20-26e1-7c9ed14ff8ed@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 07/12/2018 05:08 PM, Jens Axboe wrote:
> On 7/12/18 8:36 AM, Hannes Reinecke wrote:
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
>> 	int nr_pages;
>>
>> 	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES + 1);
>> 	if (!nr_pages)
>> 		return 0;
>> 	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_PAGES)
>> 		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
>>
>> 	return __blkdev_direct_IO(iocb, iter, min(nr_pages, BIO_MAX_PAGES));
>> }
>>
>> When checking the call path
>> __blkdev_direct_IO()->bio_alloc_bioset()->bvec_alloc()
>> I found that bvec_alloc() will fail if nr_pages > BIO_MAX_PAGES.
>>
>> So why is there the check for 'nr_pages <= BIO_MAX_PAGES' ?
>> It's not that we can handle it in __blkdev_direct_IO() ...
> 
> The logic could be cleaned up like below, the sync part is really all
> we care about. What is the test case for this? async or sync?
> 
> I also don't remember why it's BIO_MAX_PAGES + 1...
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 0dd87aaeb39a..14ef3d71b55f 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -424,13 +424,13 @@ blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>   {
>   	int nr_pages;
>   
> -	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES + 1);
> +	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
>   	if (!nr_pages)
>   		return 0;
> -	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_PAGES)
> +	if (is_sync_kiocb(iocb))
>   		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
>   
> -	return __blkdev_direct_IO(iocb, iter, min(nr_pages, BIO_MAX_PAGES));
> +	return __blkdev_direct_IO(iocb, iter, nr_pages);
>   }
>   
>   static __init int blkdev_init(void)
> 
Hmm. We'll give it a go, but somehow I feel this won't solve our problem.
Another question (which probably shows my complete ignorance):
What happens if the iter holds >= BIO_MAX_PAGES?
'iov_iter_npages' will only ever return BIO_MAX_PAGES, independent on 
whether the iter contains more pages.
What happens to those left-over pages?
Will they ever be processed?

Cheers,

Hannes
