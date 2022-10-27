Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC031FA3743
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 21:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbiJ0VAd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 17:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbiJ0U7r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 16:59:47 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D386CA8BC
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 13:52:03 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b79so2839882iof.5
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 13:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r0vHN3q2APKpd0pTS8LiPF7C1q1rYGhJxwqudfc5q8Q=;
        b=i8C61kqyXp1zqpOt4aCmmPtb5wz+JnfkCqgMR6yYGHSwL53YjgATFnwfZ8yMNX0nVR
         Lx/xmZ+tGiohojQf5oLve7dExbjxendh8M8nenEOst62Wh1bN9EJrwAdwLPDFonKPDps
         Lhc+QVVAon1wN6XCg3d48wqgE+h7qCEploILvZk1MSV/9/BHg/Cl6MYlMRF+FTjwloPC
         pLK+3aT78hcw9+N4e7jQOPpjSBZ7gWzWa0qF935yFFvfog6yqGG0mGvzIHuL3c/JcetL
         61pwg4hBDq2orka8xOb9OUZV/QlaWqUYAtGmWLMpfaBpLl5LSFt/qFnR9XsVVDs5ROtF
         yTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0vHN3q2APKpd0pTS8LiPF7C1q1rYGhJxwqudfc5q8Q=;
        b=bgUF02RlvgX+ygfSFT0CREn9WqTvILBTZwpIRqdjmJ2zux7FH+3y3Ez5KrBftNj72L
         ZRf4+UEdRf859ustQlx57QeQNajHW3+XNPTmOB5NrEgeIOxfEf5f4T+Qjodzvdu2go5u
         Ps/Gmz5HCxDPhG+6W5Kq8aNL1DGnXiAreddfKgMmQgy1PbSwyb+wFuZGr8P3doR+eM4d
         cj5rq1FjH8Oc5TMqMe9tdnc7ttaBgR1dYCe82QGCO0MXLW074ec3APRE5Q3qjjulNzhT
         /I38TPDeTcyj9D1EUynhTg3Pfv0XNao5KQmr6832+DtpBjocP4LwRqlNw3GL/EU/LcQa
         X4FQ==
X-Gm-Message-State: ACrzQf01pnSSCpBKAX9nSuIK5FeIwuFuG/fQIdZxJfsaAWO3XtAVwCZU
        8KJf2ZlxxK9TbXzUipVywMesvW3PkpJReiB+
X-Google-Smtp-Source: AMsMyM7JXYXclgPhMv4xWZ2tLKSfarzxIABivZs1/mr+rXwiT5Q99O9zQp/v4Dex4bmi7ov68d7FJw==
X-Received: by 2002:a5d:9d88:0:b0:6bb:af14:4992 with SMTP id ay8-20020a5d9d88000000b006bbaf144992mr5684052iob.53.1666903922500;
        Thu, 27 Oct 2022 13:52:02 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b17-20020a026f51000000b00371ef930be0sm990821jae.1.2022.10.27.13.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 13:52:02 -0700 (PDT)
Message-ID: <f45e0f35-833f-2cae-ca53-86d439a2e2d3@kernel.dk>
Date:   Thu, 27 Oct 2022 14:52:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] block: fix bio-allocation from per-cpu cache
Content-Language: en-US
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        linux-block@vger.kernel.org
References: <CGME20221027101534epcas5p3b8335c05a1003531f1a4488dc27f27ee@epcas5p3.samsung.com>
 <20221027100410.3891-1-joshi.k@samsung.com>
 <38b863cd-9cec-1300-6d92-a0a5b89b3399@kernel.dk>
 <1620b347-b473-1a8f-136d-a480d641b5d7@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1620b347-b473-1a8f-136d-a480d641b5d7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/27/22 2:45 PM, Pavel Begunkov wrote:
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

Oh yeah, triggers in < 1 second for me when running my usual irq
peak bench:

t/io_uring -p0 -d128 -b512 -s32 -c32 -F1 -B1 -R0 -X1 -n24 -P1 /dev/nvme0n1 /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1 /dev/nvme4n1 /dev/nvme5n1 /dev/nvme6n1 /dev/nvme7n1 /dev/nvme8n1 /dev/nvme9n1 /dev/nvme10n1 /dev/nvme11n1 /dev/nvme12n1 /dev/nvme13n1 /dev/nvme14n1 /dev/nvme15n1 /dev/nvme16n1 /dev/nvme17n1 /dev/nvme18n1 /dev/nvme19n1 /dev/nvme20n1 /dev/nvme21n1 /dev/nvme22n1 /dev/nvme23n1

Interestingly, doesn't trigger in qemu with just a single device.

-- 
Jens Axboe


