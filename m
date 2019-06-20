Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F63BC43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 09:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A692082C
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 09:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="clV7Dq/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfFTJYz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:24:55 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43143 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTJYz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 05:24:55 -0400
Received: by mail-yw1-f67.google.com with SMTP id t2so873208ywe.10
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2019 02:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Bwr8k3+SFvaYBHWfDRhmuHYJT8RcVANW3HGErNj2YT8=;
        b=clV7Dq/4BfvF3uN8s3TuhNEsps0vqh03rveRDsTKK7rVmGHCzocpvytl6OM2y5PZG8
         cVudpngo8Z63dKSd5qYXv8G+MeX4N3R2ap6MIxpvCg8LpEYVo6GS6LRn+qYrR3KMgQpx
         dAq66covE0nlfU61c5J9DNRNEMmlnyd0Lxm10zBWGisg74Gq/B+6LpplW4vC4lGQrZXu
         JygGyapkdh4Eaq6Ob4ITmez5PK/035v+Q6tn3uViD/MyTRdIk3iisZVvQCT7nV8m+JWL
         kbI7xlCFOpxIqyozGRiiQS5cPGrEAZqR3+qSRRpg5zMGDmAJ3M85Sx59P1q7+oOGdUzb
         NnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Bwr8k3+SFvaYBHWfDRhmuHYJT8RcVANW3HGErNj2YT8=;
        b=Ga3TP5MqTHBtf61d38+5h+rJNVDHPUfqjxTOfqUlD3WSpVhEAlrn3k8nLtgX5Gr0ke
         eQYtGpno6cEtBP6VRkdzAF8ADuYCdBtyyS0kd4evbgKjPF5l7gbrllwDOEXu9JQDms+L
         CIG0ue4OpVilWcj1+xGDMMMmSkjSbnwUuaHtczfKpP8fCeMOgNq1ETR+40zXRnfVx+gE
         KpcTKZLXiO/QioYDjwhjhpznYAsEJLvVbT1z2D5MlP4LgQmRXwyEdRuOuN3Yr1c6Y/Y/
         iShJ6JNFQzmJc4R/lJR+OOKU26qfKcKl5PKW5ANMAKxGg03tPiTHxkN9b0owLwPLcmGH
         IFoQ==
X-Gm-Message-State: APjAAAW7+m/PLLJrFgjO/a+fyfTsQ7viMerNeNCaWDzj92JuvBsB+rtr
        ZVt66NgV978/jycKAKHRoIHLSWv6GZ+laApX
X-Google-Smtp-Source: APXvYqyd2TGhXA7VT2/ERpdAggE+ZhK22NujEO2NgsNWTy7BjMWJj82UTnbiGLsUz1HHyxbWqdYVmQ==
X-Received: by 2002:a0d:db11:: with SMTP id d17mr59529574ywe.416.1561022694346;
        Thu, 20 Jun 2019 02:24:54 -0700 (PDT)
Received: from ?IPv6:2600:380:5278:90d8:9c74:6b59:c9f5:5bd0? ([2600:380:5278:90d8:9c74:6b59:c9f5:5bd0])
        by smtp.gmail.com with ESMTPSA id l14sm5276754ywb.59.2019.06.20.02.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 02:24:53 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.2-rc6
Message-ID: <fad0dd2d-9991-f993-a072-8eae509030a9@kernel.dk>
Date:   Thu, 20 Jun 2019 03:24:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Three fixes that should go into this series. One is a set of two patches
from Christoph, fixing a page leak on same page merges. Boiled down
version of a bigger fix, but this one is more appropriate for this late
in the cycle (and easier to backport to stable). Last patch is for a
divide error in MD, from Mariusz (via Song).

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190620


----------------------------------------------------------------
Christoph Hellwig (2):
      block: return from __bio_try_merge_page if merging occured in the same page
      block: fix page leak when merging to same page

Jens Axboe (1):
      Merge branch 'md-fixes' of https://github.com/liu-song-6/linux into for-linus

Mariusz Tkaczyk (1):
      md: fix for divide error in status_resync

 block/bio.c         | 38 +++++++++++++++++++++-----------------
 drivers/md/md.c     | 36 ++++++++++++++++++++++--------------
 fs/iomap.c          | 12 ++++++++----
 fs/xfs/xfs_aops.c   | 11 ++++++++---
 include/linux/bio.h |  2 +-
 5 files changed, 60 insertions(+), 39 deletions(-)

-- 
Jens Axboe

