Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2028C433E1
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 20:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A566D20738
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 20:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgHUURb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:17:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41854 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUURa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 16:17:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id z23so1375897plo.8
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 13:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TvqfbIal1fhViLBt0TJDTBGBgyQJ/PvbcwMzTTzIF3Q=;
        b=G2oZnOVn3lWX4YNmJ8BPK/K+WitXE6/ma+ApQftPepdxG/D+Lfn2tNYLgi/nP88/tX
         KtfVoV12TaDVfmUyhrubMmDFJ9lC+smXYZKhV4YhQAm51GcWoySWVKkmm/MRq3OGj4mR
         erH4AY1vbiHDjzBWsyOFZiT49eTfF0iEbvt4fix/e+Y/TWgaM6gIpP1A68DINxmk0/uD
         LDGHeJSfdIZhEC/f56MV3vyWo+Yz7NoPMOGeX5+sow4uQrOCIyzlSNtRnDKTh3Pzk7kl
         kKz0p1e/wAyGjRBlXC5XVLOpQtVIWMBl95LMlCbita1w1GnUlxxLUQCfc2kVn4Zn7W+A
         qcnQ==
X-Gm-Message-State: AOAM531E+9FG6wEyM7xNb0zdxR44e1+TXZBn+yHYEml+rqnWSPOl6YQS
        zA1Uo5E5Tzb1eVVc9f/gXfo=
X-Google-Smtp-Source: ABdhPJw6iWLIY01PJTBPYf9ddwJiu0zY5IHMSZMFyaax6pEtVMSk+Tx6CkxF6BiShYabwNfo442YPg==
X-Received: by 2002:a17:90b:4c46:: with SMTP id np6mr3904034pjb.201.1598041049624;
        Fri, 21 Aug 2020 13:17:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:95a5:8a0f:6e94:b712? ([2601:647:4802:9070:95a5:8a0f:6e94:b712])
        by smtp.gmail.com with ESMTPSA id a199sm3042782pfa.201.2020.08.21.13.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 13:17:29 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme-core: fix crash when nvme_enable_aen timeout
To:     Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, axboe@fb.com
References: <20200820035413.1790-1-lengchao@huawei.com>
 <fc1efcce-99d9-05cf-5f32-9c454e3b0efe@grimberg.me>
 <820d5867-3e44-a009-d6b5-ea1a3fecd037@huawei.com>
 <20200821074910.GA30216@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ebfa21a4-57a1-f350-8fbc-92f35770dc93@grimberg.me>
Date:   Fri, 21 Aug 2020 13:17:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821074910.GA30216@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> -static void nvme_enable_aen(struct nvme_ctrl *ctrl)
>>>> +static int nvme_enable_aen(struct nvme_ctrl *ctrl)
>>>>    {
>>>>        u32 result, supported_aens = ctrl->oaes & NVME_AEN_SUPPORTED;
>>>>        int status;
>>>>        if (!supported_aens)
>>>> -        return;
>>>> +        return 0;
>>>>        status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT, supported_aens,
>>>>                NULL, 0, &result);
>>>> -    if (status)
>>>> +    if (status) {
>>>>            dev_warn(ctrl->device, "Failed to configure AEN (cfg %x)\n",
>>>>                 supported_aens);
>>>> +        if (status < 0)
>>>> +            return status;
>>>
>>> Why do you need to check status < 0, you need to fail it regardless.
>>
>> agree.
>> Just want to keep the old logic. I guess the old logic: if supported_aens
>> is true, the result of set features can ignore.
>>
>> If there is no objection to doing so, I will resend the patch later.
> 
> In the past we've dedice to ignore real NVMe errors in various
> spots as the functionality wasn't deemed critical.  I think that is
> pretty sloppy and we should only do that where we really have to.

Agreed.
