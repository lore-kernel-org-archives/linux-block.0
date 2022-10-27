Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A32ECAAA1
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 20:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbiJ0Uzf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 16:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbiJ0Uyj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 16:54:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D042CA232C
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 13:46:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l14-20020a05600c1d0e00b003c6ecc94285so4504388wms.1
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 13:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o0NFMMzDFm5KljdFdu0npxW+N0yBfPP9ih29d6XeGHI=;
        b=dQ2HgTuRgq+9udmcQ0yJpdipCxW0tAFIJLjlDFv6ppH25kIdkDXRuadRY9UdTloOf6
         MalGLoBWwhVdIbBA7aoKNG7XdewVHxZy8t6bGzxOCy0gR4KoCj7J2OhS5Lsb74TxYuod
         BFYPieZplbelxRPL6nqX6hYNv1NWH1qnxTb7piaBTNNYuDTLwPv37MTYPg8Lx4J2LKd1
         w7cUh7TpSq8IhDHQqh5gAY5daJHgfAUyunKPF/EV9j0xz/gX6505zMqjDL1Y8yrOxhmt
         HeyHT3vgq/UJjduPztrttIjtlENtF9w2Jb4ElUroX+XJoKuJoudcIz5MYmk8iBVzIEtE
         W37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0NFMMzDFm5KljdFdu0npxW+N0yBfPP9ih29d6XeGHI=;
        b=zND+SkmjNNNh97bx7UUk4rzujDTPzKBz9/A15p+PJZPacI7eXKPqqztPPZ8mvn+YVs
         9w1gBSKJ3vgnyIA3fdmad+8sMEEGOnsVBR2sCSHfhb2wq3udUpe0piSnixNeOUqDlHuZ
         CYtdcpSxCgZqx5S7OHbLTCwP6Ps8tKvL98XcaXNeh4ixGV86hAmYX4Rrst88CpKiblUX
         ny1rdXIJuevahPtROR5E6BY+XYapY/UAvlz2RWQFkPX8/4eXAspDafoydch2CO0PvKHf
         17o4BQTByJpfBsHHjlQbD24jNSmIuwbwwUnNToMVVhH99wcymx89I/Vu9rC3BCVLDY6x
         H4yA==
X-Gm-Message-State: ACrzQf2lMJkkXnD2izTH2/3bwryg00FfSaI1baFwiuTldNNIGE1jkkwZ
        YIEGqwGyjjMxMRVqK+IAltgPTc5fPYpWzQ==
X-Google-Smtp-Source: AMsMyM5+E8cUw6n96MUpF3u7buyuMNQVXMhMQtG+py77u7UtQ43cXr2fwncymXEeyeLQUpsf5ft+pw==
X-Received: by 2002:a05:600c:1e2a:b0:3c8:353b:253f with SMTP id ay42-20020a05600c1e2a00b003c8353b253fmr7311853wmb.51.1666903599212;
        Thu, 27 Oct 2022 13:46:39 -0700 (PDT)
Received: from [10.10.42.20] (213-205-70-130.net.novis.pt. [213.205.70.130])
        by smtp.gmail.com with ESMTPSA id a17-20020adfdd11000000b00236695ff94fsm1994792wrm.34.2022.10.27.13.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 13:46:38 -0700 (PDT)
Message-ID: <1620b347-b473-1a8f-136d-a480d641b5d7@gmail.com>
Date:   Thu, 27 Oct 2022 21:45:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] block: fix bio-allocation from per-cpu cache
To:     Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
        linux-block@vger.kernel.org
References: <CGME20221027101534epcas5p3b8335c05a1003531f1a4488dc27f27ee@epcas5p3.samsung.com>
 <20221027100410.3891-1-joshi.k@samsung.com>
 <38b863cd-9cec-1300-6d92-a0a5b89b3399@kernel.dk>
Content-Language: en-US
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <38b863cd-9cec-1300-6d92-a0a5b89b3399@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/27/22 21:44, Jens Axboe wrote:
> On 10/27/22 4:04 AM, Kanchan Joshi wrote:
>> If cache does not have any entry, make sure to detect that and return
>> failure. Otherwise this leads to null pointer dereference.
>>
>> Fixes: 13a184e26965 ("block/bio: add pcpu caching for non-polling bio_put")
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> ---
>> Can be reproduced by:
>> fio -direct=1 -iodepth=1 -rw=randread -ioengine=io_uring -bs=4k -numjobs=1 -size=4k -filename=/dev/nvme0n1 -hipri=1 -name=block
>>
>> BUG: KASAN: null-ptr-deref in bio_alloc_bioset.cold+0x2a/0x16a
>> Read of size 8 at addr 0000000000000000 by task fio/1835
>>
>> CPU: 5 PID: 1835 Comm: fio Not tainted 6.1.0-rc2+ #226
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x34/0x48
>>   print_report+0x490/0x4a1
>>   ? __virt_addr_valid+0x28/0x140
>>   ? bio_alloc_bioset.cold+0x2a/0x16a
>>   kasan_report+0xb3/0x130
>>   ? bio_alloc_bioset.cold+0x2a/0x16a
>>   bio_alloc_bioset.cold+0x2a/0x16a
>>   ? bvec_alloc+0xf0/0xf0
>>   ? iov_iter_is_aligned+0x130/0x2c0
>>   blkdev_direct_IO.part.0+0x16a/0x8d0
> 
> Was going to apply this, but after running some testing, it does
> fix the initial crash but I still get weird corruption crashes
> with the series it's fixing.
> 
> Pavel, I'm going to drop this series for now.

I found one yesterday. Is the issue reproducible?

-- 
Pavel Begunkov
