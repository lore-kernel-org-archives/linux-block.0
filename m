Return-Path: <linux-block-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:60896 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbcFBDcx (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2016 23:32:53 -0400
MIME-Version: 1.0
In-Reply-To: <20160601134816.GA20963@infradead.org>
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
	<1464615294-9946-6-git-send-email-ming.lei@canonical.com>
	<20160601134816.GA20963@infradead.org>
Date: Thu, 2 Jun 2016 11:32:51 +0800
Message-ID: <CACVXFVOJ-RDpu3yy1af3ZTo16-q4J6hsuV5d=6_0fi-i4b3ycw@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] fs: xfs: replace BIO_MAX_SECTORS with BIO_MAX_PAGES
From: Ming Lei <ming.lei@canonical.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-block@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	"supporter:XFS FILESYSTEM" <xfs@oss.sgi.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 1, 2016 at 9:48 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, May 30, 2016 at 09:34:33PM +0800, Ming Lei wrote:
>> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
>> index e71cfbd..e5d713b 100644
>> --- a/fs/xfs/xfs_buf.c
>> +++ b/fs/xfs/xfs_buf.c
>> @@ -1157,9 +1157,7 @@ xfs_buf_ioapply_map(
>>
>>  next_chunk:
>>       atomic_inc(&bp->b_io_remaining);
>> -     nr_pages = BIO_MAX_SECTORS >> (PAGE_SHIFT - BBSHIFT);
>> -     if (nr_pages > total_nr_pages)
>> -             nr_pages = total_nr_pages;
>> +     nr_pages = min(total_nr_pages, BIO_MAX_PAGES);
>>
>>       bio = bio_alloc(GFP_NOIO, nr_pages);
>
> While I think this is a useful cleanup on it's own I think
> you'd make everyones life easier if bio_alloc simply clamped down
> the passed nr_pages value to the maximum allowed.

Yes, that looks a good cleanup, but need be careful because the
passed 'nr_pages' can be used after returning from bio_alloc() in
the current function, and it is easy to see this usage.

So we can do that in another patchset instead of this one.

Thanks,

> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
