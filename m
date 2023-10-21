Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCA4C004C0
	for <linux-block@archiver.kernel.org>; Sat, 21 Oct 2023 16:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjJUQVN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Oct 2023 12:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjJUQVM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Oct 2023 12:21:12 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7814F1A8
        for <linux-block@vger.kernel.org>; Sat, 21 Oct 2023 09:21:07 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-57de6e502fcso1156597eaf.3
        for <linux-block@vger.kernel.org>; Sat, 21 Oct 2023 09:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697905267; x=1698510067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnyRv3obejbZsVeNe7gX5j+PPYvawtVE9GwYcTWW9RE=;
        b=v/9CxKaHwb74CU8ViLnuFAyxzrf4Bcysx1w8/KOYrT9f+P1FAaV+70BZFE6BIWGf8B
         vnzPzwYBdaULS+ylSHD/xtxkJMjWJNBA+QX8LeX4XnOsHciPNHiMKoqKrt2tRFheEpY+
         AMHV1dzXVIF7QON0I1/mHNPyQv2fDs9t27JhqNEtNtp/SL2OOi2pt5LCLiWqbzcZhtcT
         HnRA+xaSJBd59ClNS2ZVAgqadzhbL0+KQVvO5w8Iw/iDXgfsd/dqBpoWs8p/cE8DBDR/
         f+PvDRLpqH1Bidw5ppSOItPJ0VUaJUBlyg7A3WGIiRrZyXhYlUwoRPOrLT5ge6pdTNVA
         iIuA==
X-Gm-Message-State: AOJu0YwipdltRXs3LTDdIWSYIcP5uJXs8f2tva6cGPL+JCQ3dAeScwR/
        PVpftsb0efGUVBbcAqeYmz4=
X-Google-Smtp-Source: AGHT+IFXCVBZXxaNVnUT2+zTwIMvjW4I+TsJPUeBVQp6uB3DUroe1l44bP2LCw55vENdacBrHj3hZw==
X-Received: by 2002:a05:6358:1c2:b0:143:8084:e625 with SMTP id e2-20020a05635801c200b001438084e625mr6149533rwa.11.1697905266382;
        Sat, 21 Oct 2023 09:21:06 -0700 (PDT)
Received: from [192.168.197.167] (79.sub-174-194-200.myvzw.com. [174.194.200.79])
        by smtp.gmail.com with ESMTPSA id j6-20020a63ec06000000b0059b782e8541sm3289333pgh.28.2023.10.21.09.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 09:21:05 -0700 (PDT)
Message-ID: <b3325fe5-4208-432b-97a9-d40f5cdda4b0@acm.org>
Date:   Sat, 21 Oct 2023 09:21:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Improve shared tag set performance
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ed Tsai <ed.tsai@mediatek.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20231018180056.2151711-1-bvanassche@acm.org>
 <31ca731b-7ffb-185a-fdbc-9e4821e2b46f@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <31ca731b-7ffb-185a-fdbc-9e4821e2b46f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/21/23 00:32, Yu Kuai wrote:
> Sorry for such huge delay, I was struggled on implementing a smoothly
> algorithm to borrow tags and return borrowed tags, and later I put this
> on ice and focus on other stuff.
> 
> I had an idea to implement a state machine, however, the amount of code
> was aggressive and I gave up. And later, I implemented a simple version,
> and I tested it in your case, 32 tags and 2 shared node, result looks
> good(see below), however, I'm not confident this can work well general.
> 
> Anyway, I'll send a new RFC verion for this, and please let me know if
> you still think this approch is unacceptable.
> 
> Thanks,
> Kuai
> 
> Test script:
> 
> [global]
> ioengine=libaio
> iodepth=2
> bs=4k
> direct=1
> rw=randrw
> group_reporting
> 
> [sda]
> numjobs=32
> filename=/dev/sda
> 
> [sdb]
> numjobs=1
> filename=/dev/sdb
> 
> Test result, by monitor new debugfs entry shared_tag_info:
> time    active        available
>      sda     sdb    sda    sdb
> 0    0    0    32    32
> 1    16    2    16    16    -> start fair sharing
> 2    19    2    20    16
> 3    24    2    24    16
> 4    26    2    28    16     -> borrow 32/8=4 tags each round
> 5    28    2    28    16    -> save at lease 4 tags for sdb

Hi Yu,

Thank you for having shared these results. What is the unit of the
numbers in the time column?

In the above I see that more tags are assigned to sda than to sdb
although I/O is being submitted to both LUNs. I think the current
algoritm defines fairness as dividing tags in a fair way across active
LUNs. Do the above results show that tags are divided per active job
instead of per active LUN? If so, I'm not sure that everyone will agree
that this is a fair way to distribute tags ...

Thanks,

Bart.

