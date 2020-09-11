Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE40C433E2
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 21:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18FD822208
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 21:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oluSrePI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgIKVxs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 17:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgIKVxo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 17:53:44 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E559C061573
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 14:53:44 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w186so11405463qkd.1
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 14:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3JOgHWrldpIIP/5kC09ZNfXwFYBRhpOv4PWXdWSWudc=;
        b=oluSrePIM1+x/qTYmfYnZrqmV3fH8mrlbRXhznW5FqmxQQuqsgOoR6E+u4Pf0vjdXA
         b93NeKQt1QDN/pbh/6OmMNXTu+1Wb+oeWfDXM8bMRiEzRWSrDy/ddpv78E95iAddLm4j
         l6jz8at6fEldWzLO5HU0zgx6kuhncULj4WMkvx1qX/Cm6Q5neS/ZH98zEOLNAjcs0BH1
         fK529MO9D0YUF5uPCbScZKIoQu9D7FUgkIsa3mnn5TfWwWH9YD5C+M+7M66kpOIsTULj
         O8URAcLRaDhry5NqhfMNHRnG64TB3z5o5yaclHD4N2KFXhVjaOhp/d4AOL29KkRMihXk
         CXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=3JOgHWrldpIIP/5kC09ZNfXwFYBRhpOv4PWXdWSWudc=;
        b=EHAm2TEKYFamGYVdvCt3ytcPeJGf8oZzXJDNz3FOCBhdeLb67he7Bk2ohOS59ldmJb
         zkwf+bes+e25PPP99MsjEgY75oV8IDvcDcbqZofONz8iCOmWtgm+magzXmP/f69bFlxW
         sjJjSE3OxGOBlbUq8kJVAkG683IeA3s5IqJBgGBkWrHJF5evTYNfeyKdWz9TJET79H/6
         w8mtTK6Bj0RWCu9n4VYre2ZkORI7cWgtvZ1BuFf9k93mT1inRHfsFyZD+ngeBDaCxEgW
         VL2yL0PaKI3zgDFIRL4SAx6YE6xlqDLQ3hkSOnhOCa9bkFIOyYp6E08zdI35G3zeCJIS
         GH5Q==
X-Gm-Message-State: AOAM530A3fBmDWVWQ649zNxXeB+CPMr5kN8l0CezqWxSJvBwD3oyrcpT
        SF2obnrdMh3S7CtXHW/+ijM=
X-Google-Smtp-Source: ABdhPJx7MKEr+LuZWIHg7NFl50A/Y56dMJDfL7XBuz9M7ApQj9c84lidLRLcRoK2btAIhIspKOVKJg==
X-Received: by 2002:a37:6301:: with SMTP id x1mr3361585qkb.323.1599861223287;
        Fri, 11 Sep 2020 14:53:43 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id g12sm4043625qke.90.2020.09.11.14.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 14:53:42 -0700 (PDT)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: use lcm_not_zero() when stacking chunk_sectors
Date:   Fri, 11 Sep 2020 17:53:37 -0400
Message-Id: <20200911215338.44805-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200911215338.44805-1-snitzer@redhat.com>
References: <20200911215338.44805-1-snitzer@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Like 'io_opt', blk_stack_limits() should stack 'chunk_sectors' using
lcm_not_zero() rather than min_not_zero() -- otherwise the final
'chunk_sectors' could result in sub-optimal alignment of IO to
component devices in the IO stack.

Also, if 'chunk_sectors' isn't a multiple of 'physical_block_size'
then it is a bug in the driver and the device should be flagged as
'misaligned'.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/blk-settings.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 76a7e03bcd6c..b09642d5f15e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -534,6 +534,7 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 
 	t->io_min = max(t->io_min, b->io_min);
 	t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
+	t->chunk_sectors = lcm_not_zero(t->chunk_sectors, b->chunk_sectors);
 
 	/* Physical block size a multiple of the logical block size? */
 	if (t->physical_block_size & (t->logical_block_size - 1)) {
@@ -556,6 +557,13 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		ret = -1;
 	}
 
+	/* chunk_sectors a multiple of the physical block size? */
+	if (t->chunk_sectors & (t->physical_block_size - 1)) {
+		t->chunk_sectors = 0;
+		t->misaligned = 1;
+		ret = -1;
+	}
+
 	t->raid_partial_stripes_expensive =
 		max(t->raid_partial_stripes_expensive,
 		    b->raid_partial_stripes_expensive);
@@ -594,10 +602,6 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 			t->discard_granularity;
 	}
 
-	if (b->chunk_sectors)
-		t->chunk_sectors = min_not_zero(t->chunk_sectors,
-						b->chunk_sectors);
-
 	t->zoned = max(t->zoned, b->zoned);
 	return ret;
 }
-- 
2.15.0

