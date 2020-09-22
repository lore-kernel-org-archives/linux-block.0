Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E078FC4363D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 03:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C0E8206FB
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 03:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="sxhWSarw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgIVDfN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 23:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgIVDfM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 23:35:12 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA1EC061755
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 20:35:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l71so10813108pge.4
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 20:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9wLhhzcNS0P7UTjgkUlOAA40Hjt+i5A3fNAKc5EV9IU=;
        b=sxhWSarwoCyNbCnN9Wsb7ZIsqOkyXrw5ITBC797khUx7oHmbhvT/mQBcF35Vw/ZwE7
         wbX73TxH1qYXOUtc4zaWYHfh9KOl+513K6md8E7dwrQUEZrzp66MAQzrLGx52Hc8S1UQ
         V4G5CwflbhdWRHLEENkpHg0IkRSulryc6FNoEglASIh50rw+Xh3dtk4Uj/N26Q+FQOCH
         8cC/lFRLjqEF1J5HweRpKl28q2gvdREh6JqdTXuVwd5kgu7/X82SXzROIRD+IUw5O/TN
         a9mmv6d9YkZ1Q0SLoIh5sJbmWXQNEGQkGq/MMz1OMJihNTKMxzOIUwbRag8mNTdCiG/C
         om8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9wLhhzcNS0P7UTjgkUlOAA40Hjt+i5A3fNAKc5EV9IU=;
        b=bGZrImEMjFpujFThImHsaIXKw1KGViT3M+CtWOSC4Otv1hZZb227wK44RMPRN0r65j
         kA/PuveiFWOcJl2a0kgxNU/uzt4HGciLrt9d7zFSO2qrRy+Q1O+I32mOaHMYA/xqF8g1
         KMyAR3+Eq/VAz1K48r7wKUQ1SIcq9NOOyH0qrFKFOPtwdQBZquysKyILsE/TDjZqj0G3
         OJsriR2ErWlijaGTs/ZvJ0jc+E5/SSi1Phz8WraB900impmE4jLsKasBWbCosBhhPXsT
         LE0Uo518yfF7TD/nhv/sv5WAfyxWL/YXiTNjpNWwEL6nxxfS8RoUMxK8RwKDcgAA7MHm
         TlLA==
X-Gm-Message-State: AOAM533KeS1AiIbMOrZrtgbaDKzGlCdLzB9F94YtiOwFHpM4bju59dHH
        aHF5BlEUy5/G0XAYlbUEP+H7BA==
X-Google-Smtp-Source: ABdhPJxf/JOJUbigEKnDT/59OY8WC2Ho7Y+15oVK2BX3j5LinFq0BzKxJGIramXoBTy+i4muz337pQ==
X-Received: by 2002:a63:fe57:: with SMTP id x23mr1948009pgj.309.1600745712439;
        Mon, 21 Sep 2020 20:35:12 -0700 (PDT)
Received: from box.bytedance.net ([61.120.150.73])
        by smtp.gmail.com with ESMTPSA id mp3sm714859pjb.33.2020.09.21.20.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 20:35:11 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, Hou Pu <houpu@bytedance.com>
Subject: [PATCH v2 1/2] nbd: return -ETIMEDOUT when NBD_DO_IT ioctl returns
Date:   Tue, 22 Sep 2020 11:34:56 +0800
Message-Id: <20200922033457.46227-2-houpu@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922033457.46227-1-houpu@bytedance.com>
References: <20200922033457.46227-1-houpu@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We used to return -ETIMEDOUT if io timeout happened. But since
commit d970958b2d24 ("nbd: enable replace socket if only one
connection is configured"), user space would not get -ETIMEDOUT.
This commit fixes this. Only return -ETIMEDOUT if only one socket
is configured by ioctl and the user specified a non-zero timeout
value.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Hou Pu <houpu@bytedance.com>
---
 drivers/block/nbd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ce7e9f223b20..538e9dcf5bf2 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -395,6 +395,11 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	}
 	config = nbd->config;
 
+	if (!test_bit(NBD_RT_BOUND, &config->runtime_flags) &&
+	    config->num_connections == 1 &&
+	    nbd->tag_set.timeout)
+		goto error_out;
+
 	if (config->num_connections > 1 ||
 	    (config->num_connections == 1 && nbd->tag_set.timeout)) {
 		dev_err_ratelimited(nbd_to_dev(nbd),
@@ -455,6 +460,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 		return BLK_EH_RESET_TIMER;
 	}
 
+error_out:
 	dev_err_ratelimited(nbd_to_dev(nbd), "Connection timed out\n");
 	set_bit(NBD_RT_TIMEDOUT, &config->runtime_flags);
 	cmd->status = BLK_STS_IOERR;
-- 
2.11.0

