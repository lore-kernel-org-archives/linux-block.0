Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE511C432BE
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 17:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B5F60F51
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 17:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhHMRSN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 13:18:13 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:34329 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhHMRSM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 13:18:12 -0400
Received: by mail-pl1-f178.google.com with SMTP id d1so12889158pll.1
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 10:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6ienZbwguL6JxIZLyDC7vEnqfM94gw/FEoQHX2SJ1HE=;
        b=YuBB5fCM5pHZww+UEiPRUZ887IXmYpI0tKsEfbJvKc4B6YxX/APymeMBCEicNRErzT
         oco0+s8NTRyiJG+Z/UvsUiCuucKaKRBC8vLCGu1rWzJ9jQ2bpb6dCvDrHdBcUxtGRz1G
         DUB5ZLpqF7PDlfXGWA0GnCRI7PNe+gFauNr3K5g/wazJtWXcxwFvmobLoM9E89+Uc7ZY
         IbBrpTK16NP502RwiPXpGO8NAR1q92XyJNCIdS0ddDDjyYeeSO20wb9RiqbxCb++eukW
         PF6Rna2YK6mmgmvWiJqP393ro2NppkAhEXbCDxdfKgnsi3w3D0y+4//fDQ3Q1gWPerhC
         8aww==
X-Gm-Message-State: AOAM530ICa4IOwjXmSLHLw5S7wNJPN3OOLPGaGcoH5MGoParnGhl7sdL
        00tpsgynh48WXvQ2MCziZZIW5wWsUSaqhgfq
X-Google-Smtp-Source: ABdhPJwm3IIQ3W31mWTa9g2O+2CTZyp/xzI1hC3pUVTsgG5I8g0vUvTfAj1kh/6t+F5CYBA9GbZJWg==
X-Received: by 2002:a17:90a:d509:: with SMTP id t9mr3508010pju.225.1628875064503;
        Fri, 13 Aug 2021 10:17:44 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:b745:b195:ae3f:f02d])
        by smtp.gmail.com with ESMTPSA id j2sm2948519pfe.201.2021.08.13.10.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 10:17:43 -0700 (PDT)
Subject: Re: [PATCH block-5.14] Revert "block/mq-deadline: Add cgroup support"
To:     Tejun Heo <tj@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <YRQL2dlLsQ6mGNtz@slm.duckdns.org>
 <035f8334-3b69-667d-be91-92dcab9dc887@acm.org>
 <YRQhlPBqAlkJdowG@mtj.duckdns.org>
 <00e13a7b-6009-a9d7-41ba-aae82f5813de@acm.org>
 <YRVfmWnOyPYl/okx@mtj.duckdns.org>
 <631e7e18-52ca-9bec-0150-bac755e0ff24@acm.org>
 <YRV1JkkxozEb4YO6@mtj.duckdns.org>
 <DM6PR04MB7081F2D0E8579489175DF363E7FA9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <YRad3tQaZfR8v7lb@mtj.duckdns.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <5527319b-ba0c-00a3-19cf-612f2e2b073d@acm.org>
Date:   Fri, 13 Aug 2021 10:17:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRad3tQaZfR8v7lb@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/13/21 9:29 AM, Tejun Heo wrote:
> The problem with complex optional hardware features is often the
> accompanying variability in terms of availability, reliability and
> behavior. The track record has been pretty sad. That isn't to say this
> won't be useful for anybody but it'd need careful coordination in
> terms of picking hardware vendor and model and ensuring vendor
> support, which kinda severely limits the usefulness.

I think the above view is too negative. Companies that store large 
amounts of data have the power to make this happen by only buying 
storage devices that support I/O prioritization well enough.

Bart.

