Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455F2C4338F
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 22:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2221360F6D
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 22:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhG0WpI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 18:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbhG0WpI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 18:45:08 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087FEC061760
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 15:45:07 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k4-20020a17090a5144b02901731c776526so6989823pjm.4
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 15:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F2VzMT246wGHVuc/C9Yr3QO5HUyDdP84+0q/UDf2X6g=;
        b=PwMkTFH/H7ItHM5Ni1u4MMEdqyaBLO3/VCima4M0PnAJqoTXJkRnqf6kAoBsGyb4He
         CH+fDf5FHRa1L7Lvsgyi55s00bbJGF+1nNsmYyw3kRz+7EodZ/BrJZ170fbhB3YYXplM
         dUyuKmzDp7/lQP8hLTbBeaZB93HGv/yXHBdckuVS/55YrydpcymOulVx9NCuTaP9G8Tn
         i/pTPmxsEIIcQ3xwtrCTEK3XvwMKXiOXXpkMFneL3ON90V0YJPQCM4O34sWDL+AZPAdn
         K4RXRaoxejlfTO+5nZEidGO5gs3m8TorFdA9hXkY3M1SxBQJvkgOc6sLawTavyxwegEI
         u2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F2VzMT246wGHVuc/C9Yr3QO5HUyDdP84+0q/UDf2X6g=;
        b=BF4DtN5e9iSsU6jH8nGktj0vI3ht7EjXjzr80trNSMcNc4fB2x/jX4gQYSmIAvK/dU
         Ans/LPRRHRgYx2KhwNrZ90X++nszukAJnNEjOmpkeRrMgxor6M35i0sczebobUlZZHsE
         V/TBlDutTVyY47tihXYYaenKsNrVkqT2TVot6orHsCgojOXJWUlqq/FlS2MQ1+JV1rI3
         /MpjlZ5xii2O53fzroMw4Wua9Dw3x3K3eRtf7NFu/8Tf4X84vsySL1yfNYaotg9eyjdx
         E4/zQ6STxztCGPM6J+bjOe2N7oub+1HrRovyUSpGlSWPCLk5vFugX8oEo2v9Zwd+h2qx
         ei+g==
X-Gm-Message-State: AOAM532IDAJsprB+AjqSGIMqcfW+uBk32Z2p037J6nMHfQiAKuGvK9q6
        PYcxNzG2ZoB9RExxLLSuP0Bhkw==
X-Google-Smtp-Source: ABdhPJxmOmDQDNgdJdifQ1zu56tZWRU5l55FFo7Zhy4Tpksm8CM6OcOcJ8W2SgFMIbm/SMTffkshtw==
X-Received: by 2002:a17:902:fe87:b029:12a:ef40:57a2 with SMTP id x7-20020a170902fe87b029012aef4057a2mr20597385plm.81.1627425906358;
        Tue, 27 Jul 2021 15:45:06 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id f4sm5288861pgi.68.2021.07.27.15.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 15:45:05 -0700 (PDT)
Subject: Re: [PATCH] blk-mq-sched: Fix blk_mq_sched_alloc_tags() error
 handling
To:     John Garry <john.garry@huawei.com>
Cc:     osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com
References: <1627378373-148090-1-git-send-email-john.garry@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <20fb9978-af00-0bc6-33d2-c41bfb129cb4@kernel.dk>
Date:   Tue, 27 Jul 2021 16:44:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1627378373-148090-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/21 3:32 AM, John Garry wrote:
> If the blk_mq_sched_alloc_tags() -> blk_mq_alloc_rqs() call fails, then we
> call blk_mq_sched_free_tags() -> blk_mq_free_rqs().
> 
> It is incorrect to do so, as any rqs would have already been freed in the
> blk_mq_alloc_rqs() call.
> 
> Fix by calling blk_mq_free_rq_map() only directly.

Applied, thanks.

-- 
Jens Axboe

