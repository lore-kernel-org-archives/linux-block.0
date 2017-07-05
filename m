Return-Path: <prvs=35297c532=damien.lemoal@wdc.com>
Subject: Re: [PATCH v2] block: Fix __blkdev_issue_zeroout loop
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20170704082702.15727-1-damien.lemoal@wdc.com>
 <20170705172616.GA5417@lst.de>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <a6f6dd2c-53de-82a4-9000-6d4e959703bb@wdc.com>
Date: Thu, 6 Jul 2017 08:50:42 +0900
MIME-Version: 1.0
In-Reply-To: <20170705172616.GA5417@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 7/6/17 02:26, Christoph Hellwig wrote:
> On Tue, Jul 04, 2017 at 05:27:02PM +0900, Damien Le Moal wrote:
>> The BIO issuing loop in __blkdev_issue_zeroout() is allocating BIOs
>> with a maximum number of bvec (pages) equal to
>>
>> min(nr_sects, (sector_t)BIO_MAX_PAGES)
>>
>> This works since the BIO will always be limited to the absolute maximum
>> number of pages but this is ineficient as too many bvec entries may be
>> requested since different units (number of sectors vs number of pages)
>> are used in the min() operation. Fix this by correctly using the same
>> unit (number of pages), making sure that this number is at least 1 for
>> cases where the number of sectors is less that the number of sectors in
>> a page.
>>
>> Also remove a trailing space after the bit shift in the internal loop
>> min() call.
> 
> Can you move the nr sectors calculation into a helper and add some
> comments?

Sure, no problem. I will send a v3 today.

-- 
Damien Le Moal,
Western Digital
