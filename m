Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97042CCA47D
	for <linux-block@archiver.kernel.org>; Mon, 13 Jun 2022 19:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347210AbiFMTCc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346299AbiFMTBg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jun 2022 15:01:36 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367692E0A2
        for <linux-block@vger.kernel.org>; Mon, 13 Jun 2022 09:32:43 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id x138so6174529pfc.12
        for <linux-block@vger.kernel.org>; Mon, 13 Jun 2022 09:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rTQVyhwCnQC25ttNunfcKpyJXAHNEa8jAIPenZqJ3XY=;
        b=HjlCAJu5myiaKwtE0IleRBw+iOZDRgk/NHyWFs+znyscbifMVMc8DYY8eR0zXJekGT
         PMFBnX4VfL+l5zaedtrYY8S+kjoMJyrMpM7Xd81gsw397l3Ex8401UJMKEbIzYmWKqEv
         nBJdPPAhqesmMqKiOSYVGm/qiKuG9gA38k83GemoXjjdKJuUfBc15NjMDahJx4qAqAbZ
         bAUMaM6vIdwT7wvv/vYzJnkApyQ1ugLkPchVIkkLDauQ0S355V/UdctCDiT/jr1B5Is2
         /5XTviIY8YBv2P8Rc1/pcaSVThstIAdSWPhM13EVwoXXBmfHqi6DBjPGdg94garRykHF
         HfZQ==
X-Gm-Message-State: AOAM533triiKlZY2UEkJChOsxTAH8yEa2JVI/2Fjwu83l2Ga0zGOvgLT
        WoSXt9r0yWMWLvtAlHvGeko=
X-Google-Smtp-Source: ABdhPJw5a+s+mO5o3DNsFd6kcQ43Btvg57dgx4HRGIXqlUodIx5GPn3ztTmiySAuptBYWn7sWK5vjw==
X-Received: by 2002:a05:6a00:4503:b0:51b:de97:7f2c with SMTP id cw3-20020a056a00450300b0051bde977f2cmr428284pfb.12.1655137962511;
        Mon, 13 Jun 2022 09:32:42 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:6862:a290:1a09:5af5])
        by smtp.gmail.com with ESMTPSA id n11-20020a056a000d4b00b0051b9d15fc18sm5595995pfv.156.2022.06.13.09.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 09:32:41 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Cixi Geng <cixi.geng1@unisoc.com>, Jan Kara <jack@suse.cz>,
        Yu Kuai <yukuai3@huawei.com>,
        Paolo Valente <paolo.valente@unimore.it>
Subject: [PATCH] block/bfq: Enable I/O statistics
Date:   Mon, 13 Jun 2022 09:32:34 -0700
Message-Id: <20220613163234.3593026-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

BFQ uses io_start_time_ns. That member variable is only set if I/O
statistics are enabled. Hence this patch that enables I/O statistics
at the time BFQ is associated with a request queue.

Compile-tested only.

Reported-by: Cixi Geng <cixi.geng1@unisoc.com>
Cc: Cixi Geng <cixi.geng1@unisoc.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Paolo Valente <paolo.valente@unimore.it>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bfq-iosched.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0d46cb728bbf..519862d82473 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7046,6 +7046,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
 	spin_unlock_irq(&bfqd->lock);
 #endif
 
+	blk_stat_disable_accounting(bfqd->queue);
 	wbt_enable_default(bfqd->queue);
 
 	kfree(bfqd);
@@ -7189,6 +7190,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfq_init_entity(&bfqd->oom_bfqq.entity, bfqd->root_group);
 
 	wbt_disable_default(q);
+	blk_stat_enable_accounting(q);
+
 	return 0;
 
 out_free:
