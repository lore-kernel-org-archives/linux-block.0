Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F3DC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 01:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D32A218CD
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 01:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="II7QhUgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfB0B5V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:57:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43758 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbfB0B5V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Feb 2019 20:57:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id q17so7162434pfh.10
        for <linux-block@vger.kernel.org>; Tue, 26 Feb 2019 17:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6gvbBsAEahaJie0QElsnef7t2M5MstyFU0LUHL6XAN4=;
        b=II7QhUgWhIvUQ4oFQS6WUeOP511WVZZEiPXQ0dHoXmkS80pKWrn0Wv0HuJYsfqXEXH
         sYn+9Jd7tTZyYGpdEr+LVoMiiHPLUu5KvEdrFEJMdM7bOCjfpG2mcdvkKvfm8+UK9QBp
         H017Dm+k2dhHN8AwevBNEAIOGQdv3xVlnxg2yBuiRvrg69e05QyazIvHn/XcYRd/B2BQ
         tH2jtGvZVxNtANRwVCvdedr+g8CY0DbFEpGjTVtLYwQZVnDrmf4UeYIbDLNd3S5snXdn
         RQN/s4rGuZKkVzD9Ki3wXXARcdKrQen6u9byPmXtfGUuL1XWTQXlJaOB8f5hARu5t0+5
         X6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6gvbBsAEahaJie0QElsnef7t2M5MstyFU0LUHL6XAN4=;
        b=ov8Uw1VJ/LEaImvGOGBf37smeMMtO9MhxENKuQGNJkWG5BrTbrrhuz+nGmlOszASH+
         C4eIvNEGUi31Pls6MbHviaJFK2UHGJNzxJMjRGTLpC5SXibSUICLGhphAJcHhtrUwmmv
         0w7PsGSD7zkJzQoOZ223dgbogD0thVafIwXG9Bw+JQPGesXVwxgqmpxUVkEpkXAmmeCQ
         0uuhHhcXgMC/PfaXc2nBAoPD3obF8e7tcSpaUVnYkzvRfJykCk3K1qJdE3eYL/bdz7O9
         ye8oEkSMvLs13hmpZbNvX6q/Mlbm+vEzwawlj4l5I0kpbdOkNRhjJ6/YRHyYfuKYpRSb
         ZFwQ==
X-Gm-Message-State: AHQUAuZOvE3p12Z7cwN7OZXAR40cOwmrq3TNj1YSIxVaJcrLUBYCVEuK
        HX6SJujpO5IBE+ykPi5KCswDHQ==
X-Google-Smtp-Source: AHgI3IZNdfJxpAXAb5kIXLW6b2fpuztdAYJpku872b0Sc/i01pJuRAXV07exiVpS6DkKn5b17NS7mA==
X-Received: by 2002:aa7:918b:: with SMTP id x11mr22602492pfa.228.1551232640171;
        Tue, 26 Feb 2019 17:57:20 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id f6sm23650777pfc.88.2019.02.26.17.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 17:57:18 -0800 (PST)
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
References: <20190211190049.7888-1-axboe@kernel.dk>
 <20190211190049.7888-13-axboe@kernel.dk> <20190220225856.GB28313@ming.t460p>
 <b143e8c3-33d5-5f09-c441-98b3bf326d81@kernel.dk>
 <20190226034613.GA676@sol.localdomain>
 <aa1184bb-b482-0637-21e4-1ddb0e7aea90@kernel.dk>
 <1652577e-787b-638e-625d-c200fb144a9d@kernel.dk>
 <CACVXFVNOFA8_p+hVvaCffWAQ7+dgn++0b4Wn3naJzyNZN=CoFg@mail.gmail.com>
 <09820845-07cb-5153-e1c5-59ed185db26f@kernel.dk>
 <20190227015336.GD16802@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e4dace7b-6a6f-2606-9a7e-8ae3c97c26b0@kernel.dk>
Date:   Tue, 26 Feb 2019 18:57:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227015336.GD16802@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/26/19 6:53 PM, Ming Lei wrote:
> On Tue, Feb 26, 2019 at 06:47:54PM -0700, Jens Axboe wrote:
>> On 2/26/19 6:21 PM, Ming Lei wrote:
>>> On Tue, Feb 26, 2019 at 11:56 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 2/25/19 9:34 PM, Jens Axboe wrote:
>>>>> On 2/25/19 8:46 PM, Eric Biggers wrote:
>>>>>> Hi Jens,
>>>>>>
>>>>>> On Thu, Feb 21, 2019 at 10:45:27AM -0700, Jens Axboe wrote:
>>>>>>> On 2/20/19 3:58 PM, Ming Lei wrote:
>>>>>>>> On Mon, Feb 11, 2019 at 12:00:41PM -0700, Jens Axboe wrote:
>>>>>>>>> For an ITER_BVEC, we can just iterate the iov and add the pages
>>>>>>>>> to the bio directly. This requires that the caller doesn't releases
>>>>>>>>> the pages on IO completion, we add a BIO_NO_PAGE_REF flag for that.
>>>>>>>>>
>>>>>>>>> The current two callers of bio_iov_iter_get_pages() are updated to
>>>>>>>>> check if they need to release pages on completion. This makes them
>>>>>>>>> work with bvecs that contain kernel mapped pages already.
>>>>>>>>>
>>>>>>>>> Reviewed-by: Hannes Reinecke <hare@suse.com>
>>>>>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>>>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>>>>>> ---
>>>>>>>>>  block/bio.c               | 59 ++++++++++++++++++++++++++++++++-------
>>>>>>>>>  fs/block_dev.c            |  5 ++--
>>>>>>>>>  fs/iomap.c                |  5 ++--
>>>>>>>>>  include/linux/blk_types.h |  1 +
>>>>>>>>>  4 files changed, 56 insertions(+), 14 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/block/bio.c b/block/bio.c
>>>>>>>>> index 4db1008309ed..330df572cfb8 100644
>>>>>>>>> --- a/block/bio.c
>>>>>>>>> +++ b/block/bio.c
>>>>>>>>> @@ -828,6 +828,23 @@ int bio_add_page(struct bio *bio, struct page *page,
>>>>>>>>>  }
>>>>>>>>>  EXPORT_SYMBOL(bio_add_page);
>>>>>>>>>
>>>>>>>>> +static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
>>>>>>>>> +{
>>>>>>>>> + const struct bio_vec *bv = iter->bvec;
>>>>>>>>> + unsigned int len;
>>>>>>>>> + size_t size;
>>>>>>>>> +
>>>>>>>>> + len = min_t(size_t, bv->bv_len, iter->count);
>>>>>>>>> + size = bio_add_page(bio, bv->bv_page, len,
>>>>>>>>> +                         bv->bv_offset + iter->iov_offset);
>>>>>>>>
>>>>>>>> iter->iov_offset needs to be subtracted from 'len', looks
>>>>>>>> the following delta change[1] is required, otherwise memory corruption
>>>>>>>> can be observed when running xfstests over loop/dio.
>>>>>>>
>>>>>>> Thanks, I folded this in.
>>>>>>>
>>>>>>> --
>>>>>>> Jens Axboe
>>>>>>>
>>>>>>
>>>>>> syzkaller started hitting a crash on linux-next starting with this commit, and
>>>>>> it still occurs even with your latest version that has Ming's fix folded in.
>>>>>> Specifically, commit a566653ab5ab80a from your io_uring branch with commit date
>>>>>> Sun Feb 24 08:20:53 2019 -0700.
>>>>>>
>>>>>> Reproducer:
>>>>>>
>>>>>> #define _GNU_SOURCE
>>>>>> #include <fcntl.h>
>>>>>> #include <linux/loop.h>
>>>>>> #include <sys/ioctl.h>
>>>>>> #include <sys/sendfile.h>
>>>>>> #include <sys/syscall.h>
>>>>>> #include <unistd.h>
>>>>>>
>>>>>> int main(void)
>>>>>> {
>>>>>>         int memfd, loopfd;
>>>>>>
>>>>>>         memfd = syscall(__NR_memfd_create, "foo", 0);
>>>>>>
>>>>>>         pwrite(memfd, "\xa8", 1, 4096);
>>>>>>
>>>>>>         loopfd = open("/dev/loop0", O_RDWR|O_DIRECT);
>>>>>>
>>>>>>         ioctl(loopfd, LOOP_SET_FD, memfd);
>>>>>>
>>>>>>         sendfile(loopfd, loopfd, NULL, 1000000);
>>>>>> }
>>>>>>
>>>>>>
>>>>>> Crash:
>>>>>>
>>>>>> page:ffffea0001a6aab8 count:0 mapcount:0 mapping:0000000000000000 index:0x0
>>>>>> flags: 0x100000000000000()
>>>>>> raw: 0100000000000000 ffffea0001ad2c50 ffff88807fca49d0 0000000000000000
>>>>>> raw: 0000000000000000 0000000000000000 00000000ffffffff
>>>>>> page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
>>>>>
>>>>> I see what this is, I'll cut a fix for this tomorrow.
>>>>
>>>> Folded in a fix for this, it's in my current io_uring branch and my for-next
>>>> branch.
>>>
>>> Hi Jens,
>>>
>>> I saw the following change is added:
>>>
>>> + if (size == len) {
>>> + /*
>>> + * For the normal O_DIRECT case, we could skip grabbing this
>>> + * reference and then not have to put them again when IO
>>> + * completes. But this breaks some in-kernel users, like
>>> + * splicing to/from a loop device, where we release the pipe
>>> + * pages unconditionally. If we can fix that case, we can
>>> + * get rid of the get here and the need to call
>>> + * bio_release_pages() at IO completion time.
>>> + */
>>> + get_page(bv->bv_page);
>>>
>>> Now the 'bv' may point to more than one page, so the following one may be
>>> needed:
>>>
>>> int i;
>>> struct bvec_iter_all iter_all;
>>> struct bio_vec *tmp;
>>>
>>> mp_bvec_for_each_segment(tmp, bv, i, iter_all)
>>>       get_page(tmp->bv_page);
>>
>> I guess that would be the safest, even if we don't currently have more
>> than one page in there. I'll fix it up.
> 
> It is easy to see multipage bvec from loop, :-)

Speaking of this, I took a quick look at why we've now regressed a lot
on IOPS perf with the multipage work. It looks like it's all related to
the (much) fatter setup around iteration, which is related to this very
topic too.

Basically setup of things like bio_for_each_bvec() and indexing through
nth_page() is MUCH slower than before.

We need to do something about this, it's like tossing out months of
optimizations.

-- 
Jens Axboe

