Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BE2C49EA5
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 15:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A980C613DA
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 15:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhFXPil (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 11:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhFXPik (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 11:38:40 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785B8C061574
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 08:36:21 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id s17so7835626oij.0
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HTaIHQp1wTQPzNJmD2nxVzyvRK6AEMQd+kkM2IZEPTs=;
        b=XXUYivUXSu1OVCct7yua/BIYxpQWhIdE6hWR9zg8iXAw6gudOYW36iWEqYG17JSpQj
         GPu8VVVUgL7WHxs0HaQ9yja4ytKWNHNg2Jgeyk8gxE5euvW8kXDL1SgjKGooMQAgElk2
         4ik2VNgf1a8Uhx59PAXheBvBiL4phlEO4zO/8VOlpyXpMgOQePm9ISY3NJyJKJ5xTmR+
         DuempLsEVIUMWsV0cdL2FC1Cwsm1/rIwGWK5iT3XVZnahswK6pB9IlKke+JvzAAl9zn1
         t9kUNBMbf4EL2PaNkZ91el/dSW37LPWAX8FHk8CmU/ZBU1PnR79Jynnv1vp922otlZOB
         9V1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HTaIHQp1wTQPzNJmD2nxVzyvRK6AEMQd+kkM2IZEPTs=;
        b=iGSRq4d1iTQCvyKbDIY9mmpgmSdoDnRHJDpKUah7z/TKw6roCXDYedQXfIgrLWwWOS
         gTeQR5WQ12Mg2SKj4TUTyk1/vaHdTx+0YFq45PyHI2ISsAwGWYML49IAUZzENS9yjiz2
         virqmv8hisk+M1eRPyqM+yQN1q6H9fBwPvCjJ9DOoPXR/iTtFltagHHwo4ZoRnhgCkBU
         eArOet5IAwGrDGS3Qg0Rp1pmQsYoJfaqgyBOl7tM97QHR49ya1AX1LyuJJPU7R/PVOve
         XYxkJCLzhJ7dn0naTuflCOCPS9wg9mRjzfIIiqNhwJTEr9Qf9325kRhGbCAeHL2CDVYi
         9a2g==
X-Gm-Message-State: AOAM53296MwUK1Vgp/ZKRmCnNTTuG1/Qes8t5XKqdykAhqhpqBSwI4DM
        T/d21vdlFzXsrSr6445oJXegs6lzKFdZtQ==
X-Google-Smtp-Source: ABdhPJzPnTY/UhftvCDR4EYXO8JbvL0370bOe/GX7l8bpUxNJztaxwdyYYyeZ/NtGZnHRFihZmPvEQ==
X-Received: by 2002:aca:1711:: with SMTP id j17mr7566243oii.2.1624548980707;
        Thu, 24 Jun 2021 08:36:20 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id i15sm762752ots.39.2021.06.24.08.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 08:36:15 -0700 (PDT)
Subject: Re: [PATCH] block: mark blk_mq_init_queue_data static
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210624081012.256464-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <62fd04f8-4fe5-a5e9-ed6d-78c83433aa13@kernel.dk>
Date:   Thu, 24 Jun 2021 09:36:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210624081012.256464-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/21 2:10 AM, Christoph Hellwig wrote:
> All driver uses are gone now.

Applied, thanks.

-- 
Jens Axboe

