Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8A3C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiFWTBP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiFWTBB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:01 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EBA10CD3D
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:15 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id c4so2629850plc.8
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=knKlLEHn8hCQZqUlhnKOmaPVcm9Kj1Qvvc0B3u5dn7k=;
        b=gMiy3BcB74D/vlnXXFd9f7FnQMXyftmTm/UdUP4Ty9TIJzn3EhexQJz6C3WkCpJFX1
         JcDXk5jPdNtQULm962jFmaWYMxrJskt4GCvSbdwNEvvICcAmAvr4Kmtym7DOOGHvyscB
         jBjCUfli+iCAX+wuIpFwcFdfsU0B8c/ryjA38zntwpVl3ra34pdkLfrNesbfHLzXY9cG
         z69fhHu6Me/z5AZ7CKiAdrTvLVWVk9T+2oIrqQIpKCel8gNmpT0vEgHSLneQs4p5H9RX
         PY2S/6bR4fZCLYBvDso1j57N24IbBXuCFe6O9KKnSuroT7Xi8Cvv+aOVQl6iiBsU0O3S
         oZWQ==
X-Gm-Message-State: AJIora/pBb4e9jeQCLzG3846Ba6LF8yXDlDpba3obtiAjw13IEE7N3M6
        1fvTft02mZAPkpqdg1LUI94Pj//8mc4=
X-Google-Smtp-Source: AGRyM1tSUSrwG2L1MiP3cVPUMGE/LaPCVISebC4m3AEZI/A5+T0QGQpbwVRhh1MK3gutcW1fTZZLAg==
X-Received: by 2002:a17:902:d4cf:b0:16a:3027:b286 with SMTP id o15-20020a170902d4cf00b0016a3027b286mr17447968plg.142.1656007575319;
        Thu, 23 Jun 2022 11:06:15 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:14 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH 26/51] md/raid5: Use the enum req_op and blk_opf_t types
Date:   Thu, 23 Jun 2022 11:05:03 -0700
Message-Id: <20220623180528.3595304-27-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags.

Cc: Song Liu <song@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/raid5.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 5d09256d7f81..b11d8b6a2dc2 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1082,7 +1082,8 @@ static void ops_run_io(struct stripe_head *sh, struct stripe_head_state *s)
 	should_defer = conf->batch_bio_dispatch && conf->group_cnt;
 
 	for (i = disks; i--; ) {
-		int op, op_flags = 0;
+		enum req_op op;
+		blk_opf_t op_flags = 0;
 		int replace_only = 0;
 		struct bio *bi, *rbi;
 		struct md_rdev *rdev, *rrdev = NULL;
@@ -5896,7 +5897,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 			(unsigned long long)logical_sector);
 
 		sh = raid5_get_active_stripe(conf, new_sector, previous,
-				       (bi->bi_opf & REQ_RAHEAD), 0);
+					     !!(bi->bi_opf & REQ_RAHEAD), 0);
 		if (sh) {
 			if (unlikely(previous)) {
 				/* expansion might have moved on while waiting for a
