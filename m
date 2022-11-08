Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4DCC4332F
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 14:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiKHOQP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbiKHOQO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 09:16:14 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9D569DD6
        for <linux-block@vger.kernel.org>; Tue,  8 Nov 2022 06:16:11 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id h193so13481412pgc.10
        for <linux-block@vger.kernel.org>; Tue, 08 Nov 2022 06:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5gQ77cJYhWLwVw6OTRfByzvrqqb5ZjgfyENtp3rPeAg=;
        b=iezbgklMmiQ+txoOM8ZHz+Rpm6lZ/v96Ztp2JfWLFvkT9z5jr9CRJkk4eXKQtURfua
         ZroN3bbkvyx0DOr6aTsdy4a6EHDBjbeGOS4TG6ViG8IrnFIpYrmM+MiuHuj1k3FvuIUg
         tQ7E03m5aA6aFwA0XOhcz5JDvqOPSs2Ae8U48cfWwhlS+7YFKRMTXM7+lUcZZYdyg2FL
         wgyMDkSRVP9BW3wDjot7SMay6BQW4Q777dUlVe8YcWZ2/Rnds4nQaCo8tuZNxBkKm/PR
         5FZjAifB8/cA0dqx2KNJKt09TgwDfMTQAQ34Hva9fouQTPLfAikNYJWI15ayjK9/ASi+
         McMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gQ77cJYhWLwVw6OTRfByzvrqqb5ZjgfyENtp3rPeAg=;
        b=oFvQlzMfcwxyx8+PbHuU9TDemRMwwYhyeAgBOAQvm8z6885vD/WP20EckCt3N4m847
         I2ZtHjC+0m/9nxXWCUSD6Rmfi0WBYex21sl99bBVA206uahQHi9xSBvM6s0j96Pm/Q9K
         UPpBpFzTFipMhsE72py4HpyfXqeCAT13FFB3hzB3hG/OPWa6yvsB81vNPfJ+U+2RE3ww
         /4SJu5CBvr3sDbkr2yvirp9ZRCoiSWN9PBttRYx8ZzuQaiIWOefgJ37ooUXP2U0Uav6d
         AjRa0TzQY59gAzfTvNY+MSefcpCUnxMRlJFrHEdxh4RL863vSYyChQ8dGAVaMOhUiCCB
         Iisw==
X-Gm-Message-State: ACrzQf1hF6xBhE2z05VBjX2pcaSukkP9BZ6zWvwhdrL4cFy8N8c9GG48
        dmubWzJxwpv02Cs0CqL6YcG5Bh2r5F5O1vSY
X-Google-Smtp-Source: AMsMyM4aSz4gtqrG/IZCsEVzearQOFoOnv5464JLmYfU7lB+JcgRzKrk85yVWbDkK+x+2fM9+2ePGA==
X-Received: by 2002:a63:4f59:0:b0:46f:b2a4:e9d3 with SMTP id p25-20020a634f59000000b0046fb2a4e9d3mr42389169pgl.452.1667916971271;
        Tue, 08 Nov 2022 06:16:11 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g18-20020aa796b2000000b005622f99579esm6416494pfk.160.2022.11.08.06.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 06:16:10 -0800 (PST)
Message-ID: <3188d3de-77ad-b0a8-b54a-f8f358c22416@kernel.dk>
Date:   Tue, 8 Nov 2022 07:16:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] blk-mq: remove blk_mq_alloc_tag_set_tags
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20221107061706.1269999-1-hch@lst.de>
 <97c6c6b7-1de5-a341-e24c-f18e62aeaae7@kernel.dk>
 <20221108062030.GA19853@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221108062030.GA19853@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/7/22 11:20 PM, Christoph Hellwig wrote:
> On Mon, Nov 07, 2022 at 09:20:37PM -0700, Jens Axboe wrote:
>> Getting rid of the helper is nice, but the realloc one is badly
>> named imho. Can we rename that while at it? There are only 1
>> caller after this anyway.
> 
> Tell me your preferred name and I'll do it.

Just call it blk_mq_alloc_tag_set_tags() at least and get rid of the
realloc? Should make the patch simpler too.

-- 
Jens Axboe
