Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EA0C64E8A
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 01:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C67220757
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 01:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXCX/WZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgK3Bkc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Nov 2020 20:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgK3Bkc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Nov 2020 20:40:32 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB66C0613CF
        for <linux-block@vger.kernel.org>; Sun, 29 Nov 2020 17:39:51 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 64so13499924wra.11
        for <linux-block@vger.kernel.org>; Sun, 29 Nov 2020 17:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PoMKFPjbtgNPMUcjbVOC/M0oX60/gOzcfsIwbmJ0sQg=;
        b=BXCX/WZw45r/n8a18BpZjgrxKNrwLSvkE1lRapcE6hPE0yo5fEjW1rTnRhqi6PuOCY
         SMMHQq5RylKKO03MLeBb/qft075YwV+l9s6MT19sKGOcOHq4X9I7k+xKF84zws6el3b+
         emomKfCeY3oX3eSDqJ3Zby+ZOMtOtIe9Ygzn8KyTkpROk4RqJ+BPTs5hVarK+92WQhYO
         JsMiUKzLF3hDawrTikGBbLJNxBhJa+gGPbM1L6mO05yUFxB9e1kmnoHI3W8zqCQX3/Sr
         UkOx+FYvWDixUM0PH/d3nsAeYtUNbzO9QhW0FHe+0OBJuARtMBvOQkC/R8zvGqDpNo/+
         8dJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PoMKFPjbtgNPMUcjbVOC/M0oX60/gOzcfsIwbmJ0sQg=;
        b=tgDSdPKSAopTv14NNk8BgUYLkuWNpmQFoxQHZ1CQLQm1AeBtjf6snLQyu+M17QChVL
         4Yf/c00LetrfzmpvOdhoJo6hDnav3hVssxyp0wpmEhtBg2g6c7Dgz3UHLnm5ZPNjl2LH
         5QTbdC8fj5qCoGyjLrcK0vCKE22wkdxrSpKnK+yckRiYuWNT6DodbT1UdVqNkSJpPVrY
         RvaFy70k74eYFsiFB+lE3kx5FHopMUFdD6aCuy8kK/mMPGf0uOYXOZXV26D1MgqzhMoF
         PuQZ59cBIPLgjLao2bJvoKF0qRBkhfbXg/86qQidx6pToX+PWYU/yNxoPDV/iw+ugzLd
         Z/Yg==
X-Gm-Message-State: AOAM530sdn1GKdVWVnY2rZBfDc7NQ+ZIm4ApgUtmxSPeOUdCxlsvcFJV
        RWbz8rA/h+/czhKMeo16HB378/d7+TA=
X-Google-Smtp-Source: ABdhPJx3+9pJ8uRBs4Z7LwpDckJjH4SX8vp35xpLVwNOanCwFGMO4aPEIqgR9YfS3W0EoYQwF8d0eg==
X-Received: by 2002:adf:c844:: with SMTP id e4mr4392300wrh.345.1606700390479;
        Sun, 29 Nov 2020 17:39:50 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id k1sm24573414wrp.23.2020.11.29.17.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:39:50 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 0/3] cleanups/fix for blk_mq_get_tag()
Date:   Mon, 30 Nov 2020 01:36:24 +0000
Message-Id: <cover.1606699505.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[1/3] fixes using tag_offset of a different HW queue. May only fire
if it's allowed for queues to have different breserved_tags or a resize
happened while it was waiting (can be?). Two others are simple cleanups
catched the eye.

Pavel Begunkov (3):
  blk-mq: use right tag offset after wait
  blk-mq: deduplicate blk_mq_get_tag() bits
  blk-mq: idiomatic use of WARN_ON_ONCE

 block/blk-mq-tag.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.24.0

