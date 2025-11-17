Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547632C21F4
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763400384; cv=none; b=uUl0d67KilMJOOzaF3+EKYn4y66t/Sdp5FgODGp3slmmvKNZZUlCDqdgzXHnjmKXIehnd3rBraCECGP6bAO8OYdlZV5TRzR8Kf3OKK6sYTo9HjVgNLPnIcROvd5NXQGBVDH1PIQuM37wuKVamnQIHXl+9G2XGpr1lXYVd+0BQ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763400384; c=relaxed/simple;
	bh=eNAbAlLxtfdIFI4DsoP7fW20zHjXCvlLcYgwWPPGr3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6DAZjt3UD+6Tf1iqhk2AU8XNrXXDj3J9pIRdus9eWpcEXud0ed9WnIY1WPJlMWzrx2qj/a5sKviyw6GH1l4k0EqkHzOSQ3/Q3pQ+ZebpJvdz3axXXHctoMLJsIaoi1SsQz7XqP/QP7RxcUJwctiKqSOViiMrHQX/yCzP0SxDQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFgVlQxd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFgVlQxd"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29516a36affso52284635ad.3
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 09:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763400382; x=1764005182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v3YaAQQfJl7oxy9ZHWXLH2rWSEnvHqvGOwv88JZqfY4=;
        b=nFgVlQxdW5jTK1wb5GzFogTOxl8P3sN04YS9ggh9JRN3IoEzyPm+C4Cvj0AdxvPKQb
         LpUEM5hKOFylV15iNfapV87w6FvuCN0CzALVbfu+O4t9+9RDKP+dhI0OSIMaNXyHDMjL
         SiMI4aTczmoNgyvEex2il7TDWAE8/k6lfEJV0bjiEt+8lulTKC98aIwdfYJQIBA5LKW+
         W6zn/RMUi4Ta8RGcfoVnoqz7IOEmzHEcRmvW56+EDchQbkolTxzrLa1JszUzmBCdx7+V
         NXLuQZ64aHAI988ayztyp1U64eAxgH7E899hLa/tTNjVFKRNX2G94c9yP7BvvDISpk3h
         ndDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763400382; x=1764005182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3YaAQQfJl7oxy9ZHWXLH2rWSEnvHqvGOwv88JZqfY4=;
        b=LnFPaZgmIg1xvymwUMe3DeC8D91wqPZUajD+SGvrTMecRg4lVoEQDe651iaaDCt1QD
         J107yjoD0yP0FyZaKFJ7mbwcfN9r2ktMP+jCNksaADAl3OOcHmcVZH4jdy7+dNNgKAxn
         d+1fhbw+H1bJwo/8iK/e1SR87wX/KXNPtiajwvJOmzHDsoVIr94UACrTbXwBQLKs7Hd2
         TLvFGa+qFA4Q6IWMVWHVDpPrtJFkkVkPCYTSkk+wtaTPgwhCJ7cyKd5610Z+sw7AsqUV
         9dWO0YRmQRJDlOJx2nP0WWq0fkyHzUxGnAq/+2adOf9NZ5Hwb9bQUNGSa4zeNgPhnduc
         B5WA==
X-Forwarded-Encrypted: i=1; AJvYcCXCR5iEYNqVK9o06jVy/VB81JatoA5VM2BZn3TdyDSAMKSR3l48IHq/lD9STeTZmsm8ITInnrmXB5aq/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrAG2PYzDa0SZNtYBGkTS5gBUX/xXxMRnXq8ip0Qbw3jnIa1Wv
	RysBiTIHQQe21yBeXxqmWYJ8upiFBC09eIOebdYlKIYSozV+/XcV+BKl
X-Gm-Gg: ASbGncvWXlXrGCl/eeZ8QwkYu0stm/okYud5HvbdB6/eonK1e4zfPE82JTos2KVLUUl
	WE95bNbr8Ry94V1SqNX5dDNZrQ0SBcym45hFNiZ4xIfJSjDmUbwptgsKnD9IIjvRJT29pF/nTWd
	Ek7kHizNRCokN5zQV2gCdzDTMCD1O8vcMGNQo3F4mgcpQNsAQvPPiKvQao4mZaq2CyDNHm8ZhgA
	bM4FkK487iZIogKnIMq9lxiv48luTzeQcKZaU1y2P6whH0wgh+UZQAx1QIkbq0IplpCtUbHpGcA
	p1BNS4DVealf0AkEvOc4Tivm4Pbr2AgKu77XsPiIWAoCiUs5nwz4uotjOD1BsCbw02eta3lbaj1
	TVFKKmIPK2zqRzK9s9KX7OnpaRdIes4xLky7HnFGEOpmnILQ7PGLTfi7oYAmkpA8UcsaqYW2W
X-Google-Smtp-Source: AGHT+IGVOqt1KvdPHFwUMBNxRfOX0UgBscBOMeK4i00bBVPVTRd3PKUbbydP08iP89j2CLTLFzgFUQ==
X-Received: by 2002:a17:902:d4c4:b0:298:55c8:eb8d with SMTP id d9443c01a7336-2986a72bf9dmr158144985ad.35.1763400382095;
        Mon, 17 Nov 2025 09:26:22 -0800 (PST)
Received: from hsukr3.. ([2405:201:d019:4042:4a5d:d140:fa1f:849b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2565easm145017485ad.48.2025.11.17.09.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:26:21 -0800 (PST)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com (open list:DRBD DRIVER),
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: shuah@kernel.org,
	david.hunter.linux@gmail.com,
	Sukrut Heroorkar <hsukrut3@gmail.com>
Subject: [PATCH] drbd: add missing kernel-doc for peer_device parameter
Date: Mon, 17 Nov 2025 22:55:56 +0530
Message-ID: <20251117172557.355797-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 build warns that peer_device is undocumented in the bitmap I/O
handlers. This parameter was introduced in commit 8164dd6c8ae1
("drbd: Add peer device parameter to whole-bitmap I/O handlers"), but
the kernel-doc was not updated.

Add the missing @peer_device entry.

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 drivers/block/drbd/drbd_bitmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 85ca000a0564..2d26f9d2454d 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1213,6 +1213,7 @@ static int bm_rw(struct drbd_device *device, const unsigned int flags, unsigned
 /**
  * drbd_bm_read() - Read the whole bitmap from its on disk location.
  * @device:	DRBD device.
+ * @peer_device: Peer device for which the bitmap read is performed.
  */
 int drbd_bm_read(struct drbd_device *device,
 		 struct drbd_peer_device *peer_device) __must_hold(local)
@@ -1224,6 +1225,7 @@ int drbd_bm_read(struct drbd_device *device,
 /**
  * drbd_bm_write() - Write the whole bitmap to its on disk location.
  * @device:	DRBD device.
+ * @peer_device: Peer device for which the bitmap write is performed.
  *
  * Will only write pages that have changed since last IO.
  */
@@ -1236,7 +1238,7 @@ int drbd_bm_write(struct drbd_device *device,
 /**
  * drbd_bm_write_all() - Write the whole bitmap to its on disk location.
  * @device:	DRBD device.
- *
+ * @peer_device: Peer device for which the bitmap write is performed.
  * Will write all pages.
  */
 int drbd_bm_write_all(struct drbd_device *device,
@@ -1258,6 +1260,7 @@ int drbd_bm_write_lazy(struct drbd_device *device, unsigned upper_idx) __must_ho
 /**
  * drbd_bm_write_copy_pages() - Write the whole bitmap to its on disk location.
  * @device:	DRBD device.
+ * @peer_device: Peer device for which the bitmap write is performed.
  *
  * Will only write pages that have changed since last IO.
  * In contrast to drbd_bm_write(), this will copy the bitmap pages
@@ -1275,6 +1278,7 @@ int drbd_bm_write_copy_pages(struct drbd_device *device,
 /**
  * drbd_bm_write_hinted() - Write bitmap pages with "hint" marks, if they have changed.
  * @device:	DRBD device.
+ * @peer_device: Peer device for which the bitmap write is performed.
  */
 int drbd_bm_write_hinted(struct drbd_device *device) __must_hold(local)
 {
-- 
2.43.0

