Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D8AC433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 15:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8DDD60FF1
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 15:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245712AbhDPP27 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 11:28:59 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:45031 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbhDPP24 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 11:28:56 -0400
Received: by mail-pj1-f44.google.com with SMTP id q14-20020a17090a430eb02901503aaee02bso3753107pjg.3;
        Fri, 16 Apr 2021 08:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dBQTxUFrjwvsCdlEVTG7RhY8i8OidyFaeos2pX2WolE=;
        b=GGxeqd8wJlbcVu+Y4DR8TF58GI7SS7GcUPZUFwT+VIsXp54UCnqQiR0YpqFeDuCbG+
         Ku9Z9wcMBHIBCMCCiOOEgicdVoi60HCWbBx00+QwHJ0W/Ra0ZfJW2+OhLD8RunbLEwSx
         gIv575GIOCPB0/6SzAti/sn0EDhVaYE1b23MvVStN9TFNgBZA+86piHrzns1JzLuv+H9
         c/J7C3k9jnzNn45Dr5FacORBAlhLhWZECMq4d8s7iWbPu9CG08KKR40msv3hwvnon0L9
         p/dQtecfaErO0g0X2GN9Fj+udIM5rSWGheTvLRZGONeLVAXOkBQy+tyecgO3u2QuKM6y
         FKcA==
X-Gm-Message-State: AOAM532Bpq9CR/azO9EyBdl+L/RcUCOdoBwLs7d3nHEF67ROZfWqXxUA
        YSkqtGuxsZBVrAFuyJYLLuQ=
X-Google-Smtp-Source: ABdhPJzWtT8SbIiIv8xuMkmmhSFImhlIUKuwKWw9oX5SI4jGU2XMhaeq3PkkD5TgK5xN+pXLb/tBuA==
X-Received: by 2002:a17:90b:1e0b:: with SMTP id pg11mr10600410pjb.146.1618586910490;
        Fri, 16 Apr 2021 08:28:30 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:deb4:c899:3eb6:a154? ([2601:647:4000:d7:deb4:c899:3eb6:a154])
        by smtp.gmail.com with ESMTPSA id t17sm5285487pfe.35.2021.04.16.08.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 08:28:29 -0700 (PDT)
Subject: Re: [PATCH v7 1/3] bio: limit bio max size
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, gregkh@linuxfoundation.org,
        hch@infradead.org, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        mj0123.lee@samsung.com, osandov@fb.com, patchwork-bot@kernel.org,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        tj@kernel.org, tom.leiming@gmail.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
References: <bb8f7127-edff-4a32-2d5c-4343002bda19@acm.org>
 <CGME20210416060827epcas1p39350d45cef64c91be681b76180b63140@epcas1p3.samsung.com>
 <20210416055039.20126-1-nanich.lee@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <9ad8ef3f-905c-543e-d2af-7bf2f43ea04c@acm.org>
Date:   Fri, 16 Apr 2021 08:28:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210416055039.20126-1-nanich.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/15/21 10:50 PM, Changheun Lee wrote:
>> On 4/15/21 3:38 AM, Changheun Lee wrote:
>>> @@ -538,6 +540,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>>>  {
>>>  	unsigned int top, bottom, alignment, ret = 0;
>>>  
>>> +	t->bio_max_bytes = min_not_zero(t->bio_max_bytes, b->bio_max_bytes);
>>> +
>>>  	t->max_sectors = min_not_zero(t->max_sectors, b->max_sectors);
>>>  	t->max_hw_sectors = min_not_zero(t->max_hw_sectors, b->max_hw_sectors);
>>>  	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);
>>
>> The above will limit bio_max_bytes for all stacked block devices, which
>> is something we do not want. I propose to set t->bio_max_bytes to
>> UINT_MAX in blk_stack_limits() and to let the stacked driver (e.g.
>> dm-crypt) decide whether or not to lower that value.
> 
> Actually, bio size should be limited in dm-crypt too. Because almost I/O
> from user space will be gone to dm-crypt first. I/O issue timing will be
> delayed if bio size is not limited in dm-crypt.
> Do you have any idea to decide whether takes lower bio max size, or not
> in the stacked driver?
> Add a flag to decide this in driver layer like before?
> Or insert code manually in each stacked driver if it is needed?

There will be fewer stacked drivers for which the bio size has to be
limited than for which the bio size has not to be limited. Hence the
proposal to set t->bio_max_bytes to UINT_MAX in blk_stack_limits() and
to let the stacked driver (e.g. dm-crypt) decide whether or not to lower
that value.

Thanks,

Bart.
