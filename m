Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB23AC433DB
	for <linux-block@archiver.kernel.org>; Mon, 21 Dec 2020 18:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C5F230FC
	for <linux-block@archiver.kernel.org>; Mon, 21 Dec 2020 18:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgLUSKj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:10:39 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:45459 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgLUSKj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Dec 2020 13:10:39 -0500
Received: by mail-pf1-f169.google.com with SMTP id q22so6869685pfk.12;
        Mon, 21 Dec 2020 10:10:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8dIJLNnmNoE8h9i8sFnbQZj9YUqZfg5A0um10+iHuWA=;
        b=p2SXanvsM6i7Ebx8At7Vet6dQSUpJi6xfQiRiDQk2YPF2gg/e+lXS0LXV4NdeKudzD
         ommg1ou1J+95iDwu064Hjgw12F5Rv55BoSKDKmUWi9NSo5cLWCTofPWZbhPBEfQf89Zf
         i/Z9/HGtZlu2BRbMbx4U+MN4Vc7MqVQTKk5PpIsRQv3NnkWbRMnKxRiNn0tBji0T/vHU
         2qwR6ilVpM6HPjJPDSdSPOCwpUFfheHrl8QWWTmtlS8ENT2ZurDX/QbVMQGdXciSgbhu
         ed3SRD4LLSheAfCReJsnogsOhLRM0YI5epsz0HoHq6P0pQQCqwO2wXPxSqdi6kOfuChL
         3N/A==
X-Gm-Message-State: AOAM532CgKqdLolU/b8MKIgQloSXBUqZbMiTQQC3z8OBgUUlZCFdhVfH
        2fcXXjb+txHpzqxfj+Kuw9w=
X-Google-Smtp-Source: ABdhPJxvsIuJR7cnSE+GOx+aeGq3hJ9BhVJ0K5yLOc3OvpjdYfSXULP24hOxio3i+iw46w/JNdybPQ==
X-Received: by 2002:a63:fd10:: with SMTP id d16mr2737575pgh.333.1608574198507;
        Mon, 21 Dec 2020 10:09:58 -0800 (PST)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s13sm17724335pfd.99.2020.12.21.10.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 10:09:57 -0800 (PST)
Subject: Re: [RFC PATCH v2 2/2] blk-mq: Lockout tagset iter when freeing rqs
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, hare@suse.de, ppvk@codeaurora.org,
        kashyap.desai@broadcom.com, linuxarm@huawei.com
References: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
 <1608203273-170555-3-git-send-email-john.garry@huawei.com>
 <df44b73d-6c42-87ee-3c25-b95a44712e05@acm.org>
 <4d2004bb-4444-7a63-7c72-1759e3037cfd@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <31de2806-bbc1-dcc3-b9eb-ce9257420432@acm.org>
Date:   Mon, 21 Dec 2020 10:09:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <4d2004bb-4444-7a63-7c72-1759e3037cfd@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/21/20 4:06 AM, John Garry wrote:
> On 18/12/2020 22:43, Bart Van Assche wrote:
>> Does this mean that we do not yet have
>> a full explanation about why the above call stack can be triggered?
> 
> We understand it, and I'll describe my experiment in detail:
> a. fio runs on 2x disks, sda (root partition disk) and sdb.
> b. for sda, userpace triggers blk_mq_queue_tag_busy_iter(), as in
> stackframe above. Since its request queue is not frozen, it will iter
> the busy tags.
> c. on sdb, I continuously change the IO scheduler.
> 
> So sdb request queue gets frozen as we switch IO sched, but we could
> have this sequence of events:
> - blk_mq_queue_tag_busy_iter() on sda takes reference to a sdb request
>    - Getting a tag and updating ->rqs[] in tagset is not atomic
> - requests for sdb cleared in tagset and request memory is freed
> - blk_mq_queue_tag_busy_iter() on sda still holds reference to sdb
> request and dereferences it -> UAF
> 
> Hope it's clear. It is a bit unlikely, I will admit, but it still can
> happen and UAF is never good. So please let me know if other idea to solve.

Hi John,

Do you agree that all partitions (struct block_device) of a disk share a
request queue (block_device.bd_disk->queue)? I'm asking this because it
seems like in the above explanation it has been assumed that different
partitions use different request queues.

Thanks,

Bart.

