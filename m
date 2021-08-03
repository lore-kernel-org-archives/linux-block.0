Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCD6C4338F
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 00:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E7960F11
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 00:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhHCACV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 20:02:21 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:34667 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhHCACU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Aug 2021 20:02:20 -0400
Received: by mail-pl1-f169.google.com with SMTP id d1so21625879pll.1
        for <linux-block@vger.kernel.org>; Mon, 02 Aug 2021 17:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MlgF8i/HAWnSeKCOQX5+hUiM7nmM5Orv7QOIjqfuSQY=;
        b=OF9JJlEWOXaZew6tSCLOyhyf2JY//I5R+zjIk4DXBPnvNWydGhdPYkM69pXYD83Qg7
         bFdKbJDGy8j5aSP+nc5dVzrxzVEZvcXm6KJcritcbSsY5FJrbYoUzM0ExUv7GFQBADcA
         vktC4HugyNkj/7u5QjrkCrtY/TZvxoA5PoHyRFBag4bYLNlx63+mmWqk+1XmFjtBZKlS
         QfAXj1vdu29tP5B8UviMl4ZwTEZB4R24NO2Qb/UPc7m7cTu1nAtk9iwkWDTZxBZSIrBc
         FRfoSjb8kD7C5QMQHa53j0eTVUtpTr3LsCWCkfNUAHWmyEWaA/rpftqXWTuJwVB3/bIi
         072A==
X-Gm-Message-State: AOAM530b7Ty3YLsWmujjpFnUavLqRkuoOkG2ZlbRdSqhR/gN/xeV/+oi
        TLDi+G3vmFClfMFF9e+8384=
X-Google-Smtp-Source: ABdhPJyGpl0Cua4jASy3GXh3en7V45+mScQKL0pEEYfP5+vjYpCcih5xexHFBO2ZZMTuOMpljfQLdA==
X-Received: by 2002:a17:90a:4481:: with SMTP id t1mr20051467pjg.232.1627948929252;
        Mon, 02 Aug 2021 17:02:09 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:bca4:545f:af00:8cbe])
        by smtp.gmail.com with ESMTPSA id s7sm12712988pfk.12.2021.08.02.17.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 17:02:08 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] Two loop driver patches
Date:   Mon,  2 Aug 2021 17:01:58 -0700
Message-Id: <20210803000200.4125318-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

The two patches in this patch series are what I came up with while testing
Android software. Please consider these patches for inclusion in the upstream
kernel.

Thanks,

Bart.

Bart Van Assche (2):
  loop: Prevent that an I/O scheduler is assigned
  loop: Add the default_queue_depth kernel module parameter

 drivers/block/loop.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

