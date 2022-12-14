Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEC8C4167B
	for <linux-block@archiver.kernel.org>; Wed, 14 Dec 2022 17:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbiLNRzk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Dec 2022 12:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237720AbiLNRzi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Dec 2022 12:55:38 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0A9F23
        for <linux-block@vger.kernel.org>; Wed, 14 Dec 2022 09:55:36 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id m15so6926656ilq.2
        for <linux-block@vger.kernel.org>; Wed, 14 Dec 2022 09:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5mupyHph60zW1pBiVb4mDSMN7RkjMG8EJ9nxvuoQ3I=;
        b=DxoQG/CUV6j/eIQ4DQf2r1048BkXOzql3x5HEv6/SDQxco/uInwIFwDzawZcJUoOzy
         TOCCZICRMLVJhEbwcoApINifHZj1o2D0vyNykiZnyCOu28d3h5PPggPaTE8DXd2SlHVY
         2ew+bj54yDuwubo8nIw47UKWkPc6BGTDH6LpFjdl0P6nPg2ALs2YUaSbrpHKwRLETY1i
         b6hO9fAnJku0IUECOSVyXmNX8pUp6cV+UeJMTRODX7/toSNJUVl6b3nyqFVC8eRkGa3b
         q7aiwYKifPun/jZLJhZYSZYvWte9uhGf2jRtVjAOH54qw84YqN3lo0oDf2z08JdFElTo
         8mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5mupyHph60zW1pBiVb4mDSMN7RkjMG8EJ9nxvuoQ3I=;
        b=L8KCl7Qsor1pbJcc8MQ1A9zFSGwgVTgVwUCoiZcQ74JMGv7ecPalHZYObfg1aydXAO
         C8YyySwaQyY5OhuEkIH6SAYQYGjkRKqw6d2tRjUWTWF5sEH1Jr/NYSpt/4bSMIK0lqXw
         L9R/NUkCguMJCeRqHiRwXOPuIEo15n/bOZorw/U4dflnfWWShhq7glIg+o+F7sYvXs6q
         BB9QhiBcJ9afbKYra/kkOU9yArUGHvob4ZyL9+fgys6tja7W1u4u8TgXM1TDGh5fCfNC
         XRUA8ecZ6msWuqmqbafdYlrcI0Kgl5A1TXxCFOPbr2mmOr0awPUnI0Pj8SW5WEIpsGE8
         TyZw==
X-Gm-Message-State: ANoB5pnMY6mkNKhOupIifFdHBvFoIpuWdhYrYcrT2w37wsw6ZkyLF0mY
        Xg0q5dQJxymYpXmzwnN+yoReOg==
X-Google-Smtp-Source: AA0mqf65/Kf9O9EnNDER/ZDoDPXWd03V7lAqgfPJL2N4119ThlOL/HDlJIORW0PhNwXDQJGWscBDHw==
X-Received: by 2002:a92:dc83:0:b0:302:42c9:8f2f with SMTP id c3-20020a92dc83000000b0030242c98f2fmr2516110iln.1.1671040536091;
        Wed, 14 Dec 2022 09:55:36 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x5-20020a92dc45000000b002eb1137a774sm2364958ilq.59.2022.12.14.09.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 09:55:35 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ken Chen <kenchen@google.com>,
        "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc:     Saravana Kannan <saravanak@google.com>, stable@vger.kernel.org,
        kernel-team@android.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221208212902.765781-1-isaacmanjarres@google.com>
References: <20221208212902.765781-1-isaacmanjarres@google.com>
Subject: Re: [PATCH RESEND v1] loop: Fix the max_loop commandline argument
 treatment when it is set to 0
Message-Id: <167104053516.12018.3829902997304947122.b4-ty@kernel.dk>
Date:   Wed, 14 Dec 2022 10:55:35 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 08 Dec 2022 13:29:01 -0800, Isaac J. Manjarres wrote:
> Currently, the max_loop commandline argument can be used to specify how
> many loop block devices are created at init time. If it is not
> specified on the commandline, CONFIG_BLK_DEV_LOOP_MIN_COUNT loop block
> devices will be created.
> 
> The max_loop commandline argument can be used to override the value of
> CONFIG_BLK_DEV_LOOP_MIN_COUNT. However, when max_loop is set to 0
> through the commandline, the current logic treats it as if it had not
> been set, and creates CONFIG_BLK_DEV_LOOP_MIN_COUNT devices anyway.
> 
> [...]

Applied, thanks!

[1/1] loop: Fix the max_loop commandline argument treatment when it is set to 0
      commit: 85c50197716c60fe57f411339c579462e563ac57

Best regards,
-- 
Jens Axboe


