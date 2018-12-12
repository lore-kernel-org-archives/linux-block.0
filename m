Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3E3C65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 16:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B132084E
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 16:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GYGXDFOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B132084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbeLLQEy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:04:54 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38537 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeLLQEx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 11:04:53 -0500
Received: by mail-io1-f66.google.com with SMTP id l14so15201239ioj.5
        for <linux-block@vger.kernel.org>; Wed, 12 Dec 2018 08:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=m2VAcYoVgNv0ZUdx6HM4Jp0kc9IuI/5HhY38vCEztYg=;
        b=GYGXDFOvKWRTCO2rU+3anoXQw6xHslcuzTl9eIm+3DmMKuqZ0FxswfxoigwMKr6m00
         uuUSiZ1O9o1p15GYdG/YI73GXoEHYcEG755Mt2tyy5dXa1mrleomHv5nqkepkfHel7NG
         AUgpa+Ji4w8fRQc3n1aP2cRHDTADpVuT+ETPjhgHJ0PvcGKLnXEV19dXN0pLTmP8XOLi
         F7foY88gCzdDT3ks2Kh4ox6i8ivBjGPndC0RNONgG9KRQ3Pf6TTl+8vpWVCTACbPJVRv
         IiDRo7aBfM1/NUNLc7rfdL9allba/HOUgW+KJvaHG64corMcE/lKwkMBeGfyEMItU7Gd
         berw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=m2VAcYoVgNv0ZUdx6HM4Jp0kc9IuI/5HhY38vCEztYg=;
        b=h2nidpeBGDpVvJVE3CM8KLQmamm/i71tAadX0T2ZdOxdjoP2fqd7Qeeobvc5CsxzjT
         /RvV8EHnxyRy9IISM3oRN6TuQWVwi44KfLC+zo31zDchItPaNvJ1AZaZQ7Qh/DJ2zJO6
         6MS6+PAn6wNjV3IbWYxabUrvBya5+XrUdM7eh6VRHoEhJhOAfMGQpbfRcCqFFE2kMKlW
         bg57hlIjL8CYWO5tLmuAo1RBfLqXVkIeZCbSni0WW5dkTvhzOIA3v/Szu84Eru1mgVks
         HEKoPzE9pdTjsLMkOuaLUd/2Q7w6JNAT6WydRfZxM4QAXBK9LqcBdI2qC/OPYEjygKxy
         yXfQ==
X-Gm-Message-State: AA+aEWa5u8je9n4Kvdd9FAld9iGOsSRDgXW6xh0+B0II79T5+ZYP34AR
        ehhDmG94367BGU8+BS/AbDzhiw==
X-Google-Smtp-Source: AFSGD/WrUM25sGNoyEKosc9d6gjbSud+x9+zQeFlu3+mPfHuC7cbFyF5PR2CYGHZf7gM04ry1bi+FA==
X-Received: by 2002:a6b:2c17:: with SMTP id s23mr17805509ios.76.1544630693096;
        Wed, 12 Dec 2018 08:04:53 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id n124sm3896665itn.4.2018.12.12.08.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 08:04:51 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] nvme: provide fallback for discard alloc failure
Message-ID: <eea978e4-2c63-26d7-dbb6-8023c58675d4@kernel.dk>
Date:   Wed, 12 Dec 2018 09:04:50 -0700
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
page allocation in sd. If we fail allocating the special page, we return
busy, and it'll get retried. But since ordering is honored for dispatch
requests, we can keep retrying this same IO and failing. Behind that IO
could be requests that want to free memory, but they never get the
chance.

Allocate a fixed discard page per controller for a safe fallback, and use
that if the initial allocation fails.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c71e879821ad..7ca988e58790 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -564,9 +564,14 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	struct nvme_dsm_range *range;
 	struct bio *bio;
 
-	range = kmalloc_array(segments, sizeof(*range), GFP_ATOMIC);
-	if (!range)
-		return BLK_STS_RESOURCE;
+	range = kmalloc_array(segments, sizeof(*range),
+				GFP_ATOMIC | __GFP_NOWARN);
+	if (!range) {
+		if (test_and_set_bit_lock(0, &ns->ctrl->discard_page_busy))
+			return BLK_STS_RESOURCE;
+
+		range = page_address(ns->ctrl->discard_page);
+	}
 
 	__rq_for_each_bio(bio, req) {
 		u64 slba = nvme_block_nr(ns, bio->bi_iter.bi_sector);
@@ -581,7 +586,10 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	}
 
 	if (WARN_ON_ONCE(n != segments)) {
-		kfree(range);
+		if (virt_to_page(range) == ns->ctrl->discard_page)
+			clear_bit_unlock(0, &ns->ctrl->discard_page_busy);
+		else
+			kfree(range);
 		return BLK_STS_IOERR;
 	}
 
@@ -664,8 +672,13 @@ void nvme_cleanup_cmd(struct request *req)
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
@@ -3578,6 +3591,7 @@ static void nvme_free_ctrl(struct device *dev)
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 	kfree(ctrl->effects);
 	nvme_mpath_uninit(ctrl);
+	kfree(ctrl->discard_page);
 
 	if (subsys) {
 		mutex_lock(&subsys->lock);
@@ -3618,6 +3632,12 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 
+	ctrl->discard_page = alloc_page(GFP_KERNEL);
+	if (!ctrl->discard_page) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	ret = ida_simple_get(&nvme_instance_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0)
 		goto out;
@@ -3655,6 +3675,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
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

