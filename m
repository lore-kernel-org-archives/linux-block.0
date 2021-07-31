Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7708EC432BE
	for <linux-block@archiver.kernel.org>; Sat, 31 Jul 2021 17:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205C761077
	for <linux-block@archiver.kernel.org>; Sat, 31 Jul 2021 17:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhGaRPY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 31 Jul 2021 13:15:24 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:55137 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhGaRPY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 31 Jul 2021 13:15:24 -0400
Received: by mail-pj1-f47.google.com with SMTP id b6so19658292pji.4;
        Sat, 31 Jul 2021 10:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DlaoNmwnEWDtxTjH4uaBlzq3ZGun3yheeOVe4kPMWlc=;
        b=nRiNHjZ3ak47qCrpNaQC0KlEFsD2IJqBqsI1jy+9CnSM9OelaAgyA+Mu1MpcgIs33K
         MjTuU01NGmSM3JZkodBKzlqvY7euttqBs+vUI/X4Wky9Z4F5YoY/FY9v+1T4wJk1wMqp
         uyuR9peYgOq5CdJwj6JuMSN2wtPUeborC3fpNiF+BO/p+RdsZo4jqLIkjf2H9wv2yWcd
         0aPU4N2NJQndTWUwMJdKLmtguitLd5aDvvCQLx+gJlN1PRM1mgCF+AT64aqjPlPBFy7l
         30fA1O9pqE8ytkwTagftLoWxnF4Nk5dfidjo4DqJUZjkvfDminEzRO9X7AhsKeS2wCQ8
         oB8g==
X-Gm-Message-State: AOAM530AyiOT1ba5ld2GHS9chB2nRk5whiy6MnnsWZBk98rF/EJPNoi9
        UbnSAvSw+/rL2sLUcI8XPBI=
X-Google-Smtp-Source: ABdhPJxagnFWjqey40tjfYyQ5SyxoZzmV1olLTHdeYhT7HZM2cviRdp277uKthSeil31eA/NJXkRIQ==
X-Received: by 2002:a17:90a:d90f:: with SMTP id c15mr9207955pjv.178.1627751717376;
        Sat, 31 Jul 2021 10:15:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:13bf:959e:93b8:7d56? ([2601:647:4000:d7:13bf:959e:93b8:7d56])
        by smtp.gmail.com with ESMTPSA id z5sm2501918pff.97.2021.07.31.10.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jul 2021 10:15:16 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: allow hardware queue to get more tag while
 sharing a tag set
To:     Yu Kuai <yukuai3@huawei.com>, axboe@kernel.dk, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20210712031818.31918-1-yukuai3@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ade72519-5e16-1cc5-9a77-cb9ead42035e@acm.org>
Date:   Sat, 31 Jul 2021 10:15:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210712031818.31918-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/11/21 8:18 PM, Yu Kuai wrote:
> If there are multiple active queues while sharing a tag set, it's not
> necessary to limit the available tags as same share for each active queue
> if no one ever failed to get driver tag. And fall back to same share if
> someone do failed to get driver tag.
> 
> This modification will be beneficial if total queue_depth of disks
> on the same host is less than total tags.

This patch adds new atomic operations in the hot path and hence probably
has a negative performance impact. What is the performance impact of
this patch for e.g. null_blk when submitting I/O from all CPU cores?

Thanks,

Bart.
