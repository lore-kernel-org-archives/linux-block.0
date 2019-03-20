Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD70C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 20:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6DF21873
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 20:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfCTUSx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:18:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45382 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTUSx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 16:18:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so2576621pgk.12
        for <linux-block@vger.kernel.org>; Wed, 20 Mar 2019 13:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=umM+vb0S9fzaz8XDr8knGw9xI1I151VcD0bnvbVERSI=;
        b=S4zc+Orl8SUi4T5lMvr1nYXCGToHFR0HTTbf9Txamm5J1PRhRo0u4uAgUdB5CcswcL
         YThQeQKODN1+JVzaJy2OTAFlQGAaa9ZDRhAb3dnelQMyX7oz195jSp/frVD5ROaHW7uH
         NIS7WMaVw9Ujfjzq9vI9t0+g//8C4q14gzp7IFS/QTz9TwXaqGjeHRr+5qPSMPkrbIWz
         CQqx2X1YNR87kbKDgJ/e6KmjE7yuOboDHnBX/4J2uhSJSsbfcRE4JXrKMZv58D59d7jO
         lStiorfYqbrBAkUIXwZ5x2bIiFs7PePdtr2PKQj6Q4ToUIG4OaSGReCBuxm4ZAXmoEEI
         EATw==
X-Gm-Message-State: APjAAAX7DJ3pblK/+m2cKXz75dljQLEHMNH3OrEOHcT1mFynppPicit9
        c6E8Gu/DtjgLELFNfWJ+7Hw=
X-Google-Smtp-Source: APXvYqyfOB0BPbLxYpEO1ZJqYud4YMDs/9E2ZImKcHNSCK3WNB38426AMqJlk5E47xMacj3cXyhuNA==
X-Received: by 2002:a63:5c66:: with SMTP id n38mr9072334pgm.15.1553113132646;
        Wed, 20 Mar 2019 13:18:52 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 184sm3877027pff.149.2019.03.20.13.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 13:18:52 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] blkcg: Fix kernel-doc warnings
Date:   Wed, 20 Mar 2019 13:18:45 -0700
Message-Id: <20190320201845.39595-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Avoid that the following warnings are reported when building with W=1:

block/blk-cgroup.c:1755: warning: Function parameter or member 'q' not described in 'blkcg_schedule_throttle'
block/blk-cgroup.c:1755: warning: Function parameter or member 'use_memdelay' not described in 'blkcg_schedule_throttle'
block/blk-cgroup.c:1779: warning: Function parameter or member 'blkg' not described in 'blkcg_add_delay'
block/blk-cgroup.c:1779: warning: Function parameter or member 'now' not described in 'blkcg_add_delay'
block/blk-cgroup.c:1779: warning: Function parameter or member 'delta' not described in 'blkcg_add_delay'

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-cgroup.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 77f37ef8ef06..617a2b3f7582 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1736,8 +1736,8 @@ void blkcg_maybe_throttle_current(void)
 
 /**
  * blkcg_schedule_throttle - this task needs to check for throttling
- * @q - the request queue IO was submitted on
- * @use_memdelay - do we charge this to memory delay for PSI
+ * @q: the request queue IO was submitted on
+ * @use_memdelay: do we charge this to memory delay for PSI
  *
  * This is called by the IO controller when we know there's delay accumulated
  * for the blkg for this task.  We do not pass the blkg because there are places
@@ -1769,8 +1769,9 @@ void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay)
 
 /**
  * blkcg_add_delay - add delay to this blkg
- * @now - the current time in nanoseconds
- * @delta - how many nanoseconds of delay to add
+ * @blkg: blkg of interest
+ * @now: the current time in nanoseconds
+ * @delta: how many nanoseconds of delay to add
  *
  * Charge @delta to the blkg's current delay accumulation.  This is used to
  * throttle tasks if an IO controller thinks we need more throttling.
-- 
2.21.0.155.ge902e9bcae20

