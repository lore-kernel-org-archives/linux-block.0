Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C985C4338F
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 04:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3767B619E5
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 04:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhHPERZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 00:17:25 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:39480 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhHPERZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 00:17:25 -0400
Received: by mail-pj1-f53.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so30343511pjn.4;
        Sun, 15 Aug 2021 21:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VGQ6B94EGHj3H0WVGab38MvJV4C1IW98Ade2+yP4yzc=;
        b=PSVtZALkFwOJGJ8udoFHQbP2WdGcj7XSnJ6t8cKKBrkP2rlDnmwDIP7AnHuTdUNXrX
         vUFECheWoCh+5UfKxpvMS9Dx23wVDeX8C8eNg42EOuA05RtAj32sXQN0aCWJc6wbQP7B
         yGjmp1BjKctM/8vlpryKuFKQ6G7W8n9YRACyX8jdm4rtuijLf4XEkZOI3RF8e3rny5sV
         SLrx3TMeyDAdwBx1j2bZ9T+ZZcdXg1JYA/jnQ+sGcXEVMRY8WCzdpfqqosYM73ek87ao
         06LuT0l7EnkTr0V4fWhaa715F9a++mzXPWfRXWCU1YgHubYDObsHflG74TOspsMRTs+E
         7RGQ==
X-Gm-Message-State: AOAM533fBPUgDftsDx4V7M2B6NrK9juL+Rsl6XQpkb/+mY2/vnHaRwoG
        09B9qt933DRwPQlOJAqkkXs=
X-Google-Smtp-Source: ABdhPJxnBLahpzCRRiIlIwdrSPnemb10fYGm83yYh2erypPGIj9DtbMV8M9OYocf2o2upR65MApJKA==
X-Received: by 2002:a05:6a00:1884:b029:3bb:640f:4cfc with SMTP id x4-20020a056a001884b02903bb640f4cfcmr14420387pfh.61.1629087413831;
        Sun, 15 Aug 2021 21:16:53 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:fa8f:c6de:b478:78fe? ([2601:647:4000:d7:fa8f:c6de:b478:78fe])
        by smtp.gmail.com with ESMTPSA id d15sm2808358pfd.115.2021.08.15.21.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Aug 2021 21:16:53 -0700 (PDT)
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
 <07d2e6ba-d016-458a-a2ce-877fd7b72ed0@acm.org>
 <a63fbd36-5a43-e412-c0a2-a06730945a13@huawei.com>
 <b4603b71-4306-4542-e4fb-bf30133f89a8@acm.org>
 <010fcd39-c819-8e0e-c188-62b1947603bf@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a47ba8e9-520e-19b5-dd8f-7929f624bbbd@acm.org>
Date:   Sun, 15 Aug 2021 21:16:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <010fcd39-c819-8e0e-c188-62b1947603bf@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/14/21 2:43 AM, yukuai (C) wrote:
> test result:
> | test round | with this patch | without this patch |
> | ---------- | --------------- | ------------------ |
> | 1          | 4310k           | 4265k              |
> | 2          | 4295k           | 4327k              |
> | 3          | 4217k           | 4213k              |
> | 4          | 4355k           | 4236k              |
> | 5          | 4315k           | 4337k              |
> | average    | 4294k           | 4275k              |

Hi Kuai,

Thank you for having taken the time to rerun the IOPS measurements with
kernel debugging disabled. According to my calculations the standard
deviation (50K) is larger than the difference between the averages
(19K). Unfortunately that makes it hard to draw any conclusion ...

Bart.
