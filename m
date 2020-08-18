Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E3DC433DF
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 04:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D692A2072A
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 04:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQFsAJKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgHREMo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 00:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgHREMn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 00:12:43 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB52C061389;
        Mon, 17 Aug 2020 21:12:42 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id d27so14216543qtg.4;
        Mon, 17 Aug 2020 21:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hXLCDfrcY5+egor1E3ATfAy15D+Z8YefF1V4ZEaEKWs=;
        b=CQFsAJKSDdLlK3EhRNv8Z+2s7zS5F6umJ9AQlthkXD6FPmHHIHJ0xmjQgnRIDPvjIK
         LIDlw+c/jKJWU5j81LM7I3qDNXFytBw2i5gCvMP4Luu/00YfE+Sv2TOSFm+i1XaFoXzX
         MgCZ4zOxi9UlsItvXwDU5pjAT5XzMEJZW/GG50wgPowfpvokDRqPX1D9OY2KAfmt05vA
         XCu2lRg191aqx42qf9gTZlzPUddGOzGpHTVJrz7v4eX7lKb//h7JqmBHmbDaf04Bq+9G
         PkXqIwAVE73e+Uz4y4T/w/JXFyENAzMhvah3QTgZb9FZu6sE9fgt4RUo1cRQVv306KDo
         1pgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hXLCDfrcY5+egor1E3ATfAy15D+Z8YefF1V4ZEaEKWs=;
        b=XL5OOhsGRXgQ7ZFBwvIgG1FqiaEpVcfoRc4BGfA4Tjnt/Mf3eDdwNX52NOQ+KrcIVM
         bEAkwV7xE7vXPI5xCn3CASYU+EsDhVflFbSBetQ797RNwtlowqQN01MhIqpHgGdEnOHL
         +PX0WcFQO6Cx+1cUD3+/OA0NSkRicJeuthuNP3ZfiMHtxos3yDDjVhiTLSAvLcLHxTNV
         MwGbY1C2HwdcHj0DBdWYf3Jep26nxgocwqdN3q262AGvzn0g9f03Ms9XzuO8Z704fCTA
         JNTsskCMH3ih4aWs8NCw1/Vq1MQWk61IOCLDwpiWlv0eiJV0hGSEjTyZw9sAg5jqeG/h
         wpTw==
X-Gm-Message-State: AOAM533aCpDvdlY5ARSJUXRx5iCuxZb3XktkwJqeEpXqtAPQS+xBpE1j
        d0v5Mn8aXcFAPb2fy7V6LvIX/VIo/TsBqQ==
X-Google-Smtp-Source: ABdhPJzaOrgJhzGbXOnMQBgWRgj5jPoujDkofHqlBTpYElKd3yqJ8qhcCmgFn27KsFM9jDNkDTNmrQ==
X-Received: by 2002:ac8:4519:: with SMTP id q25mr16754352qtn.29.1597723961327;
        Mon, 17 Aug 2020 21:12:41 -0700 (PDT)
Received: from magi.myfiosgateway.com (pool-173-75-208-99.phlapa.fios.verizon.net. [173.75.208.99])
        by smtp.gmail.com with ESMTPSA id i65sm19592212qkf.126.2020.08.17.21.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 21:12:40 -0700 (PDT)
From:   Brooke Basile <brookebasile@gmail.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Brooke Basile <brookebasile@gmail.com>
Subject: [PATCH] block: rnbd: rnbd-srv: silence uninitialized variable warning
Date:   Tue, 18 Aug 2020 00:03:18 -0400
Message-Id: <20200818040317.5926-1-brookebasile@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Clang warns:
	drivers/block/rnbd/rnbd-srv.c:150:6: warning: variable 'err' is used
	uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
        	if (IS_ERR(bio)) {
            	^~~~~~~~~~~
	drivers/block/rnbd/rnbd-srv.c:177:9: note: uninitialized use occurs here
		return err;
		^~~
	drivers/block/rnbd/rnbd-srv.c:126:9: note: initialize the variable 'err'
	to silence this warning
        	int err;
               	^
                	= 0

Silence this by replacing `err` with `ret`, returning ret = 0 upon
success.

Signed-off-by: Brooke Basile <brookebasile@gmail.com>
---
 drivers/block/rnbd/rnbd-srv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 0fb94843a495..f515d1a048a9 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -123,10 +123,10 @@ static int process_rdma(struct rtrs_srv *sess,
 	struct rnbd_io_private *priv;
 	struct rnbd_srv_sess_dev *sess_dev;
 	u32 dev_id;
-	int err;
 	struct rnbd_dev_blk_io *io;
 	struct bio *bio;
 	short prio;
+	int ret = 0;
 
 	priv = kmalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -138,7 +138,7 @@ static int process_rdma(struct rtrs_srv *sess,
 	if (IS_ERR(sess_dev)) {
 		pr_err_ratelimited("Got I/O request on session %s for unknown device id %d\n",
 				   srv_sess->sessname, dev_id);
-		err = -ENOTCONN;
+		ret = -ENOTCONN;
 		goto err;
 	}
 
@@ -168,13 +168,13 @@ static int process_rdma(struct rtrs_srv *sess,
 
 	submit_bio(bio);
 
-	return 0;
+	return ret;
 
 sess_dev_put:
 	rnbd_put_sess_dev(sess_dev);
 err:
 	kfree(priv);
-	return err;
+	return ret;
 }
 
 static void destroy_device(struct rnbd_srv_dev *dev)
-- 
2.28.0

