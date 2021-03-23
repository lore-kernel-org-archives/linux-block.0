Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FD3C433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 18:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 172C7619B4
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 18:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhCWSNZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 14:13:25 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:43566 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhCWSNO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 14:13:14 -0400
Received: by mail-pj1-f42.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so10489405pjb.2
        for <linux-block@vger.kernel.org>; Tue, 23 Mar 2021 11:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3P4/mXFhJ/Dtn8cjDyndslkTLcCHvMTiZcMWHyv681Q=;
        b=Fi+W41NnxCizkaBYbjQ7pg/eJhPZR6XW7RMN+VyI/n8sq095xV2eaVJHFjOhJwjVJr
         H89QVOP0BpGrz9jKHSSboNJuXN990uGneqkDT/GBNlz3xPBN/7k3J6kfoy21tZz87w4x
         Wcled1WjZjpgs3q++99DxH6ORkrt2newf2FJk7KpnxIaUDJV6Pp1Lr3NWaLmq3LsSIn9
         Gy/Tce7Zt6HFfx/QUq9rn8R7bdQ1qI+oHkUjNxyjoDRYBgUhfhuHXEna5He5f5dCLOnD
         MOBZyUqmtCgtb7HvQnI9YOF2E0fQTSZHyKgKmkkTa79kr6Kx0VCIKcr0lRwgEWyhCLtr
         /nCQ==
X-Gm-Message-State: AOAM531h2Qgi+UgOr0HbS92J+jKH9bqgx3gTm610FBtmcOWc38dUpQAo
        Dal7Tk4W/eEmmGGpSNx/H3M=
X-Google-Smtp-Source: ABdhPJwfoSBgnXvyx8KbaFhNsyMPOYAFVg5BKmYQ7TrjDgXlVBGlUmxnrhI709Y+C5JTnIYWRDvemg==
X-Received: by 2002:a17:90a:d3d8:: with SMTP id d24mr5763366pjw.28.1616523194486;
        Tue, 23 Mar 2021 11:13:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3b29:de57:36aa:67b9? ([2601:647:4802:9070:3b29:de57:36aa:67b9])
        by smtp.gmail.com with ESMTPSA id i8sm3277008pjl.32.2021.03.23.11.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 11:13:14 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the
 underlying device
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
 <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me>
 <31e7f7f4-55fa-6b0c-426d-7f7e7638ab4b@huawei.com>
 <5d28226d-4619-74b6-1c73-c13ed57aa7ea@grimberg.me>
 <20210323161544.GA13402@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <162dc8f7-b46d-37ff-01e8-51d813e0a904@grimberg.me>
Date:   Tue, 23 Mar 2021 11:13:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210323161544.GA13402@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> Sagi, suggest trying this patch.
>>
>> The above reproduces with the patch applied on upstream nvme code.
> 
> Weird.  I don't think the deadlock in your original report should
> happen due to this.  Can you take a look at the callstacks in the
> reproduced deadlock?  Either we're missing something obvious or it is a
> a somewhat different deadlock.

The deadlock in this patchset reproduces upstream. It is not possible to
update the kernel in the env in the original report.

So IFF we assume that this does not reproduce in upstream (pending
proof), is there something that we can do with stable fixes? This will
probably go back to everything that is before 5.8...
