Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7084FC55189
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 09:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4376A20735
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 09:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="LvFNogxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgDVJBA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725968AbgDVJBA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 05:01:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6719AC03C1A6
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2020 02:01:00 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h12so237970pjz.1
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2020 02:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1oSwgbdRKpWZbApHpNeDS3+KWK+1P6ooTW7bXAE3HjU=;
        b=LvFNogxUGjZvf3SM0OAOr5tM6QS7MLodlGdCun3hcECrno31c8F4T12COi/Jti5nm1
         eQoqXSS005CMFkmUrKiOnT4X8pVjMTgOqk/juIXsl4HvkvZlPGqSnADHGejFAFauZTDf
         f3YPCZzFtRPZWUx5W0NCCB8QPuQLPO/sHZTVdx6PkCrIYmHnPpT37HLbrr1WzI7cCadc
         pdZmSH1EWEvjcQYvNpPTmgy0XbR1EUMnhbBwkptD3I2ZPyZdmNy3OnAGQTc5v2TZi0er
         3H7acLvRACpl88gbj5ChBBmHhIIsnAZ1sVyyzK1k8EwTLDOJLDxk/y65402f1cHcRBqC
         zp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1oSwgbdRKpWZbApHpNeDS3+KWK+1P6ooTW7bXAE3HjU=;
        b=VBLygLa2TP0S/7qhYvGLOp3ec/2+NYRfwW6UtcIXIwAm1cwvUlLFCikMJvAUqoi7B2
         YwOS7HpG/zeSJF9DeSlaWDlu9wFhIVMOaPBoatNa+ynnVjBnukgB2zb5yT+jwyqsz8k8
         K9KL5CZ3D12GpOM2YYA/2cjSvWPxerVFLmBhT9bB6J5ZWR4r5nSBxl9aEPFiKOMyXanX
         MVIBkSTngYSOGIjcPer8uc9cnci19/GYtrWo5axvkkzoSv6wH5fyS2rqd4vMD9L9/+m8
         mS1j24zmJOaQNBLJDpFnwiq6z6Wtc/HstsBDfVZ12lYvtacw4t1oFv57Du9s2HiNE0yC
         c9Dg==
X-Gm-Message-State: AGi0PuZY6rV+n8U3xWN6hXxHEfCHnFKDttLWq/B5Q0i0QgLERtNLuRY8
        Nd4mp21NvsFb0AaaKz4hFjuSaA==
X-Google-Smtp-Source: APiQypLprH/dcnAnO/TtFdHjnAWs0V2X23WQolusyOg6z01Eo42FZ/7AUTNPVzF57vzMTIDipCi8ew==
X-Received: by 2002:a17:90a:fb4e:: with SMTP id iq14mr10559136pjb.146.1587546059901;
        Wed, 22 Apr 2020 02:00:59 -0700 (PDT)
Received: from debian.bytedance.net ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id p66sm4660054pfb.65.2020.04.22.02.00.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 02:00:59 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mpa@pengutronix.de, linux-block@vger.kernel.org,
        nbd@other.debian.org, Hou Pu <houpu@bytedance.com>
Subject: [PATCH 1/2] nbd: export dead_conn_timeout via debugfs
Date:   Wed, 22 Apr 2020 05:00:17 -0400
Message-Id: <20200422090018.23210-2-houpu@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200422090018.23210-1-houpu@bytedance.com>
References: <20200422090018.23210-1-houpu@bytedance.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As dead_conn_timeout could be changed by reconfiguring
a nbd device. Export it so user could find current value
of it.

Signed-off-by: Hou Pu <houpu@bytedance.com>
---
 drivers/block/nbd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 43cff01a5a67..59c6ce2d2e43 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1597,6 +1597,8 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
 
 	debugfs_create_file("tasks", 0444, dir, nbd, &nbd_dbg_tasks_ops);
 	debugfs_create_u64("size_bytes", 0444, dir, &config->bytesize);
+	debugfs_create_u64("dead_conn_timeout", 0444, dir,
+			   &config->dead_conn_timeout);
 	debugfs_create_u32("timeout", 0444, dir, &nbd->tag_set.timeout);
 	debugfs_create_u64("blocksize", 0444, dir, &config->blksize);
 	debugfs_create_file("flags", 0444, dir, nbd, &nbd_dbg_flags_ops);
-- 
2.11.0

