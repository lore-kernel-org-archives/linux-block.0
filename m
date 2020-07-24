Return-Path: <SRS0=qKaS=BD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8C7C433EA
	for <linux-block@archiver.kernel.org>; Fri, 24 Jul 2020 17:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5230206F6
	for <linux-block@archiver.kernel.org>; Fri, 24 Jul 2020 17:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfX5kMNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgGXRrl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgGXRrl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jul 2020 13:47:41 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C40C0619D3
        for <linux-block@vger.kernel.org>; Fri, 24 Jul 2020 10:47:40 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x69so9409131qkb.1
        for <linux-block@vger.kernel.org>; Fri, 24 Jul 2020 10:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vvtBe8wfI2Nyjo7UVPTJwjxI8vmvbV6uhPi1eXluD4Q=;
        b=sfX5kMNVQA2geBGZEzVW+wdu61y6HqSTfyfC+R2HTSJhnR/L7yiNnqA/FMskQI6Jw9
         8TuFMFwaZ9aOK9DMlYs/6NW4iHGZ1MQ0z/1duuXT0EUeHC075PTduOU46EEuUrdu2+ze
         gy1XFTqi4G+yw82Ecn3xpg31Hr3HSTXcFt+JvlzZFSkDcT0q0pn2HbpfRUawnflg363e
         6/yfvUuMkDz25s0rp0WTf3gf8KbP5zKqYEdR4W358mxv2AECD7MEKZ4TgbGHQl6tyAZy
         Yc/sVeipZB9O4+pbbrRsjw23++aV5Q/IMBvcpTRc4CG8CV+N48L2/AnNNwvmz3cEkmRb
         MA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=vvtBe8wfI2Nyjo7UVPTJwjxI8vmvbV6uhPi1eXluD4Q=;
        b=Q77RHHctIfhbk+yJ0qbwyn52BdDJ2OSyUnrVUgY8loGUYaUnkotADql6NjkQwUD4VE
         LeiOJwblu4q0muksQz7TKSnWoRCZ9YiuMBrj2usckuAvWz3J4XL/4jFenPp9yh8tGO2b
         KV/MZneo0hrJ1oKlynvuzhinDkbZTm4FLi6351v/TaAoUSc8NmX30bFFgf0UA8G2M0Kx
         fjWJ4m/fdtl3cHYZrLM2/322JDUAoyftdGgI/0Y/eMXceROSDyF/BbauMYVpaJ+A1Y6Q
         XVme+uNSPmamzYCrGv2yj6Wl5wfBrTTZqHxLH8D7+2DdxJSipHP0tOfdVvI1535qSIML
         Nyhw==
X-Gm-Message-State: AOAM531P/gTjAZeL6J+QUutmm/Y2sJTJK2WDviLfdUr999vH1ntKu0cN
        9a24MGyLUzZ8B5yuRSATK3Y=
X-Google-Smtp-Source: ABdhPJy3u9X/LZrEBcnzHqIvih1ekiphmh5VUfl1+yQGnTTGpvo6N+vJ9ZGQt4Y2BPOksFGy57bw6Q==
X-Received: by 2002:a37:9a46:: with SMTP id c67mr12141851qke.85.1595612859966;
        Fri, 24 Jul 2020 10:47:39 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id b8sm2182059qtg.45.2020.07.24.10.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 10:47:39 -0700 (PDT)
Date:   Fri, 24 Jul 2020 13:47:38 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [git pull] device mapper fix for 5.8-rc7
Message-ID: <20200724174738.GA84895@lobo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 6958c1c640af8c3f40fa8a2eee3b5b905d95b677:

  dm: use noio when sending kobject event (2020-07-08 12:50:51 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.8/dm-fixes-3

for you to fetch changes up to 5df96f2b9f58a5d2dc1f30fe7de75e197f2c25f2:

  dm integrity: fix integrity recalculation that is improperly skipped (2020-07-23 14:39:37 -0400)

Please pull, thanks!
Mike

----------------------------------------------------------------
- Stable fix for DM integrity target's integrity recalculation that
  gets skipped when resuming a device. This is a fix for a previous
  stable@ fix.

----------------------------------------------------------------
Mikulas Patocka (1):
      dm integrity: fix integrity recalculation that is improperly skipped

 drivers/md/dm-integrity.c     |  4 ++--
 drivers/md/dm.c               | 17 +++++++++++++++++
 include/linux/device-mapper.h |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)
