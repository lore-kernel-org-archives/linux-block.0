Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E70C433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 22:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359399AbiFVWdN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jun 2022 18:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359258AbiFVWdN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 18:33:13 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C81621E36
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 15:33:12 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id r1so16563982plo.10
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 15:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=QAYDnhWBUumQJXLfjLM/HrotAv8NVofKnBHrbwoQ4uI=;
        b=T4SQKvmVgykOMJflWwdcXiHwHaW6ppUL6HpcoyV5P5YmLv05PZ6ywgtWJGQ81+ry4m
         KszItlKZ3EpSACiBoKNrLwpXRyen8O2vs6mNbpNljaC5f++yyLxx9MZMY2XBeRgdaKGS
         A09Kxam4vbOBqas6DMCnXxbiHv2vgOyUg+nis+ZaifLjO2p3D62Uamrmaacp3j6HzKLd
         gCaxNXS5PcwEZ9PvFm7wmN9+rrIK3WKQrtYGPvw3alATQw6CJ/odCJ1ugivLjM2GCFEs
         cQDUIfAud4wtRq7y5/IGcX6YRcyll6JC9SwX3zx14ytWSwCqmz1r1cPZ2rC2SAw1Tj2n
         6x8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=QAYDnhWBUumQJXLfjLM/HrotAv8NVofKnBHrbwoQ4uI=;
        b=P1Km3wrX60pU9Hw9KUT5lsDi770gaLW1QluuD0RI+IsTNgCcvyqJRZ/4sCAtADroV+
         n+GGgmiUYn0LxMB+Vt8Q3C42L/CnDkdwMzzSHclxR6ocYOj/9ZezJVPgWKQlW728hiU0
         CVzk5Ks5tFp8vrEahPjzcGHdNypGNV7Pd+49YitbOw03qhfU3LfprD0YSfo1PSL7IYxP
         pCgVDYs638IZbKt2ypeGzvbOPJYFIiqBW9ZPoAa1V2onK94gPULY5aAKC7BeZNlUGg9p
         fjRxK+pdIINjK6xdCE6lhBJuNdptCzV7NUOhtF0oEiXxvo+Xj5qCHnHm3dhJByQTkKDR
         OOfA==
X-Gm-Message-State: AJIora+WmBQ+XPseNLY3d1+Cl8OXpnLYfCJEj1Ydx/FchjbC/ZPcdL/c
        cosFqDThrSj6vPSZiQBKwKdGcQ==
X-Google-Smtp-Source: AGRyM1sVc1ogbU/b7rlbzF68iEfptv2tG9a4AJSUp9uVgyMRQ81sfKMlvvYWh45MR18JSdkr1pN45Q==
X-Received: by 2002:a17:902:e810:b0:16a:2934:c8f7 with SMTP id u16-20020a170902e81000b0016a2934c8f7mr16468040plg.171.1655937191761;
        Wed, 22 Jun 2022 15:33:11 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id m14-20020a63ed4e000000b0040d2717473fsm2191066pgk.38.2022.06.22.15.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:33:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     christoph.boehmwalder@linbit.com
Cc:     lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        philipp.reisner@linbit.com
In-Reply-To: <20220622204932.196830-1-christoph.boehmwalder@linbit.com>
References: <20220622204932.196830-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: bm_page_async_io: fix spurious bitmap "IO error" on large volumes
Message-Id: <165593719059.163762.1120892404181433441.b4-ty@kernel.dk>
Date:   Wed, 22 Jun 2022 16:33:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 22 Jun 2022 22:49:32 +0200, Christoph Böhmwalder wrote:
> From: Lars Ellenberg <lars.ellenberg@linbit.com>
> 
> We usually do all our bitmap IO in units of PAGE_SIZE.
> 
> With very small or oddly sized external meta data, or with
> PAGE_SIZE != 4k, it can happen that our last on-disk bitmap page
> is not fully PAGE_SIZE aligned, so we may need to adjust the size
> of the IO.
> 
> [...]

Applied, thanks!

[1/1] drbd: bm_page_async_io: fix spurious bitmap "IO error" on large volumes
      commit: 66923326b519bbc4ebcb5275645b58427f801824

Best regards,
-- 
Jens Axboe


