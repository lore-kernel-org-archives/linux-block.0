Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0FDC432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 02:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E2A61002
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 02:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhH0CtK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 22:49:10 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:43949 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhH0CtJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 22:49:09 -0400
Received: by mail-pl1-f176.google.com with SMTP id n12so3009232plk.10
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 19:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+67Xxk12hz/m/1F7vhLPlNgAB6/6lpI05yWOEdfWm/w=;
        b=jK39Vez6kYQ7NHmdL1dWcqaLl8A/uFljW+saOXIda6Q64VNJKGIlAcGtVpExFPWpME
         4JDs7ClIHTxCN5BFbSCUshK7nOfiDXN7MArYcJqEeZ08smbIPMIaZOIZmy7lJVvBjaeh
         pLmUj4dNcLP1NxhGp7QIeMAVvg9Spp0bEKeJGP429El9Ow2o0+j4geqp5BsRqoySyWCF
         gs6H3o9P6Z+0nSguYzSM03Ecsx2XB8CyQz1aDo8ktYPWcAP/poe1DWEJ3R/scinsQv5s
         RcX76NAgpYDxMss463Q6dagG/imdE77j/RqSmphm54xmdtP1dnmTHKpoBH4eXiSOpt1+
         Rr3A==
X-Gm-Message-State: AOAM533tgm2F1UKMOBZ/qECaQiuqT88dSKWLFdQeJODbahg+62CGWGbw
        1WfyQMF2vY56Tf4CaeLaMUk=
X-Google-Smtp-Source: ABdhPJxxngBtr/HW1aKSt2A5LoHvNhDbuF/b5DDoH74nDcVF3vtVOExVJ1X6N3xSjMUHL6F7Ylg/tQ==
X-Received: by 2002:a17:90a:890a:: with SMTP id u10mr7755608pjn.40.1630032500619;
        Thu, 26 Aug 2021 19:48:20 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:4949:2f:2d87:ed91? ([2601:647:4000:d7:4949:2f:2d87:ed91])
        by smtp.gmail.com with ESMTPSA id b23sm4109377pji.49.2021.08.26.19.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 19:48:20 -0700 (PDT)
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
Message-ID: <fdd60ef5-285c-964b-818a-6e0ee0481751@acm.org>
Date:   Thu, 26 Aug 2021 19:48:18 -0700
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
> On 8/26/21 6:03 PM, Bart Van Assche wrote:
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

With the patch series that is available at
https://github.com/bvanassche/linux/tree/block-for-next the same test reports
1090 K IOPS or only 1% below the v5.11 result. I will post that series on the
linux-block mailing list after I have finished testing that series.

Bart.


