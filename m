Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25CAC4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 15:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C79206B8
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 15:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="Tcf0fu0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfDCPmx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:42:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39605 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCPmw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 11:42:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id t28so20083567qte.6
        for <linux-block@vger.kernel.org>; Wed, 03 Apr 2019 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=fI2DGuQbswE7t7GK7Y9TvVX5Ux7RcSRNkCmO/laIxhU=;
        b=Tcf0fu0BsQTrvofF9ufYPLhBSapV1I2tx5Aju58/ZqLtOGo2VOQA9BrOACZgcDcIM7
         XBudTXRw4tC3fE30QTky9+mUw5uW6bMGMIGJy4X8pImVCd91Uei9/oxEPWO2eCcN4UxD
         qOO7zpdqGzkRUdKc7nv8izK4Wobanw9Ngs5PRAlGv0ZJHZK7EawFqSS/D3Iqf9qBYnbu
         p6f6bL2M5Pu+Rf/niyqfc23fwd+DwLrIQ0UpdDSiRyBCY/henE08v9kdoisyFN6eSHYs
         dXvhVS8UTZhcGAOfp4JlEb66oKrS7Btc5fY+J2o/uflmNo3qJt387K4jkjXXyTyc2r6a
         dUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=fI2DGuQbswE7t7GK7Y9TvVX5Ux7RcSRNkCmO/laIxhU=;
        b=QeCj12V6ZVL/1BVI8o7qZPqKMH95ZZIufyKuMwDfWr4ZSGxJueIVWET6OAOqzo1xYq
         6HC0bS2TgRmfXVZgr+J5OlWgrOPtl/6V7VsMobyFZwn6HJ7pvBflEBKvjTh7walvO1pW
         rAxT3mehsVSMqlFyhKUf78QzXluh8rXDT0fBZ+bMrU8VylHQe6qGVy8ajN0lyTLuc0m0
         KTDJQulD/jKSoTIq/7qUhyxcve2GNu9hn2BctjLYlrlyQxEZzbBuKs5JrJfnPRHvTOXx
         5mldruFFkXjNNNsQK6esHeDuaD//BR2UqEpOTkYmEiPoudXHGnTMvv7Q8lUsMF1s9Z/L
         7S5Q==
X-Gm-Message-State: APjAAAVaLM7xPmbhWwF5KkeK4gIhzsvYmBAjtKjuOTTzK2iMnD1M1Kjv
        28d7Hd4yDxI4oHQG+CWi631YqXMfRfFDmQ==
X-Google-Smtp-Source: APXvYqwoLQdaEG6M8pKrcXVAJ82PeqqmESHu8oDyS3BrpF5wS1pzyA69/+CkLyMY1znRdfzted8WQg==
X-Received: by 2002:ac8:196b:: with SMTP id g40mr556597qtk.218.1554306171430;
        Wed, 03 Apr 2019 08:42:51 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g5sm8659591qke.71.2019.04.03.08.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 08:42:50 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, nbd@other.debian.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] nbd: add a round robin client option
Date:   Wed,  3 Apr 2019 11:42:49 -0400
Message-Id: <20190403154249.15438-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have found cases where single threaded IO applications really suffer
from the CPU to connection mapping on NBD.  With the OSS nbd server you
can run out of threads to meaningfully service all of the IO coming in
over one connection which will cut your throughput in half.  The
internal FB server uses folly's async socket which has one thread
reading and writing to the socket which limits throughput.  Having a
naive round robin approach in the nbd driver itself to round robin on
all of its available sockets allows for us to get 2-3x performance
improvement in the single threaded IO workload as we essentially force
the user space server to get more balanced traffic.  This is ok from an
NBD perspective because we don't really care which socket the request
goes out, and in fact if there is a connection failure on one socket
we'll re-route requests to other sockets without issue.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/nbd.c      | 14 ++++++++++++++
 include/uapi/linux/nbd.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 90ba9f4c03f3..53463217fbe9 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -77,6 +77,7 @@ struct link_dead_args {
 #define NBD_BOUND			5
 #define NBD_DESTROY_ON_DISCONNECT	6
 #define NBD_DISCONNECT_ON_CLOSE 	7
+#define NBD_ROUND_ROBIN			8
 
 struct nbd_config {
 	u32 flags;
@@ -84,6 +85,7 @@ struct nbd_config {
 	u64 dead_conn_timeout;
 
 	struct nbd_sock **socks;
+	atomic_t connection_counter;
 	int num_connections;
 	atomic_t live_connections;
 	wait_queue_head_t conn_wait;
@@ -830,6 +832,10 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
 		blk_mq_start_request(req);
 		return -EINVAL;
 	}
+	if (test_bit(NBD_ROUND_ROBIN, &config->runtime_flags))
+		index = (atomic_inc_return(&config->connection_counter) %
+			 config->num_connections);
+
 	cmd->status = BLK_STS_OK;
 again:
 	nsock = config->socks[index];
@@ -1322,6 +1328,7 @@ static struct nbd_config *nbd_alloc_config(void)
 	init_waitqueue_head(&config->conn_wait);
 	config->blksize = 1024;
 	atomic_set(&config->live_connections, 0);
+	atomic_set(&config->connection_counter, 0);
 	try_module_get(THIS_MODULE);
 	return config;
 }
@@ -1782,6 +1789,8 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 			set_bit(NBD_DISCONNECT_ON_CLOSE,
 				&config->runtime_flags);
 		}
+		if (flags & NBD_CFLAG_ROUND_ROBIN)
+			set_bit(NBD_ROUND_ROBIN, &config->runtime_flags);
 	}
 
 	if (info->attrs[NBD_ATTR_SOCKETS]) {
@@ -1953,6 +1962,11 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 			clear_bit(NBD_DISCONNECT_ON_CLOSE,
 					&config->runtime_flags);
 		}
+
+		if (flags & NBD_CFLAG_ROUND_ROBIN)
+			set_bit(NBD_ROUND_ROBIN, &config->runtime_flags);
+		else
+			clear_bit(NBD_ROUND_ROBIN, &config->runtime_flags);
 	}
 
 	if (info->attrs[NBD_ATTR_SOCKETS]) {
diff --git a/include/uapi/linux/nbd.h b/include/uapi/linux/nbd.h
index 20d6cc91435d..ea74ba420dfa 100644
--- a/include/uapi/linux/nbd.h
+++ b/include/uapi/linux/nbd.h
@@ -56,6 +56,8 @@ enum {
 #define NBD_CFLAG_DISCONNECT_ON_CLOSE (1 << 1) /* disconnect the nbd device on
 						*  close by last opener.
 						*/
+#define NBD_CFLAG_ROUND_ROBIN (1 << 2) /* round robin requests on the
+					* connections for the device. */
 
 /* userspace doesn't need the nbd_device structure */
 
-- 
2.14.3

