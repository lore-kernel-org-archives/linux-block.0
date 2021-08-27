Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0163C19F37
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 00:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACED66103A
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 00:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244062AbhH0A7q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 20:59:46 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:37559 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244077AbhH0A7O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 20:59:14 -0400
Received: by mail-pf1-f169.google.com with SMTP id j187so4251950pfg.4
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 17:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zYKwj0wocqruu85HhdP/MRXNZC2muLq5b+/KD6B11uc=;
        b=df8Z3HXvvTlu0XWd70r4Rhq3RM1RE7IW4U5JcWXwAs8Y5AjOIUQZ+4dRL/epz0xHQ6
         Vpl2V7WHTpAe8PQl6H0IuJeR4FWREP3bZbHtQsO6MYwPraeNXz2zBeARu9XhGJMXhvc7
         JIoONk+Y9VKdd5SYwIOjKi2WdXnWzOZ3HwLT29VoUxR4PtZCM+ehDaLGitjeanO9DGHx
         dtIM1uhCDE8IgRYn2wlkS4ZyXbUciYMjfzKwzH5iPI2yW0bFgxPThLk/mX4EcKNsR3j5
         sg+lqLXQcp45JsU7y3DEPABCtkRZWMaH3XGXrUSV1GtUbp+o6zg6uI5JjBdysHc0hPed
         Ov8g==
X-Gm-Message-State: AOAM530kcsl22G0eYWBe7LQzBTdRYuZzEY+sIxHhqfn2qjsGpnDybXl2
        bDHLLqu6NzyqaVrjLVGZ9ISnd3qgB4s=
X-Google-Smtp-Source: ABdhPJzp13cQjsFewRghpHlL+l4ugfr+2PXyrl4Od+sVS69yPL+cHTE4MEwgw8Sw5ZTNg4OPnRDQlg==
X-Received: by 2002:a05:6a00:10d3:b029:3c8:d7c4:973f with SMTP id d19-20020a056a0010d3b02903c8d7c4973fmr6276190pfu.16.1630025905869;
        Thu, 26 Aug 2021 17:58:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:22e3:6079:e5ce:5e45? ([2601:647:4000:d7:22e3:6079:e5ce:5e45])
        by smtp.gmail.com with ESMTPSA id o14sm4493089pgl.85.2021.08.26.17.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 17:58:25 -0700 (PDT)
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
 <59c19a63-f321-94e8-cb31-87e88bd4e3d5@acm.org>
 <0ef7865d-a9ce-c5d9-ff7f-c0ef58de3d21@kernel.dk>
 <2332cba0-efe6-3b35-0587-ee6355a3567d@acm.org>
 <dd1f2b01-abe5-4e6f-14cf-c3bef90eb6f9@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <389d85fd-ea8c-7998-2ae0-49818f1669c3@acm.org>
Date:   Thu, 26 Aug 2021 17:58:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <dd1f2b01-abe5-4e6f-14cf-c3bef90eb6f9@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/26/21 5:05 PM, Jens Axboe wrote:
>> Here is an overview of the tests I ran so far, all on the same test
>> setup:
>> * No I/O scheduler:               about 5630 K IOPS.
>> * Kernel v5.11 + mq-deadline:     about 1100 K IOPS.
>> * block-for-next + mq-deadline:   about  760 K IOPS.
>> * block-for-next with improved mq-deadline performance: about 970 K IOPS.
> 
> So we're still off by about 12%, I don't think that is good enough.
> That's assuming that v5.11 + mq-deadline is the same as for-next with
> the mq-deadline change reverted? Because that would be the key number to
> compare it with.

A quick attempt to eliminate the ktime_get_ns() call from
__dd_dispatch_request() improved performance a few percent but not as much
as I was hoping. I need a few days of time to run these measurements, to
optimize performance further and to rerun all functional and performance
tests.

Thanks,

Bart.
