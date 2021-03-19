Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8C6C433DB
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 18:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83BF66198D
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 18:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCSSca (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 14:32:30 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:36661 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhCSSc2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 14:32:28 -0400
Received: by mail-pj1-f51.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so7143105pjh.1;
        Fri, 19 Mar 2021 11:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DAi9p6B72mg+AIdjDuBmefxfri1AsJvuXZdk5crIJUg=;
        b=sc/vvwTukpBkO68bkuZYGo8VD7z4zgKYywHqEiLQx0AXayE6CejzFEjyr4Cq/ab53/
         PnZ9vuB0b1zltbwsd9XB0is3DZqaQHweSdA7t7Qxpxof+f9UryjjuoLNctiszYnKYMJf
         b1gdnh7wl8JwE9revkzqdpzFI1SZlxQDSatpo9aqnpMbBYvzdu6sgMubWjJvWX0xjRZU
         6cwjXbfiu2/9J/bENocjzKXYbiZBzTHjB+4NB2cW7MvKZl451CfEdb7Of3aimea18LXD
         qW3Uopfq63VOPkkdGqEviI41R5kH1S8RvOGpAPvtleZMd/GFH4i+DlVeacf97uzAYfbi
         zwSA==
X-Gm-Message-State: AOAM531ou5BgnwkOJwFYddQQAfiE75aWr7SUjXUFc8Ud7hklUBN1B8ih
        fIKm8aCwAfm9KQIR0KOyyOPQEIIpbC1dxw==
X-Google-Smtp-Source: ABdhPJziwlFBEzH7DmAb8okFUnMfzlDvshhOkQfibMxsXg6ObrowSHktj6y3XrOYrChqTFdqSwgeXQ==
X-Received: by 2002:a17:90a:5d09:: with SMTP id s9mr10685532pji.172.1616178747531;
        Fri, 19 Mar 2021 11:32:27 -0700 (PDT)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id n5sm6331272pfq.44.2021.03.19.11.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 11:32:26 -0700 (PDT)
Subject: Re: [RFC PATCH v3 2/3] blk-mq: Freeze and quiesce all queues for
 tagset in elevator_exit()
To:     John Garry <john.garry@huawei.com>, Ming Lei <ming.lei@redhat.com>
Cc:     "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pragalla@codeaurora.org" <pragalla@codeaurora.org>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>,
        yuyufen <yuyufen@huawei.com>
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-3-git-send-email-john.garry@huawei.com>
 <YElrSFGyim3rjDN+@T590> <8c6c6783-6152-2332-2f50-14c409e40320@huawei.com>
 <2b0c66ba-03b3-844c-1684-f8e80d11cdbb@acm.org>
 <4ffaba53-100a-43a5-8746-b753d4153be5@huawei.com>
 <fff92b15-d483-ad6a-bb01-ef61117b7cbd@acm.org>
 <82526e78-66e5-fc3c-7acd-38f1813ebe1e@huawei.com>
 <e0906b2e-6a2b-ce34-84a1-36eaddbb824d@acm.org>
 <85fd2c95-2258-9b51-02f8-01895c06f814@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4bd89a91-ca98-9c22-e01b-9fb7936623cd@acm.org>
Date:   Fri, 19 Mar 2021 11:32:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <85fd2c95-2258-9b51-02f8-01895c06f814@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/19/21 11:19 AM, John Garry wrote:
> OK, but TBH, I am not so familiar with srcu - where you going to try this?

Hi John,

Have you received the following patch: "[PATCH] blk-mq: Fix races 
between iterating over requests and freeing requests" 
(https://lore.kernel.org/linux-block/20210319010009.10041-1-bvanassche@acm.org/)?

Thanks,

Bart.
