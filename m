Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EAAECAAA1
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 21:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbiJ0VAR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 17:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237584AbiJ0U7h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 16:59:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A2A3740D
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 13:51:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z14so4183259wrn.7
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 13:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7qIvcdz0oBbAnHIIBOf9/AEH0rRd02GI8eps/0HQmc=;
        b=V5IboZXaZh5EXvkzw6WknSSFP3QzIw+9IiZkMxXlfwEcZq/LAvEetAfzF9jx1uar0g
         hmTIWGEH8m3JIlaC9cPzS78t/ixeTF8x8Mrf+ZT/NC6IPPy32uqfKdzhP1Jt6Rszu//S
         PqfqKHRVUxgQu1MWuZbflwcCtnBSf2fScMSbpri5tZ9hQWSWbEw93YOpt28HH2G8U50V
         yYtY0A9wcXygDg9jSjk1N61i1297KE/xz5po6xdrZcFuT5zmiwi3wWogAkEwzDXvHycd
         OpPjwvbwDfoD9F53g0quauD8lXsillmiJrCDLVIqooot7lZPlXdXnT5CpGlwOTn+FkRx
         V8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7qIvcdz0oBbAnHIIBOf9/AEH0rRd02GI8eps/0HQmc=;
        b=gXCtckskUdJ9Z3j5KJ076SXdmqvBEIx06PijKgEVYO6wdIKpPOu1J4Q9uMVZ0RYkWW
         1aXF+2Ni7YTQ4sSE8cyV8+O/AqK5vIUgl5BmGwyGkHyDytcvh0E1QTI045DpSoNoX9mD
         Q+S90+dV7yT23qWzoTdKReRpA1xAgv/Il7fHf94oJKulU6uuz3juvqVCoBoqLVmLuHnM
         gzQGhVrkNKVxlo0udj3MUd9ZXtG1QF0Hn6qbIOnbzlofHDf+VME7c2/GeXIelY9jymQt
         xrRWbYNwM3muZ9BLTNfd81gCirbdjOIN7slGBAtHc7ijFuC3/WeinAkB2By14gZL0vI6
         bD2w==
X-Gm-Message-State: ACrzQf1U8NKekoFer1ZUmy2VL7LEr7JfavSyVcEfh5kLbc7CYDsVTjaK
        q5UtRmHyfSzRVhp4qB4i/XZnO9v6kK/R+w==
X-Google-Smtp-Source: AMsMyM4yiSaHcu34JFJf/5NbYV6i4fne9I6KCtRf1tBZ5VoImIcRMYJQx1JyYatKRIJTJ+uhLmCDPw==
X-Received: by 2002:a05:6000:170d:b0:236:6aa1:8a56 with SMTP id n13-20020a056000170d00b002366aa18a56mr16642247wrc.302.1666903909539;
        Thu, 27 Oct 2022 13:51:49 -0700 (PDT)
Received: from [10.10.42.20] (213-205-70-130.net.novis.pt. [213.205.70.130])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c4fce00b003b476cabf1csm2633822wmq.26.2022.10.27.13.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 13:51:49 -0700 (PDT)
Message-ID: <0daa8fb3-460f-a8c5-fc22-63d28ee3a6e1@gmail.com>
Date:   Thu, 27 Oct 2022 21:50:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] block: fix bio-allocation from per-cpu cache
Content-Language: en-US
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
        linux-block@vger.kernel.org
References: <CGME20221027101534epcas5p3b8335c05a1003531f1a4488dc27f27ee@epcas5p3.samsung.com>
 <20221027100410.3891-1-joshi.k@samsung.com>
 <38b863cd-9cec-1300-6d92-a0a5b89b3399@kernel.dk>
 <1620b347-b473-1a8f-136d-a480d641b5d7@gmail.com>
In-Reply-To: <1620b347-b473-1a8f-136d-a480d641b5d7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/27/22 21:45, Pavel Begunkov wrote:
> On 10/27/22 21:44, Jens Axboe wrote:
>> On 10/27/22 4:04 AM, Kanchan Joshi wrote:
>>> If cache does not have any entry, make sure to detect that and return
>>> failure. Otherwise this leads to null pointer dereference.
>>>
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
>>>   <TASK>
>>>   dump_stack_lvl+0x34/0x48
>>>   print_report+0x490/0x4a1
>>>   ? __virt_addr_valid+0x28/0x140
>>>   ? bio_alloc_bioset.cold+0x2a/0x16a
>>>   kasan_report+0xb3/0x130
>>>   ? bio_alloc_bioset.cold+0x2a/0x16a
>>>   bio_alloc_bioset.cold+0x2a/0x16a
>>>   ? bvec_alloc+0xf0/0xf0
>>>   ? iov_iter_is_aligned+0x130/0x2c0
>>>   blkdev_direct_IO.part.0+0x16a/0x8d0
>>
>> Was going to apply this, but after running some testing, it does
>> fix the initial crash but I still get weird corruption crashes
>> with the series it's fixing.
>>
>> Pavel, I'm going to drop this series for now.
> 
> I found one yesterday. Is the issue reproducible?

found one bug *

-- 
Pavel Begunkov
