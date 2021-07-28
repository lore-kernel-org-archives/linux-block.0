Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85F0C4338F
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 13:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCEB96023B
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 13:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhG1N0E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jul 2021 09:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhG1N0D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 09:26:03 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE88C061757
        for <linux-block@vger.kernel.org>; Wed, 28 Jul 2021 06:26:01 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id t21so2629446plr.13
        for <linux-block@vger.kernel.org>; Wed, 28 Jul 2021 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y28WvbSB482/vIdME9ZmqMPohDocl+++9eJHbKIwx54=;
        b=gS1EtNSdxAHciluFn3kj2oEIF2hguKUDgQgiUUooulqooshEApbeEmr3S8lDsrA9KC
         z7MHsheTosddJ4mIT1ovstI00CXs4U4/kQdJtKOZZltkDhJL/V5HcU0c56FBSUdjeoX4
         lG+IInqUxgb3IuJc8/koTOBgc1zaoAAxTdXOkIgRNl51XR41JQoEi+NQXD7zjrsGx4zz
         a2bofHFLZkOMvPD/NfdH32MGPIscwffj1YANyqdkYFt8tw1y87sOLoqutRMabKblGldS
         z5oInXibwLViAtvsi5hfHZPkK3d1LJyQWfV1d2olSUQ3LfkE6WPTuZg6NBxRawPZx90h
         vFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y28WvbSB482/vIdME9ZmqMPohDocl+++9eJHbKIwx54=;
        b=jCxD0Cd+YajZaGlV6m+s34hmZd6u9qFOsO1SsQjlOgNMBUBT3qG9zzVMigNGCHmgbM
         5XLjun9NpRasnlGQz9eQifsiLWCmhWyJ29HhpxuZNd7L3MWqGlUu9wKfq1nb5KlE+uOJ
         PKD8xNnwu5up6xSzisS/S+yxLywYrz+NLhwQ/r4gZsEr8EEAGfb8468cVkieSqQPo9DI
         VlV5uUv/TLMeUlwOH9wyJHUwcsMcnPD+0g5fz8mzfItmSBnVmr/+XfU3xIkX95i04Eyo
         Pt0DvdkF9Mu+URK+0/2FmB0y9sHj74kVqvc/QY+GduJSYy9s/HkJ9AnZ4i+xZbpHtSpN
         PnbA==
X-Gm-Message-State: AOAM530Q1EE0b2yeOH6xFfuirL2G4DOUgiBj6cZLGwYKmsZeS8NhyCDC
        S34MKtt55EEScjfFEyvpAqjYqUTs30FxtqF2
X-Google-Smtp-Source: ABdhPJwvJflvNCLxaqEa7ovLje2o1pb/H0hQzHxnRV5BJC0NNPIE7gXEKqrT4OmmLAwZC1C0qI4mCw==
X-Received: by 2002:a17:90b:15c9:: with SMTP id lh9mr9471785pjb.111.1627478760766;
        Wed, 28 Jul 2021 06:26:00 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id gm7sm6458696pjb.28.2021.07.28.06.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 06:26:00 -0700 (PDT)
Subject: Re: [PATCH] block: remove cmdline-parser.c
To:     Christoph Hellwig <hch@lst.de>
Cc:     caizhiyong@huawei.com, linux-block@vger.kernel.org
References: <20210728053756.409654-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9771af4b-fc8a-4847-9449-8d14c814938e@kernel.dk>
Date:   Wed, 28 Jul 2021 07:25:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210728053756.409654-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/21 11:37 PM, Christoph Hellwig wrote:
> cmdline-parser.c is only used by the cmdline faux partition format,
> so merge the code into that and avoid an indirect call.

Applied, thanks.

-- 
Jens Axboe

