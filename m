Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7241DC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 04:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D54A218CD
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 04:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oWRbi5X8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfB0EFT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Feb 2019 23:05:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34823 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbfB0EFS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Feb 2019 23:05:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id j5so7333562pfa.2
        for <linux-block@vger.kernel.org>; Tue, 26 Feb 2019 20:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ieF34xLZn1h0GfiFS8uuY4TNk2Kbtni4MclMaVIclpM=;
        b=oWRbi5X8OhUP/QA2CWVojxtBtZ4sznbTNnCUjt/15Erq+1BehDCTHB0559UI6QfaP/
         Nr+0eIrijE4oVT3kQKYrfaeWlFwyrR5t/EbqN7OUBEFX+EP0qe5IURjTNa5BTpaoZ+/W
         US1DDVZoAmhNwy4l3tFARsOYnHtF57bmKIdi4QC8gH6SgbAebcsJRAm+MychtZ3zPNBF
         e8Aas/a5fyTM1gQCMtSqAR5Wkj2QZDH3aiqYgHkxZZ2FiXKsnQNcHmD8ZS5rMr9Sys2v
         +bwXugtZCjyHvZXJVk+BC0NvfCHM7pMpx6g25E7KbrA6BIL7Vxwsf6twWknN/IjhwOfC
         FMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ieF34xLZn1h0GfiFS8uuY4TNk2Kbtni4MclMaVIclpM=;
        b=jFXvKe38UDb9TFF7InaoHA1/PflEYdX9evIlftijzLaav3C61AQuk+WaTgQ3naxiox
         fTuL78JdT0DqQs4Ag7qCMiicnNn6Hz33/aEXR8oqxs9kwM/TAEBc0QMAOHziw8Ww8ug6
         wi5DFF7cyII/mvfORRrG07Tomfd2cZ8t6uA59OxUryqPre1aOxjWeN/yTG8ssQX+0vHc
         jrIjO9AYAs3Kw1oWqDPhnM9M5t2gIaqJAkb3Tfwcu1qMrgXbeKt4Ow50G50iDbbze5JK
         EHs4v6Po/20PbSxv6ZWWfjabZZQ/uF8VfcSNE51SXySkJBms4KLcjhaUxX9pidXYM4oZ
         f+dw==
X-Gm-Message-State: AHQUAuY8Oyy27ogUB5+06aex8Ohyqoq99MP8jW98/SiCgb15GZDlUc1F
        P9Lll7q9Z9rIY1ObUFyoyOMBYQ==
X-Google-Smtp-Source: AHgI3IYV4UWw6HykwqBjM3oFEc5V+muutnA/oskeVp+9fV8eWG2cn6GBco5p4Ts7fdFBQObDt3Sscw==
X-Received: by 2002:a62:f54d:: with SMTP id n74mr29396414pfh.98.1551240317707;
        Tue, 26 Feb 2019 20:05:17 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d26sm18155313pfn.86.2019.02.26.20.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 20:05:16 -0800 (PST)
Subject: Re: [PATCH 11/19] block: implement bio helper to add iter bvec pages
 to bio
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "open list:AIO" <linux-aio@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-api@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>,
        jannh@google.com, Al Viro <viro@zeniv.linux.org.uk>
References: <CACVXFVNOFA8_p+hVvaCffWAQ7+dgn++0b4Wn3naJzyNZN=CoFg@mail.gmail.com>
 <09820845-07cb-5153-e1c5-59ed185db26f@kernel.dk>
 <20190227015336.GD16802@ming.t460p>
 <e4dace7b-6a6f-2606-9a7e-8ae3c97c26b0@kernel.dk>
 <20190227022144.GE16802@ming.t460p>
 <b54683e8-fbff-01ab-db98-c35de8e00e9f@kernel.dk>
 <20190227023719.GF16802@ming.t460p>
 <9ce37f86-dd8b-ef51-7507-d457585a892a@kernel.dk>
 <20190227030944.GG16802@ming.t460p>
 <7a1f4293-8f88-81e0-9464-cc27e39184cb@kernel.dk>
 <20190227034409.GH16802@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2a48c5da-7eea-13a1-9939-9e182e11dc9b@kernel.dk>
Date:   Tue, 26 Feb 2019 21:05:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227034409.GH16802@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/26/19 8:44 PM, Ming Lei wrote:
> On Tue, Feb 26, 2019 at 08:37:05PM -0700, Jens Axboe wrote:
>> On 2/26/19 8:09 PM, Ming Lei wrote:
>>> On Tue, Feb 26, 2019 at 07:43:32PM -0700, Jens Axboe wrote:
>>>> On 2/26/19 7:37 PM, Ming Lei wrote:
>>>>> On Tue, Feb 26, 2019 at 07:28:54PM -0700, Jens Axboe wrote:
>>>>>> On 2/26/19 7:21 PM, Ming Lei wrote:
>>>>>>> On Tue, Feb 26, 2019 at 06:57:16PM -0700, Jens Axboe wrote:
>>>>>>>> On 2/26/19 6:53 PM, Ming Lei wrote:
>>>>>>>>> On Tue, Feb 26, 2019 at 06:47:54PM -0700, Jens Axboe wrote:
>>>>>>>>>> On 2/26/19 6:21 PM, Ming Lei wrote:
>>>>>>>>>>> On Tue, Feb 26, 2019 at 11:56 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On 2/25/19 9:34 PM, Jens Axboe wrote:
>>>>>>>>>>>>> On 2/25/19 8:46 PM, Eric Biggers wrote:
>>>>>>>>>>>>>> Hi Jens,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Thu, Feb 21, 2019 at 10:45:27AM -0700, Jens Axboe wrote:
>>>>>>>>>>>>>>> On 2/20/19 3:58 PM, Ming Lei wrote:
>>>>>>>>>>>>>>>> On Mon, Feb 11, 2019 at 12:00:41PM -0700, Jens Axboe wrote:
>>>>>>>>>>>>>>>>> For an ITER_BVEC, we can just iterate the iov and add the pages
>>>>>>>>>>>>>>>>> to the bio directly. This requires that the caller doesn't releases
>>>>>>>>>>>>>>>>> the pages on IO completion, we add a BIO_NO_PAGE_REF flag for that.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> The current two callers of bio_iov_iter_get_pages() are updated to
>>>>>>>>>>>>>>>>> check if they need to release pages on completion. This makes them
>>>>>>>>>>>>>>>>> work with bvecs that contain kernel mapped pages already.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Reviewed-by: Hannes Reinecke <hare@suse.com>
>>>>>>>>>>>>>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>>>>>>>>>>>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>>  block/bio.c               | 59 ++++++++++++++++++++++++++++++++-------
>>>>>>>>>>>>>>>>>  fs/block_dev.c            |  5 ++--
>>>>>>>>>>>>>>>>>  fs/iomap.c                |  5 ++--
>>>>>>>>>>>>>>>>>  include/linux/blk_types.h |  1 +
>>>>>>>>>>>>>>>>>  4 files changed, 56 insertions(+), 14 deletions(-)
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> diff --git a/block/bio.c b/block/bio.c
>>>>>>>>>>>>>>>>> index 4db1008309ed..330df572cfb8 100644
>>>>>>>>>>>>>>>>> --- a/block/bio.c
>>>>>>>>>>>>>>>>> +++ b/block/bio.c
>>>>>>>>>>>>>>>>> @@ -828,6 +828,23 @@ int bio_add_page(struct bio *bio, struct page *page,
>>>>>>>>>>>>>>>>>  }
>>>>>>>>>>>>>>>>>  EXPORT_SYMBOL(bio_add_page);
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> +static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>> + const struct bio_vec *bv = iter->bvec;
>>>>>>>>>>>>>>>>> + unsigned int len;
>>>>>>>>>>>>>>>>> + size_t size;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> + len = min_t(size_t, bv->bv_len, iter->count);
>>>>>>>>>>>>>>>>> + size = bio_add_page(bio, bv->bv_page, len,
>>>>>>>>>>>>>>>>> +                         bv->bv_offset + iter->iov_offset);
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> iter->iov_offset needs to be subtracted from 'len', looks
>>>>>>>>>>>>>>>> the following delta change[1] is required, otherwise memory corruption
>>>>>>>>>>>>>>>> can be observed when running xfstests over loop/dio.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Thanks, I folded this in.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>> Jens Axboe
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> syzkaller started hitting a crash on linux-next starting with this commit, and
>>>>>>>>>>>>>> it still occurs even with your latest version that has Ming's fix folded in.
>>>>>>>>>>>>>> Specifically, commit a566653ab5ab80a from your io_uring branch with commit date
>>>>>>>>>>>>>> Sun Feb 24 08:20:53 2019 -0700.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Reproducer:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> #define _GNU_SOURCE
>>>>>>>>>>>>>> #include <fcntl.h>
>>>>>>>>>>>>>> #include <linux/loop.h>
>>>>>>>>>>>>>> #include <sys/ioctl.h>
>>>>>>>>>>>>>> #include <sys/sendfile.h>
>>>>>>>>>>>>>> #include <sys/syscall.h>
>>>>>>>>>>>>>> #include <unistd.h>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> int main(void)
>>>>>>>>>>>>>> {
>>>>>>>>>>>>>>         int memfd, loopfd;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>         memfd = syscall(__NR_memfd_create, "foo", 0);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>         pwrite(memfd, "\xa8", 1, 4096);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>         loopfd = open("/dev/loop0", O_RDWR|O_DIRECT);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>         ioctl(loopfd, LOOP_SET_FD, memfd);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>         sendfile(loopfd, loopfd, NULL, 1000000);
>>>>>>>>>>>>>> }
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Crash:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> page:ffffea0001a6aab8 count:0 mapcount:0 mapping:0000000000000000 index:0x0
>>>>>>>>>>>>>> flags: 0x100000000000000()
>>>>>>>>>>>>>> raw: 0100000000000000 ffffea0001ad2c50 ffff88807fca49d0 0000000000000000
>>>>>>>>>>>>>> raw: 0000000000000000 0000000000000000 00000000ffffffff
>>>>>>>>>>>>>> page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
>>>>>>>>>>>>>
>>>>>>>>>>>>> I see what this is, I'll cut a fix for this tomorrow.
>>>>>>>>>>>>
>>>>>>>>>>>> Folded in a fix for this, it's in my current io_uring branch and my for-next
>>>>>>>>>>>> branch.
>>>>>>>>>>>
>>>>>>>>>>> Hi Jens,
>>>>>>>>>>>
>>>>>>>>>>> I saw the following change is added:
>>>>>>>>>>>
>>>>>>>>>>> + if (size == len) {
>>>>>>>>>>> + /*
>>>>>>>>>>> + * For the normal O_DIRECT case, we could skip grabbing this
>>>>>>>>>>> + * reference and then not have to put them again when IO
>>>>>>>>>>> + * completes. But this breaks some in-kernel users, like
>>>>>>>>>>> + * splicing to/from a loop device, where we release the pipe
>>>>>>>>>>> + * pages unconditionally. If we can fix that case, we can
>>>>>>>>>>> + * get rid of the get here and the need to call
>>>>>>>>>>> + * bio_release_pages() at IO completion time.
>>>>>>>>>>> + */
>>>>>>>>>>> + get_page(bv->bv_page);
>>>>>>>>>>>
>>>>>>>>>>> Now the 'bv' may point to more than one page, so the following one may be
>>>>>>>>>>> needed:
>>>>>>>>>>>
>>>>>>>>>>> int i;
>>>>>>>>>>> struct bvec_iter_all iter_all;
>>>>>>>>>>> struct bio_vec *tmp;
>>>>>>>>>>>
>>>>>>>>>>> mp_bvec_for_each_segment(tmp, bv, i, iter_all)
>>>>>>>>>>>       get_page(tmp->bv_page);
>>>>>>>>>>
>>>>>>>>>> I guess that would be the safest, even if we don't currently have more
>>>>>>>>>> than one page in there. I'll fix it up.
>>>>>>>>>
>>>>>>>>> It is easy to see multipage bvec from loop, :-)
>>>>>>>>
>>>>>>>> Speaking of this, I took a quick look at why we've now regressed a lot
>>>>>>>> on IOPS perf with the multipage work. It looks like it's all related to
>>>>>>>> the (much) fatter setup around iteration, which is related to this very
>>>>>>>> topic too.
>>>>>>>>
>>>>>>>> Basically setup of things like bio_for_each_bvec() and indexing through
>>>>>>>> nth_page() is MUCH slower than before.
>>>>>>>
>>>>>>> But bio_for_each_bvec() needn't nth_page(), and only bio_for_each_segment()
>>>>>>> needs that. However, bio_for_each_segment() isn't called from
>>>>>>> blk_queue_split() and blk_rq_map_sg().
>>>>>>>
>>>>>>> One issue is that bio_for_each_bvec() still advances by page size
>>>>>>> instead of bvec->len, I guess that is the problem, will cook a patch
>>>>>>> for your test.
>>>>>>
>>>>>> Probably won't make a difference for my test case...
>>>>>>
>>>>>>>> We need to do something about this, it's like tossing out months of
>>>>>>>> optimizations.
>>>>>>>
>>>>>>> Some following optimization can be done, such as removing
>>>>>>> biovec_phys_mergeable() from blk_bio_segment_split().
>>>>>>
>>>>>> I think we really need a fast path for <= PAGE_SIZE IOs, to the extent
>>>>>> that it is possible. But iteration startup cost is a problem in a lot of
>>>>>> spots, and a split fast path will only help a bit for that specific
>>>>>> case.
>>>>>>
>>>>>> 5% regressions is HUGE. I know I've mentioned this before, I just want
>>>>>> to really stress how big of a deal that is. It's enough to make me
>>>>>> consider just reverting it again, which sucks, but I don't feel great
>>>>>> shipping something that is known that much slower.
>>>>>>
>>>>>> Suggestions?
>>>>>
>>>>> You mentioned nth_page() costs much in bio_for_each_bvec(), but which
>>>>> shouldn't call into nth_page(). I will look into it first.
>>>>
>>>> I'll check on the test box tomorrow, I lost connectivity before. I'll
>>>> double check in the morning.
>>>>
>>>> I'd focus on the blk_rq_map_sg() path, since that's the biggest cycle
>>>> consumer.
>>>
>>> Hi Jens,
>>>
>>> Could you test the following patch which may improve on the 4k randio
>>> test case?
>>
>> A bit, it's up 1% with this patch. I'm going to try without the
>> get_page/put_page that we had earlier, to see where we are in regards to
>> the old baseline.
> 
> OK, today I will test io_uring over null_blk on one real machine and see
> if something can be improved.

For reference, I'm running the default t/io_uring from fio, which is
QD=128, fixed files/buffers, and polled. Running it on two devices to
max out the CPU core:

sudo taskset -c 0 t/io_uring /dev/nvme1n1 /dev/nvme5n1

since nvme1n1 tops out at 1164K 4k rand reads (hardware limit). Just
tried with null_blk, since I haven't done that before, and I get about
1875K from a single device with the same test case. Using 2 devices
yields the same result, so we're CPU core bound at that point. We don't
get the sg walk with null_blk though, but I do see about 4%
blk_queue_split() time with that.

-- 
Jens Axboe

