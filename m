Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE8EC282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 19:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A845C2184B
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 19:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="DWPbwRHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbfAWTGQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:06:16 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:41223 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfAWTGP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 14:06:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references:
        content-type; bh=pXF6AjWEHgclyKhf3oOYHLUnR8WiNdMoDHSApKS/jeY=; b=DWPbwRHGHQMg
        /f/A8MICTQwNPpYyz+LmqGmnpNWuFhbwf6/LRzX6Zs/BFpV4Xg00vl5xObeCtQoK6b0ndC/t3h9VV
        lgx8rS6UICNy/zXD64KWnaWhELFdaHBhyalEVx8WzCGMXqVtAc79kvSPndhgN2UyPUpsZBRFc82RY
        cxnqeRvAYQD2bG8VkrNngapnF+yPtnhHskO5LX+NlcXx6c4qsm57bZrj+UuPg7T544AWEdNAAZc9b
        TQM9ZPc8a71HLOOeANam9m4lXcCBnKy7aPE9FXSKnE7QFBkR33hDkukksbO8yTvQQs0dLZBCcAK4s
        iqXA0uocXE1Z5E/kuOZ5mQ==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gmNql-000GYL-Gx; Wed, 23 Jan 2019 20:06:12 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 2092EC05BA;
        Wed, 23 Jan 2019 20:06:04 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] blk-wbt: Declare local functions static
Date:   Wed, 23 Jan 2019 11:05:57 -0800
Message-Id: <20190123190557.118894-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.08)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5rDCEEfHMYGNpZHE5in9s21602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTaOqZpfO3PVJjdazu3l6Zm3CrxbKqqxVb1b/D8J7mjn9lDh
 ZuDehiH2YklRjLmWtDSmAEYI57h2mKAXM6QK99xqZOFbSD3u8HyLgGOQKCi94ZirvAF3OqvQ/d/G
 LtUd5hzilbHtbFYVmmyNP/jzd7CC6hBx0MWsIqDBZyeY119Okv3hl8yPfPdsT0UPQvdnVMP9qe3I
 Twa/UrnO17H8sjMk0wiB5Hyfbd+MEJoOqabVUmvDy59pzP1iosV0DNWOAjsB3T+hOyzW0bl+/QV8
 RdKS1l2gNs8W35/Lu5lkBAh2g5urZeOoRlS3fa6L1M3ELxSuY5C7qrMgUVevVCUo+QQVT1zD59o8
 cPYKs494BBiYWXB0LnlSAmZGKlGh+832sR/U1GxR3NZrDHp1fQ0nwHO331/E3ahF5MMcDI7KdpjQ
 KaVgSv3s297vjqLnIk+BzsgvP92yJqFDUMWgYkYfhC800CNhDhZZBbWXRP9DmYCFHAulXE/lgVmD
 l+C55ct/osocMnvUlJcqRSp+qxOrAQRQ6J1fhOzjF0b4LXcjJZ5loth3gASW7MfTuzXCmihGzpbi
 e5mtF/tsyLRZFHqln6dZfHjjgY7JNIk9GLSWNMRS2MeJG46Ak/W4t/4kLAP1dOY/LfL7gmLD8aOy
 aL9692JjJ/MO+TGI2hIzk/Zr8wI+f3KQ/ZeiWgrc/26+18642nXKATDDBZ7fFc0FDw0l2bg+Pz9j
 dpz4c73qn3IomnaPKdqqwW8OJYT7g9X95w+XsBeSa/brvme1u7G+zX75v4WUhb5rHHYPM2/wE2Wz
 JpWf5bwKcfIpPo3vv82R1c8NXqvdRWSFfvxlx1m1Ym2uLiVd8SvdW1dCll14oDe0jOuGmtEyvDkN
 3AfUBddcu9g0Uhw2BnTTFGX5/yI4Ky+1ZJcbisse6dD2zodquQzBPplKqs2wWVbjHO/cpJpsYlvF
 hM9K4zU87RPKmpUSkSG4ytdGODUE44iWpa+JxtJuE1U7eojXnY/uzNutdsWDREzP4w4=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch avoids that sparse reports the following warnings:

  CHECK   block/blk-wbt.c
block/blk-wbt.c:600:6: warning: symbol 'wbt_issue' was not declared. Should it be static?
block/blk-wbt.c:620:6: warning: symbol 'wbt_requeue' was not declared. Should it be static?
  CC      block/blk-wbt.o
block/blk-wbt.c:600:6: warning: no previous prototype for wbt_issue [-Wmissing-prototypes]
 void wbt_issue(struct rq_qos *rqos, struct request *rq)
      ^~~~~~~~~
block/blk-wbt.c:620:6: warning: no previous prototype for wbt_requeue [-Wmissing-prototypes]
 void wbt_requeue(struct rq_qos *rqos, struct request *rq)
      ^~~~~~~~~~~

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-wbt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index f0c56649775f..fd166fbb0f65 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -597,7 +597,7 @@ static void wbt_track(struct rq_qos *rqos, struct request *rq, struct bio *bio)
 	rq->wbt_flags |= bio_to_wbt_flags(rwb, bio);
 }
 
-void wbt_issue(struct rq_qos *rqos, struct request *rq)
+static void wbt_issue(struct rq_qos *rqos, struct request *rq)
 {
 	struct rq_wb *rwb = RQWB(rqos);
 
@@ -617,7 +617,7 @@ void wbt_issue(struct rq_qos *rqos, struct request *rq)
 	}
 }
 
-void wbt_requeue(struct rq_qos *rqos, struct request *rq)
+static void wbt_requeue(struct rq_qos *rqos, struct request *rq)
 {
 	struct rq_wb *rwb = RQWB(rqos);
 	if (!rwb_enabled(rwb))
-- 
2.20.1.321.g9e740568ce-goog

