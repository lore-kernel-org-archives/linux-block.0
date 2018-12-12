Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D80C65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 16:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551082080F
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 16:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="l4O1+uh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551082080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbeLLQSO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:18:14 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40607 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLLQSO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 11:18:14 -0500
Received: by mail-io1-f66.google.com with SMTP id n9so15234196ioh.7
        for <linux-block@vger.kernel.org>; Wed, 12 Dec 2018 08:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=PDTXBaUiAiJ/myKUEJfNL7fG5D8vShOLScGSvT4N3U0=;
        b=l4O1+uh4jSpOSdwqkzW3ZQsB4YwZX0mhZkZem//xP6JbB74cb9LWtZ0n1Nbl0ohGQI
         hdULQXYZxnv0FDJqOEf5lNBQKSkGJmiBjQkuDm6JLUm06cP2XgeQiPa8o+yt2JIqticd
         KoRKlP0KyAnDwcydacbwstEtSb74OW4Azo2ciu65MPSRqOfU21FKypS9l+UDyGUCus2o
         Wv+r3b6X9haYFGuQupVI4Mf+wWkkDutWB/lQNeNWk5ek6Ofk6p3nJcxWkaLVAAfqfjlA
         8vWKC0NxIkyA7srQITsSVtxLWHzHys45zJGR+9fvCRwkCjlT2QrUF3Y8wIGzOLMKS3u/
         auJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=PDTXBaUiAiJ/myKUEJfNL7fG5D8vShOLScGSvT4N3U0=;
        b=OWRLzFnnZ2+DdwpRco7/WbJaCjGXv6ejMGCg4LGc9/IqwVj18NyxLVGIezdlm14AwH
         kftzw55AqrqrBDYo3uWLrsxGr5z2y8lllPHMKIaNEwdGvjYpbwiCt5LORhB4UahQK0io
         VBwf/K+TjwAinjGZaIHmDlQic1mp6zJl+xXPc4ZF+82Y5MrbZb4DihKAiH+tTJ3iNHRl
         /nhKuhPgc6Dr4F+TrbH5Yu705tf7TaS1H7JXFBFcRKxCCQQc26xQ3KVBYPDj9X+q0DSV
         2ClP0Co6ZGtZdiYkm5CK3bh/Lacskq0G/0SuGE2iB58o6dVngLA0eUXj9Npvt4jYnaT7
         VLcA==
X-Gm-Message-State: AA+aEWZMgqfv/WKyeetA7LxhoryoYqm/CtjmwPTfrn0ZolKVtuJOuO+M
        fnXosSsWBJclEucOb/tqhVg7+A==
X-Google-Smtp-Source: AFSGD/Uy/pe8qWUBxViYqXT8o8+CJ2Pu9hM/VwRc1FH30ORiP1YxYNEy7QvZ0yCVfwSerbebqe9zNA==
X-Received: by 2002:a5d:9654:: with SMTP id d20mr17242889ios.257.1544631493730;
        Wed, 12 Dec 2018 08:18:13 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h64sm3048845itb.14.2018.12.12.08.18.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 08:18:12 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] nvme: provide fallback for discard alloc failure
Message-ID: <87d6d992-6d9f-c863-c14c-e4f3555cb3d6@kernel.dk>
Date:   Wed, 12 Dec 2018 09:18:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When boxes are run near (or to) OOM, we have a problem with the discard
page allocation in nvme. If we fail allocating the special page, we
return busy, and it'll get retried. But since ordering is honored for
dispatch requests, we can keep retrying this same IO and failing. Behind
that IO could be requests that want to free memory, but they never get
the chance.

Allocate a fixed discard page per controller for a safe fallback, and use
that if the initial allocation fails.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

No functional change, just added a comment, and a safe guard BUILD_BUG_ON
to ensure that our max discard segments always fit within a single page.
And corrected the s/sd/nvme typo in the commit message.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c71e879821ad..c57cf40e7e04 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -564,9 +564,19 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	struct nvme_dsm_range *range;
 	struct bio *bio;
 
-	range = kmalloc_array(segments, sizeof(*range), GFP_ATOMIC);
-	if (!range)
-		return BLK_STS_RESOURCE;
+	range = kmalloc_array(segments, sizeof(*range),
+				GFP_ATOMIC | __GFP_NOWARN);
+	if (!range) {
+		/*
+		 * If we fail allocation our range, fallback to the controller
+		 * discard page. If that's also busy, it's safe to return
+		 * busy, as we know we can make progress once that's freed.
+		 */
+		if (test_and_set_bit_lock(0, &ns->ctrl->discard_page_busy))
+			return BLK_STS_RESOURCE;
+
+		range = page_address(ns->ctrl->discard_page);
+	}
 
 	__rq_for_each_bio(bio, req) {
 		u64 slba = nvme_block_nr(ns, bio->bi_iter.bi_sector);
@@ -581,7 +591,10 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	}
 
 	if (WARN_ON_ONCE(n != segments)) {
-		kfree(range);
+		if (virt_to_page(range) == ns->ctrl->discard_page)
+			clear_bit_unlock(0, &ns->ctrl->discard_page_busy);
+		else
+			kfree(range);
 		return BLK_STS_IOERR;
 	}
 
@@ -664,8 +677,13 @@ void nvme_cleanup_cmd(struct request *req)
 				blk_rq_bytes(req) >> ns->lba_shift);
 	}
 	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
-		kfree(page_address(req->special_vec.bv_page) +
-		      req->special_vec.bv_offset);
+		struct nvme_ns *ns = req->rq_disk->private_data;
+		struct page *page = req->special_vec.bv_page;
+
+		if (page == ns->ctrl->discard_page)
+			clear_bit_unlock(0, &ns->ctrl->discard_page_busy);
+		else
+			kfree(page_address(page) + req->special_vec.bv_offset);
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
@@ -3578,6 +3596,7 @@ static void nvme_free_ctrl(struct device *dev)
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 	kfree(ctrl->effects);
 	nvme_mpath_uninit(ctrl);
+	kfree(ctrl->discard_page);
 
 	if (subsys) {
 		mutex_lock(&subsys->lock);
@@ -3618,6 +3637,14 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 
+	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
+			PAGE_SIZE);
+	ctrl->discard_page = alloc_page(GFP_KERNEL);
+	if (!ctrl->discard_page) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	ret = ida_simple_get(&nvme_instance_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0)
 		goto out;
@@ -3655,6 +3682,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 out_release_instance:
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 out:
+	if (ctrl->discard_page)
+		__free_page(ctrl->discard_page);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e20e737ac10c..f1fe88598a04 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -241,6 +241,9 @@ struct nvme_ctrl {
 	u16 maxcmd;
 	int nr_reconnects;
 	struct nvmf_ctrl_options *opts;
+
+	struct page *discard_page;
+	unsigned long discard_page_busy;
 };
 
 struct nvme_subsystem {

-- 
Jens Axboe

