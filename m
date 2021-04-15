Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF5AC433B4
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 23:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE3A610FA
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 23:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhDOXMI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 19:12:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37610 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234654AbhDOXMI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 19:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618528304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0y9ELWB5zZsLoM46VSwkd7Yl/ytP1uGsNaYxYYVPgQc=;
        b=HzfEyOUpsfOxIeXYTz3TF4FJZChFKpY09Md21DITYD2/QPo/cJJR6Qe21WbIseHswI9ZKt
        9ov2/09EeW9atNP9yFASQHWGItdRUs82b/YOea3VboAQFEPCC/7DilflQdC/3le2WELm6Y
        kvmR1Evbbf/5XjrIIpURQxQDWG8mk8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-dpEsksVOPuuDBrNetWKiiA-1; Thu, 15 Apr 2021 19:11:42 -0400
X-MC-Unique: dpEsksVOPuuDBrNetWKiiA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5E5687A83C;
        Thu, 15 Apr 2021 23:11:40 +0000 (UTC)
Received: from localhost (thegoat.4a2m.lab.eng.bos.redhat.com [10.16.209.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5979260855;
        Thu, 15 Apr 2021 23:11:34 +0000 (UTC)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: nvme: update failover handling to work with REQ_FAILFAST_TRANSPORT
Date:   Thu, 15 Apr 2021 19:11:24 -0400
Message-Id: <20210415231126.8746-2-snitzer@redhat.com>
In-Reply-To: <20210415231126.8746-1-snitzer@redhat.com>
References: <20210415231126.8746-1-snitzer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

BZ: 1948690
Upstream Status: RHEL-only

Signed-off-by: Mike Snitzer <snitzer@redhat.com>

rhel-8.git commit f8fb6ea1226e2abc525c88da13b346118d548eea
Author: Mike Snitzer <snitzer@redhat.com>
Date:   Tue Aug 25 21:52:46 2020 -0400

    [nvme] nvme: update failover handling to work with REQ_FAILFAST_TRANSPORT
    
    Message-id: <20200825215248.2291-9-snitzer@redhat.com>
    Patchwork-id: 325177
    Patchwork-instance: patchwork
    O-Subject: [RHEL8.3 PATCH 08/10] nvme: update failover handling to work with REQ_FAILFAST_TRANSPORT
    Bugzilla: 1843515
    RH-Acked-by: David Milburn <dmilburn@redhat.com>
    RH-Acked-by: Gopal Tiwari <gtiwari@redhat.com>
    RH-Acked-by: Ewan Milne <emilne@redhat.com>
    
    BZ: 1843515
    Upstream Status: RHEL-only
    
    If REQ_FAILFAST_TRANSPORT is set it means the driver should not retry
    IO that completed with transport errors.  REQ_FAILFAST_TRANSPORT is
    set by multipathing software (e.g. dm-multipath) before it issues IO.
    Update NVMe to prepare for failover of requests marked with either
    REQ_NVME_MPATH or REQ_FAILFAST_TRANSPORT.  This allows such requests
    to be given a disposition of FAILOVER.
    
    Introduce nvme_end_req_with_failover() for use in nvme_complete_rq()
    if REQ_NVME_MPATH isn't set.  nvme_end_req_with_failover() ensures
    request is completed with a retryable IO error when appropriate.
    __nvme_end_req() was factored out for use by both nvme_end_req() and
    nvme_end_req_with_failover().
    
    Signed-off-by: Mike Snitzer <snitzer@redhat.com>
    Signed-off-by: Frantisek Hrbata <fhrbata@redhat.com>

---
 drivers/nvme/host/core.c |   33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

Index: linux-rhel9/drivers/nvme/host/core.c
===================================================================
--- linux-rhel9.orig/drivers/nvme/host/core.c
+++ linux-rhel9/drivers/nvme/host/core.c
@@ -311,7 +311,7 @@ static inline enum nvme_disposition nvme
 	    nvme_req(req)->retries >= nvme_max_retries)
 		return COMPLETE;
 
-	if (req->cmd_flags & REQ_NVME_MPATH) {
+	if (req->cmd_flags & (REQ_NVME_MPATH | REQ_FAILFAST_TRANSPORT)) {
 		if (nvme_is_path_error(nvme_req(req)->status) ||
 		    blk_queue_dying(req->q))
 			return FAILOVER;
@@ -323,10 +323,8 @@ static inline enum nvme_disposition nvme
 	return RETRY;
 }
 
-static inline void nvme_end_req(struct request *req)
+static inline void __nvme_end_req(struct request *req, blk_status_t status)
 {
-	blk_status_t status = nvme_error_status(nvme_req(req)->status);
-
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = nvme_lba_to_sect(req->q->queuedata,
@@ -336,6 +334,28 @@ static inline void nvme_end_req(struct r
 	blk_mq_end_request(req, status);
 }
 
+static inline void nvme_end_req(struct request *req)
+{
+	__nvme_end_req(req, nvme_error_status(nvme_req(req)->status));
+}
+
+static inline void nvme_end_req_with_failover(struct request *req)
+{
+	u16 nvme_status = nvme_req(req)->status;
+	blk_status_t status = nvme_error_status(nvme_status);
+
+	if (unlikely(nvme_status & NVME_SC_DNR))
+		goto out;
+
+	if (!blk_path_error(status)) {
+		pr_debug("Request meant for failover but blk_status_t (errno=%d) was not retryable.\n",
+			 blk_status_to_errno(status));
+		status = BLK_STS_IOERR;
+	}
+out:
+	__nvme_end_req(req, status);
+}
+
 void nvme_complete_rq(struct request *req)
 {
 	trace_nvme_complete_rq(req);
@@ -352,7 +372,10 @@ void nvme_complete_rq(struct request *re
 		nvme_retry_req(req);
 		return;
 	case FAILOVER:
-		nvme_failover_req(req);
+		if (req->cmd_flags & REQ_NVME_MPATH)
+			nvme_failover_req(req);
+		else
+			nvme_end_req_with_failover(req);
 		return;
 	}
 }

