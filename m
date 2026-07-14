Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0C73988FB
	for <linux-block@vger.kernel.org>; Tue, 14 Jul 2026 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030010; cv=none; b=ZIia014huBpAh5pKDlHTSwwpKJtSE56GI7PYg0H0sCRig9Ttyc/0WNi0mImTHUOOMLnpx6NErC0pDkssbBPbNd2Z28BVpUhpMPM6zk4HtsWHuC7yGwUiggL9pQCJAwoftJlyf4bf5WQnGPnJT94BLOpstGc+tWI+qdCoiem/L2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030010; c=relaxed/simple;
	bh=uEJvVCkmHOvFYP+eSvMNv8ZhynMnE8aWkYiTYUJgs7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FIs5fdAKlnoIL7gwh2GgdhpfxM9nuYmigiUMmDNxfqpXtfBNIw59fR9F1koBuz66AvMKshGqNqvkJsVDsvQsHfjVuxY4Ub7Kvx4xKnYGolzMf/sQEbhec+Si8WvpWDmC/pgJ/xLYOqoAAcaK2D2KoAWi7jCJynMXD61INPv73Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUtPVSTz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUtPVSTz"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-381b831d535so994188a91.0
        for <linux-block@vger.kernel.org>; Tue, 14 Jul 2026 04:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030008; x=1784634808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EM2CA/sZkLiaC+4R5X6O7VrwHDInDWut6K0oPFdflpY=;
        b=SUtPVSTzQALSFnCitUxCvA9E6/jbioLWGiuCIeur4rLR5/pJ8YohGLYXPz9QBBG9eQ
         KX691p17VNMdSgZIeSTWpiP2kFdT1jpSSIxvV4mrp8juHfovNxXaZw88+FeqZSnlEn5G
         aY0zifIfur9mknynu+34KiNmSUyIQb4XZLiTRFfOKfgAw5O3wrTbyCaAsGW/V1ZTACRg
         HbhyzgYf2hycleiaqE4kDbhI/HwueisdRofRPbb+oTgCDebnkRA954+zEsXFi/737wGE
         pKWgyroO+uY3I9x4/4JVSIA+gzF5SX30x/bjDAGCeMTKGuvpRhZv2HZKb7rUnuoW6wzz
         Tj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030008; x=1784634808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EM2CA/sZkLiaC+4R5X6O7VrwHDInDWut6K0oPFdflpY=;
        b=a/jmcVMkPRkcgFnrn6EWkqg/N9XrpjrREaT2KsbBiIqdMRxWFNcXAoHVBW3gpt5ANo
         MIePpHqMBP2TKqERDr/c/hsrvSiRUvtDpVXOsGmYhP6MwStUpR9oc1xYo0tzMHjsf95j
         JeZLVAKxqpNwcA2lzSpW9h428U0GGNpuKZfH7LAv83QepLOdL2w3G2Mavi2ACTE3rzPO
         an7GufOkr6kla2WvH4BnV9PiB54CkArBEThoEBQWIeYzYEX1d5EFI1X/s0FPF5TQOmPy
         t2Xkis/cYZA2mz5aCmUwOaz9BD13ViWpZnaH+q9TUYRrB2hPPTvWlwb3KQpkF7h8w5VQ
         BACg==
X-Forwarded-Encrypted: i=1; AHgh+Rpzkgjm/r16y32WJT5gBRH1v8BBLmuzc8WkzP8SWC1CwUtbmSTxzl6TX7JElSaSdU+Gc05vgwAwNLpnaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwD+cwGTuMUj+OskpcNChcjXY48KsZLuEqr1JfcjpdO9wFJ+Eni
	nH3aOxDWQ7j3PgWcxbD8Qq+6geznSTizFJgpHyZnA6OeA230ZJT6udLM
X-Gm-Gg: AfdE7cnhN+TZiiWLHLarKcDkSNHVxPtHZZJYbv/oalMn51tKa9tvNnSNTOZ2+n5o3r2
	kV5LMOZRZHGZI23lXmrE5s+O8UHNZ0X4MIAsNwr5srTlaKsw35p2sMIt5hNciw8ElrL4cmK2K8r
	bdgFTBo/hWNB1LTnnOyYkt4ZJ8KzbcIkZ5rs2EthlR8SXui0QutcYlmamK0mi+s1gRj00KP45W+
	9Bx8zHe6VTnpublav3KmIA3T9tL6CsFdJ+SIapDAd+WtrkZROa1yRTpnnnXLMgXC1DTg8wc9Sak
	8zrUzFCxOE56+T3Q8ku8SsGspnflLOMOhdtTxSCZrPGczretAc0u1WTy4kMndLac5IxrM2HZR4E
	GK9xjECPN/JMFFQcnOz9ZhrFnglu/VeIzmyU1ng27sAwwQrjtSzyuAX7nw+N+6k7+gG1C5R4KAd
	ttEcy7KQ==
X-Received: by 2002:a17:90b:35c4:b0:381:21c1:75c0 with SMTP id 98e67ed59e1d1-38dc74cfa71mr12709581a91.15.1784030007543;
        Tue, 14 Jul 2026 04:53:27 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cef8852e68sm4073615ad.37.2026.07.14.04.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:53:27 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jens Axboe <axboe@kernel.dk>,
	Danil Kipnis <danil.kipnis@cloud.ionos.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Bart Van Assche <bvanassche@acm.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] block/rnbd: Fix double free in process_msg_open
Date: Tue, 14 Jul 2026 19:50:51 +0800
Message-ID: <20260714115051.1401174-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

process_msg_open() allocates srv_sess_dev with
rnbd_srv_create_set_sess_dev() and then initializes its embedded kobject
through rnbd_srv_create_dev_session_sysfs().

If sysfs creation fails, the helper calls kobject_put(). The final put
invokes rnbd_srv_sess_dev_release(), which reaches
rnbd_destroy_sess_dev() and frees srv_sess_dev. process_msg_open() then
jumps to free_srv_sess_dev and calls kfree() on the same object again,
resulting in a double free.

Add the session device to the list and release srv_dev->lock before
creating the sysfs entries. On failure, rely on the kobject release
callback as the sole owner of the cleanup instead of freeing the object
again.

This issue was found by a static analysis tool I am developing.

Fixes: 8cee532f469b ("block/rnbd: server: sysfs interface functions")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/block/rnbd/rnbd-srv.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 10e8c438bb43..5a991bfbf3ad 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -778,18 +778,22 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 		}
 	}
 
+	/*
+	 * Add the session device to the list before initializing its
+	 * kobject. If sysfs creation fails, kobject_put() invokes the
+	 * release callback, which removes the object from this list and
+	 * releases all resources associated with the session device.
+	 */
+	list_add(&srv_sess_dev->dev_list, &srv_dev->sess_dev_list);
+	mutex_unlock(&srv_dev->lock);
+
 	ret = rnbd_srv_create_dev_session_sysfs(srv_sess_dev);
 	if (ret) {
-		mutex_unlock(&srv_dev->lock);
-		rnbd_srv_err(srv_sess_dev,
-			      "Opening device failed, failed to create dev client sysfs files, err: %d\n",
-			      ret);
-		goto free_srv_sess_dev;
+		pr_err("Opening device '%s' on session %s failed, failed to create dev client sysfs files, err: %d\n",
+		       full_path, srv_sess->sessname, ret);
+		goto free_path;
 	}
 
-	list_add(&srv_sess_dev->dev_list, &srv_dev->sess_dev_list);
-	mutex_unlock(&srv_dev->lock);
-
 	rnbd_srv_info(srv_sess_dev, "Opened device '%s'\n", srv_dev->name);
 
 	kfree(full_path);
-- 
2.43.0

