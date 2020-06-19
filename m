Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89287C433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 20:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66B2621532
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 20:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592599709;
	bh=ezmY6GG7N7R5TA87zG71AETUtzEOHo2C5MHAftMq7+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kc0nFl3XUx9lBy0AQOHoiBefrY34J12MTBdl4+IG1PCwlzXieSvx+pBrVVXcQQMXk
	 NSjNZBgLcSs9i2YJafg0ZLv8EsnUweYURTG7eWVnenUheEJRSHvPcvWbx1lm+jOUlC
	 Il61zT/meSS8esd7EuBdtEx6f4wfi3hPgw4vVPqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390804AbgFSUrg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 16:47:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34728 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390467AbgFSUrf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 16:47:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id v14so4995438pgl.1;
        Fri, 19 Jun 2020 13:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZlpRC/Mpz8aVWhkWOBV4KQndGPE3w8KEQwXgj5xVC8o=;
        b=XT6D8W6pqVvesiZxqE2XkjaJbUJvhUSR5bL4gLRW/8wuxUcCVLK9/hzJsvkk85hMJw
         DY2Ei+Yp5ne19uG4eWUvIlrQZiwDWo7pLdha/6A78NKLJ+RfXjz38G5rGao5htcEe5gz
         kLmiu+37NdDH5Sr9THVC1t51XIs9+1hV2zQ9eYXCyJ+HtnvnmoPWyNaU3v/COnBCZj9u
         +fX7cdY+gxlohFCVT75beacYUt77slhDqtLQHs2ooJGz+9MBx4kcISH2IoYA5mtwyXvt
         O1SD8vA6OTOds1wkpc4+QfgI8sVgEOKZ5yrYVznh3yNViIBtrX0ppskjjcloZvp+oZyh
         SVwQ==
X-Gm-Message-State: AOAM5306gm1SxP/WO2PBX2BcITyHGiyC4HeL+/Q0HY+RId+YyQxm9Uw8
        m1JqZEAeCy0dGtE5SWDLCb4=
X-Google-Smtp-Source: ABdhPJyEOMPI7dRp2zsaFrfUBNU9hX4Hv01VXR4E79Tt8FRLBZbwnTJwnov/PttgARJDYchOL+CQpw==
X-Received: by 2002:aa7:952a:: with SMTP id c10mr10162941pfp.252.1592599655068;
        Fri, 19 Jun 2020 13:47:35 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id v7sm6569138pfn.147.2020.06.19.13.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 13:47:32 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 4556A41C23; Fri, 19 Jun 2020 20:47:32 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 2/8] block: clarify context for refcount increment helpers
Date:   Fri, 19 Jun 2020 20:47:24 +0000
Message-Id: <20200619204730.26124-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200619204730.26124-1-mcgrof@kernel.org>
References: <20200619204730.26124-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Let us clarify the context under which the helpers to increment the
refcount for the gendisk and request_queue can be called under. We
make this explicit on the places where we may sleep with might_sleep().

We don't address the decrement context yet, as that needs some extra
work and fixes, but will be addressed in the next patch.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-core.c | 2 ++
 block/genhd.c    | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index a0760aac110a..14c09daf55f3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -610,6 +610,8 @@ EXPORT_SYMBOL(blk_alloc_queue);
  * @q: the request_queue structure to increment the refcount for
  *
  * Increment the refcount of the request_queue kobject.
+ *
+ * Context: Any context.
  */
 bool blk_get_queue(struct request_queue *q)
 {
diff --git a/block/genhd.c b/block/genhd.c
index f741613d731f..1be86b1f43ec 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -985,11 +985,15 @@ static ssize_t disk_badblocks_store(struct device *dev,
  *
  * This function gets the structure containing partitioning
  * information for the given device @devt.
+ *
+ * Context: can sleep
  */
 struct gendisk *get_gendisk(dev_t devt, int *partno)
 {
 	struct gendisk *disk = NULL;
 
+	might_sleep();
+
 	if (MAJOR(devt) != BLOCK_EXT_MAJOR) {
 		struct kobject *kobj;
 
@@ -1764,6 +1768,8 @@ EXPORT_SYMBOL(__alloc_disk_node);
  *
  * This increments the refcount for the struct gendisk, and the gendisk's
  * fops module owner.
+ *
+ * Context: Any context.
  */
 struct kobject *get_disk_and_module(struct gendisk *disk)
 {
-- 
2.26.2

