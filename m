Return-Path: <SRS0=imFw=XJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D64DC4CEC9
	for <linux-block@archiver.kernel.org>; Sat, 14 Sep 2019 17:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBD12067D
	for <linux-block@archiver.kernel.org>; Sat, 14 Sep 2019 17:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv58Hov0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfINRcC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Sep 2019 13:32:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55697 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730648AbfINRcC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Sep 2019 13:32:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id g207so5779793wmg.5;
        Sat, 14 Sep 2019 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FRSNdszeRgOqEiAj8/M1A2W/ZSrgyiE+3juhS2eD1HI=;
        b=Kv58Hov0PTq8FRxeAiCOpuTZDn6Vqwztz5pHiEvdEPa48/eu9EqodJzpNEsuHFC+FI
         VhIambL365SB0rM9usx1YDz64Bm4bR6QjFgBAnKVaUetsGeUD7wCGR6eXS/7JU7Bynd+
         duafi+rT6Bwt59o4EfInsW8znQNcBfdSlEC7hjDXnCIkwtVUCfmi0dAACvc10Xo4MdRQ
         6Pggwb3jEMmz4kyis7AnXzQJ7jSJ99bBHn+1xTdXSY69MCcOhtToBGQmwqVnai8ZODP9
         tNRea4e9UcS3TcatwV9MI18r44xzaOqLW0rjJb790h2egV2Bboiqs+ndPkGCG8KH8xXa
         8TVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FRSNdszeRgOqEiAj8/M1A2W/ZSrgyiE+3juhS2eD1HI=;
        b=X2eHV2EdN8Z/PcSxAb10gIkUyvju+VAjmtq0EtsduHkTdiv0ouDh6Oi0EJlQOzcfDC
         QlQxdF+ZxbDmPCnNICdjY9IDs0KqvyMapd9ixLMLqtHkomcrIdYMWFiKewcRVg9r9Unf
         IxUL0byPQF+/OODIdXmvpXdkKYMkDyJ1in9LDK8STMpFhvKlP6mxF4cbFvoomKxAK9hL
         115c7fS5rI/lei89eAabAtoA/mDMK42RDN1PS6x+e5xayfAhu5kKWDbWeKphtSg1nXN8
         z+FiV+CPqKU57BWaNKxUBJvq+sI9D0lISLMqqCxB3vGCpG3Kf82E8blXGB55jaO9lQAo
         B2gw==
X-Gm-Message-State: APjAAAWYipwoGZKHGWrplrji0HpvfpRhjWlTlu5HAvJ6gl+c8nUYqxxb
        DMdZK9IoxzF/UAMbcU1d0MU6fIB7
X-Google-Smtp-Source: APXvYqzX6B9pibXpXv0aSCq1t/F5ZpJkg4d/BnxAS0KD7CUS8+ELuy+w01MoQjZ0Qxm/jQHHu/7EQw==
X-Received: by 2002:a1c:7919:: with SMTP id l25mr7461259wme.23.1568482319982;
        Sat, 14 Sep 2019 10:31:59 -0700 (PDT)
Received: from localhost.localdomain ([109.126.145.74])
        by smtp.gmail.com with ESMTPSA id y13sm62981711wrg.8.2019.09.14.10.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 10:31:59 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH] bfq: Fix bfq linkage error
Date:   Sat, 14 Sep 2019 20:31:50 +0300
Message-Id: <9afc7a2cd013344290096d9dfe9355bcb57b3bbd.1568482098.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Since commit 795fe54c2a828099e ("bfq: Add per-device weight"), bfq uses
blkg_conf_prep() and blkg_conf_finish(), which are not exported. So, it
causes linkage error if bfq compiled as a module.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0e2619c1a422..b6f20be0fc78 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -900,6 +900,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	}
 	return ret;
 }
+EXPORT_SYMBOL_GPL(blkg_conf_prep);
 
 /**
  * blkg_conf_finish - finish up per-blkg config update
@@ -915,6 +916,7 @@ void blkg_conf_finish(struct blkg_conf_ctx *ctx)
 	rcu_read_unlock();
 	put_disk_and_module(ctx->disk);
 }
+EXPORT_SYMBOL_GPL(blkg_conf_finish);
 
 static int blkcg_print_stat(struct seq_file *sf, void *v)
 {
-- 
2.22.0

