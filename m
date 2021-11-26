Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FACDC433F5
	for <linux-block@archiver.kernel.org>; Fri, 26 Nov 2021 17:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhKZR3t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Nov 2021 12:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhKZR1s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Nov 2021 12:27:48 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B156FC061D60
        for <linux-block@vger.kernel.org>; Fri, 26 Nov 2021 08:55:46 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id m9so12258449iop.0
        for <linux-block@vger.kernel.org>; Fri, 26 Nov 2021 08:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EDS2/0OZnN8Yw+lCiybES2eHP22JnKrPW2o1V5evDOM=;
        b=C8QmUu5hmXhMVkzBdut4hMaRUJyacbRIH2gubo8jLLug4HOxGfUGyOX7Aj7Z7WCYUU
         T8JtghGeNN/hdEmGKj/oJLP4r48bg19eBGqUhlazqGqf37TmzWS8cGJcHRQ+vEFKjihW
         BQVUk5S+/nDT/C18fqfPXmJn5FSzjMluFSZiwOhLBpk5irQtZLYD2wXTqu10XcTUIUd+
         l1YuErzdPW75uoyQ35KqiLnOn7zvPVltnJSkPboOWS81OXi+Y/952LDYumkpXF2rJllQ
         kJYg2tuPihnth2wptLShDnwpKKM00gxvH0MizjMYSVOKlb7BUjtDNA45/9pkuaQqEN4a
         epnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EDS2/0OZnN8Yw+lCiybES2eHP22JnKrPW2o1V5evDOM=;
        b=AAUGt12MpQL9UgOiDmZqhjAuqYgV8UFC6EIQnB848DuqS1OyIOWb0j6ZUSw51mBSk3
         xMlp9NCeR/1I+uCLnZ745SoXiENqECGef8ea3FpMOUVUFC7rPXHBKy5bFHHDlVZUNvOu
         KPtH0FkqthwlfMopqj+DpZJ3e0P9wvJh0+ah4GdUW19tG6tQ+wxLujHVeTSybE5s0lBO
         jUCoWvHNh5o60yt4w72o5JnJrxvFi5/SAFeosLJvDE8PFOePKPhQAT4k13iE9aHUrIt+
         tTpUw91LB8AcKgHxIhhLTZPQwefgNifwwEL4NtdJYq9a+5h+7iPSK8xXeAt21PBKNArl
         LyHQ==
X-Gm-Message-State: AOAM530rRV5mlVuajqEnQKV7bqEAq5+8ur4SlUojML/Du3j337vgNISJ
        PoGSPjyBv8qJYjaoAOltEjSx0JgNxe+qn48F
X-Google-Smtp-Source: ABdhPJyGf22J9LsH+edxTWD8Sx95AqHqfhbWPFlW1x0SNo1dVmZWhAj3Jr0JMoStWOPH8QteD33X5Q==
X-Received: by 2002:a05:6602:1581:: with SMTP id e1mr36874278iow.64.1637945745338;
        Fri, 26 Nov 2021 08:55:45 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id z6sm4258907ioq.35.2021.11.26.08.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 08:55:44 -0800 (PST)
Subject: Re: I/O hang with v5.16-rc2
From:   Jens Axboe <axboe@kernel.dk>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20211126095352.bkbrvtgfcmfj3wkj@shindev>
 <124f86f8-91db-3a02-702d-5c26b22de107@kernel.dk>
Message-ID: <e1b65eee-e8c8-e98d-d2f7-5e35eca46651@kernel.dk>
Date:   Fri, 26 Nov 2021 09:55:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <124f86f8-91db-3a02-702d-5c26b22de107@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/21 9:21 AM, Jens Axboe wrote:
> On 11/26/21 2:53 AM, Shinichiro Kawasaki wrote:
>> I ran my test set on v5.16-rc2 and observed a process hang. The test work load
>> repeats file creation on xfs on dm-zoned. This dm-zoned device is on top of 3
>> dm-linear devices. One of them is dm-linear device on non-zoned NVMe device as
>> the cache of the dm-zoned device. The other two are dm-linear devices on zoned
>> SMR HDDs. So far, the hang is recreated 100% with my test system.
>>
>> The kernel message [2] reported hanging tasks. In the call stack, I observe
>> wbt_wait(). Also I observed "inflight 1" value in the "rqos/wbt/inflight"
>> attribute of debug sysfs.
>>
>> # grep -R . /sys/kernel/debug/block/nvme0n1 | grep inflight
>> /sys/kernel/debug/block/nvme0n1/rqos/wbt/inflight:0: inflight 1
>> /sys/kernel/debug/block/nvme0n1/rqos/wbt/inflight:1: inflight 0
>> /sys/kernel/debug/block/nvme0n1/rqos/wbt/inflight:2: inflight 0
>>
>> These symptoms look related to another issue reported to linux-block [1]. As
>> discussed in that thread, I set 0 to /sys/block/nvme0n1/queue/wbt_lat_usec.
>> With this setting, I observed the hang disappeared. Then this hang I observe
>> also related to writeback throttling for the NVMe device.
>>
>> I bisected and found the commit 4f5022453acd ("nvme: wire up completion batching
>> for the IRQ path") is the trigger commit. I reverted this commit from v5.16-rc2,
>> and observed the hang disappeared.
>>
>> Wish this report helps.
>>
>>
>> [1] https://lore.kernel.org/linux-block/b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com
> 
> Yes looks the same as that one, and that commit was indeed my suspicion
> on what could potentially cause the accounting discrepancy. I'll take a
> look at this.

I sent out a patch in the other thread, please give that a whirl.

-- 
Jens Axboe

