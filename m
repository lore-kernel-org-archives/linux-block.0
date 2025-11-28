Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128522EE5F5
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318775; cv=none; b=SLQ1i05NHnLscB1y7BCTmSBHxqJ4Tkd8x5DElKl4fUjrAWXNO1Dle46rxgw42dXerZHX0FU7PDpAy2rz2vPVhtjtZaxuk+46w2eQ9qreyKC0S2IcrstG1A9r6AdchBn1EgR5Uxg6hco2jld6AUvdV6hnR8nCR3xqqWO2iLxzolQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318775; c=relaxed/simple;
	bh=JLIdNXPMejF737Jv1xzF5GicNRibkuRDb9iX4pmjoI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EmjzvHkm8S6ba6vZVBt47lCRj2ZwzSGChu3UYEPyX1SSI6exmJ2lBmxaExBpEYjAaDc5LCyCvYef/6U7k8LV+EjenVvAVr+pEBbBjnLWVuTJ2SNT+yqkEbZCKQwMHER7U2t+IeSb9PCPIyUduv+pzMcwFd/E/5T+/+iswe6wrEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3h5NxD2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3h5NxD2"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b80fed1505so1933832b3a.3
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 00:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318773; x=1764923573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B+NwUppxNtx5dO3GeNOAlGv3QVGc2Q+cteUdMRhiTw=;
        b=e3h5NxD2+pjCU+SL4YYCXLOBvl2ZfbIVgZx0v94A5jYGGMy2YxzoJ2BvRB7sgYqCdG
         apEykxsswt4QE1e00J7/lg5wXxqaMckUKsKxLIzybNLFlVgVWGDFACNNWv+GOn8a1L8o
         lTIX9cnHDuZU6moNC2Mdj4bmo8eT8y5ikd79d5IfF03notzdK4Ug8TgTE9SeYdrqnMy0
         TXU4PRVHxeX8OJWhf8QHfhfDRnfR8kIZ/9I9MnoVuoSK8rYuvGayN8OcY+3lOOJXkS0b
         6sed7j4zSDFJ81iwNkdCcFDzQzIkXpi+lm/oZPlfQXMghV5QtreY6YfBaYgs0Qr3VYRG
         gaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318773; x=1764923573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3B+NwUppxNtx5dO3GeNOAlGv3QVGc2Q+cteUdMRhiTw=;
        b=Pvtc9b4MrpKYQVOk4C4NVD43EDKanA57gDLPpLyJ8kH9RWcXnwxwkB8wFfWs16SWvS
         +nePPSFDvNLoBBJaW1wCxnglvpE3AA2wTK3fA20SfzfBQGXiQCiCdbwHpfnDakWQwL6v
         Kro0xVewhOnbNw5RpbM6j2vNJSRovRo2odOwgim26DLlg5261BBX367G0gHrGdo+EYli
         /ayjR/Y6M201MFtOFx6XTuDwJlZNLzmQ64schpeVP+YqtRhW5kDKwNCJLxUfXSH1DkKV
         J2liBfb0dX/Y6Cabb/HDHgosARsm59GXT5c1e7AgQk5KNY9UIzKumAIBIUFzgUdjKGlq
         xDSQ==
X-Gm-Message-State: AOJu0YxQIC4pDFrg2BJS2Slf7aBCq7J1fKtx319JUTi4PSo2hMVHF4iY
	W6vUQFF8zJpfgaZOGsarhtd409fkv3NOJkIrs6t8e0dpMKHRI+W96O6y
X-Gm-Gg: ASbGncumH1C+JNk9e1aGNvZcoZtyyhQZ2nonF9dYjDbj/e6gQaCpwTWQtgaMD8jVh6l
	45pba8XSJi34wAaqnca0pVSqwLjlUWcVmHQyYyvgK6QTA4GKHSz4zaRckCWTvZymC613er3Y3+q
	DzmA/Ym5vIZjmh0wDdulFuAc/BdVphCvgAVj2YmAhfBFCpK/TPr1aylEQgfQvArX76mKWm6gJSN
	smftHFgd6fP9gh0AyCxULtkKiKfxjLc56/+mINaQlROk0NUQ1mbooSOUZdmQSF81o5CH8XMnjRT
	rgFu5klatLfsUF0Dhw9IZfU6nR5k8xZrWAopMmCws83D1P6rTC3qq+ubV6HXV5S0PSZm3w3WN8T
	tw1dzjLwxlC5ljyji4CYaskXpZuLq4svbR179R4oNYzMwEELyf8UMKB5m3T0zYzBV+7ZZj+U6mx
	AvguVAe1HrqGh6w13UMtWB24HeUQ==
X-Google-Smtp-Source: AGHT+IExpRIXm/rx9JSaduyyoo433z0edlCZgYRCixn+2l+uiE9AooEQRv+QW8QlPPxN5lYcC0yJLw==
X-Received: by 2002:a05:7022:2390:b0:11b:2de8:6271 with SMTP id a92af1059eb24-11c9d8635bcmr22508225c88.39.1764318773026;
        Fri, 28 Nov 2025 00:32:53 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:32:52 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v2 03/12] md: bcache: fix improper use of bi_end_io
Date: Fri, 28 Nov 2025 16:32:10 +0800
Message-Id: <20251128083219.2332407-4-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Don't call bio->bi_end_io() directly. Use the bio_endio() helper
function instead, which handles completion more safely and uniformly.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/md/bcache/request.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index af345dc6fde..82fdea7dea7 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1104,7 +1104,7 @@ static void detached_dev_end_io(struct bio *bio)
 	}
 
 	kfree(ddip);
-	bio->bi_end_io(bio);
+	bio_endio(bio);
 }
 
 static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
@@ -1121,7 +1121,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
 	ddip = kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
 	if (!ddip) {
 		bio->bi_status = BLK_STS_RESOURCE;
-		bio->bi_end_io(bio);
+		bio_endio(bio);
 		return;
 	}
 
@@ -1136,7 +1136,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
 
 	if ((bio_op(bio) == REQ_OP_DISCARD) &&
 	    !bdev_max_discard_sectors(dc->bdev))
-		bio->bi_end_io(bio);
+		detached_dev_end_io(bio);
 	else
 		submit_bio_noacct(bio);
 }
-- 
2.34.1

