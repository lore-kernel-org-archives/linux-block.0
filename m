Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36DA18C03D;
	Thu, 10 Oct 2024 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728593074; cv=none; b=lFxJZlf3avyenJc/CBM99pRHnOiYwp/0cVDItbz5Krkvzn/g17/nhJaFPl8LKLHjdpEPR2A4HI97a3hpiog0PVvYzeoHY6sMMyhbLxDab0r7FAL9YffGF9BWjZG29xe7Vlix6c1eASM8DMSOdO5V8nq8vMHWYSUoTvZzjUwaifw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728593074; c=relaxed/simple;
	bh=ECBin4k6fw2OruJMi64LWYj7wG/maXr/6kyXQve3tKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i1M8A61VfekeFdID0Xw575V1s4pz2oYKkpCzguJdjcxO+r0+wWqIMYjQ47JP2BB7EMT/sLZ3TcMeu9NBidd+CY/wHa0UCu1eF8gUKNoMVaWDSIHJD30uaa2V5CmQmc1HjaNdaZLrEWFDoloddC0HsaqMfy/awsTutblmpnjZ2Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=aT9yBInu; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="aT9yBInu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=2yWyCpZ53gIzx3cAD/L1bBLUXyJxFe90aJntlIsY7DE=; b=aT9yBInumEWU60gV
	hmoBzenr8/UVDbVxS8RVtQaRYD3ZDaRMzGPplltSjtBmfnjdaepkTRKdfeBQmxrLN7ntezYZhM1CW
	Eig8HEueTHvc55w1U6RbNIb8ghmifhl/g8I1ZQpsb+5DPQyAWbavmL+Rouq2RlmvtEfzepN7u1acm
	ynVYnUttaLcBFQsCvAxrWp8YZIHRDQnQG6cxC/G6/yfMOcdSfMmKzYroLjTlEbV6j7/DdQYKpzMEx
	Eyplvi5UsEJjSNT5h/tI9667UVOS/zbDaZZAKYiQ4oCRw5GrcdhVkSq5FNj64Ea47tb9nCXb97ML+
	L4USjEM5i16eVH46NQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sz01M-00AMjK-0t;
	Thu, 10 Oct 2024 20:44:28 +0000
From: linux@treblig.org
To: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	axboe@kernel.dk
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] drbd: Remove unused conn_lowest_minor
Date: Thu, 10 Oct 2024 21:44:26 +0100
Message-ID: <20241010204426.277535-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

conn_lowest_minor() last use was removed by 2011 commit
69a227731a37 ("drbd: Pass a peer device to a number of fuctions")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/block/drbd/drbd_int.h  |  1 -
 drivers/block/drbd/drbd_main.c | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 2a05d955e30b..e21492981f7d 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1364,7 +1364,6 @@ extern struct bio_set drbd_io_bio_set;
 
 extern struct mutex resources_mutex;
 
-extern int conn_lowest_minor(struct drbd_connection *connection);
 extern enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsigned int minor);
 extern void drbd_destroy_device(struct kref *kref);
 extern void drbd_delete_device(struct drbd_device *device);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 0d74d75260ef..5bbd312c3e14 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -471,20 +471,6 @@ void _drbd_thread_stop(struct drbd_thread *thi, int restart, int wait)
 		wait_for_completion(&thi->stop);
 }
 
-int conn_lowest_minor(struct drbd_connection *connection)
-{
-	struct drbd_peer_device *peer_device;
-	int vnr = 0, minor = -1;
-
-	rcu_read_lock();
-	peer_device = idr_get_next(&connection->peer_devices, &vnr);
-	if (peer_device)
-		minor = device_to_minor(peer_device->device);
-	rcu_read_unlock();
-
-	return minor;
-}
-
 #ifdef CONFIG_SMP
 /*
  * drbd_calc_cpu_mask() - Generate CPU masks, spread over all CPUs
-- 
2.47.0

