Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2609BC47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 19:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F327E6124C
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 19:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhE0Tos (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 15:44:48 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:53790 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhE0Toq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 15:44:46 -0400
Received: by mail-pj1-f54.google.com with SMTP id ot16so1116676pjb.3
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 12:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iceYICvf3cSTqWqg4u9fY5NmMxNYU2mV6C1zZgsWd0E=;
        b=OLHo1Q7qakrxk52hy9L+HlAdAs7zQlTyhnDXsOpsrpDzoejxkWB7rDcV8rX6NkM8xT
         BXBIGWHahbLYXRaNA6SKkfKBtTgFZF3WZoFxypm63D7kjlGRHgx0EM5jpcVKkJDyA9k5
         ucTltaK2n1wrtx1aoBLDYmXFdYN8EeZGkpa0XWQ1IRCBDRyTcA23zHWFa6jLUXxs9Z5q
         qCduOvGMA9TKo7AKk40XgoaTs5aHIlHlEKrNoupEVUQcz4BRUm7z2pJieA852RRoIWG6
         J1XnA7r0VTgfVpdHpLhJ61n5C9U/NNQn3n8Fle5lkq6a0TvMOwM8GYvG+jnTJwcImwGG
         TnnA==
X-Gm-Message-State: AOAM533WJexj3cxOOT1+I1BVrT9egoETerhb1E1qs8sWeAsW9QwjM8xb
        uIE6jtBRYzvXGwrgWTe14jQ=
X-Google-Smtp-Source: ABdhPJzCkWnz79orZo9EIEcG8CxdR0f/veotpskiejwArHq1Rdu5KysQoZkFA0ahnHSiDbPOMnxNvA==
X-Received: by 2002:a17:902:e547:b029:fd:bd4f:a06b with SMTP id n7-20020a170902e547b02900fdbd4fa06bmr4779021plf.39.1622144591411;
        Thu, 27 May 2021 12:43:11 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id m191sm2462163pga.88.2021.05.27.12.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 12:43:10 -0700 (PDT)
Subject: Re: [PATCH 6/9] block/mq-deadline: Reduce the read expiry time for
 non-rotational media
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-7-bvanassche@acm.org>
 <DM6PR04MB7081C2ED7E71979FED8CF68EE7239@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <06958fb7-3d4c-13a1-26dd-55c8718952f4@acm.org>
Date:   Thu, 27 May 2021 12:43:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB7081C2ED7E71979FED8CF68EE7239@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/21 8:27 PM, Damien Le Moal wrote:
> On 2021/05/27 10:02, Bart Van Assche wrote:
>> Rotational media (hard disks) benefit more from merging requests than
>> non-rotational media. Reduce the read expire time for non-rotational media
> 
> "Reduce the read expire time for non-rotational..." -> "Reduce the default read
> expire time for non-rotational..."
> 
>> to reduce read latency.
> 
> I am not against this, but I wonder if we should not let udev do that with some
> rules instead of adding totally arbitrary values here...

Hi Damien and Hannes,

I agree that it's better to configure the expiry time via udev so I'm
considering to leave this patch out.

Thanks,

Bart.
