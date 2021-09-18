Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EC2C433F5
	for <linux-block@archiver.kernel.org>; Sat, 18 Sep 2021 22:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63CFA610A4
	for <linux-block@archiver.kernel.org>; Sat, 18 Sep 2021 22:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbhIRWXj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Sep 2021 18:23:39 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:33548 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbhIRWXj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Sep 2021 18:23:39 -0400
Received: by mail-pg1-f171.google.com with SMTP id u18so13479990pgf.0;
        Sat, 18 Sep 2021 15:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UmP8+XXs+eSLZ6wvZzS+PmN2+AkP9MthCeXz+zj3S80=;
        b=WHAO1PUkq1E+lPKLUSehRyxzl5cdljt3hjMKKU+jmLpUcKToc6I9MSLkBb3f/pbyoi
         eOvb1eqVdU2W2yNG25RYx7zOv3G8f/dUw+odlLuAFdlLlWX/YFVn/ce1qJBaHN8nPEao
         Eq4UgEv7fUUGRrRnK7AicJwig8BNJTMUrQyKyQcnRRpJems4WGc9Wt0/HEMpzxynWbMq
         ljiLi7wxYPio2nu+TrKJCnzTB5oK92lKF8whVxqmAhfuVDh37UD0VYnlfj+QCJFSvRBO
         vNH0gEasvrVeIi1zitmQyOwJwEUExwafG1JKtiGwENAOpHsORGIj865b1JK5g2dsrOiy
         GnGQ==
X-Gm-Message-State: AOAM5336s9q0ukfxy4iycvjWiEg/7beu6kGipPf3wCdJqidKLKat1G/e
        kyEfY4jS1XVZ7Wjp7567Ltc=
X-Google-Smtp-Source: ABdhPJw/e+EdnGPh5NJnBTYxdFfoJnn/qQkbaPq42iCh0ncuHG2aoP7eI1rbRdU34WC679DNtiB2Eg==
X-Received: by 2002:a62:504:0:b0:440:3a98:a9d1 with SMTP id 4-20020a620504000000b004403a98a9d1mr17927044pff.23.1632003734619;
        Sat, 18 Sep 2021 15:22:14 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:8557:823d:34a5:4f8c? ([2601:647:4000:d7:8557:823d:34a5:4f8c])
        by smtp.gmail.com with ESMTPSA id g140sm9534357pfb.100.2021.09.18.15.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 15:22:13 -0700 (PDT)
Message-ID: <c204fbcc-7d38-229a-772a-556333aed120@acm.org>
Date:   Sat, 18 Sep 2021 15:22:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] block/mq-deadline: Fix unused-function compilation
 warning
Content-Language: en-US
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210901064705.55071-1-tianjia.zhang@linux.alibaba.com>
 <90507369-7beb-5337-5bb3-f5e2798dee2f@linux.alibaba.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <90507369-7beb-5337-5bb3-f5e2798dee2f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/17/21 19:23, Tianjia Zhang wrote:
> ping.

Please check Linus' master branch and Jens' for-next branch before posting
block layer patches. This patch looks like a duplicate of patch
https://lore.kernel.org/r/20210830091128.1854266-1-geert@linux-m68k.org,
applied as commit 55a51ea14094a1e7dd0d7f33237d246033dd39ab.

Bart.
