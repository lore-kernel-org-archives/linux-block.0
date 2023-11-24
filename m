Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ZjjVSQ1Z"
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7694419A6
	for <linux-block@vger.kernel.org>; Fri, 24 Nov 2023 13:34:27 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a03a900956dso445362066b.1
        for <linux-block@vger.kernel.org>; Fri, 24 Nov 2023 13:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700861666; x=1701466466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80ODOo9m2Rg3srRTFfcDBosD4ljc7fJ0eSEeLwJNTXg=;
        b=ZjjVSQ1ZQuwqmo+9fLb3x9fB1yBuQ8GTcPHUygx+M6cR22guXLj8eql/Wu6qErPlyI
         cJ1aOyoo8k6Vqjh2BjQzGrbYlwvAMGeFkjwItIT+jh0CwkUSJE/viSstQMtnCegV0rJ9
         YYMUt0ZBnaqU/ii/EpwOuCDQrjRIEREfFzAnmszFPoSJGTRiYz42ydtGhsP8ml5wQ8jn
         jYhuPQrW6Q05g75rl2FCW+n0TXgTuqsN7lUHUfjRc717FzT8idJVDLY25ZamnHVjT35P
         c+xsQbcNYmuAuMxzzNoS+mLku4Vjgr1NI3TCbx2iE8m+yoWGH5ZWpY3hy7KFMgpAC1mC
         tNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700861666; x=1701466466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80ODOo9m2Rg3srRTFfcDBosD4ljc7fJ0eSEeLwJNTXg=;
        b=TmJuQitseLsZamveN8l1cTysNPDZB9/yGuXpheVGX+1SNy8neZ+kn5GehzjnxEfP3t
         LCr0efW2jSs/Bkj0eV8tqFsC8T8HD0ZwfRWyx958S0qsyeijq41q3V27ct6A9pN6yk8m
         LwbmqiZY0X1/42p1VwMqdhDtmU6poyyQZcvyqZmVoUF9UdqvFtoorawwHTm2mr4DdX6a
         JCbDkP7POC8jFMjLRgSW+EAfnbB6AUF5prWfO0VMymi1m0nZ3cqfzkQtgfmYR4qgS3QN
         neT8fy0hedD1v0X1uOeiKjcADBVGJTkfe/WljC/gMll90KfG5DB/JG/M13ptlf2FUsPa
         moxQ==
X-Gm-Message-State: AOJu0YyB43cDXqQoVbckVglsPHGQVC0u20dPK9szh9665QJkrpAzmf1Z
	Beg6AZ+epsZmtuVEH1rMyt7bf5KyUfQwgGiVKgo=
X-Google-Smtp-Source: AGHT+IHRqBQmJZn4OJXz9t/DDRA9eJYUT8ukc2S7zUQWhaSqwdGPocGwzt1u5bjhxN2iO0GQgT5lGw==
X-Received: by 2002:a17:906:11e:b0:a01:ae9a:c1d3 with SMTP id 30-20020a170906011e00b00a01ae9ac1d3mr3655015eje.11.1700861666072;
        Fri, 24 Nov 2023 13:34:26 -0800 (PST)
Received: from lb01533.speedport.ip (p200300f00f4ce298610448d17080cbe0.dip0.t-ipconnect.de. [2003:f0:f4c:e298:6104:48d1:7080:cbe0])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090668d200b009fc95fc3dabsm2548857ejr.130.2023.11.24.13.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 13:34:25 -0800 (PST)
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
Subject: [PATCH v2 for-next 2/2] block/rnbd: use %pe to print errors
Date: Fri, 24 Nov 2023 22:34:22 +0100
Message-Id: <20231124213422.113449-3-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231124213422.113449-1-haris.iqbal@ionos.com>
References: <20231124213422.113449-1-haris.iqbal@ionos.com>
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
index 64ad1cd44942..29733b615754 100644
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
 
 	bdev_handle = bdev_open_by_path(full_path, open_flags, NULL, NULL);
 	if (IS_ERR(bdev_handle)) {
 		ret = PTR_ERR(bdev_handle);
-		pr_err("Opening device '%s' on session %s failed, failed to open the block device, err: %d\n",
-		       full_path, srv_sess->sessname, ret);
+		pr_err("Opening device '%s' on session %s failed, failed to open the block device, err: %pe\n",
+		       full_path, srv_sess->sessname, bdev_handle);
 		goto free_path;
 	}
 
 	srv_dev = rnbd_srv_get_or_create_srv_dev(bdev_handle->bdev, srv_sess,
 						  open_msg->access_mode);
 	if (IS_ERR(srv_dev)) {
-		pr_err("Opening device '%s' on session %s failed, creating srv_dev failed, err: %ld\n",
-		       full_path, srv_sess->sessname, PTR_ERR(srv_dev));
+		pr_err("Opening device '%s' on session %s failed, creating srv_dev failed, err: %pe\n",
+		       full_path, srv_sess->sessname, srv_dev);
 		ret = PTR_ERR(srv_dev);
 		goto blkdev_put;
 	}
@@ -737,8 +737,8 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
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
@@ -819,7 +819,7 @@ static int __init rnbd_srv_init_module(void)
 	};
 	rtrs_ctx = rtrs_srv_open(&rtrs_ops, port_nr);
 	if (IS_ERR(rtrs_ctx)) {
-		pr_err("rtrs_srv_open(), err: %d\n", err);
+		pr_err("rtrs_srv_open(), err: %pe\n", rtrs_ctx);
 		return PTR_ERR(rtrs_ctx);
 	}
 
-- 
2.25.1

