Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A60FA3742
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 11:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiJ0Lr0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 07:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiJ0LrZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 07:47:25 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC3557BCF
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 04:47:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so3974238wmr.2
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 04:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pp3WssIDiwffa/Iw72CELrWguDX00JoxvppfetTWe1c=;
        b=SlMVCcJ74KWh3EOlvV6ErcsWhuQsLOPYemmXmipGLjIxg+M2ze2a/H+Zk4eRYQJJ+h
         aIwKb9FgYyuWUJk5qAgJQ38BQ8o7rZpJP5PBSWg2sK5ArgUHeE20RRU62tUDazuggCv+
         4wHDiNFKoM/6FV93U0ndlcVS2g2KOtC6axJegciJNPYbILFxqrRlM6fpsnnHXV7Klsdn
         AtG7CE9B14gLmdqVPHr8g941Zaz4Z0xnyy9gSq//mlUUEiZ/+zJ5/eQdLo+EPbBkbCDN
         3x6ZZAI1tNFipWwbn6+u31m4hQrwAXQd1wdQJUSkOVYAQCbKbwcD7yi2adqiPkp4q9qx
         GcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pp3WssIDiwffa/Iw72CELrWguDX00JoxvppfetTWe1c=;
        b=CAkct1/FJupIaTyGNbe34yzKZrWn6op/g50nFLETmiNshYWTgocXAP3ot/MxAvVHk8
         PIziDFC7qTKO2Xa952wSiXx8N3ysfqoGoVxX403g6g3APorwK0ONekcrKXhZPL2mq17P
         NYmfdAHfiEEdVXmjk3zfAkZyS5znV4zPVf6JX27H3f8JcTNMN1fyuczRHpq93o8ZsvVN
         jlN+osXm6X1CxVFaAugqR9+NAsKZWbJBGhXBB2cGll4ivF4RuRrHHrI+psFlMUmAhTUT
         fZmHJrm1f7asaL0E4ujNGrZbs7z+tTF16PgU1WdZsleAi4B6Lg4RDNU4utjoDMbVfGfl
         6EUA==
X-Gm-Message-State: ACrzQf2f3CIpxnifDMrLqKYv9HtmtPXgne9EGHjaHA3c07RYJKQK6td1
        kz0BpwsdJqGE8TMDxFDUAG8ysoQRoMnQyQ==
X-Google-Smtp-Source: AMsMyM55itU1AELEAim06UIy2JSVJyEtsspnwY1qIOEFxql1PaEJeC14ghkpWfSfewGIt6QmavcDxw==
X-Received: by 2002:a05:600c:310a:b0:3c6:f9a6:5a7d with SMTP id g10-20020a05600c310a00b003c6f9a65a7dmr5597081wmo.29.1666871242518;
        Thu, 27 Oct 2022 04:47:22 -0700 (PDT)
Received: from [10.1.2.99] (wifi-guest-gw.tecnico.ulisboa.pt. [193.136.152.65])
        by smtp.gmail.com with ESMTPSA id h2-20020adfe982000000b002322bff5b3bsm1176316wrm.54.2022.10.27.04.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 04:47:22 -0700 (PDT)
Message-ID: <7f2a2ecd-7fe1-d30a-a29c-8025b33156ce@gmail.com>
Date:   Thu, 27 Oct 2022 12:46:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] block: fix bio-allocation from per-cpu cache
Content-Language: en-US
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
References: <CGME20221027101534epcas5p3b8335c05a1003531f1a4488dc27f27ee@epcas5p3.samsung.com>
 <20221027100410.3891-1-joshi.k@samsung.com>
 <b7c3d003-d808-a57f-c645-48cfc06d7a52@gmail.com>
 <20221027104910.GA22546@test-zns>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20221027104910.GA22546@test-zns>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/27/22 11:49, Kanchan Joshi wrote:
> On Thu, Oct 27, 2022 at 11:38:50AM +0100, Pavel Begunkov wrote:
>> On 10/27/22 11:04, Kanchan Joshi wrote:
>>> If cache does not have any entry, make sure to detect that and return
>>> failure. Otherwise this leads to null pointer dereference.
>>
>> Damn, it was done right in v2
>>
>> https://lore.kernel.org/all/9fd04486d972c1f3ef273fa26b4b6bf51a5e4270.1666122465.git.asml.silence@gmail.com/
>>
>> Perhaps I based v3 on a wrong version. Thanks
>>
>>
>>> Fixes: 13a184e26965 ("block/bio: add pcpu caching for non-polling bio_put")
>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>> ---
>>> Can be reproduced by:
>>> fio -direct=1 -iodepth=1 -rw=randread -ioengine=io_uring -bs=4k -numjobs=1 -size=4k -filename=/dev/nvme0n1 -hipri=1 -name=block
>>>
>>> BUG: KASAN: null-ptr-deref in bio_alloc_bioset.cold+0x2a/0x16a
>>> Read of size 8 at addr 0000000000000000 by task fio/1835
>>>
>>> CPU: 5 PID: 1835 Comm: fio Not tainted 6.1.0-rc2+ #226
>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g
>>> Call Trace:
>>>  <TASK>
>>>  dump_stack_lvl+0x34/0x48
>>>  print_report+0x490/0x4a1
>>>  ? __virt_addr_valid+0x28/0x140
>>>  ? bio_alloc_bioset.cold+0x2a/0x16a
>>>  kasan_report+0xb3/0x130
>>>  ? bio_alloc_bioset.cold+0x2a/0x16a
>>>  bio_alloc_bioset.cold+0x2a/0x16a
>>>  ? bvec_alloc+0xf0/0xf0
>>>  ? iov_iter_is_aligned+0x130/0x2c0
>>>  blkdev_direct_IO.part.0+0x16a/0x8d0
>>>
>>>  block/bio.c | 11 ++++++-----
>>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/block/bio.c b/block/bio.c
>>> index 8f624ffaf3d0..66f088bb3736 100644
>>> --- a/block/bio.c
>>> +++ b/block/bio.c
>>> @@ -439,13 +439,14 @@ static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
>>>      cache = per_cpu_ptr(bs->cache, get_cpu());
>>>      if (!cache->free_list &&
>>> -        READ_ONCE(cache->nr_irq) >= ALLOC_CACHE_THRESHOLD) {
>>> +        READ_ONCE(cache->nr_irq) >= ALLOC_CACHE_THRESHOLD)
>>>          bio_alloc_irq_cache_splice(cache);
>>> -        if (!cache->free_list) {
>>> -            put_cpu();
>>> -            return NULL;
>>> -        }
>>> +
>>> +    if (!cache->free_list) {
>>
>> Let's nest it under the other "if (!cache->free_list)"
> 
> Not sure if I got you. It was under that if condition earlier, and that
> part causes trouble.

Under the free_list check specifically, the threshold would also
go in a separate if,

> What you wrote in v2 is another way, but there also we have two checks
> on cache->free_list.

Your version:

if (cache_empty())
	if (check_threshold())
		try_replenish_cache(); // splice
if (cache_empty()) // still empty
	return NULL;


vs v2:

if (cache_empty()) {
	if (check_threshold())
		try_replenish_cache(); // splice
	if (cache_empty()) // still empty
		return NULL;
}

But on the other hand compilers should be smart enough to
optimise repeated checks when the cache already have requests,
so there should be no real difference.

-- 
Pavel Begunkov
