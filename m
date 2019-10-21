Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4347ACA9EB7
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 22:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B6A20882
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 22:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbfJUWnI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 18:43:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38427 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJUWnI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 18:43:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3so8686743pgt.5
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2019 15:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kH6arMtNKhExAQtmx+B/ga34kxbYtksoL7+f/odhzAo=;
        b=k3vk8cZREe6Y5YF9OM62KK8nARXffDtkvOMx6R9xPJqBA6wyo+CObuAuRF/kKfxnhs
         jc0mINEo5rVnMOt5isCOxjMPytkBn9hqZfresHHdKZJcmR50w0oxLe+x4RedBUrKyyNK
         jQRo2ZgnXwPYNXGDuHMNlm/ZnsF65vqpfN2HCLuggncUSrxtAbVamvvUvAdNg1iM1wtz
         aDYviEN6Df06Zy5bx5Mkh3oibVQBm12VeVQO7xoEJ8xSxYcs4/ROe5Nq9xmcrBG6Ooe1
         PTHA6j7kmKR72ihRwW6Tj3R+RhuycaCr7lixaebxY0AuAYnkGABf1UECAhwFB8r2gGuo
         wW+Q==
X-Gm-Message-State: APjAAAWh7kWxsY9k06TZwu0e8Xl5LHqf1PPWm9/NyQ+LUMclEBwAYBwT
        4DxY8R7nXy9vkMal7k+QvQ0=
X-Google-Smtp-Source: APXvYqxu22ftwVOeFHXKBFRqIfeISWgt//PMqeTzZsrK/3ofmcaUADIAD3+TZ3Nj2rWoV2MjIDXqkg==
X-Received: by 2002:a62:38d5:: with SMTP id f204mr470676pfa.75.1571697787688;
        Mon, 21 Oct 2019 15:43:07 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u9sm15944763pjb.4.2019.10.21.15.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 15:43:06 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 1/4] block: Remove the synchronize_rcu() call from __blk_mq_update_nr_hw_queues()
Date:   Mon, 21 Oct 2019 15:42:56 -0700
Message-Id: <20191021224259.209542-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191021224259.209542-1-bvanassche@acm.org>
References: <20191021224259.209542-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the blk_mq_{,un}freeze_queue() calls in __blk_mq_update_nr_hw_queues()
already serialize __blk_mq_update_nr_hw_queues() against
blk_mq_queue_tag_busy_iter(), the synchronize_rcu() call in
__blk_mq_update_nr_hw_queues() is not necessary. Hence remove it.

Note: the synchronize_rcu() call in __blk_mq_update_nr_hw_queues() was
introduced by commit f5bbbbe4d635 ("blk-mq: sync the update nr_hw_queues with
blk_mq_queue_tag_busy_iter"). Commit 530ca2c9bd69 ("blk-mq: Allow blocking
queue tag iter callbacks") removed the rcu_read_{,un}lock() calls that
correspond to the synchronize_rcu() call in __blk_mq_update_nr_hw_queues().

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8538dc415499..7528678ef41f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3242,10 +3242,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue(q);
-	/*
-	 * Sync with blk_mq_queue_tag_busy_iter.
-	 */
-	synchronize_rcu();
 	/*
 	 * Switch IO scheduler to 'none', cleaning up the data associated
 	 * with the previous scheduler. We will switch back once we are done
-- 
2.23.0.866.gb869b98d4c-goog

