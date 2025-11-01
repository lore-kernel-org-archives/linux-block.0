Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE2E2561B6
	for <linux-block@vger.kernel.org>; Sat,  1 Nov 2025 05:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761975878; cv=none; b=AyMIwgSkrf1f8mUmRuEcrNjsBGszn9UJ8zW4SR65ganTvT0M8koeoRlWcGciO8+UdJHnOAEIDwAQMHBSoLSxF4Z5ZFPbtlHZQqEmvtxUb8ErRVz5knomPnXcXG2Kaf+N1oT7OUrd8aNl52U/zdqhKdoE3+sCEAg4TQn7l12Er7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761975878; c=relaxed/simple;
	bh=QoAanW8uPcUmodqCBbkdSS+W6EcjbWm0OuMo8lhfn4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HoREBiSQ6hsTEKVR3tAqhJPIUvS1eGxeJaZFGf7ONgaXdyBKrvUkUv3r0jH1aU/kUx2J0dXvDo4UaU0RndnKTIVkFElQ1SPq21pSjBa1g1oIVWN050fWbKWlPgOSnKkCrsP55uXZab62Bmqind28UKnimHz8kCsKmgoGse8DEKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqoSwLs2; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqoSwLs2"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6ceba7c97eso2676629a12.0
        for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 22:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761975876; x=1762580676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hXfrEv5oiBHpW6muXJlmwbpRlo7zdmnpcibEEEHdvoI=;
        b=kqoSwLs2BHY6phzuu3KFVnu/bH4e6cl5I9EHme7FbXoriQIe/GinEuuk89cR0Pzczf
         76As40o15YGikZwen5C6bVQX3cPlsx/prXgAaSxhT3MXpuX0l5NqFW7ajWzeHAvtEjn/
         p7O8T9ogLKfrLqkwcVeq6fd5iGPZtZxiTseyIrSUv6wtqdfUydQ29o9rgyEX59FGrNcA
         rQ6fTPpboB1X3es8Yi+xnNuM+re9U7Jkk8pzYLdT92yeAN093poHtIg74GHuhiTRShkY
         jBuT0pydkQ3JfSgqqVRCySsH0oxPjkiSBulrjj2krurD17swTqdW4+LlYJEKZWzWsRrA
         zKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761975876; x=1762580676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXfrEv5oiBHpW6muXJlmwbpRlo7zdmnpcibEEEHdvoI=;
        b=HitLO6IHBsyCeCSdYY6mIa3meGtD3pTM9kM5hUnjrfcstsKKF8qLctS+3mDAK7USA7
         dTjh3H7AT5um8qbPCZVllZeRqiePdIsJkR7DnInZopyw6inY/sJ50XSXfoImtK5o+2Rx
         dJs+PooQDGQnyesy3AB2WJLTX5TlBaUORS1l0AOs+4Tp0FTjAVWPbTZ1gCunbgk6qESr
         CFu42jUsoWa3wTyLb3h0L5wT8qc3ZWdC1MnGZywrSt+oskmq+HqiPPX6LxFVGjBSV2Vs
         iCk192YfUBjjYj3z7KtA7QFsPRXjuDoONEVmhUARClE9074+Yj0e6h4yiIeuTQb3Monb
         5rbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXPqsHlZajA++KvIZmh4+UfUFYTQLR+D67syurqSDksCY5cMEiSZMdynnOaVtagdaVmty2hMa97XQYNg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yytf4Di7Nu7hxH/7UywobyWlpVwEw9UUJ5cYBxoCcBuHWtEtomI
	XApqQsCJJIMaqfVu/8K0FKLYaT2qiUoAbzIbz0g2Mp5fqGSS+fgOnt0d
X-Gm-Gg: ASbGncubeGDAYou6rbh/yqK1tf96MuzJ9lvLAutfsMhFJpzE0B8O+iGtYukpcGZyE+P
	YsRPFN2TVPsROmpr5mvnVJoENTXIN0WnCAhZjYltNzAwcR2D4to61GcXfgU6JeFOWX1EsCqmw4V
	flWAM7W1V4EVaTiRQrv7UZudz8BYLuP8DmId7ka+X2P6E2tYVnAamdU1T8oPRF9edWGYUW1qsK2
	e8c33lVPDVNeUyDrMxCvcvYOBDlS6o58eC6Gbm6TvJO5XCieprvR3+wRfDMHF0Ldy1FtvnYYNzB
	yq60oduel/sZfMycNkFqUBq29YnHs1FQTfAenamrgu0FRsMeSTCGuP9iySmjj2QqdJVk7na1N8y
	waZLlYiMhkLJFWqInf7qdL5iLduahPYVNtyxDH6Z9zq+8kpOqh7zDeW0sCTie4GqdxRlcu/Qi
X-Google-Smtp-Source: AGHT+IEGJ4mGhF1h11nXlNMyKOMIlTHFuQycoD3FINV1TwEi5cyxUm493MSp+VBY0wey3CeA3mtjJQ==
X-Received: by 2002:a05:6a20:3d86:b0:334:8ac9:bc5 with SMTP id adf61e73a8af0-348cc8e5729mr8648568637.36.1761975875916;
        Fri, 31 Oct 2025 22:44:35 -0700 (PDT)
Received: from fedora ([38.137.53.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d897e86fsm4067572b3a.11.2025.10.31.22.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 22:44:35 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: philipp.reisner@linbit.com
Cc: lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	axboe@kernel.dk,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	i.shihao.999@gmail.com
Subject: [PATCH] drbd: replace kmap() with kmap_local_page() in receiver path
Date: Sat,  1 Nov 2025 11:14:22 +0530
Message-ID: <20251101054422.17045-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kmap_local_page() instead of kmap() to avoid
CPU contention.

kmap() uses a global set of mapping slots that can cause contention
between multiple CPUs, while kmap_local_page() uses per-CPU slots
eliminating this contention. It also ensures non-sleeping operation
and provides better cache locality.

Convert kmap() to kmap_local_page() as it aligns with ongoing
kernel efforts to modernize kmap() usage for better multi-core
scalability.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/block/drbd/drbd_receiver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index caaf2781136d..14821420ea50 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1736,13 +1736,13 @@ read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sector,
 	page = peer_req->pages;
 	page_chain_for_each(page) {
 		unsigned len = min_t(int, ds, PAGE_SIZE);
-		data = kmap(page);
+		data = kmap_local_page(page);
 		err = drbd_recv_all_warn(peer_device->connection, data, len);
 		if (drbd_insert_fault(device, DRBD_FAULT_RECEIVE)) {
 			drbd_err(device, "Fault injection: Corrupting data on receive\n");
 			data[0] = data[0] ^ (unsigned long)-1;
 		}
-		kunmap(page);
+		kunmap_local(data);
 		if (err) {
 			drbd_free_peer_req(device, peer_req);
 			return NULL;
@@ -1777,7 +1777,7 @@ static int drbd_drain_block(struct drbd_peer_device *peer_device, int data_size)

 	page = drbd_alloc_pages(peer_device, 1, 1);

-	data = kmap(page);
+	data = kmap_local_page(page);
 	while (data_size) {
 		unsigned int len = min_t(int, data_size, PAGE_SIZE);

@@ -1786,7 +1786,7 @@ static int drbd_drain_block(struct drbd_peer_device *peer_device, int data_size)
 			break;
 		data_size -= len;
 	}
-	kunmap(page);
+	kunmap_local(data);
 	drbd_free_pages(peer_device->device, page);
 	return err;
 }
--
2.51.0

