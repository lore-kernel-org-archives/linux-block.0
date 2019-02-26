Return-Path: <SRS0=PBJN=RB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5D8C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 15:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFDF20C01
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 15:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="g3w7aOEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfBZPyN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:54:13 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38268 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfBZPyN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Feb 2019 10:54:13 -0500
Received: by mail-it1-f195.google.com with SMTP id l66so4806840itg.3
        for <linux-block@vger.kernel.org>; Tue, 26 Feb 2019 07:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PSfp7jby7bJf7Iq0yet+thJT0mZpXiOS1xz90ywbKnQ=;
        b=g3w7aOEl/L8KtnvvAEkZow1u+ovK7RNvgH76lEn/RMgVPU2QVwU4hBegehn/LWbgtD
         PbedU/C6ytZXIkdP2lx4GrHFCtLDNcbMK1MB3Vte9AjS/JAF8HXFkUCrFFw7sN2SO2hY
         2OGBIiiLN/p9fI5eDTcWhtp37IGDCUSC/CgTTUzAizbJxxAm0ssN7cOnL/wTHkOYkW+2
         +OCLxwaTq+t5m9qwFVtTN0JnQFV6Cadd8C16nbKVxC09CsegmrB+RFZpykTslriix9PP
         21GZvR++Ou/FhI38fIM8CPEixRNF/whQLAOS6czplMUSQvhLlrfEJ4jUwxD5eAGPQ9o7
         FBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PSfp7jby7bJf7Iq0yet+thJT0mZpXiOS1xz90ywbKnQ=;
        b=M0L5TZRXQKzdbXtNZ7c22a5cw2VHHWakaEJT54iCfVcktesjHh1ZY81akfTdS70zzM
         LnE+2l5fEa+SIW56dqEaND02tteHm/5AKaZ2jr9yOssbEibXam9d/C7ICPPUSvthzwLU
         tw9Mwh6KJ8JrqnG2yRm2kkA92i55DoXa5qvOoRK4gtkKNzBWoW7ug8F2kGtJIB1cV32o
         zKwE8RzoTTnW2BUuyN1d4EdZDQh5K6Pp+Ain+ntZuSt1jjgcdcGTy+MCTETjUG11JUCM
         VrqbQhx2fKPYO3L5TN7ctHPVJFl/207ZM0zaOKy6gLCuCvJM1hoIK6516nvhjxNd2OYG
         +uhg==
X-Gm-Message-State: AHQUAubaakyDzDdhxbdGSLzihDk1uIi+K84TIX9yK0PrJoTDMSwi00xs
        Fg0ZlYy+jakxowvmvHwQ81ZQSQ==
X-Google-Smtp-Source: APXvYqz5rGLSbIxoYYivRzVrhhUs6j9sM+/1pDFzmQjk2XEongI2L4ZOA2r3ktY5Q95W0DCCPkMcUQ==
X-Received: by 2002:a24:30e:: with SMTP id e14mr2647634ite.111.1551196452273;
        Tue, 26 Feb 2019 07:54:12 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q133sm4761202itb.19.2019.02.26.07.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 07:54:11 -0800 (PST)
Subject: Re: [PATCH 11/19] block: implement bio helper to add iter bvec pages
 to bio
From:   Jens Axboe <axboe@kernel.dk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org, hch@lst.de,
        jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@zeniv.linux.org.uk
References: <20190211190049.7888-1-axboe@kernel.dk>
 <20190211190049.7888-13-axboe@kernel.dk> <20190220225856.GB28313@ming.t460p>
 <b143e8c3-33d5-5f09-c441-98b3bf326d81@kernel.dk>
 <20190226034613.GA676@sol.localdomain>
 <aa1184bb-b482-0637-21e4-1ddb0e7aea90@kernel.dk>
Message-ID: <1652577e-787b-638e-625d-c200fb144a9d@kernel.dk>
Date:   Tue, 26 Feb 2019 08:54:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <aa1184bb-b482-0637-21e4-1ddb0e7aea90@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/25/19 9:34 PM, Jens Axboe wrote:
> On 2/25/19 8:46 PM, Eric Biggers wrote:
>> Hi Jens,
>>
>> On Thu, Feb 21, 2019 at 10:45:27AM -0700, Jens Axboe wrote:
>>> On 2/20/19 3:58 PM, Ming Lei wrote:
>>>> On Mon, Feb 11, 2019 at 12:00:41PM -0700, Jens Axboe wrote:
>>>>> For an ITER_BVEC, we can just iterate the iov and add the pages
>>>>> to the bio directly. This requires that the caller doesn't releases
>>>>> the pages on IO completion, we add a BIO_NO_PAGE_REF flag for that.
>>>>>
>>>>> The current two callers of bio_iov_iter_get_pages() are updated to
>>>>> check if they need to release pages on completion. This makes them
>>>>> work with bvecs that contain kernel mapped pages already.
>>>>>
>>>>> Reviewed-by: Hannes Reinecke <hare@suse.com>
>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>> ---
>>>>>  block/bio.c               | 59 ++++++++++++++++++++++++++++++++-------
>>>>>  fs/block_dev.c            |  5 ++--
>>>>>  fs/iomap.c                |  5 ++--
>>>>>  include/linux/blk_types.h |  1 +
>>>>>  4 files changed, 56 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/block/bio.c b/block/bio.c
>>>>> index 4db1008309ed..330df572cfb8 100644
>>>>> --- a/block/bio.c
>>>>> +++ b/block/bio.c
>>>>> @@ -828,6 +828,23 @@ int bio_add_page(struct bio *bio, struct page *page,
>>>>>  }
>>>>>  EXPORT_SYMBOL(bio_add_page);
>>>>>  
>>>>> +static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
>>>>> +{
>>>>> +	const struct bio_vec *bv = iter->bvec;
>>>>> +	unsigned int len;
>>>>> +	size_t size;
>>>>> +
>>>>> +	len = min_t(size_t, bv->bv_len, iter->count);
>>>>> +	size = bio_add_page(bio, bv->bv_page, len,
>>>>> +				bv->bv_offset + iter->iov_offset);
>>>>
>>>> iter->iov_offset needs to be subtracted from 'len', looks
>>>> the following delta change[1] is required, otherwise memory corruption
>>>> can be observed when running xfstests over loop/dio.
>>>
>>> Thanks, I folded this in.
>>>
>>> -- 
>>> Jens Axboe
>>>
>>
>> syzkaller started hitting a crash on linux-next starting with this commit, and
>> it still occurs even with your latest version that has Ming's fix folded in.
>> Specifically, commit a566653ab5ab80a from your io_uring branch with commit date
>> Sun Feb 24 08:20:53 2019 -0700.
>>
>> Reproducer:
>>
>> #define _GNU_SOURCE
>> #include <fcntl.h>
>> #include <linux/loop.h>
>> #include <sys/ioctl.h>
>> #include <sys/sendfile.h>
>> #include <sys/syscall.h>
>> #include <unistd.h>
>>
>> int main(void)
>> {
>>         int memfd, loopfd;
>>
>>         memfd = syscall(__NR_memfd_create, "foo", 0);
>>
>>         pwrite(memfd, "\xa8", 1, 4096);
>>
>>         loopfd = open("/dev/loop0", O_RDWR|O_DIRECT);
>>
>>         ioctl(loopfd, LOOP_SET_FD, memfd);
>>
>>         sendfile(loopfd, loopfd, NULL, 1000000);
>> }
>>
>>
>> Crash:
>>
>> page:ffffea0001a6aab8 count:0 mapcount:0 mapping:0000000000000000 index:0x0
>> flags: 0x100000000000000()
>> raw: 0100000000000000 ffffea0001ad2c50 ffff88807fca49d0 0000000000000000
>> raw: 0000000000000000 0000000000000000 00000000ffffffff
>> page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
> 
> I see what this is, I'll cut a fix for this tomorrow.

Folded in a fix for this, it's in my current io_uring branch and my for-next
branch.

-- 
Jens Axboe

