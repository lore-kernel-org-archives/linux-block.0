Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19FAC43334
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 18:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiGOSrp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 14:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiGOSrp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 14:47:45 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA8D3DBD6
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 11:47:42 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id b9so5349438pfp.10
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 11:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DB6bMVaMJxrTpyC3Q10Lv0925V/oNDa826Zeow6Wsh8=;
        b=X5rVGR5qotM8vx/msDTHgxAr5J5HQOrMpXvLuwVZM/GOa3AX1UqkJ9wcGgERkWWl9N
         nvh64nMVhfaAQ7oRck7i/01rRjQaaxHCtuvGxkuuGZT6/aEEA65fzwHCNY/S4VByMRf0
         KQZVVm7H755IJE4cEXx3/jVkic+3U5DgHAtApQl0MGR9kSWdO/0+uIuFcpFFF9rIcyzb
         K1slUrpkQTHYWGtTQyHW9owMzCQTnlxPaPyZheEDpEABjw/j3UezRuLHCrThLIA9lskj
         AJXoUUaMwNUVW5jlj+okiT/YdRdkBN+YlV3dj2EC8kZ5AefYvAMdmWVoOOZDoka5pFtd
         1yLQ==
X-Gm-Message-State: AJIora9sDY24nUhld4Ay7vLJIwNHCPKY7WCGiezjSrH65xmF4twR5iee
        /k08pj9sjC/T8vTJHffu4wcJbAFYngg=
X-Google-Smtp-Source: AGRyM1v4WkdSWp9Jil96DRHTnIqwdr0e5kttvyqgJTeTI1BuYLBNz8hxgJWjimIBHmE1PkkzJX0MAA==
X-Received: by 2002:a63:9049:0:b0:412:b11b:c630 with SMTP id a70-20020a639049000000b00412b11bc630mr13262632pge.175.1657910862156;
        Fri, 15 Jul 2022 11:47:42 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2e39:7b26:bf0e:fb58])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b0016c2cdea409sm3880490plc.280.2022.07.15.11.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 11:47:41 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] Fix recently introduced kernel-doc warnings
Date:   Fri, 15 Jul 2022 11:47:33 -0700
Message-Id: <20220715184735.2326034-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series fixes two recently introduced kernel-doc warnings. Please
consider these two patches for kernel v5.20.

Thanks,

Bart.

Bart Van Assche (2):
  fs/buffer: Fix the ll_rw_block() kernel-doc header
  blktrace: Fix the blk_fill_rwbs() kernel-doc header

 fs/buffer.c             | 5 ++---
 kernel/trace/blktrace.c | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

