Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B03C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 01:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23CA364DD4
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 01:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhBBBaX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBBBaV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 20:30:21 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36075C061573
        for <linux-block@vger.kernel.org>; Mon,  1 Feb 2021 17:29:41 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id s24so1239594pjp.5
        for <linux-block@vger.kernel.org>; Mon, 01 Feb 2021 17:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VjH92aWRy6mqmgfZRhy4Z3v2+/on4r2pma/jBQ9X+Mk=;
        b=D2vtVVrV7roohOULT4qWZwI54nCWhVCrViM1gmg+osP6m5wHFi8KJ8/ooKxduK3NzP
         rXZve5I0kHGYiqAS7vKP4bVMi66WF2sGSdTEFQE5DaeC9hqrOoRufmbLS1yhsnFxcFRR
         LXSLFByJgYrcwOmDXt9t3p7pMbil1lhp3RIoo04uWPTSYXox2oTN5ziwKhdO2PYeuwzS
         KmOEp+i/vJIECx3mH+cHWnW4XbWUZ93PyN0+MAZVlRoEor6mot0yuvKW8FU3ibvszlon
         97SfkNE/1wM7D+ceJAy6893rHqrUh8y4x4mYKmpKQY3Akn4Pcrd6PxApjjRe/1kLIplC
         fyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VjH92aWRy6mqmgfZRhy4Z3v2+/on4r2pma/jBQ9X+Mk=;
        b=DUkJgAsBrTHiouf3NqBPUoPcXessvZIgCfB0BPoOo/jvvFRbftLsfynAtTaOMFH4G9
         hV4xdserGnBah8CyfnuxS+B1oZakrLmdrlIUhhW17zzadvJ6tw2s2tSf+jDK9cHhk8ye
         CYoycsETQGl1PQvPO281a7+ZofaJ0a6wXHm+Ovy48GMaqZ0RQDUM1c0Yz/ffamYamXtP
         aU3OtoqPa7NVRKBjE96cQyDFBcm/SRGPc0Hlh0F1G+EM38k2M8cbbeYCu6716w6VS+8f
         aL31RE6i63gCk4H5n4STb777hHC/6u564x2xKD1GIUdZL7h4a8SlEkK8tXRdRM7P42Ze
         HERQ==
X-Gm-Message-State: AOAM531L6ho5dKnGRitdGtLwvgBErZ1taH2YpEge5v+CK0rneT5Ag5Vx
        vYz0pKpWn3Nf4VBz007nupcRMg==
X-Google-Smtp-Source: ABdhPJxkuDYT9aciE1GeNBk+fmYiIYnnXydtw8PAnUtTlWTGmbZwyJrrhQDqletKnNxyzWf0J7ul2A==
X-Received: by 2002:a17:90b:1247:: with SMTP id gx7mr1670172pjb.22.1612229379599;
        Mon, 01 Feb 2021 17:29:39 -0800 (PST)
Received: from [0.0.0.0] ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id y6sm19136373pfn.123.2021.02.01.17.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 17:29:38 -0800 (PST)
Subject: Re: [PATCH V2 3/4] block: add io_extra_stats node
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "hch@infradead.org" <hch@infradead.org>
References: <20210201012727.28305-1-guoqing.jiang@cloud.ionos.com>
 <20210201012727.28305-4-guoqing.jiang@cloud.ionos.com>
 <SN4PR0401MB35980F52820FF8D6B0E3D8DD9BB69@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <e335365a-4839-a240-2817-c34b9ef51d18@cloud.ionos.com>
Date:   Tue, 2 Feb 2021 02:29:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB35980F52820FF8D6B0E3D8DD9BB69@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2/1/21 10:47, Johannes Thumshirn wrote:
> On 01/02/2021 02:30, Guoqing Jiang wrote:
>> If user doesn't care about the size and latency of io, and they could
>> suffer from the additional overhead. So introduce a specific sysfs node
>> to avoid such mistake.
> 
> 
> I would make this patch number 1 in the series and then merge patch 4
> (the check for blk_queue_io_extra_stat()) into the patches adding
> blk_additional_latency() and blk_additional_sector().
> 
> 

Ok, thanks for the suggestion.

Guoqing
