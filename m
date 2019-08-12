Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86CAC31E40
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 14:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5721B20679
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 14:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="njLP4ZMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfHLORD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:17:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34501 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfHLORD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 10:17:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so49763986pfo.1
        for <linux-block@vger.kernel.org>; Mon, 12 Aug 2019 07:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hjm5zIRUG1rVFASTjyjP9Aq60PPfTvqAdxXcDryP2Y0=;
        b=njLP4ZMacYdtFtqIH2bWbhUs3B0orNhpOwNoZ0xMNf+3XG/nowQtTPNxxk/ncwvvpT
         AjaqI0ZFrwZ5Ypqzu4LkUetH1TnBgzMcJAi0XgE0EnQSc/hNRwX9gmtKaRTkRrHJxCMk
         kMxMm+KNUe0vVDbj1DUepNIXBdNCTpELxvU/H9eVeKNGVqJJaScR4kY6pxYZ7QATNGDD
         nTiyGWTaUoAZAZtEhJCQDq+79fMA7uYc0EyqER4ZdPYcKGNplvdhybFNFIsFayxKZwZi
         uRxvK1GFuqQOZc5S6qWjnNrPzBRPkG8GDGgRbauXnkVuIcc5NUjyRnmidrjp+QB0VGYe
         3F/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hjm5zIRUG1rVFASTjyjP9Aq60PPfTvqAdxXcDryP2Y0=;
        b=jP34wpDelQdNUeLjJavtE5ENXKyUi1K7SFqzkIdh+iBFcHvVS66quYLcn5tUGPZ8zX
         zAdH7FBXcazHItcWF0aaO7ftbClwYoWy6TSle5wT2xp0LZGreztCL3RozTJMzW9CAF6k
         Hj/S10wX45Pf3DFG/7RZmoWf0G5X5hdybyfdbF4n2y/T86OkX4ccCOhzJS191KRhsdg2
         gCFlGLK7E6ZjI9HTmvvEzGV6G9aEujfIA0TXNwFa8GeAmKfaVfD1cp+LWHFWpwdBYx2N
         lByX5n11AV2XtVDyAEbdo7iGMoQiXQ5VMwI3orVZL6gbaWim/T0SwfbdWKPg376WHu5L
         UE4Q==
X-Gm-Message-State: APjAAAUeFSCnyBKEsTIlSbKE3ljXw+HgypT4/eJGRhefnJI+35ilSSGi
        Zr9lzoZ7p7uJ57N0bDkziqZV6Q==
X-Google-Smtp-Source: APXvYqxicOrLucvAZkbMWAmW/KpjOj9NBBiSJYXj1QNug6OYNBLNpY5g+LrI/AGcfvyR3YEszEKDfw==
X-Received: by 2002:a63:2744:: with SMTP id n65mr30029753pgn.277.1565619422739;
        Mon, 12 Aug 2019 07:17:02 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id q13sm8499863pfl.124.2019.08.12.07.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 07:17:01 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Fix memory leak in blk_mq_init_allocated_queue
 error handling
To:     zhengbin <zhengbin13@huawei.com>, ming.lei@redhat.com,
        linux-block@vger.kernel.org
Cc:     yi.zhang@huawei.com
References: <1563891042-25448-1-git-send-email-zhengbin13@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fbbc52cf-04c2-2bdf-f2a2-234c57d1d1ae@kernel.dk>
Date:   Mon, 12 Aug 2019 08:17:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563891042-25448-1-git-send-email-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/23/19 7:10 AM, zhengbin wrote:
> If blk_mq_init_allocated_queue->elevator_init_mq fails, need to release
> the previously requested resources.
> 
> Fixes: d34849913 ("blk-mq-sched: allow setting of default IO scheduler")

Please always use 12 char abbreviations for git shas. I fixed it up.

But thanks for the patch, applied.

-- 
Jens Axboe

