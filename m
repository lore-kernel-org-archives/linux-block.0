Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B449C433EF
	for <linux-block@archiver.kernel.org>; Sat, 16 Jul 2022 12:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiGPMd3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Jul 2022 08:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiGPMd2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Jul 2022 08:33:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DB31EEE0
        for <linux-block@vger.kernel.org>; Sat, 16 Jul 2022 05:33:27 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso8524636pjo.0
        for <linux-block@vger.kernel.org>; Sat, 16 Jul 2022 05:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Z5XjUyUmaWOdMLRu7KLMY18nTfzRSKpg9LsYNj7VMyg=;
        b=L8dNezZZTiMuGApSLQ+7SHjTBRtJsfgoco+bzvbWEqSDJpdDKzpWhmZbw4mEcM+sn6
         w61bQhN4j/U4Bv5zAMO0k8BdmZ4qE/pEhEJXN3Axs4u6dLEV/9OWh9AfVHEuQNFc7Vp2
         59tQiMWSa+1vZrBORKo6Hqhna1e1gvVGzKs8f6mfCqvRtP7SiLF/FQ4b6wreEOWa8aqi
         foL/CJYuCV+uZceGxy2gmTJfjQnEtzj0iK7Ut3gFVMuDnLnurF9MZRsSFQjTYJNI02kC
         kvYwG5SL3ajZunF50JxUtTeNvFJk0JaFNWLpe9X8jKd32uHv+JpUNWINxyq2JU3/B8dy
         +M0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Z5XjUyUmaWOdMLRu7KLMY18nTfzRSKpg9LsYNj7VMyg=;
        b=eFPy25vTOj9Vn4oGMxmo+0Oa+wmZhBJezK0yzppnxSZk+swEcsH6oMmLTPghGx3RLH
         1d9y+SxXEVieabnNiIsGrSJc/7RsdHhRfv7v9Uwz40y4aLiqNVIv2UbgnMKOwjmDnMpO
         MjSKnhE115neEw3WG3yrCsMQQwtQZVyKLKcPq+tIjOgowGS4Wp5dSds3R8PMt88FnFgH
         4KFg6coZZrsRAR+tDZK43swnKfu1cjBRGKI764nLMRCG3To9TNHL8UknhMCEf1M6gEF8
         YvQWRLPJBNusfIL8dDaBBmimLoe8QInDKVwqlBWfXHPtvZ98EO+xDGlDI117xVohFZ7P
         w40g==
X-Gm-Message-State: AJIora9Az+VFmlSaBi6IjAQOzIQof0l+zGK0X/se6AqLqF4IxKP3hxkS
        3mOg60NuQX9iuFvKAh09boYH4k7fjSpjCQ==
X-Google-Smtp-Source: AGRyM1vQjSSqUm74RGw7EEP5/3oQyxQ5TczVzey6fFwh16Ydz3raAIIcIJaJ0y3JqJMU7zwpOsQPmg==
X-Received: by 2002:a17:90b:17c4:b0:1f0:4482:8efc with SMTP id me4-20020a17090b17c400b001f044828efcmr26526915pjb.207.1657974807361;
        Sat, 16 Jul 2022 05:33:27 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o90-20020a17090a0a6300b001f0cece9285sm5112359pjo.18.2022.07.16.05.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 05:33:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     bvanassche@acm.org
Cc:     jaegeuk@kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
In-Reply-To: <20220715184735.2326034-1-bvanassche@acm.org>
References: <20220715184735.2326034-1-bvanassche@acm.org>
Subject: Re: [PATCH 0/2] Fix recently introduced kernel-doc warnings
Message-Id: <165797480617.363028.4687340933765044343.b4-ty@kernel.dk>
Date:   Sat, 16 Jul 2022 06:33:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 15 Jul 2022 11:47:33 -0700, Bart Van Assche wrote:
> This patch series fixes two recently introduced kernel-doc warnings. Please
> consider these two patches for kernel v5.20.
> 
> Thanks,
> 
> Bart.
> 
> [...]

Applied, thanks!

[1/2] fs/buffer: Fix the ll_rw_block() kernel-doc header
      commit: f54541403b2f51d98aa65472ddb021b1ef7d1eed
[2/2] blktrace: Fix the blk_fill_rwbs() kernel-doc header
      commit: 020e3618cc81abf11fe6bffaac27861ff94707ce

Best regards,
-- 
Jens Axboe


