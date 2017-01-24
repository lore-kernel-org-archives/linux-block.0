Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35546 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdAXJcR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 04:32:17 -0500
Received: by mail-wm0-f49.google.com with SMTP id r126so172150681wmr.0
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2017 01:32:16 -0800 (PST)
Subject: Re: BUG: KASAN: Use-after-free
To: Christoph Hellwig <hch@infradead.org>
References: <0b458b92-62ee-bffc-8f3e-fbd6490b26fd@bjorling.me>
 <20170123172021.GA28446@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Message-ID: <400b4572-0994-8950-582b-c3372333f6c8@bjorling.me>
Date: Tue, 24 Jan 2017 10:32:11 +0100
MIME-Version: 1.0
In-Reply-To: <20170123172021.GA28446@infradead.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/23/2017 06:20 PM, Christoph Hellwig wrote:
> On Mon, Jan 23, 2017 at 05:07:52PM +0100, Matias Bj�rling wrote:
>> Hi,
>>
>> I could use some help verifying an use-after-free bug that I am seeing
>> after the new direct I/O work went in.
>>
>> When issuing a direct write io using libaio, a bio is referenced in the
>> blkdev_direct_IO path, and then put again in the blkdev_bio_end_io path.
>> However, there is a case where the bio is put twice, which leads to
>> modules that rely on the bio after biodev_bio_end_io() to access it
>> prematurely.
> 
> Can you reproduce anything like this with a normal block device?

Looks like bcache has something similar with a get/put in it. I'll look
a bit more.

> 
>>
>> The KASAN error report:
>>
>> [   14.645916]
>> ==================================================================
>> [   14.648027] BUG: KASAN: use-after-free in
>> blkdev_direct_IO+0x50c/0x600 at addr ffff8801ef30ea14
> 
> Can you resolve that address for me, please?
> 

*(gdb) list *blkdev_direct_IO+0x50c
0xffffffff8142ab8c is in blkdev_direct_IO (fs/block_dev.c:401).
396			submit_bio(bio);
397			bio = bio_alloc(GFP_KERNEL, nr_pages);
398		}
399		blk_finish_plug(&plug);
400	
401		if (!dio->is_sync)
402			return -EIOCBQUEUED;

It looks like the qc = submit_bio() completes the I/O before the
blkdev_direct_IO completes, which then leads to the use after free case,
when the private dio struct is accessed.

>> Which boils down to the bio already being freed, when we hit the
>> module's endio function.
>>
>> The double bio_put() occurs when dio->should_dirty = 0, and dio->is_sync
>> = 0. The flow follows:
>>
>> Issuing:
>>   blkdev_direct_IO
>>      get_bio(bio)
> 
> bio refcounting in __blkdev_direct_IO is the following
> 
> first bio is allocated using bio_alloc_bioset to embedd the dio structure
> into it.  We then grab a second reference to that bio and only that one.
> Each other new bio just gets it's single reference from bio_alloc.
> 
> blkdev_bio_end_io then checks if we hit the last reference on the dio, in
> which case it then drops the additional reference on the first bio after
> calling the aio completion handler.  Once that is done it always drops the
> reference for the current bio - either explicitly or through
> bio_check_pages_dirty in the should_dirty case.
> 
>>      submit_io()
>>        rrpc make_request(bio)
>>          get_bio(bio)
>> Completion:
>>   blkdev_bio_end_io
>>     bio_put(bio)
>>     bio_put(bio) - bio is freed
> 
> Yes, and that's how it's intended.
> 
>>   rrpc_end_io
>>     bio_put(bio) (use-after-free access)
> 
> Can you check this is the same bio that got submitted and it didn't
> get bounced somewhere?
> 

Yup, the same:

[11.329950] blkdev_direct_io: get_bio     (bio=ffff8801f1e7a018) get ref
[11.331557] blkdev_direct_io: (!nr_pages) (bio=ffff8801f1e7a018) submit
[11.333603] rrpc bio_get:                 (bio=ffff8801f1e7a018) get ref
[11.335004] blkdev_bio_end_io:!dio->is_syn(bio=ffff8801f1e7a018) put ref
[11.335009] rrpc bio_put:                 (bio=ffff8801f1e7a018) put ref

It could look like the first get_bio() ref is decremented prematurely in
the blkdev_bio_end_io() path, where it should first have been
decremented at the end of blkdev_direct_IO() path.
