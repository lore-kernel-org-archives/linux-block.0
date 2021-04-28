Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D7DC433B4
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 06:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53D986141F
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 06:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhD1GO4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 02:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbhD1GO4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 02:14:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7DCC061574
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 23:14:12 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c22so9091079edn.7
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 23:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yv21oxwwm3U+ivQCHp5JpB+UCkax9HwL+d8tbFJQJ34=;
        b=PhOX/AdBxPCJ0gpC5bSI0nX+VDTnNu77221EnQrDMdHNbscvb1jJ2tSChf+19p9GX2
         qsAtsL1rw1xVAlFzrfwPKDQxS2oyhzgdxnZ3MgCEJs4NiKPUR3HCGrjLfka8vSgJ2BHg
         EoxnprYRlNLj6CEKqO3tvZwlpjhVqSKzHP5NoCypTkyIGwKhjSrMfkGhxfK1WCsyO7He
         UQE0fWEtjoeTkBb4gCBGs9zO7IOMaCiW6nVyDL7m4F86Qioydu2hQANQH9ugGp+O48IH
         K4/m/IPcTJnqdK/JYR+LbT9dW7xY5CDD6SSMGZCLslqqQ2ZpAgGKgw6GkHGj92SfddH7
         pN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yv21oxwwm3U+ivQCHp5JpB+UCkax9HwL+d8tbFJQJ34=;
        b=NWxWMhlTnXmPf6Tf1i638fqeV37yJ0Ky16vtNUrI38TbxUlP4lxPZ52AJTeTtiso2r
         mNRm01C7MA1cPqd1ZwJjDKhGkStA1D5J0oDvQSkJzDUJLzH/zc5/LBV56ykXbAsfxUn4
         zv2ci2RAzlJTyGf8vZeHvhFH+8YKeVf1qxS/5cmyr1RSvuyTWvK8wfxPJq8+ufiDd+ih
         nqo0gRfAJKD1rDAjf9CNvZW1IMoCwwHdaVLeq/2c//wCkyMQOwlNQw9i+MEImlWRId7F
         8/nL8s84Q1XIzI/VLkrlQeZ1ZeMYaIHNpTAvvC7S9u96yX64KukyHG8DiIvQ3viC1Z2P
         HIgg==
X-Gm-Message-State: AOAM532HFSG0gNrCF+v1lNG7J9CwuvPdLgo/dmlPuS33gzOvlVvPinFf
        g0USpIpdX3zJm80as1jOiCjWMToMJSfc7g==
X-Google-Smtp-Source: ABdhPJy82hEuWfb2FcQbu0sV/zk4pdGZx6XrwYgpbcZO5+pdzX96npQUIGFJ/9gbmRqAgw1ed896DQ==
X-Received: by 2002:a05:6402:694:: with SMTP id f20mr8937626edy.93.1619590450650;
        Tue, 27 Apr 2021 23:14:10 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5ae8b9.dynamic.kabel-deutschland.de. [95.90.232.185])
        by smtp.googlemail.com with ESMTPSA id t4sm3970322edd.6.2021.04.27.23.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 23:14:10 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 1/4] block/rnbd-clt: Change queue_depth type in rnbd_clt_session to size_t
Date:   Wed, 28 Apr 2021 08:13:56 +0200
Message-Id: <20210428061359.206794-2-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428061359.206794-1-gi-oh.kim@ionos.com>
References: <20210428061359.206794-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>

The member queue_depth in the structure rnbd_clt_session is read from the
rtrs client side using the function rtrs_clt_query, which in turn is read
from the rtrs_clt structure. It should really be of type size_t.

Fixes: 90426e89f54db ("block/rnbd: client: private header with client structs and functions")
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
---
 drivers/block/rnbd/rnbd-clt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index 451e7383738f..b5322c5aaac0 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -87,7 +87,7 @@ struct rnbd_clt_session {
 	DECLARE_BITMAP(cpu_queues_bm, NR_CPUS);
 	int	__percpu	*cpu_rr; /* per-cpu var for CPU round-robin */
 	atomic_t		busy;
-	int			queue_depth;
+	size_t			queue_depth;
 	u32			max_io_size;
 	struct blk_mq_tag_set	tag_set;
 	u32			nr_poll_queues;
-- 
2.25.1

