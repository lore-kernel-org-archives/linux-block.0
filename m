Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E23BB4A
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UrU1sbhk"
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CD7AB
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 08:37:54 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5440f25dcc7so10727201a12.0
        for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 08:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700066273; x=1700671073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwUpW1eiP2BF99iHOGbQ5+NBHyvpfqJeou6pFt4IiJA=;
        b=UrU1sbhkHdGARyBcPNgzT0bv91Qzl/aFF4OZ7zyIXOSokwe+pLOngLeCTB6JR1l2oC
         03j8oUfJx35PXiq+HKlFmF5c5ub4lRyCGKaN6Nsx2t2pHWZ0WBjGy2fgM0fM3AC/X2yE
         z8VOHMhZFF9Il/XO2JPpmHs7XoIsl5Ao1FbWR4APHB4giQGLt286M9Y+0Datc6qNfgve
         zNHg0b3HYuRCd4tnkDuVvRvM4DXn0wc+5n4hInhz++5+xEE840MwVBDAxPV2vmGcdPvG
         bP8MvZbemx3xkyZcJG9bMfYhpiM72yadxWd4c8E0JdGWgmE0kthhoXtybekNhzTto7DK
         kkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700066273; x=1700671073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwUpW1eiP2BF99iHOGbQ5+NBHyvpfqJeou6pFt4IiJA=;
        b=bPdWkDzee+sck8slEoDdOjhhuwiomNJvSd+5j1kyNQTOf3KF/5OvADyVA3rV7Am+fH
         AsiF31VVfTfNGkFNVHMP6HzH2AJTDTqeNggx3z/ytsRUiyTLNLFrklBIdxuu/0L5JGt0
         IXqIa4IAGxyFkSKw/9V4b4uQnSf09ldOUeS1VdhKDUKUxtjHAHqj3vryNP5vKB1rqrdg
         2EwyhpSUSuPVyLyQ6QQ96l3t0nrgI57wBMcyd3lrUkAdtdqsa7k8jZDYBYtXpGkhg9hz
         mO1qWyYYcRxdG0FuPyrnEbuXkY4TWyK05zW1iqfb6+k8fndgPOkB/GiWK3bwPPR+FjWs
         VOFw==
X-Gm-Message-State: AOJu0YzI2Vjcc23JR23pXOcFbZuGijN+o4tCMr+sUYf8m3eB1Tr7gbOX
	KjQlptg2vYF/qNLp67dewgUh+5r6zrTZiXHIo9k=
X-Google-Smtp-Source: AGHT+IH3GbIn/S7Bzyif7I9jUvyDwJuYyZjefqln0eoZRyWf2TGbaV8TL58Q43mcz+785AGT5RYffw==
X-Received: by 2002:a17:906:6607:b0:9c3:1d7e:f5b5 with SMTP id b7-20020a170906660700b009c31d7ef5b5mr8949700ejp.20.1700066273376;
        Wed, 15 Nov 2023 08:37:53 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id sa31-20020a1709076d1f00b009d2eb40ff9dsm4591316ejc.33.2023.11.15.08.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:37:53 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@infradead.org,
	sagi@grimberg.me,
	bvanassche@acm.org,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Supriti Singh <supriti.singh@ionos.com>,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 2/2] block/rnbd: use %pe to print errors
Date: Wed, 15 Nov 2023 17:37:49 +0100
Message-Id: <20231115163749.715614-3-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231115163749.715614-1-haris.iqbal@ionos.com>
References: <20231115163749.715614-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Supriti Singh <supriti.singh@ionos.com>

While printing error, replace %ld by %pe. %pe prints a string
whereas %ld would print an error code.

Signed-off-by: Supriti Singh <supriti.singh@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c |  4 ++--
 drivers/block/rnbd/rnbd-srv.c | 22 +++++++++++-----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 499d0e655bc3..4044c369d22a 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1569,8 +1569,8 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 
 	dev = init_dev(sess, access_mode, pathname, nr_poll_queues);
 	if (IS_ERR(dev)) {
-		pr_err("map_device: failed to map device '%s' from session %s, can't initialize device, err: %ld\n",
-		       pathname, sess->sessname, PTR_ERR(dev));
+		pr_err("map_device: failed to map device '%s' from session %s, can't initialize device, err: %pe\n",
+		       pathname, sess->sessname, dev);
 		ret = PTR_ERR(dev);
 		goto put_sess;
 	}
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index c6dafce731dc..8ccc74c133ac 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -136,8 +136,8 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
 
 	sess_dev = rnbd_get_sess_dev(dev_id, srv_sess);
 	if (IS_ERR(sess_dev)) {
-		pr_err_ratelimited("Got I/O request on session %s for unknown device id %d\n",
-				   srv_sess->sessname, dev_id);
+		pr_err_ratelimited("Got I/O request on session %s for unknown device id %d: %pe\n",
+				   srv_sess->sessname, dev_id, sess_dev);
 		err = -ENOTCONN;
 		goto err;
 	}
@@ -710,24 +710,24 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	full_path = rnbd_srv_get_full_path(srv_sess, open_msg->dev_name);
 	if (IS_ERR(full_path)) {
 		ret = PTR_ERR(full_path);
-		pr_err("Opening device '%s' for client %s failed, failed to get device full path, err: %d\n",
-		       open_msg->dev_name, srv_sess->sessname, ret);
+		pr_err("Opening device '%s' for client %s failed, failed to get device full path, err: %pe\n",
+		       open_msg->dev_name, srv_sess->sessname, full_path);
 		goto reject;
 	}
 
 	bdev = blkdev_get_by_path(full_path, open_flags, NULL, NULL);
 	if (IS_ERR(bdev)) {
 		ret = PTR_ERR(bdev);
-		pr_err("Opening device '%s' on session %s failed, failed to open the block device, err: %d\n",
-		       full_path, srv_sess->sessname, ret);
+		pr_err("Opening device '%s' on session %s failed, failed to open the block device, err: %pe\n",
+		       full_path, srv_sess->sessname, bdev);
 		goto free_path;
 	}
 
 	srv_dev = rnbd_srv_get_or_create_srv_dev(bdev, srv_sess,
 						  open_msg->access_mode);
 	if (IS_ERR(srv_dev)) {
-		pr_err("Opening device '%s' on session %s failed, creating srv_dev failed, err: %ld\n",
-		       full_path, srv_sess->sessname, PTR_ERR(srv_dev));
+		pr_err("Opening device '%s' on session %s failed, creating srv_dev failed, err: %pe\n",
+		       full_path, srv_sess->sessname, srv_dev);
 		ret = PTR_ERR(srv_dev);
 		goto blkdev_put;
 	}
@@ -736,8 +736,8 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 				open_msg->access_mode == RNBD_ACCESS_RO,
 				srv_dev);
 	if (IS_ERR(srv_sess_dev)) {
-		pr_err("Opening device '%s' on session %s failed, creating sess_dev failed, err: %ld\n",
-		       full_path, srv_sess->sessname, PTR_ERR(srv_sess_dev));
+		pr_err("Opening device '%s' on session %s failed, creating sess_dev failed, err: %pe\n",
+		       full_path, srv_sess->sessname, srv_sess_dev);
 		ret = PTR_ERR(srv_sess_dev);
 		goto srv_dev_put;
 	}
@@ -818,7 +818,7 @@ static int __init rnbd_srv_init_module(void)
 	};
 	rtrs_ctx = rtrs_srv_open(&rtrs_ops, port_nr);
 	if (IS_ERR(rtrs_ctx)) {
-		pr_err("rtrs_srv_open(), err: %d\n", err);
+		pr_err("rtrs_srv_open(), err: %pe\n", rtrs_ctx);
 		return PTR_ERR(rtrs_ctx);
 	}
 
-- 
2.25.1

