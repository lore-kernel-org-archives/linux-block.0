Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3234DC433E1
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 08:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F181D207DF
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 08:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="xxKI/AoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgHUIfl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgHUIfh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 04:35:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080BBC061385
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 01:35:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so576977plt.3
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 01:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=uM8XTPXbXUSgKL+AdmDHI3+bK/7/vjMa5gRmlkFhVPk=;
        b=xxKI/AoEFClsAFT8hsyc+twgVUDv9WfHZppdkfz7hQpnaSFzoJw51aD1lGH3aFUos5
         qOreU3P1uSoD8RksQJP5uIZUgYL3WZyxrtugs+jCF66GrOwzXt1RCyYBOxb47oBXwwZ1
         gjCftCCOxiq3ep/Fis0GTJMvJBShffgzCHNmmg0N0Labm3qrPFMt1+lJJynslVvTxeho
         OgkkN2/KmmSAwcwRL4Aqodi9NNUijI5aAziGYODVF7OW+uGWt9ltXjCILs3iTnB8l07V
         e4F5I5jQ9hSa+hLn3A4S+bDeENkVy/xGAYr50aN8OmNdFhtKEmPfSJni+iA60IOEa6M4
         p45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uM8XTPXbXUSgKL+AdmDHI3+bK/7/vjMa5gRmlkFhVPk=;
        b=ReW8mSkWj5STUfwRTPG6o5/X8KJhkJ/Mk7HpCKpkKOBcArRL9BGbGl7S02j+/xYjrT
         hmhiobOHzK25YVvcC4rODpCRMrVHLnLUMRkA/hD+S6Mgx1oONqIQ2Rbvuv6XbmoUBtTW
         aU1qtBR60dS3qGBd3vbhr6J6KTWjJrhmuKXFFFZqqeiuRg1Hg5lLeoNg/BVtRkWHnXHS
         vmQHV97LU3aj6bw8fjO9nz+Wf/UxIyBptzIod/1CdKwliRLLXHXW6ujfzolTLBrNiF04
         eH0BDEkKspxqXHl7VvHXoqZHSg7nPk4byar39RtWTBVqI5sJaQK90fsMV220+3wH3gvC
         p4kg==
X-Gm-Message-State: AOAM5325ajCmmwr8iE8itaC2NlIOHcIbDga05fgvSbOKI3/nAKvx19MQ
        9z7gCRJBXE+p58Q4W/ZgwwTZpCxMbwqVzA==
X-Google-Smtp-Source: ABdhPJwe3evCZLkLzqOeSJedIzZWh93EvT0oQftZfTL+kRpBbEIqu+nIqDFwUgJNk7A5oW7310vybA==
X-Received: by 2002:a17:90b:384b:: with SMTP id nl11mr1539602pjb.91.1597998936504;
        Fri, 21 Aug 2020 01:35:36 -0700 (PDT)
Received: from debian.bytedance.net ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id z29sm1657473pfj.182.2020.08.21.01.35.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 01:35:35 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Hou Pu <houpu@bytedance.com>
Subject: [PATCH] null_blk: fix passing of REQ_FUA flag in null_handle_rq
Date:   Fri, 21 Aug 2020 04:34:42 -0400
Message-Id: <20200821083442.10268-1-houpu@bytedance.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

REQ_FUA should be checked using rq->cmd_flags instead of req_op().

Signed-off-by: Hou Pu <houpu@bytedance.com>
---
 drivers/block/null_blk_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 87b31f9ca362..8cf13ea11cd2 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1139,7 +1139,7 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 		len = bvec.bv_len;
 		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
 				     op_is_write(req_op(rq)), sector,
-				     req_op(rq) & REQ_FUA);
+				     rq->cmd_flags & REQ_FUA);
 		if (err) {
 			spin_unlock_irq(&nullb->lock);
 			return err;
-- 
2.11.0

