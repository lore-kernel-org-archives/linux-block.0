Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D156C432BE
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 19:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B83C61037
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 19:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243489AbhHZTSN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 15:18:13 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:39672 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243388AbhHZTSM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 15:18:12 -0400
Received: by mail-pf1-f171.google.com with SMTP id e16so3162504pfc.6
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 12:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=87xtzhguPu66DgEqdVXhkAJQsftTA0hur2kbsv86gyA=;
        b=EuBdSkrYaYYbnIT8UnFYquCYFTOKzz2CBOPN5/euFInkUsX/aJZ6gHkflPmZDXZ3/D
         NQeakpl0xKP1HFf6gY6pQ1kV8lZmPKTIgl6aqmy2RUT8jAA/zO1bGd6kHaIBTw8vkN8p
         DxdcBUcCike85JRDdkAgkKDwOgFeTpEusJ/hPeqO3TvSOSQnyTkFulO4+yFXaRb94JqV
         IdmmMx0lWMHIn/6mqT8QVpYUFP0jFO/Ax4j7FFljZkjF+vI9lbjoLr+h1uzD5McTFLP2
         n3NsIUCQP0eArbZgydY7OAO6gdTbQ3BA8oewDL1Q9nPPXxUR8AHELinnPmvj+8sprPPU
         tI2Q==
X-Gm-Message-State: AOAM530g5woTjjMCLuGigqLSLalsT15ZzBYUmd7+KMCoWcYriciegk5b
        HGgmKgRSLPoPZQ74B+qQVENyWqatvj4=
X-Google-Smtp-Source: ABdhPJyQf/LGhydQjZA5FVvWpf1ddIHolx9BG454imhlFdpGghCMYJcteMnl4BafkHnZDZnDtZMh4Q==
X-Received: by 2002:a63:f410:: with SMTP id g16mr4606338pgi.201.1630005444268;
        Thu, 26 Aug 2021 12:17:24 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:22e3:6079:e5ce:5e45? ([2601:647:4000:d7:22e3:6079:e5ce:5e45])
        by smtp.gmail.com with ESMTPSA id x1sm3673274pfn.64.2021.08.26.12.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 12:17:23 -0700 (PDT)
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
To:     Jens Axboe <axboe@kernel.dk>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>
References: <20210826144039.2143-1-thunder.leizhen@huawei.com>
 <fc1f2664-fc4f-7b3e-5542-d9e4800a5bde@acm.org>
 <537620de-646d-e78e-ccb8-4105bac398b3@kernel.dk>
 <82612be1-d61e-1ad5-8fb5-d592a5bc4789@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a1c76c24-5013-02b4-85f1-2d2896cca6dd@acm.org>
Date:   Thu, 26 Aug 2021 12:17:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <82612be1-d61e-1ad5-8fb5-d592a5bc4789@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/26/21 11:45 AM, Jens Axboe wrote:
> Bart, either we fix this up ASAP and get rid of the percpu counters in
> the hot path, or we revert this patch.

I'm at home taking care of my son because he is sick.

Do you want to wait for Zhen to post a fixed version of his patch or do you
want me to fix his patch?

Bart.


