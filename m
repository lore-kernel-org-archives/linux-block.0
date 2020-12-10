Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECABC433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 10:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38B9923AC4
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 10:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgLJKTQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 05:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgLJKTL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 05:19:11 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D4BC061794
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 02:18:31 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id h16so4882205edt.7
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 02:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwUB98OMU5vN+dBpGv0EWnnHA2hhEx1MlU32S5W8EnI=;
        b=TiEFNbqTMOidxiiKF76b1nJcEUTnEX/1Gp682BLADV1z0pn12p2abDYLB7/eGn0RGg
         7TFMN5CLsPBq6bhgi2lDmBHHLX//b1JGGTMEvq5rlk3AhdOzQUXQYo/b2gqxttuO5hN7
         ctMVqjuNC8xP6FPVYug1zLMvNsPY4ZZIX98yPqTfaFtGHuSwJf5ek6KinFc7MwlrWF/c
         U6I3Yl4+WA2paoz5jm09WR1xm1ncRdlLvW9IS/Y9ndJO0BUes87fQ+MUiJ1t4FBSDLEp
         Y15XQ8/Kb5AxRgYPqiMEVjlXOrTHQ6yk1pcyiTOHSr5HE0ri+ZqxME48KuEuXWZ6GoZZ
         gk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwUB98OMU5vN+dBpGv0EWnnHA2hhEx1MlU32S5W8EnI=;
        b=SdPF64Xe7V/lSBK4gzoJhpXX8FM3qN2rEXTU+Gu38ppcP0pgmaLVUT7xbmPGk/eacI
         md6wQcHk5uGV2JbPUJIqmnC1W3b5Mx6/ok5Zw6VAJ8uQ6IHHK2dQIJkjReWwaY4TEajF
         FFwlDVf4bndiPIh3flm7GbQdPtpPJJR7L+gxxFADCnSK3LsXct+HcJFFHo8wlNc98Lmo
         xbh7BDJWsRUMonmCxagmFj8DldXqY1QUCNDmjpUzGmf808y5uNM90sAU5Erx1Zd2ZE0g
         s9mRc6d7YOaFIqPy4QSUiwg0A/+hqmrtPTrOONWQNDCCcDzShWeD5QyewGztnysejxz2
         EM9w==
X-Gm-Message-State: AOAM530dG/u5Rb/0bRVyqxr+HVLECy/Xqv/cxb4Nnum2erA68qu6gREJ
        tlIa0lfffEt7UOaT91gsgBHkTM4iMMghxQ==
X-Google-Smtp-Source: ABdhPJyqlnZxVXoUedM40PFa8WWfqfLfB3nvMpQUl8Zxol1yqPlVY2qTy+3jKM33i3aN31NXC7OE1g==
X-Received: by 2002:aa7:c84c:: with SMTP id g12mr5928364edt.193.1607595509712;
        Thu, 10 Dec 2020 02:18:29 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4938:300:58f0:963a:32b2:ff05])
        by smtp.gmail.com with ESMTPSA id s24sm3955878ejb.20.2020.12.10.02.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 02:18:29 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCHv2 for-next 2/7] block/rnbd-clt: Fix possible memleak
Date:   Thu, 10 Dec 2020 11:18:21 +0100
Message-Id: <20201210101826.29656-3-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210101826.29656-1-jinpu.wang@cloud.ionos.com>
References: <20201210101826.29656-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In error case, we do not free the memory for blk_symlink_name.

Do it by free the memory in error case, and set to NULL
afterwards.

Also fix the condition in rnbd_clt_remove_dev_symlink.

Fixes: 64e8a6ece1a5 ("block/rnbd-clt: Dynamically alloc buffer for pathname & blk_symlink_name")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index a7caeedeb198..d4aa6bfc9555 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -432,7 +432,7 @@ void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev)
 	 * i.e. rnbd_clt_unmap_dev_store() leading to a sysfs warning because
 	 * of sysfs link already was removed already.
 	 */
-	if (strlen(dev->blk_symlink_name) && try_module_get(THIS_MODULE)) {
+	if (dev->blk_symlink_name && try_module_get(THIS_MODULE)) {
 		sysfs_remove_link(rnbd_devs_kobj, dev->blk_symlink_name);
 		kfree(dev->blk_symlink_name);
 		module_put(THIS_MODULE);
@@ -521,7 +521,8 @@ static int rnbd_clt_add_dev_symlink(struct rnbd_clt_dev *dev)
 	return 0;
 
 out_err:
-	dev->blk_symlink_name[0] = '\0';
+	kfree(dev->blk_symlink_name);
+	dev->blk_symlink_name = NULL ;
 	return ret;
 }
 
-- 
2.25.1

