Return-Path: <SRS0=nPog=C6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DD0C43466
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 10:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A431C207BC
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 10:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="uqDVLCYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgIUK5s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbgIUK5r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 06:57:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB8AC061755
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 03:57:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o25so3751599pgm.0
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 03:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/xfvcdsom/q5CUNFRcCmgVmkzsyJDy2Xd2OuyVyhn8=;
        b=uqDVLCYQdF1Ohh6ZxVL4Mu7FFkm44LXZf6/pkHn6s6e2ym9Li56WYMHqTel7GwRF0B
         zgFyXa2swPoJOeFy30PK+tG741ycyZ/nwWVzLDFfwj0m119f08t5xXyxqZTf7Wwu5u+y
         lenY0/uPwqWOYpUigNwuLtglCwjhUOe6GGr/1r2KEo6rr5Bg4ECnfE2WoEOaaoOrflIi
         BpbdYfOq6/WXXwLEtHiawcH66+iEPIwiUOd9YvS5WVF6UEUjWNq0Ww1Y7bjnOpak49Lc
         GL0Eb5aaU+ImmSN2V5VHrZ07K+JFo1JSfz+nDh74x1y2z2Ry3BT2SpXVxSY2jDW3EEM5
         0C3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/xfvcdsom/q5CUNFRcCmgVmkzsyJDy2Xd2OuyVyhn8=;
        b=bdWsbWJDYoaxNwwBWyIimyMaSLJ81qNlMp4ZSNEaj+I9TxF8b8MLM0TFu3WMmXUgyM
         9IB3WtApud66JSjllegbkFOpJiAv5c0q3ephjpkkmNWyi3ho228OsVC+2z8skQkqIunA
         mcapmQnQRinU6/usDYi36P7Y+9Lu5dlqpKsdFZIB8amTz+x03mAwudTP+c7Ex2NpUHaV
         HtyC4cu5OcF3OkYQ9EZFZvuUZ2zV/pAdZH8FnWymFsL+BgwecD/rkxsgkFc4JhN4wzb4
         P3aEeDlqivX4Cpan0vP0LQHwT2oIYPHFHSBhoAUEoQcq9I7VFSdfU9iGb0xKsYYKQ6ks
         h40Q==
X-Gm-Message-State: AOAM531vhhc4Y3F/ZIiqjtl2/qkZz6pdq1jLVp/XkDo8lEiAEJ/lMpuh
        Oi0aShuVkc5tCBKYte3S1w6Bvg==
X-Google-Smtp-Source: ABdhPJwk3qxw881cWJf/l4dmF0k0V+qLlV4v6C5M4UEKY+xiqhQbULAd/YIQrRtCDUEyIfyq8hJDeA==
X-Received: by 2002:a17:902:ba98:b029:d1:e598:3ff2 with SMTP id k24-20020a170902ba98b02900d1e5983ff2mr26553974pls.44.1600685866739;
        Mon, 21 Sep 2020 03:57:46 -0700 (PDT)
Received: from box.bytedance.net ([61.120.150.73])
        by smtp.gmail.com with ESMTPSA id x62sm2792533pfx.20.2020.09.21.03.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:57:46 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, Hou Pu <houpu@bytedance.com>
Subject: [PATCH 3/3] nbd: introduce a client flag to do zero timeout handling
Date:   Mon, 21 Sep 2020 18:57:18 +0800
Message-Id: <20200921105718.29006-4-houpu@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921105718.29006-1-houpu@bytedance.com>
References: <20200921105718.29006-1-houpu@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce a dedicated client flag NBD_RT_WAIT_ON_TIMEOUT to reset
timer in nbd_xmit_timer instead of depending on tag_set.timeout == 0.
So that the timeout value could be configured by the user to
whatever they like instead of the default 30s. A smaller timeout
value allow us to detect if a new socket is reconfigured in a
shorter time. Thus the io could be requeued more quickly.

The tag_set.timeout == 0 setting still works like before.

Signed-off-by: Hou Pu <houpu@bytedance.com>
---
 drivers/block/nbd.c      | 25 ++++++++++++++++++++++++-
 include/uapi/linux/nbd.h |  4 ++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 4c0bbb981cbc..1d7a9de7bdcc 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -80,6 +80,7 @@ struct link_dead_args {
 #define NBD_RT_BOUND			5
 #define NBD_RT_DESTROY_ON_DISCONNECT	6
 #define NBD_RT_DISCONNECT_ON_CLOSE	7
+#define NBD_RT_WAIT_ON_TIMEOUT		8
 
 #define NBD_DESTROY_ON_DISCONNECT	0
 #define NBD_DISCONNECT_REQUESTED	1
@@ -378,6 +379,16 @@ static u32 req_to_nbd_cmd_type(struct request *req)
 	}
 }
 
+static inline bool wait_on_timeout(struct nbd_device *nbd,
+				   struct nbd_config *config)
+{
+	if (test_bit(NBD_RT_WAIT_ON_TIMEOUT, &config->runtime_flags) ||
+	    nbd->tag_set.timeout == 0)
+		return true;
+	else
+		return false;
+}
+
 static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 						 bool reserved)
 {
@@ -400,7 +411,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	    nbd->tag_set.timeout)
 		goto error_out;
 
-	if (nbd->tag_set.timeout) {
+	if (!wait_on_timeout(nbd, config)) {
 		dev_err_ratelimited(nbd_to_dev(nbd),
 				    "Connection timed out, retrying (%d/%d alive)\n",
 				    atomic_read(&config->live_connections),
@@ -1953,6 +1964,10 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 			set_bit(NBD_RT_DISCONNECT_ON_CLOSE,
 				&config->runtime_flags);
 		}
+		if (flags & NBD_CFLAG_WAIT_ON_TIMEOUT) {
+			set_bit(NBD_RT_WAIT_ON_TIMEOUT,
+				&config->runtime_flags);
+		}
 	}
 
 	if (info->attrs[NBD_ATTR_SOCKETS]) {
@@ -2136,6 +2151,14 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 			clear_bit(NBD_RT_DISCONNECT_ON_CLOSE,
 					&config->runtime_flags);
 		}
+		if (flags & NBD_CFLAG_WAIT_ON_TIMEOUT) {
+			set_bit(NBD_RT_WAIT_ON_TIMEOUT,
+				&config->runtime_flags);
+		} else {
+			clear_bit(NBD_RT_WAIT_ON_TIMEOUT,
+				  &config->runtime_flags);
+		}
+
 	}
 
 	if (info->attrs[NBD_ATTR_SOCKETS]) {
diff --git a/include/uapi/linux/nbd.h b/include/uapi/linux/nbd.h
index 20d6cc91435d..cc3abfb92de5 100644
--- a/include/uapi/linux/nbd.h
+++ b/include/uapi/linux/nbd.h
@@ -56,6 +56,10 @@ enum {
 #define NBD_CFLAG_DISCONNECT_ON_CLOSE (1 << 1) /* disconnect the nbd device on
 						*  close by last opener.
 						*/
+#define NBD_CFLAG_WAIT_ON_TIMEOUT (1 << 2) /* do not fallback to other sockets
+					    * in io timeout, instead just reset
+					    * timer and wait.
+					    */
 
 /* userspace doesn't need the nbd_device structure */
 
-- 
2.11.0

