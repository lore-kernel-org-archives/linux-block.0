Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DF7C433FE
	for <linux-block@archiver.kernel.org>; Fri,  4 Feb 2022 04:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356919AbiBDEJp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Feb 2022 23:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356913AbiBDEJo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Feb 2022 23:09:44 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4156CC06173B
        for <linux-block@vger.kernel.org>; Thu,  3 Feb 2022 20:09:44 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id j16so4093470plx.4
        for <linux-block@vger.kernel.org>; Thu, 03 Feb 2022 20:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Kh68bqIfR96bGqEsQD6t0ccLQCu/ga/B0iJH9ZRx6zQ=;
        b=aW6FCzwLzX1tJes3DN/wYTMmXMywRu7H//4nGgGPdDbXmYhuACnm9kSYeMId4jVEPl
         vgf3XsBpwWFb3XUdHS/n6oumA4XjQjGKqydlVmo+Xtqrsz0R6d9qkjI4QtR7lM+wXEZx
         KUgajNf+110tXuwka+YgdEjwh+ntpTb5agKFfxmDMxPfEybaxyUXqOE0+d/O/HVtmGJh
         3Gx/8L6+kI30LfJ/l6qLb7tz88SzENY3S00MJ8+7ANtRSvoSBj3XA+GJk/0sBCaeDYhE
         wF9ZFom/GbfmyunRiK/o2P4FO+4DrJc9nIurFAJ5LgQZXPRSf0iO/Q/+tQhGPqFvXWBA
         zZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Kh68bqIfR96bGqEsQD6t0ccLQCu/ga/B0iJH9ZRx6zQ=;
        b=nvAl0qu3ELkNa4INjum0h5bDcKYjf3T/ah9WL5NW10gDB2WEUXJyKv8D62b64puJxG
         EVfyXItZuHjqS2B2d0j9YRfvo8UzF+Rg6Dcuq3Q6KfUB7Zekxi6jZJNltQGWX+1UxoY/
         Tgxzp6DGlRvkVZ+F1DYfO9PLvrXE6CTByEvoHawU45Uz7syiU3qkBvXbaDqQxYQXtgaR
         oiWKMNOgQN2vOYWe2MsCCjqpNgBlaCg2cIGTp14SlmO2SfPZ+A61BD5gaprsrrxKtw++
         NJ3kTqQHXRJ3AOZ7fb/2/3CeB0wajS7tNk8xvVUpdR8VimDNkcUQ6Y4x627R/CC+nS6m
         1lpQ==
X-Gm-Message-State: AOAM530OnFlGnggN2cfDVSHRGAiaFDW9SIlSAsNmVk4OlqLXuTOeGxn0
        N0sYaHjpPuhJDDPRGj1ulgAWtA==
X-Google-Smtp-Source: ABdhPJwfiI1eIEL3VdvFW5NMTqjZKtPcFWlmo2jedeKQ1D7v1nQGivCZU3HMFeLmQB/exMNLktzSKw==
X-Received: by 2002:a17:90a:4e89:: with SMTP id o9mr1057365pjh.132.1643947783585;
        Thu, 03 Feb 2022 20:09:43 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id s12sm515884pfd.112.2022.02.03.20.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 20:09:43 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Dmitry Monakhov <dmonakhov@openvz.org>, stable@vger.kernel.org,
        Alexey Lyashkov <alexey.lyashkov@hpe.com>,
        Dmitry Ivanov <dmitry.ivanov2@hpe.com>
In-Reply-To: <20220204034209.4193-1-martin.petersen@oracle.com>
References: <20220204034209.4193-1-martin.petersen@oracle.com>
Subject: Re: [PATCH] block: bio-integrity: Advance seed correctly for larger interval sizes
Message-Id: <164394778292.433581.8274625002734886779.b4-ty@kernel.dk>
Date:   Thu, 03 Feb 2022 21:09:42 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 3 Feb 2022 22:42:09 -0500, Martin K. Petersen wrote:
> Commit 309a62fa3a9e ("bio-integrity: bio_integrity_advance must update
> integrity seed") added code to update the integrity seed value when
> advancing a bio. However, it failed to take into account that the
> integrity interval might be larger than the 512-byte block layer
> sector size. This broke bio splitting on PI devices with 4KB logical
> blocks.
> 
> [...]

Applied, thanks!

[1/1] block: bio-integrity: Advance seed correctly for larger interval sizes
      commit: b13e0c71856817fca67159b11abac350e41289f5

Best regards,
-- 
Jens Axboe


