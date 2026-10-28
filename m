Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205908;
	b=HFtQIPqelwYxoJZRXENmpJQVrdFSYQki4zzGi6WQuSV+IjkclUjd01hGM4n9fnXlY0qm
	 NBpMvq6wvev0xUppMRJwUnLE4iMzaH2pgnpO8zc1+CDoAJfRKKH5EB8UH5LN39BPKUOZw
	 4SkloTr8M9hfVmdGgkxF/7bKiDpDr9GZ2+uNwn7QEl3cA/gMlYeUHmKB6B10z6a82dk6a
	 5e+2RcIRXBAzQdg5LrUuwY1namDJ/vfbYidSYw7yEyJ+6uSjfmGH2UN8BOa0J9k4BC9Ls
	 6qGHNi3ucD+iC+cKFrAl9m0R+7hjiR0HI/B9kX9kFAnfy4esBys38Vp5mr5bwk06V8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NPYId+WLZ9CYq7PztDOdkbzT95eHKob8nO+vC7K1yIE=;
	b=YaoVaHs7BSFbBnw6gkNo5QlZTdzwqR4j3kRC4q0pavygo76YgRTsy2ZeTG3EV+/ip/wM
	 WzeBFwcpDR3V7omjx6MR9ukwziWo03oMsbr7mMbnbbl5/YFnN6JQMf6bX49+HkaVZbgMY
	 di8c7GrOsXlJ6SPlhVFuU7KPqWqs6IbhF7rOpnADVMLskRD4xD77CrP6DALw8Qe+eegKF
	 8ZHF8LfiyezmG+LrZdzlkgpPfRDHxvSwamAabFQoGM71JJ/N39WTJBcWSEn0Wku2Oyv2k
	 loajFBiL/QYjM5povJcqkQzNCi6W/G86Qj4oqoXvfVZ6aQjolWjN0CfS7nrqKOuG0wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WVi5fPx5;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2595A606A322
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2595A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WVi5fPx5
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6df5e315bd1so911281eaf.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205907; x=1793810707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NPYId+WLZ9CYq7PztDOdkbzT95eHKob8nO+vC7K1yIE=;
        b=WVi5fPx5CYBze1SL/ej1es+fEy0HFwe28exS5ksMRVmF/4j7XtECfmTMnBJOVV0EKd
         3Cjd6v4+DRO8KcnY2A6J/NxbPl7gVoK3bfu1220N1Rv/I6JayG6MRpVMIt2gBoyX1Yoz
         Eqjd8t1DzRyWKrXIeYqkq1HClANeQ2xe8TwxJ+cYNd+ZgWuuFAO+vd7YV2gJ3jgdicnk
         LoR5t+g/cnf1UVnn2BTUppcpX8cTO6Io63bVp/b/s65uXoMq0D3JqrVKGeuPmRytUkPY
         ZYLFGGsGU9FVHE+RUr0GsrbATN1Wl1ucxe+21P5OShaQO/PwJHPmDhz0ns06KuEpfArz
         9D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205907; x=1793810707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NPYId+WLZ9CYq7PztDOdkbzT95eHKob8nO+vC7K1yIE=;
        b=BCWPSNhaIDuBECFK/QSB9tZy4kruR14fV32EbVKd8kfewwg+DTrCaCOv9JED0q2SS+
         fSnGXM5EYt6ENUSbkArIv7sIDj9dal6Bt4WRL3W2VK3VnpstxbV5ECv18i4pi+FYJ84A
         h0PfiaY94O6OU6B1+NtY/OBWCygI0RGl+RDPJC9WqMNNx63Y0jtME4cY4e7pULTlu+kZ
         COexXe5diYroaxm4LmAg7JU5XVVzHUjJrMqx1R/atV5oQgjD+Fvl6snaYCQxpWslwpJD
         N+ul6iBS3u0BlNOCU/kwZo5MLv2PdLMnKbCkKyQ44Egp5fE0lBEDDJPO2U1MwfEJmdmJ
         +H0w==
X-Gm-Message-State: AFq9FYIydXOLJUFAiiVAYURAxIrasdtu6/pRMkztwFh6jyEfnyQoCRxo
	SbBkzqWkF9U6xs/DuAQRdjWubQYeKHgX367ZArOgK2mFKz4BWfFvqBGn/Na9rGnrPjDoQjOq3O1
	LPXzKXk0=
X-Gm-Gg: AYBFou146sGEwKvumcXCuJ3LfK7p6hxKaHyTiT1waT2OQdAJquHiLwPPBiaN5K3p6RO
	82LrBQF4RhKlNlRPdMlyhGwtafLH9LJHZwjURvir+HuRz84zxo/FTJcPAEYPhA8oE3v6hkcI+cd
	Ew5lb/rxTNIYhspZsLyVzRlUqL2rPxWInKKXIueqAADpQXTyX8BBUQvY9YQkb3mH4WKBwtKSEE/
	uQE2w6V3eyQ9DtB2ksErKn6SpLmDff6GfZ8KTd5fHt9XDvArCE0GKOPi5JxulrZVc8X064xH7Bl
	32vBiUIDIjCDABvKjSqtPg9BuL0X92lqu8CEfWAgdSMv3ugg+lEqVXRhxpjWQfCrJ8LMP8qNrmN
	6YGuQGG7TWi5u16PUQzpVjYQydlsEiBOwkWPemP1qfu3nSGMVnp25uwNmCJeTw3j5f+jvuSlRPZ
	ub2AQusgnkhaP/YcbnVRC2dqcMol3xspLokSSAmhTSIZXk45vg1e+fDYPRDFJHbseA7K/jmqT4Q
	FsnwN4M7FV7ZPxDBJMAlXZdhZDQXaUCM0ZAvNel3sXBMvGbetFdbxaRKcYHEYiJ7iEygyouJwEi
	RuTQdGn9ikXId/oNCnhBQ7gAyfOWeJ44FKehkDZWpJGP3bX8J4dQtSDtE8Mb0PqRcXRFqBllaA=
	=
X-Received: by 2002:a05:6820:1505:b0:706:5b0b:4e8e with SMTP id 006d021491bc7-713f1c59b54mr1614231eaf.55.1793205907169;
        Wed, 28 Oct 2026 09:45:07 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 40/98] rnbd-srv: publish the sess_dev at the end of OPEN
Date: Wed, 28 Oct 2026 10:41:43 -0600
Message-ID: <20261028164415.1262013-41-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <mason@kernel.org>

rnbd_sess_dev_alloc() stores the empty sess_dev in the XArray as its
first step. An IO message with the new ID from another connection can
find it before bdev_file is set, or hold a reference while a failing
OPEN frees it after a mere RCU grace period. Both are reachable from any
host that can open a device.

Reserve the ID with a NULL entry and store the sess_dev once nothing can
fail anymore. The error path still erases the ID, and no longer needs
synchronize_rcu().

Fixes: 2de6c8de192b ("block/rnbd: server: main functionality")
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Cc: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/rnbd/rnbd-srv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 1cfa2c580759..1c80e8fe0267 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -431,7 +431,7 @@ static struct rnbd_srv_sess_dev
 	if (!sess_dev)
 		return ERR_PTR(-ENOMEM);
 
-	error = xa_alloc(&srv_sess->index_idr, &sess_dev->device_id, sess_dev,
+	error = xa_alloc(&srv_sess->index_idr, &sess_dev->device_id, NULL,
 			 xa_limit_32b, GFP_NOWAIT);
 	if (error < 0) {
 		pr_warn("Allocating idr failed, err: %d\n", error);
@@ -802,6 +802,13 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	list_add(&srv_sess_dev->dev_list, &srv_dev->sess_dev_list);
 	mutex_unlock(&srv_dev->lock);
 
+	/*
+	 * Nothing fails from here on, so let I/O messages find the sess_dev.
+	 * The ID is reserved, so this store allocates nothing.
+	 */
+	xa_store(&srv_sess->index_idr, srv_sess_dev->device_id, srv_sess_dev,
+		 GFP_KERNEL);
+
 	rnbd_srv_info(srv_sess_dev, "Opened device '%s'\n", srv_dev->name);
 
 	kfree(full_path);
@@ -813,7 +820,6 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 
 free_srv_sess_dev:
 	xa_erase(&srv_sess->index_idr, srv_sess_dev->device_id);
-	synchronize_rcu();
 	kfree(srv_sess_dev);
 srv_dev_put:
 	if (open_msg->access_mode != RNBD_ACCESS_RO) {
-- 
2.56.0

