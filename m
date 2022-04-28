Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1427EC433EF
	for <linux-block@archiver.kernel.org>; Thu, 28 Apr 2022 19:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbiD1T4c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Apr 2022 15:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbiD1T4b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Apr 2022 15:56:31 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107D9BF310
        for <linux-block@vger.kernel.org>; Thu, 28 Apr 2022 12:53:16 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so6636237pjb.0
        for <linux-block@vger.kernel.org>; Thu, 28 Apr 2022 12:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lS0ufo28JApWWWITS5hlwhgT6n0g475gSGKPNtXDcoI=;
        b=ceFnH2DHbYlSsG1CQd4A59YqwK7XGqTludgOTEp9j9MAWrX184sMKlOQ8lXlxGJNs+
         QcqLFYZPZlA18Bdv3q/qRjLOToBJ05Vx69fqq1SmXgP/0KpA1hMEvaj9JAPUptBFKVgI
         crWfw9dNL+DolCtXCBCCuNDeCzp1P3Ru0CNbt0d34BkPVV/656HQM9F7j50i7vO+ethA
         0ZMdttnxDD0IJXIpcZsvWcaNqpJR2YlqyGlaJr9VumaAFv5vwgwF7UfGtxB5NATys4dG
         761dfHHOdZdTs+9CAW8p+3I9Ald8kW3b3k44KWp4aKFnHAIJRTrJMPNsbQkIySyBaBSa
         jpAQ==
X-Gm-Message-State: AOAM530IxUaybNXXUWDO9ktIlVNz6pWVDN1xxI8xpgYulgHSx/E5pMdw
        R3ejeOl1uQJI7NcQ5dNsAjc=
X-Google-Smtp-Source: ABdhPJwStshcvnwF3sx/+PqobxK51UL/q/SB07RSdnvuwmgMWNlFg5FeA2R0LWdRkFoPfinS366t/g==
X-Received: by 2002:a17:902:a3c9:b0:158:d83f:c436 with SMTP id q9-20020a170902a3c900b00158d83fc436mr35228868plb.162.1651175595449;
        Thu, 28 Apr 2022 12:53:15 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6f14:f527:3ca8:ecbf? ([2620:15c:211:201:6f14:f527:3ca8:ecbf])
        by smtp.gmail.com with ESMTPSA id n14-20020a17090ac68e00b001d9e3b0e10fsm9328912pjt.16.2022.04.28.12.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 12:53:14 -0700 (PDT)
Message-ID: <106143d4-a3b5-4699-10f8-d4d048d3ec64@acm.org>
Date:   Thu, 28 Apr 2022 12:53:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH blktests 1/3] Introduce the io_schedulers() function
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20220427213143.2490653-1-bvanassche@acm.org>
 <20220427213143.2490653-2-bvanassche@acm.org>
 <20220428035042.eqtokeaohmxerwu4@fedora>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220428035042.eqtokeaohmxerwu4@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/22 20:50, Shinichiro Kawasaki wrote:
> On Apr 27, 2022 / 14:31, Bart Van Assche wrote:
>> -	local scheds
>>   	# shellcheck disable=SC2207
>> -	scheds=($(sed 's/[][]//g' "${TEST_DEV_SYSFS}/queue/scheduler"))
>> +	local scheds=($(io_schedulers "${TEST_DEV_SYSFS}"))
> 
> I ran block/005 with this patch and observed it fails without failure message.
> To fix it, the line above should be:
>          local scheds=($(io_schedulers "$(basename "${TEST_DEV}")"))
> 

This is something I should have noticed myself. I will fix this.

Thanks,

Bart.
