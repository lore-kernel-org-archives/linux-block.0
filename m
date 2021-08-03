Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975ECC432BE
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 18:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7664360725
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 18:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhHCSi6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Aug 2021 14:38:58 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:42578 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbhHCSi6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Aug 2021 14:38:58 -0400
Received: by mail-pj1-f48.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso11pjo.1;
        Tue, 03 Aug 2021 11:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WJYQcXM/ofUPMB+RBQxPq0m9h51ViO2SpCc1//JSrXM=;
        b=qsLs31PaQBYjTG5CSQ2Qmbj+AEO3fDTJg88QCQut9RBgVJZhVK+6wC1evDA6DE3K4Y
         guwgBHhyga6aCOZ7az5vxzXDQU3h9AF2oQarmBqgNjAASW9FBKox7dRMdfmg9oYQuKqf
         ziDz3f7iacBVYAmrkGjDW/aeN3A1nyCBqYCi+kIzsaCfGd/8zmElK7/7oAUtuvTBJJ/3
         D8SSkcpVvydNp5g8B3+NbHpfbbknZAFcdfELv90gI/uQd6GP8+0U00p3SO4Z5GxdWBRi
         Gb6MI5g7Vr/+mCQ/68n79U/nnMxKKxOB81C39uhN4rJAZ32lRXYfPyCdA6EemUZj1dUz
         9K8w==
X-Gm-Message-State: AOAM533X/gW+VxIi55Kw15wvDW30xrl2bfdpW8V2KBJXQ4IWHH169JfY
        rO7GO5gggJFl9o01OAO2PvA=
X-Google-Smtp-Source: ABdhPJzgA/1jktfXbQQDFhXI8WXt99jGtglEOXQTTsjlLfwHbW6JCUWzv/sikq7++DN7OcCQGCUDkg==
X-Received: by 2002:a65:6248:: with SMTP id q8mr267440pgv.279.1628015926799;
        Tue, 03 Aug 2021 11:38:46 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:f630:1578:90bf:ff92])
        by smtp.gmail.com with ESMTPSA id a8sm4388072pfk.219.2021.08.03.11.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 11:38:45 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: allow hardware queue to get more tag while
 sharing a tag set
To:     "yukuai (C)" <yukuai3@huawei.com>, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20210712031818.31918-1-yukuai3@huawei.com>
 <ade72519-5e16-1cc5-9a77-cb9ead42035e@acm.org>
 <5ab07cf8-a2a5-a60e-c86a-ab6ea53990bb@huawei.com>
 <e587c572-bcd7-87c4-5eea-30ccdc7455db@acm.org>
 <b124b91b-7474-fa27-b78c-01b7e7396a17@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <07d2e6ba-d016-458a-a2ce-877fd7b72ed0@acm.org>
Date:   Tue, 3 Aug 2021 11:38:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <b124b91b-7474-fa27-b78c-01b7e7396a17@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/2/21 7:57 PM, yukuai (C) wrote:
> The cpu I'm testing is Intel(R) Xeon(R) Gold 6140 CPU @ 2.30GHz, and
> after switching to io_uring with "--thread --gtod_reduce=1
> --ioscheduler=none", the numbers can increase to 330k, yet still
> far behind 6000k.

On 
https://ark.intel.com/content/www/us/en/ark/products/120485/intel-xeon-gold-6140-processor-24-75m-cache-2-30-ghz.html 
I found the following information about that CPU:
18 CPU cores
36 hyperthreads

so 36 fio jobs should be sufficient. Maybe IOPS are lower than expected 
because of how null_blk has been configured? This is the configuration 
that I used in my test:

modprobe null_blk nr_devices=0 &&
     udevadm settle &&
     cd /sys/kernel/config/nullb &&
     mkdir nullb0 &&
     cd nullb0 &&
     echo 0 > completion_nsec &&
     echo 512 > blocksize &&
     echo 0 > home_node &&
     echo 0 > irqmode &&
     echo 1024 > size &&
     echo 0 > memory_backed &&
     echo 2 > queue_mode &&
     echo 1 > power ||
     exit $?

> The new atomic operations in the hot path is atomic_read() from
> hctx_may_queue(), and the atomic variable will change in two
> situations:
> 
> a. fail to get driver tag with dbusy not set, increase and set dbusy.
> b. if dbusy is set when queue switch from busy to dile, decrease and
> clear dbusy.
> 
> During the period a device "idle -> busy -> idle", the new atomic
> variable can be writen twice at most, which means this is almost
> readonly in the above test situation. So I guess the impact on
> performance is minimal ?

Please measure the performance impact of your patch.

Thanks,

Bart.

