Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795143377;
	b=K3A/4qMuaJxkcsSrbquGPaoLa13oknP1wjb0EraosoSP0SQNRT9jCXA8IsMDTri5oV+M
	 QF7+OJiJ7i+8FkMFknya3MaH5msazbxtt7HyNcCbcEzKJ4OC5rafBgyMb7pEdZpINfc5n
	 goG6CpF0acaU4A/gyDloM/4UIdjlbuxIQHrfVXRYZS3ip3rqkrhIEZQzoxr2bXEfKWFIj
	 QVwTmkyuVDSqlmfUkqQczILjwvEInvYdg4jHGts0AMCoBzvRAgdmaT/xZ4Kn8Tw7R3Vgn
	 TIXgQXEoXsbrFlSHowjNgr56Rt6QzBazWSS3BTSejDj3BOKaspJkkdsQpzIagH4Ykzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795143377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ggrWRBIjN1YpUxZsuLBqhrBRUvzhtYh6cQ2yjgY8+GM=;
	b=gJT2xUejPPCcoPu38Ww+ZoVcxONLw9pZn2gzYzNdKxy88ObGpoYix1gNi3oRf8hy5Jpx
	 QIQcKDiq3IRd7PEHLpoIgAb/bkHh9Spm0mxxMIg0uUL1R7bZdIUpalFnQ7gv/JS6RIYTh
	 27yia+pr7QkegeFRvGtt6+gdv+u0GzHXuUN/cWwFXbQ6cJQ6vTgt35EPkRRAeGQPskYqb
	 mmbgEFcmklCGfSgQp6gOpwa9E+WseSLVN2Yx26BDArA3YcxmIGV5sPeLKJtFEvuPIUoMH
	 TCXeIJLi+ztJ1bUll+4TToTJn4dvpnDxlKM/gDrKO+njafemYXqv/8U2YCf4AfJJxrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=eJvIGSPR;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329AC606A339
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 02:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 329AC606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=eJvIGSPR
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b3a42a4bcdso233264a91.0
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 18:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1795143376; x=1795748176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ggrWRBIjN1YpUxZsuLBqhrBRUvzhtYh6cQ2yjgY8+GM=;
        b=eJvIGSPR/SdCZYtVYv0MrT8rgH7TfGHp2xiJ0zCbr7hBjfC+YjuE2M0LRWoinqGfbG
         bhAw3Fspkn3VKjsIMf+63wLKm9vdeYkjZ00XMpaZacRBgQuLF70HYuvB+zfQGC6VnqRA
         BDeDJQioDe/5dBCPPLnDl14/cZPQmDUZ1zjcrDx8AbJ1sQjjOUz2OyEpedWN33qLOheo
         iUiXLFbYkM6mvvVi74/BwxEPRpp6TELJzQd/Xp8LuWdbN9DjOVvM/5Gp8Z2YZzPQ4MNE
         1GztF7xqlsq1vykNDoMxTLvEBLSHUiWcCGhQAd8Q6EyE0oB7569RQDzjktDi5Lc1lksR
         PwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795143376; x=1795748176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ggrWRBIjN1YpUxZsuLBqhrBRUvzhtYh6cQ2yjgY8+GM=;
        b=iQaNP6C7gpAtAHaAkmaRqTrnc6BWoPFQURmn/e5R8GEINkB2HS0XUvQm1Vh2Les5io
         nKmKCmKHNSjwxrInTMfw90/moacpQ5SJUnhRc4zvUsOWzky1ZaxdTS7NCEPNkYfHJm/T
         57+c4afQn8bDJo/njt6H144BO4+Bi5uZYkIgbPpXz+1GvrFOhWMgSNZVkDspPW7zpO4T
         9k/VPm+dVLklgXEy0WJZ8R0dgLc2R+ey4Jwv49UA6g/2I+07WPHMbAkGfxjb3GU4sS8a
         jPHS8JyDY/p2eO0NsniG0K+tvZWExnpxwpA950r8fcZGNTybz77afJU6RrV3hD3TDFWU
         sLqw==
X-Gm-Message-State: APuU4Z9Onm2myYZF5GwcJSJDBBKyRRNjLeU3osm5cGxp+W6FBnZOSTIB
	vhIOy1WMv5WtUlUJHj+kJi+X0Z8g5OJLi5U/A6P1AA4RyFX04XdqzzL/ok7+9pmgQdq47Fo1kF1
	v0Hdk5kLICkUYTWSNYuUAOpbsUFnwC6NGZc1bXLdlLY62nHk/w6M2FOP9gMY3qshfO5Zu/yJyMv
	sXETo=
X-Gm-Gg: AZFdTZf1ifgedinAt0rAZSgetK1lRca69FEkd+lKuSyTqqhpG1VFDZ1AVxFWHbjdibc
	FWXNaUKa7dagx9l0MVW251Lzjxj0MJlruJkHlXBXclsANM13vazeZmvNW12vo2Y4WUqAq9n65pi
	MHqC5eo32/hQefDXWnIwxLe6G5cKTdVrVt7RduKmt9P6WsieOM8i+pyGkjPr9dEs9mzB57eNAyT
	k+esW6rjVX1sPegJOxgwxxL06PNegLkbUOJplZyVgHo1v5YkTmde2+fKClDr+S6XQ4B03F+EjGn
	LOJQLcWoBq3/NRZo1pLxhYNDxw6OgbInIe5IQ/3J76L1dEdGEAkea/8ifebPFCR3f333G3MmcYv
	EQR4B1LwHEdyQU3ZCJjdtjeEnjPA+NIcw7m5mqlmGGmnszTQrdoa8ME6PBQoNSXOGUsehmajLmo
	OiXPCaVXu9vY+dLixVywbrbS0NYt8mdAi8jLVcAyRTWdhZeGxa/yABmd/Cm7UZTDZ1W1qwf32wM
	JXDxeESCfO19HVeBMiJDp6EcF07gz9WMYgblF0b3JpQAxKKh0Q8D4LXAvdTTRV4md/monb23/ao
	aKD4uGHILb8EYlhHMqBXH1e8uWI2YS70wmaDlVaSeH5Qspb0cEg//rzDD5M=
X-Received: by 2002:a17:90b:2f8f:b0:3b3:ba43:54c3 with SMTP id 98e67ed59e1d1-3b41c942998mr1197821a91.33.1795143376352;
        Thu, 19 Nov 2026 18:56:16 -0800 (PST)
Received: from localhost.localdomain ([103.26.8.217])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm5546461a91.8.2026.11.19.18.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 18:56:15 -0800 (PST)
From: Lei Chen <lei.chen@smartx.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Chen <lei.chen@smartx.com>
Subject: [PATCH v2 2/5] block: link request queue debugfs directories to tag sets
Date: Fri, 20 Nov 2026 10:56:01 +0800
Message-ID: <45aaf07093aa28ee50653e83fe74e9593bf7b164.1795143228.git.lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795143228.git.lei.chen@smartx.com>
References: <20261009030111.57784-1-lei.chen@smartx.com> <cover.1795143228.git.lei.chen@smartx.com>
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

Tag set debugfs directories use numeric IDs that do not identify their
attached disks. Starting from a disk's debugfs directory therefore gives
no direct way to find its tag set configuration and CPU mappings.

Add a tagset symlink in each blk-mq request queue's debugfs directory,
pointing to ../../tagset/<id>. Queues sharing a tag set link to the same
directory. Create the link only when both debugfs directories exist.

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 block/blk-mq-debugfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index fd9eb17e97b9..72634277e088 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -644,11 +644,19 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
 
 void blk_mq_debugfs_register(struct request_queue *q)
 {
+	struct blk_mq_tag_set *set = q->tag_set;
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
+	char target[32];
 
 	debugfs_create_files(q, q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
+	if (!IS_ERR_OR_NULL(q->debugfs_dir) &&
+	    !IS_ERR_OR_NULL(set->debugfs_dir) && set->debugfs_id >= 0) {
+		snprintf(target, sizeof(target), "../../tagset/%d", set->debugfs_id);
+		debugfs_create_symlink("tagset", q->debugfs_dir, target);
+	}
+
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx->debugfs_dir)
 			blk_mq_debugfs_register_hctx(q, hctx);
-- 
2.43.0

