Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D18C67839
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A8520880
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="h1OPYfc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A8520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeLKTR0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:17:26 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46481 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeLKTR0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:26 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so13993602ljh.13
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 11:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H9nWBPfYW84tctbJc+ROv6OY4/CteCEQpmHH16Eu8b8=;
        b=h1OPYfc4N0gmIDfmwABehgiudKb18sHygTDILZWOYjI++3IODxZvZwvdt+vpRBcRo+
         KOjqr70lbHTwuPrY3jWc3pXkZE2AuPDnNpDRVw3NhlfBCy/oFkkQLDcSVz1fUmSi+jNG
         /QvCQcIWjOnS8LBxRJgJV7KwKNk6w4sFmilzMDQvDMUxmT25pa0Yj2VGXKBxgoX2ptkc
         tEMAgV3AJ56Ecx3LIM6+0dYh030yyvJhE8H5NU/l0YPcyf8Bw4tkVf1HYK9yis6mPY00
         Xw6336c3Lk1VzXlGyHAElOyiBVB1dVwlEcae5N4JNicVVNE7yf+JwZwoSOuwr5P82WkG
         00xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H9nWBPfYW84tctbJc+ROv6OY4/CteCEQpmHH16Eu8b8=;
        b=hA2Fj7ymdbo9ZnX1Pe/rjsBpBDtKeLYR4+IhXweX6CDRl3sigeqPHhHhsqtAVNZnqP
         +KuhLaXC2aGV9p8YWtcys7A+KEKiVFSP9KJo+L1qGpXPLHicBGmJILwMnxLVYgiRBxdP
         PP8vJDRfzQ97g0l4WrzgV7y9MJgNa9Yy3l+28VzP8/8Wp0DYt/ImXP74xTWGr/zQUv0T
         rsuvonsywQyF/xkSWHx9B18ic83QSg0ltbTHPsGQejUKxJKFPwCRee9LSwjj3g7lYX0k
         nJpnCuO6wur3umoLPZWngyUnixd9YL+Sy2U+1IOXM0VprmRfDaIMmPd1dri4rurX541N
         LnPw==
X-Gm-Message-State: AA+aEWZhQgKD4112t+irVev7jWy75HkPZcewQE2yNvIo5ActkVIFmmU4
        m7FBUZcM1nM1MFiNfRbyLygV9g==
X-Google-Smtp-Source: AFSGD/XRfo4Dw4GdF522BKuhlK/hB8VjCAfBQvlXl5Qb3jUM5D8/vcEc0d9Xg+MaVlPs4lb8jM/bHQ==
X-Received: by 2002:a2e:9957:: with SMTP id r23-v6mr10159814ljj.98.1544555843804;
        Tue, 11 Dec 2018 11:17:23 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:23 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 19/21] lightnvm: disable interleaved metadata
Date:   Tue, 11 Dec 2018 20:16:25 +0100
Message-Id: <20181211191627.15542-20-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211191627.15542-1-mb@lightnvm.io>
References: <20181211191627.15542-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

Currently pblk only check the size of I/O metadata and does not take
into account if this metadata is in a separate buffer or interleaved
in a single metadata buffer.

In reality only the first scenario is supported, where second mode will
break pblk functionality during any IO operation.

This patch prevents pblk to be instantiated in case device only
supports interleaved metadata.

Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 6 ++++++
 drivers/nvme/host/lightnvm.c | 1 +
 include/linux/lightnvm.h     | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index ff6a6df369c3..e8055b796381 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1175,6 +1175,12 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (geo->ext) {
+		pblk_err(pblk, "extended metadata not supported\n");
+		kfree(pblk);
+		return ERR_PTR(-EINVAL);
+	}
+
 	spin_lock_init(&pblk->resubmit_lock);
 	spin_lock_init(&pblk->trans_lock);
 	spin_lock_init(&pblk->lock);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index ba268d7cf141..f145fc0220d6 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -990,6 +990,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
 	geo = &dev->geo;
 	geo->csecs = 1 << ns->lba_shift;
 	geo->sos = ns->ms;
+	geo->ext = ns->ext;
 
 	dev->q = q;
 	memcpy(dev->name, disk_name, DISK_NAME_LEN);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 7afedaddbd15..5d865a5d5cdc 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -357,6 +357,7 @@ struct nvm_geo {
 	u32	clba;		/* sectors per chunk */
 	u16	csecs;		/* sector size */
 	u16	sos;		/* out-of-band area size */
+	bool	ext;		/* metadata in extended data buffer */
 
 	/* device write constrains */
 	u32	ws_min;		/* minimum write size */
-- 
2.17.1

