Return-Path: <SRS0=Lvn3=OC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB262C43441
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F6B20865
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 18:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PNrCgJqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F6B20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395303AbeKXFTw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:19:52 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36971 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391577AbeKXFTv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Nov 2018 00:19:51 -0500
Received: by mail-pg1-f195.google.com with SMTP id 80so3379012pge.4
        for <linux-block@vger.kernel.org>; Fri, 23 Nov 2018 10:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xoHXsz5i1U24MlbYVPJenFoEGlB/YU7byvbkdX2oJsY=;
        b=PNrCgJqwBBKX+K+gMDO2afHWKPeSztXiTdqTpQLl2ZDQAHxXgClD12avT+AU8t9FIt
         uu9Zpth+pqBk9nZkRs/kxGXAD6sOJgKTfrkl1d6rX8Wu34J5BpB52OQMvU/MHt0IRnFv
         KqfjGeUqeIgdruNms2/K8vFcF5+kFp+E3VlYkfoOsg/yUDufhp6dnPxpHXRMuCqmLyKQ
         mA/kzsWE/4SOxqhJEbndikGYrmr42WvD1+h4JosJDl3jNcOqUbEF9Q6fDE5DwWeXVNSB
         WySjIMAOz2x9bayJ6lC825P80xGOTng6uKVYdWZXyUrpOEp9ySNJs8Ylh1ZOrIOL7t1L
         i3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xoHXsz5i1U24MlbYVPJenFoEGlB/YU7byvbkdX2oJsY=;
        b=KH1UwW08BVvq7RT2i0P93KbwBwI+PvWAOJ3hkJttmrVCGb9BdfOR84iqOgHV/xlbqf
         qTvqKi/8Xb8HRXeUcipEWy7DsjirLqnLOV2f/DpaWinthVUZxvpMxQLs6BJuqHpDFWmZ
         9SB8fgM8Y71N0Z8sq5d3I0mqjVteCnTQP+Z/uWT5v3sc56roPBoOouInF8aUgRswpxQ0
         yKVPIpdD9XOz+Wt4mGOavEEz4CpE6z862j3ckVVxkxSQdb/kDKA5FzYbGhUa5TB6C1j7
         8sDlEgonZn5zo+/ixbJrdk9H523gKBbMvB958sruPjHxyeY5DgPVil6+MN4HdBpl18aH
         rpWQ==
X-Gm-Message-State: AGRZ1gKa5UhHixe2m1dGvQkOJol/VShf3H35D99FE4f9w1f/MexUvi2V
        ND9aKJ7j1mvlN+EVEB9/qlO+WDc2UcE=
X-Google-Smtp-Source: AJdET5ejkCdg6NJcUI8WeDPYfubq7oMGfmO0yFl7Bi+nrpST3Do2reFtHrgICGDAbOnSCX0MexAEdQ==
X-Received: by 2002:a62:5d0c:: with SMTP id r12mr17615236pfb.0.1542998065654;
        Fri, 23 Nov 2018 10:34:25 -0800 (PST)
Received: from x1.thefacebook.com (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s37sm52294260pgm.19.2018.11.23.10.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 10:34:24 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/6] blk-mq: never redirect polled IO completions
Date:   Fri, 23 Nov 2018 11:34:11 -0700
Message-Id: <20181123183411.8708-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181123183411.8708-1-axboe@kernel.dk>
References: <20181123183411.8708-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It's pointless to do so, we are by definition on the CPU we want/need
to be, as that's the one waiting for a completion event.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ba3c7b6476b7..37674c1766a7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -585,7 +585,12 @@ static void __blk_mq_complete_request(struct request *rq)
 		return;
 	}
 
-	if (!test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags)) {
+	/*
+	 * For a polled request, always complete locallly, it's pointless
+	 * to redirect the completion.
+	 */
+	if ((rq->cmd_flags & REQ_HIPRI) ||
+	    !test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags)) {
 		q->mq_ops->complete(rq);
 		return;
 	}
-- 
2.17.1

