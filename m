Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D877288B8
	for <linux-block@vger.kernel.org>; Sun,  5 Apr 2026 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775404033; cv=none; b=pzKGd+uwTXVHYYaLT9Bv5rpa32gkr9BzpVsu4Dz11e6wjJN9rVC6IXC/ZIUNv4igPfZQr5XK+x1EzdtzMPKOnd26OBy8rkgcC1p4MvmLoHGRNV8Yhv7WlVs4PezVKivNDHf2zQoKw9xezrRriowt4+eZzkxGMbPcBWE/rMOUVWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775404033; c=relaxed/simple;
	bh=meNifUCrFKnm7OhNcC8ymnP12Ih1WJ0NsbIEGdB9Bxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YmT0q7BfbXwGvVvH3I++jBq8veb43kclFH9Aykd4BUzwfs40AalxFPlTHTQ6jrBNRJVtiUUUXUUTTpHeIwRbUCk1Qb6/X83NDWxcHHZtmA2tR+zQXfDX8XLjI3lt+npioIfHKLu4aDt/P5w56Hk9BdZT3w+bwyAyC1sYiIcVk44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2PqFZk8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2PqFZk8"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so3620695e9.2
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2026 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775404030; x=1776008830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij+T5jzWpjsPXYuNnUcPKiRbTS9+M0L00zfNyuOLfvI=;
        b=G2PqFZk8ke5eXAG8Q4LyqJJjZhNRxq+H00c475gsrTmj3cb8hSsKmgIBsKNbNsa/NQ
         V+w2JJtqUdlOppyQ/qgBY0Yeq7alD3b+E5gMYH5ZV09UaoQMgoDJ9xvqYtfvC2gqqc3S
         kk6uBcFtiP8JO/JPek/9Ggrsr8ExzvpMmSm1WVf2Ph1WvupKF8X0fhDTA8Sp54YUzXNg
         8Ztb0iibVmrJwg1B0qwmB2T8vuwYpkWZB3K1mzYjZf+86KUmhX8kxuP+Fi5RRdezWnm8
         dC/+CAnn4wIhFlPmU5KW6sYm0Tv3gst1khQtRgYy87Knb44Ap01fMJRVHu9kZHBbcoBe
         1+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775404030; x=1776008830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ij+T5jzWpjsPXYuNnUcPKiRbTS9+M0L00zfNyuOLfvI=;
        b=Au5ptrhn3xOJ1DkOlF5JjhLR32QSqKNvJ0tRHkt0aJHpx++yWnIjWDqyM+Kld+8SwV
         wPsxBTSGOcTJ8NXRugwJI2Cykpuble9s1YY5s7cp2fgr9pmGMlLTyGmKuvUmSqWAXfNY
         ZRxHUrCsIGYQtya4iBZNd2OdVbhM3wYVdkRxhvCnIcXpTA39KCmxSG1kwlljH+EaU0Cp
         bO63CSHxi7pPPKD7dv2uZ5fsjp2/MRXy7iZOMLFU7whufpWDmt0zsaikxpvipHFXWlcR
         IKk8Xc5Km1K8fayk4EIBE2WRXUrM/5eSYlFnmew6bwfo4vRFmCRIDwPk4Z/KVyPVRTVc
         +3Og==
X-Forwarded-Encrypted: i=1; AJvYcCVgru8AXouaN/DX6PMM6d8/IkahpsKOeX1uGNWtNjqlp9xswlmZ649A90J+wzbXfNr5cIkfSh3z6p1Usw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn275ng/SIynFuRVFWuibMdGBHkXxTWQOW2LLH7TVUkysYF6o6
	YsPTluapruxpmodg/aF6crCdm8M1HlN/xTFi+PXbPZS0MMA4rKCc7s92
X-Gm-Gg: AeBDietCDVMqSgTuUX0T/mkuqlBAQ75DPYtltZraKVaEhf6VgluP+IGlXBjv44NVdcJ
	UVLbY95f9BSBFbIvgtq8EddL/+R6LxOzH6WKxX5DeByjvffiB6XJ2ZUDQkpoIlvQ/0LHs3VUWqc
	h7HxCiKSytrayKcNE5N52FGBWh35X15pzU7C2CvCHjExTVeEA7eIiA9zY09gpfv5MGrWiGxLdig
	BGxobjoXam9RwrtAgC9XzdiP6Lb+KZrA9S0h2E7+Lfnd29X6t6C8/NOV8KWcHmw6m78yeIQHjXT
	7egQju84q44mFXvWlrDUg8C8fiAWRUkORkxbTF1PTUniLMITp8uw75J3fGLTGFFIhwN0VDzSVIi
	gVMTV1IXhnW26m+6HtkJ6Ek2q6juoRpIJMrYvQHGcPm1B6KwDPlfVRddkt/tuGgzTBOwy7ImOwM
	3+GaR8J7XcGca6fqopE6x6MnhHiuXBD8sKKTRY2hp5HcuZeMxJlXAhFt1RmDQvqFk+isD7y4bKT
	4b3uR2VyXHG
X-Received: by 2002:a05:600c:4593:b0:488:9696:488a with SMTP id 5b1f17b1804b1-488997e7dc7mr165902365e9.30.1775404030180;
        Sun, 05 Apr 2026 08:47:10 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488b0c53a27sm22255485e9.7.2026.04.05.08.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 08:47:09 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v3] drbd: use get_random_u64() where appropriate
Date: Sun,  5 Apr 2026 16:47:04 +0100
Message-ID: <20260405154704.4610-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the typed random integer helpers instead of
get_random_bytes() when filling a single integer variable.
The helpers return the value directly, require no pointer
or size argument, and better express intent.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/block/drbd/drbd_main.c | 4 ++--
 drivers/block/drbd/drbd_nl.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 200d464e984b..b1a721dd0496 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -874,7 +874,7 @@ void drbd_gen_and_send_sync_uuid(struct drbd_peer_device *peer_device)
 	if (uuid && uuid != UUID_JUST_CREATED)
 		uuid = uuid + UUID_NEW_BM_OFFSET;
 	else
-		get_random_bytes(&uuid, sizeof(u64));
+		uuid = get_random_u64();
 	drbd_uuid_set(device, UI_BITMAP, uuid);
 	drbd_print_uuids(device, "updated sync UUID");
 	drbd_md_sync(device);
@@ -3337,7 +3337,7 @@ void drbd_uuid_new_current(struct drbd_device *device) __must_hold(local)
 	u64 val;
 	unsigned long long bm_uuid;
 
-	get_random_bytes(&val, sizeof(u64));
+	val = get_random_u64();
 
 	spin_lock_irq(&device->ldev->md.uuid_lock);
 	bm_uuid = device->ldev->md.uuid[UI_BITMAP];
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index e201f0087a0f..377f60b40f28 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3173,7 +3173,7 @@ int drbd_adm_resume_io(struct sk_buff *skb, struct genl_info *info)
 			 * matching real data uuid exists).
 			 */
 			u64 val;
-			get_random_bytes(&val, sizeof(u64));
+			val = get_random_u64();
 			drbd_set_ed_uuid(device, val);
 			drbd_warn(device, "Resumed without access to data; please tear down before attempting to re-configure.\n");
 		}
-- 
2.53.0

