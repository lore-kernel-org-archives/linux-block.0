Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1285FC388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3C65206F1
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgKKIga (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 03:36:30 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44]:37545 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKKIg3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 03:36:29 -0500
Received: by mail-pj1-f44.google.com with SMTP id ei22so368833pjb.2
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 00:36:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z7ZIZUJlYrCIASsZIPaS/o5ulY2e3LdHJbfoMN/Tt7I=;
        b=PpYpi7qFHAjU6VHzHsSlAbTjakfLtJFcvmJLleGHV6UE+tJ3ny8G40xwrDR+YLlmUW
         GyRmHCOsE1yTQZAVoTN3X/Ow5tg8faCjNyCMVxEJgrdr2OtdM7fD6BT+fJ86bZhY2sXb
         yjMui+Gbv8yVRwBiGhSlUs/FYxi1xOX6aR+KtJgDNyf6q0ghGs5wNhhtDafZQnj6pZwq
         dDtwmBEr2tMsfnt9W7yM3I9YXLhVWAjgWFIx5SqAjNoMP6eR3Q6b4Ah98QDouFzi0aW1
         RIKGbG38OdYzeHmttaQYiR+GiN1yMzCGLrZVAPdnHFLv7+YVPvuJ+CL34v4/FEmsdiDf
         NV4g==
X-Gm-Message-State: AOAM531YlyyfehEkHsrbnv1Q7DNvPge1MpTP3dn3mgxqhVTy5mkOLnai
        Wb+o2NmsjkqLK/JHj8kDM7s=
X-Google-Smtp-Source: ABdhPJzMgwlDSM2QG0rtgJV3wgocFi2y7labto7PdNBi9UlF9GY17s6LU1RK1oD9VwDs06fG1gXKqQ==
X-Received: by 2002:a17:90a:11:: with SMTP id 17mr2881297pja.66.1605083788967;
        Wed, 11 Nov 2020 00:36:28 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:47ee:2018:3e3c:f9be? ([2601:647:4802:9070:47ee:2018:3e3c:f9be])
        by smtp.gmail.com with ESMTPSA id j13sm1654647pfd.97.2020.11.11.00.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 00:36:28 -0800 (PST)
Subject: Re: [PATCH V3] nvme: enable ro namespace for ZNS without append
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, javier@javigon.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, joshi.k@samsung.com, k.jensen@samsung.com,
        Niklas.Cassel@wdc.com,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>
References: <20201110210708.5912-1-javier@samsung.com>
 <20201110220941.GA2225168@dhcp-10-100-145-180.wdc.com>
 <87931ded-b17b-90b2-c5b2-a1a465d109cc@grimberg.me>
 <20201111081530.GB23062@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e8f50827-4bc9-7300-0f8b-ed0a854fb50b@grimberg.me>
Date:   Wed, 11 Nov 2020 00:36:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201111081530.GB23062@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> -	if (id->nsattr & NVME_NS_ATTR_RO)
>>>> +	if (id->nsattr & NVME_NS_ATTR_RO || test_bit(NVME_NS_FORCE_RO, &ns->flags))
>>>>    		set_disk_ro(disk, true);
>>>
>>> If the FORCE_RO flag is set, the disk is set to read-only. If that flag
>>> is later cleared, nothing clears the disk's read-only setting.
>>
>> Yea, that is true also for the non-force case, but before it broke
>> BLKROSET so I reverted that. We can use this FORCE_RO for BLKROSET as
>> well I think...
> 
> Let me prioritize the hard r/o setting.  mkp actually has an older patch
> that did just that which I'll resurrect.

Sounds good.
