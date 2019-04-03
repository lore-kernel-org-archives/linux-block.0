Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4EDC10F0B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 20:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBD221734
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 20:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfDCULf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:11:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36387 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCULe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 16:11:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id ck15so7382168plb.3;
        Wed, 03 Apr 2019 13:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fbFb30DuL1WyFK9RqYkg9Uo0R4Ri3L7ljBbLZ+QBvKI=;
        b=UuUFFT+XMZbxtZu28RwTwYyWelr+Pbo8hpfiF+RNJYkbz6/1DHOL5aO4adeMbaHFaR
         VXv1J2atym1H/ZSjfYXdz7TG3EIPfXWK470kkUcGuws2v0BYWXt6gqozPw0OJOZyso8q
         ZL1rgAMnjULM26zM39O/gtrUq7HAUtvWyMm7ljvf99J3Vo0fhXdq40kvTlFYf4i3b8Iq
         CCD/xZWb8SpKrjy1JlBaU9yiXVBH30IL7SI2r70Id2FKegWy2DTGlvjrJ4Mtt8hcoOi+
         SlZUwC4SC/tbH779tPShH+AnnnB4J2kuUFnbhN9q2faqGj6sYhfyBqzTKorTydGZjBlb
         6biw==
X-Gm-Message-State: APjAAAVfSsFhppIhiKR0C5HQ4Ub5fxs0uxDCqfTrUuiPJLZGnvTyDw/5
        qDwvmJT6tgGImjmuv1O/tZE=
X-Google-Smtp-Source: APXvYqxO0cnQBHdHUuUMr6OSL4WA8oaIsH6uno/4gC9oSJ3EqTjRvxll/aOT4LuHX/7+8Bwv677Z/Q==
X-Received: by 2002:a17:902:2b87:: with SMTP id l7mr2065115plb.38.1554322293871;
        Wed, 03 Apr 2019 13:11:33 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id p7sm22707724pfp.70.2019.04.03.13.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 13:11:32 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Laurence Oberman <loberman@redhat.com>, stable@vger.kernel.org
Subject: [PATCH] block: Fix blk_mq_try_issue_directly()
Date:   Wed,  3 Apr 2019 13:11:26 -0700
Message-Id: <20190403201126.22819-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If blk_mq_try_issue_directly() returns BLK_STS*_RESOURCE that means that
the request has not been queued and that the caller should retry to submit
the request. Both blk_mq_request_bypass_insert() and
blk_mq_sched_insert_request() guarantee that a request will be processed.
Hence return BLK_STS_OK if one of these functions is called. This patch
avoids that blk_mq_dispatch_rq_list() crashes when using dm-mpath.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Laurence Oberman <loberman@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Reported-by: Laurence Oberman <loberman@redhat.com>
Fixes: 7f556a44e61d ("blk-mq: refactor the code of issue request directly") # v5.0.
Cc: <stable@vger.kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 652d0c6d5945..b2c20dce8a30 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1859,16 +1859,11 @@ blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	case BLK_STS_RESOURCE:
 		if (force) {
 			blk_mq_request_bypass_insert(rq, run_queue);
-			/*
-			 * We have to return BLK_STS_OK for the DM
-			 * to avoid livelock. Otherwise, we return
-			 * the real result to indicate whether the
-			 * request is direct-issued successfully.
-			 */
-			ret = bypass ? BLK_STS_OK : ret;
+			ret = BLK_STS_OK;
 		} else if (!bypass) {
 			blk_mq_sched_insert_request(rq, false,
 						    run_queue, false);
+			ret = BLK_STS_OK;
 		}
 		break;
 	default:
-- 
2.21.0.196.g041f5ea1cf98

