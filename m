Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BAFC433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 13:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED0B610E9
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 13:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhIONzY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 09:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbhIONzY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 09:55:24 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619C4C061574
        for <linux-block@vger.kernel.org>; Wed, 15 Sep 2021 06:54:05 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id j18so3485204ioj.8
        for <linux-block@vger.kernel.org>; Wed, 15 Sep 2021 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7/Q4nZ9EOUpJt4n1PFYQUwazd+gd9harjBRnthmgWbM=;
        b=TlIQZb60vkuXEduYXWNxHT3rCTopsdtbEw/5Hf0armaQEorx0w+ki/iFDu5531ftnQ
         Sgc8tBR/DJjlAULRlDWxfMQXStPz4Slwk5PhVL5Q7zfjHUmpWs6IXmwwE7Tu56Vuo5Om
         TzqmZJ6O17uPp6nCurJcla7K1Ydn8jNvrE2drAD/iOtkITDL7etUYHxnd1ExlYypJFc2
         BLbRgJ60ArY3ulHY+29EKOPgfMH4tBcPWgHD6ZberiOlGBa8VC625BCTSRCRqFvl4IZl
         gXRs1MSWrcl7BaS5QWu1Y/4/aYDsYZzF+bAbeM/+w5/42Og9R8w/bUpPA9oy+bgktkNI
         oExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7/Q4nZ9EOUpJt4n1PFYQUwazd+gd9harjBRnthmgWbM=;
        b=XrYZAVif6qkw/QYx8rhvODantqV+Yr5EKAfFAoktVXJVr7zQfTYMjm7kgJtpXPu0AE
         2jgKnV/q+HdIFP81aD3OEdbUyo+Q95UkYnlYiXDD+Pm6tpuhqJS0PmUlPBqehRik8Gpw
         XYAirEA616ekt23x1ayNe6BKRvUd81GHRiTYWTOBGD7mrOPwHnUyCz+F1SVovcQajpFy
         eRT8GuwtP2W54hsiR50TpLeA/UEcjmhJE6u73y6XaAlDQNMouzc+ZQ8KuC4zYLiUh8V/
         5XxV0WXLZvjB4/69qUsLc4w3VTO6xPfDV162QW+RKQjc9kwYFfhsEnhPa7+bGx+ZuyX1
         VL1g==
X-Gm-Message-State: AOAM531g/5BZ1V9r2fEtxIRJVwCxlZsilsKRk4NwwJT7lTU31A7nojm8
        ZgJretJcIFCOcxp0AUr/hd54jQ==
X-Google-Smtp-Source: ABdhPJxlB2dTVJHinqtET2J+SWBAp94tlra5zu4ou1r8Apg3HVCKOzfE6ppnsu1diR1sTvCsJWsZYw==
X-Received: by 2002:a05:6638:3813:: with SMTP id i19mr124026jav.16.1631714044718;
        Wed, 15 Sep 2021 06:54:04 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id w3sm1881ilc.23.2021.09.15.06.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 06:54:04 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.15
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YUH6AxwHYm+FN1Au@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f4eb130b-1110-bab9-7794-e1ad91443ef0@kernel.dk>
Date:   Wed, 15 Sep 2021 07:54:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YUH6AxwHYm+FN1Au@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/15/21 7:49 AM, Christoph Hellwig wrote:
> The following changes since commit 67f3b2f822b7e71cfc9b42dbd9f3144fa2933e0b:
> 
>   blk-mq: avoid to iterate over stale request (2021-09-12 19:32:43 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.15-2021-09-15

Pulled, thanks.

-- 
Jens Axboe

