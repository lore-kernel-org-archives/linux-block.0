Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674A5C76186
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 21:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFE42147A
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 21:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbHzUbNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfGXVfc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jul 2019 17:35:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51488 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGXVfc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 17:35:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so43099689wma.1;
        Wed, 24 Jul 2019 14:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IEg8P4rVHcrzMYhNW3Mur+QDB3HpJjXn10bDzy/W1dU=;
        b=FbHzUbNIRJIGHu+HQ5A9Eh6R1q4UeAJh8+tWiwT08ohIPEMFxT7aVfx9zgzsQDD2fB
         KruNsqSXmMCdS9HO40PV7eAKwpEej7xONalYlw0+s1ICZinA049e2myqlSOggtQGPrNY
         umzJYNIiljkPZOSYVVN61ciuv7ul4tLI/vccY6R/K4+idnp0hYbBJVISZiCMOLIBnVZe
         tZ0QwZai8ddysrQ8HI/LZFmGg3edb6NvrU48w5bbEQHuMmqyIfe1opf3H/aSTKUinm6h
         yDOHdrqXmd9hjLBGHOU+ReHxZPJIx2c1qVs66EqTvE32zKy9DW/UkL2PckJHaGlswNxf
         rFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IEg8P4rVHcrzMYhNW3Mur+QDB3HpJjXn10bDzy/W1dU=;
        b=XhBJRatI82gKXyYvlRRdgGWs5xdhK5ihOR7fnovkuvTAcCc6mDz9ryUyvtduK8DJFn
         qV1Lch1LVtVO9LNYgWbi0qaM0zaKEtllzkDcMOLTt24V+UJ6Qot8y+fabxNHKuPr6IdK
         4GiuUZbQQqESoz/6F/PKaUe9gGec/rfa7cOkN13uKD1TR0xEeEk3b6LKHUwO+EWUZx4c
         odODl0cu2jhQu39Nn49lMXFSsAGpfs6MFWGiTUl+tl81Tjqd+OoO6HJv5dDCxsy/6Jfh
         INpuiq0siQ8EzSpn0RwJ2WegtRffYW2jF44LusetkgTmjB40n00EVbf7WREgekQDLOXy
         6d4g==
X-Gm-Message-State: APjAAAUQYTLQNjxVSoGalnx6wKHbhX0fxSixDMW/WXOpLYPcMujYkYvL
        CUMMMx13aT7ZNl0znrgc1Ds=
X-Google-Smtp-Source: APXvYqymZNM9wh4T1b+PC2J4rXPEdqjaxxAtVl8cEwb1iDURMmx3hTPvsO5YYbiqtbZ1LUihLIX6Hw==
X-Received: by 2002:a1c:a019:: with SMTP id j25mr75148878wme.95.1564004130210;
        Wed, 24 Jul 2019 14:35:30 -0700 (PDT)
Received: from localhost.localdomain ([109.126.147.168])
        by smtp.gmail.com with ESMTPSA id u186sm80799083wmu.26.2019.07.24.14.35.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 14:35:29 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, josef@toxicpanda.com
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [RESEND RFC PATCH 0/2] Fix misuse of blk_rq_stats in blk-iolatency
Date:   Thu, 25 Jul 2019 00:35:08 +0300
Message-Id: <cover.1560510935.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190724213508.ZT6fZWY1D5Z11rlPjdv3PiP7ca3Bv7uLRd5XzBstCKQ@z>

From: Pavel Begunkov <asml.silence@gmail.com>

There are implicit assumptions about struct blk_rq_stats, which make
it's very easy to misuse. The first patch fixes consequences, and the
second employs type-system to prevent recurrences.

Acked-by: Josef Bacik <josef@toxicpanda.com>

Pavel Begunkov (2):
  blk-iolatency: Fix zero mean in previous stats
  blk-stats: Introduce explicit stat staging buffers

 block/blk-iolatency.c     | 60 ++++++++++++++++++++++++++++++---------
 block/blk-stat.c          | 48 +++++++++++++++++++++++--------
 block/blk-stat.h          |  9 ++++--
 include/linux/blk_types.h |  6 ++++
 4 files changed, 94 insertions(+), 29 deletions(-)

-- 
2.22.0

