Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A668C4332D
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 01:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 632CD2310A
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 01:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbhANBub (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 20:50:31 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:39631 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbhANA0q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 19:26:46 -0500
Received: by mail-wm1-f47.google.com with SMTP id 3so3194066wmg.4
        for <linux-block@vger.kernel.org>; Wed, 13 Jan 2021 16:26:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u4TOR+Z08uLcRAZJfpRYbgyzml2ie4yUyY/TC14bY2U=;
        b=ZxTRJVkegOGb/WRwqiDZyT5taQnZFmnaA2R1Nk762mJznbeGffmSu5DuH8XHgRwdXx
         nWA5OwAR/sBs7kP2BdmO7e0Nif98x3u1kciyGQyO7pVaX6e8uXxZh+0iRhAWX/OSKfJ5
         x3IqdeL1eTq7yotI3R8z6T0md4vSBOTpldhpYBeAKYm6e1AQMIIEm3HbwzjUNHoS1uQB
         FCMJTffoFwWjuieBLHUuh80DJC7g/Ua6EOhIp+yKOIvduPe8l0ritA5SqApjdRMcTk4m
         F2cvTT3kCcCZ5AZciHbKf67J6xWPYk1dooq7FTmOPer0Do3dV6Uhw2w4dTBsifXFjY/k
         3UTQ==
X-Gm-Message-State: AOAM533QGuGDVcWTp+cp7fo96JnFvP03XBdNASxQy4VgKbmXxBNpjEdj
        /llJ1CBiji52j0vEMnYB617YKnQK3/Y=
X-Google-Smtp-Source: ABdhPJxKZ46vRCf7ePCzpIQJqDcUjRUds5ij5UAtWD2jYp1vwONlB6ECSXQU0jYmN6WEY2r6/YnC9Q==
X-Received: by 2002:a1c:5644:: with SMTP id k65mr1421494wmb.62.1610583424695;
        Wed, 13 Jan 2021 16:17:04 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988? ([2601:647:4802:9070:e70c:620a:4d8a:b988])
        by smtp.gmail.com with ESMTPSA id 94sm6742258wrq.22.2021.01.13.16.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 16:17:04 -0800 (PST)
Subject: Re: [PATCH v2 1/6] blk-mq: introduce blk_mq_set_request_complete
To:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de,
        linux-block@vger.kernel.org, axboe@kernel.dk
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-2-lengchao@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6ce3e173-4ac3-e84d-88ca-76057a8d8e1e@grimberg.me>
Date:   Wed, 13 Jan 2021 16:17:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210107033149.15701-2-lengchao@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> In some scenarios, nvme need setting the state of request to
> MQ_RQ_COMPLETE. So add an inline function blk_mq_set_request_complete.
> For details, see the subsequent patches.

Its kinda difficult to understand the meaning of all of this...
the cover letter tells us nothing, and patches 1/2 also tells us
to see subsequent patches.

This is saved in the git change log history, so please try
describe what it is you are going with this, even if there are
overlaps between patches.
