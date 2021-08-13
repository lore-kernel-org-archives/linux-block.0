Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFB4C4338F
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 14:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3146023D
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 14:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbhHMOCY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 10:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbhHMOCY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 10:02:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B617EC061756
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 07:01:57 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id a20so12174630plm.0
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wNrJnUYnfRPBzUpjeotChldlaMSS/UUcjD6ZPv2sG0Y=;
        b=Nzhdzc0pkVIq+/WOScKH6VFqEciABIu6NIY4ntKraFvmWE2uG8bmaSE4WRIqqLM4Nv
         Fy21vfA2Xh+ySSNej/5hI0/Ng+a2GWVHLk53Ea4Nv7T4zXIRs08ucpxzmDvifZoDw827
         9gkQkSf/gR6eiakZpVR3V189qnkEWKr/swl8VjLylhUQFnYToH8Br23snCY7c2hmUlPy
         gHKLZ/EmOUNG1btrQIByk1vDGw4Sl5eAzDgVXVe0/oRBnAst3ikq/cAeJsq0mFbR9Q8H
         dPH0d6JMI+Gfegvb8kejjKyswhN9vK78YahZrQE1orglH45gCvb95GeiOfA2tBBuz/T5
         NIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wNrJnUYnfRPBzUpjeotChldlaMSS/UUcjD6ZPv2sG0Y=;
        b=VzCwFxMWpjBDYiKNhq3ldO4CDj1P0K1TbbN83LmbPsm+HhOXzsq5ThiKaSMix1w454
         8770r6DCrXe0rKKxyALVuOVIUOiLw0RxLtxA9+/equt0rTfbDL+2vM1IK19lOhdYOShn
         Pwcr1T4R2gdz8lE6fBSXMMJpzAnQj34OYo9gIqY1aeV/QCYDhTBa0GlV3LgC3tkoB3XL
         UgAi3eHgn2083Z8z4YmAtsuuBrKC1/Q2Aqgb89MrFNt9urVrzzeskr6V2J7hzvuKFnog
         0YXHfP+K9mdlh+aCt5p6BhUFswg7cInjbYs/FTXk/vqfo4A05iAWQCi+zRBUrJjBX7L4
         PDmg==
X-Gm-Message-State: AOAM53285qNRNFrXoVE6+r/Xl80R8FcPRMmwjaBu75BEjheR/tM83Cir
        QETeKqFYn+SEuNXLiIx9IxChpA==
X-Google-Smtp-Source: ABdhPJw0ATt2/jMALH6Jn8BR5awfVUf62Q9ddlhuw8cDthMRIcKHkSBz8kAm7LTmKy1M0IIQBYrFBA==
X-Received: by 2002:a17:902:7786:b029:12c:dac0:15ba with SMTP id o6-20020a1709027786b029012cdac015bamr2217216pll.27.1628863317135;
        Fri, 13 Aug 2021 07:01:57 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id p29sm2562991pfw.141.2021.08.13.07.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 07:01:56 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: clear active_queues before clearing
 BLK_MQ_F_TAG_QUEUE_SHARED
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20210731062130.1533893-1-yukuai3@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <198821c1-520c-4175-4c4e-ee092c271baa@kernel.dk>
Date:   Fri, 13 Aug 2021 08:01:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210731062130.1533893-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/31/21 12:21 AM, Yu Kuai wrote:
> We run a test that delete and recover devcies frequently(two devices on
> the same host), and we found that 'active_queues' is super big after a
> period of time.
> 
> If device a and device b share a tag set, and a is deleted, then
> blk_mq_exit_queue() will clear BLK_MQ_F_TAG_QUEUE_SHARED because there
> is only one queue that are using the tag set. However, if b is still
> active, the active_queues of b might never be cleared even if b is
> deleted.
> 
> Thus clear active_queues before BLK_MQ_F_TAG_QUEUE_SHARED is cleared.

Applied, thanks.

-- 
Jens Axboe

