Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4DFC169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 12:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99CF214DA
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 12:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="XTK1ndTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfBKM0E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:26:04 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39554 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbfBKMZU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 07:25:20 -0500
Received: by mail-lj1-f193.google.com with SMTP id v12-v6so3850156ljc.6
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 04:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aPqNfQfc1x7Ctx+Hrva5vIaSgQJbQvQq7LNoEgp6zBs=;
        b=XTK1ndTuzO9MANc3qb+2im7yByKWCMX3ge+mWO5pzGVkpwprpwSmohjsTEEW5kMDap
         BrsU6SCHss4pStE9FLL9oHQ7JUmlETI6aY0a3M7PkbU5wK7IRs73ZDVvX/p1Hv7s5/7/
         URcpggj/hOfyFmBaZH5441VUsLGWAOOQXiqib8jfDgO6wtmM2V9buvp+QJzR0xbTxXn6
         YwG6adZcCv+NXzPvtzREyVSlstQrXRavPjkOojgkimCiC9/lRU1oEEkkZsnu3feyncoX
         Vm/ukWS9PpJIuFH2BPqnUowRyHZw4XYix5ac1SOo8XDQLO0Bn/9A5OiGPaeoTDpv98mV
         6emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aPqNfQfc1x7Ctx+Hrva5vIaSgQJbQvQq7LNoEgp6zBs=;
        b=MtMTfJ1RYWNceLUU7KUz2CUOjZGKxaalzcjaw1rVW1QxFwHB7ALPbYr4kG9SboG0yW
         JoqI9wZvUzV8q8aFeIoyoXtHbZh+Isnut4D7BGFWslgXwBm5IHk/TnNGIM4OUNGf0HLK
         h6WC0NVIHy0TTJEMRwSvC9zyRu89G2oKH7wF3EUMBP+ni9YzHmqdIBdCp1JcGn6wLtv3
         dlO24XVq7wGB358SPzor5LWfxfe9Ynu3hIQWnJhMYuZCIXLwUnNMyUHlerQtBEHfVCq/
         tSmK8OPzdq2LafrHMkGItTf/FtHW+vST8LbBEnxfrnk6b/UpcmxVExDmBuvzCP/eFi/+
         4KCQ==
X-Gm-Message-State: AHQUAuYhpmdvOmt/YlIOH23If/30scHzTzDKFfM0pyC2mgaHwd3mHz+G
        k3qImHC9lxTLwK4gPkGz8LTIRg==
X-Google-Smtp-Source: AHgI3IYx5x5MagVlcrHSOfbNqh+KmAib2TjETzeyEeQP9W5L1l1Bl6/t0Ut89x2xO6fanMv65iyK4Q==
X-Received: by 2002:a2e:3603:: with SMTP id d3-v6mr21153964lja.46.1549887918637;
        Mon, 11 Feb 2019 04:25:18 -0800 (PST)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id d70sm2278481lfe.14.2019.02.11.04.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:25:17 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 2/8] lightnvm: pblk: use vfree to free metadata on error path
Date:   Mon, 11 Feb 2019 13:25:03 +0100
Message-Id: <20190211122509.19910-3-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190211122509.19910-1-mb@lightnvm.io>
References: <20190211122509.19910-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

As chunk metadata is allocated using vmalloc, we need to free it
using vfree.

Fixes: 090ee26fd512 ("lightnvm: use internal allocation for chunk log page")
Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 1ff165351180..1b5ff51faa63 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -141,7 +141,7 @@ struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk)
 
 	ret = nvm_get_chunk_meta(dev, ppa, geo->all_chunks, meta);
 	if (ret) {
-		kfree(meta);
+		vfree(meta);
 		return ERR_PTR(-EIO);
 	}
 
-- 
2.19.1

