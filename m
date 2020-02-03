Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE608C3524F
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D022080D
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vJ9AQJrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgBCKlc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:41:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36558 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbgBCKlZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 05:41:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so16324998wma.1
        for <linux-block@vger.kernel.org>; Mon, 03 Feb 2020 02:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rzt4yAe3s0HBIE04/HczDDOIa4+f9r0CEH+uqzj+BDc=;
        b=vJ9AQJrI1BNhzha7OjhKAOLAwHr7Z+z7FaHE/TXavIB7TfKhs9SQePDc2R8bFtgs5t
         EVbMjFiIuIUfZfkHbLplmpieXt33rdSbtnVu2O5C1fizzkCT2brbn8/q6LwbVoW9e5wM
         imQ6Iwpzi1DfRuI0WZeC64+tvO8CUs2ymRxKzvpcSPOg8sPQb0PXKDg5kIRNfqVaGVF/
         vw/nf6lnJ/5Ct4JrxcB4ocm+V8w1/Bp7p5AFAOZlMFFJ9yc+Y0TYrpfSalLil7S35uEl
         aQ0L2yQ+h9FEpQWcgR2Avz0qbvo+YbTk303y2qWju+6m8ioFjRclKCzJTXqUywsfzasl
         ci/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rzt4yAe3s0HBIE04/HczDDOIa4+f9r0CEH+uqzj+BDc=;
        b=Ada8G2InxXrmCFQyVM1d2pCp/aGbfCnERsMdnozsVRk33URwEqykFeC7waqVfpfL+7
         mfJXmNCOMsD4WLpnmdFxPz987XfHEMyH9SKEM5D76du6VnAzm1SXHk/lHGqAuJYKrr/+
         Uq6D65Bdwx7/Zc9RW699DrOhHuSdDUeiAWpYuT35GKNz/lSn9Err49qDfjG7ALyJXvBq
         jvj3+9fBDXzr1qH+Uh2nofrh3qAkaoSXUXWs6At7X6xO/IwFn+iFGJswuIs6oTv2krDZ
         CDYd+MLBjAcJQqem5oiokhdpz+lu906ZV8XK0JvX1LV4YlgQ9NrEejU9B8Wxnv33HC4g
         n6Eg==
X-Gm-Message-State: APjAAAX5bjpMzHIaihHwtd2SdgAB12nKwp6LvodZSE1i0M/e5hEPbga9
        uRtMZYLqFTkYHOg3F/7TLc5gzA==
X-Google-Smtp-Source: APXvYqw515wJAJ5URUt4G4dWfEtITv3CNgLhWcem3hZCnhYkTKKDKFIe/C6Dkjwu362xwj3FjOsMkA==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr28134873wmi.21.1580726482645;
        Mon, 03 Feb 2020 02:41:22 -0800 (PST)
Received: from localhost.localdomain (84-33-65-46.dyn.eolo.it. [84.33.65.46])
        by smtp.gmail.com with ESMTPSA id i204sm23798930wma.44.2020.02.03.02.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 02:41:22 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX V2 6/7] block, bfq: get a ref to a group when adding it to a service tree
Date:   Mon,  3 Feb 2020 11:40:59 +0100
Message-Id: <20200203104100.16965-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203104100.16965-1-paolo.valente@linaro.org>
References: <20200203104100.16965-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

BFQ schedules generic entities, which may represent either bfq_queues
or groups of bfq_queues. When an entity is inserted into a service
tree, a reference must be taken, to make sure that the entity does not
disappear while still referred in the tree. Unfortunately, such a
reference is mistakenly taken only if the entity represents a
bfq_queue. This commit takes a reference also in case the entity
represents a group.

Tested-by: Chris Evich <cevich@redhat.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c  |  2 +-
 block/bfq-iosched.h |  1 +
 block/bfq-wf2q.c    | 12 ++++++++++--
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index cae488b58049..09b69a3ed490 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -332,7 +332,7 @@ static void bfqg_put(struct bfq_group *bfqg)
 		kfree(bfqg);
 }
 
-static void bfqg_and_blkg_get(struct bfq_group *bfqg)
+void bfqg_and_blkg_get(struct bfq_group *bfqg)
 {
 	/* see comments in bfq_bic_update_cgroup for why refcounting bfqg */
 	bfqg_get(bfqg);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 2c7cec737b2a..d1233af9c684 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -985,6 +985,7 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
 struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
 struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node);
+void bfqg_and_blkg_get(struct bfq_group *bfqg);
 void bfqg_and_blkg_put(struct bfq_group *bfqg);
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 26776bdbdf36..eb0e2a6daabe 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -533,7 +533,9 @@ static void bfq_get_entity(struct bfq_entity *entity)
 		bfqq->ref++;
 		bfq_log_bfqq(bfqq->bfqd, bfqq, "get_entity: %p %d",
 			     bfqq, bfqq->ref);
-	}
+	} else
+		bfqg_and_blkg_get(container_of(entity, struct bfq_group,
+					       entity));
 }
 
 /**
@@ -647,8 +649,14 @@ static void bfq_forget_entity(struct bfq_service_tree *st,
 
 	entity->on_st_or_in_serv = false;
 	st->wsum -= entity->weight;
-	if (bfqq && !is_in_service)
+	if (is_in_service)
+		return;
+
+	if (bfqq)
 		bfq_put_queue(bfqq);
+	else
+		bfqg_and_blkg_put(container_of(entity, struct bfq_group,
+					       entity));
 }
 
 /**
-- 
2.20.1

