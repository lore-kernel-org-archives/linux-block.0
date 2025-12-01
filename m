Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8052C030E
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764579902; cv=none; b=f2IaZkYAWs+BxpjO8OQmk07O/jBYCEpRbhNHaISk97n8OqX0Jo7x8q191jPhkGyJzsU9O0jzRk4dJN1q7JT2DCTA5/UfX+p500CAmrbUm8e/I/7P76yMZiYqk7EabKifo9EaM4kH20eoC8vOxr0pzCSXou+yEtOubjZhcDOyOlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764579902; c=relaxed/simple;
	bh=JLIdNXPMejF737Jv1xzF5GicNRibkuRDb9iX4pmjoI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nrapz+CX/+8LMvoC7VdQDlMS1Ze4L9IGv7B+a3RXGzsXrrJm/N5iw8rrjcBhrzuuIfWGkqthqAz72+2xEYqTCkctyT0bjYBvGOE4lKaFJioI/hWrlJGHomy6vW1hXrZDfjAoy18XW1M6d5fMVG2ES+swzyGDRi7r2U3LbXmWtS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbieNTfq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbieNTfq"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7bf0ad0cb87so4727346b3a.2
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 01:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764579900; x=1765184700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B+NwUppxNtx5dO3GeNOAlGv3QVGc2Q+cteUdMRhiTw=;
        b=nbieNTfqgJGTlh/GgrhZAIZaBLoZjTBD6ft2QW7Rgu7WMrpzdkJ5NdroTW8N4xGBjg
         HFw+YJzO7Qw0/Tj4c7AQVPrtPflzgGweYjFVtri7hzymjCSmpw+wvUAv6Jt+lCmCaLad
         uMEsGfgGnuwvyvt6GWD7MwF4SDOI+CP24OLoVGrYQPRzyk+bO6ZbMnAceFKP1ip7ibP9
         0d1vgMJsFcVXJuBLzkOvTQr2fbw6dOW4WcKClu9QV9h5X6uYvs103wmCyEP5J9wRSY7d
         9CnHwGQECUKQQs+ATXtFoWZA2sJ7Lytmem/TdoRksgpsHcZZ8blVBQbZUOBJp2IwvYg7
         1haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764579900; x=1765184700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3B+NwUppxNtx5dO3GeNOAlGv3QVGc2Q+cteUdMRhiTw=;
        b=RnbrRdCxXPQ9aRTSCKTT5PkhDKfV4sPJr1cTi7OlRATHmHzMKAunCfJPOm6oDqjtb+
         eOOOGQxCQNHvH0UCy39+Q9NWog9qbboNk+mxaqierZCoEd5a3+pZJ8T53IAaX7jCgnoF
         86jA5ouGYwPENcDEiO7riBtKP24jSXok4raXr0ohtoGhMXmbNvHueId6Rz8fOu9PnTgA
         LX5ePrR9HhT4xU6C7Jv4ko6dnKPOp2Y77huWgXASaSYeI2gIksYS6TO54LFosVMyXZJq
         0UMTrvAoDObi6BIIT0NxJiTHn1kVUnjV0Ubk2Zmy9Jxr4yvKLhWi2jP/U9hNJVlmqNL9
         jodA==
X-Gm-Message-State: AOJu0YzEaujow+VyeGGnYAXYoX+IMXOyanTIfzcEZZy4mcgtb9H6ZLeG
	9gzUFnCQ17S443prZpLMNSknN3NYTci1DaZ1vqWhNKI1T/He/OiJGVbf
X-Gm-Gg: ASbGncshI3L2nLYwHfHOIVjv3HekWiWIEgl2R3XcVrM8cFAlQjAOzZf/01nVwKLecl9
	nh7F2sVggo5Xl/h1bhwHDJQX11EH3VlRw5E8yQtrENtUnRgIJB2BYg+/DJpZB4rnDISv3CFBIXP
	dL6hp2j/bSDfO+VyCyXU05SMwdfzP/BfB7xTJH4CFNDJKLXVXvDmAJFe7u17dWwb+IouI6nrG91
	AaD46vZIiZ0nABzI50itIklPkLgMLkJOo1dPVOv/EiZsekbYZRQKocquhz1JWCsGAPyWv1EQWXw
	J5HcW3nNujvnJKXtGJU7SbRexJcq3FcG6fyUbnd+dxZCbzYV0b2X52y84HXG2FpaD1iK4Wlp+na
	7sDfOsoAgMrnDHBupa7ZB/jPMWihNi9sKjaY5A3gNDjOKs0ELF/oli+fcudukiSJ4Ln6o/NulD7
	h7HpDvjk3uKUxE9MWhBOcLDH40MA==
X-Google-Smtp-Source: AGHT+IH19AutgiB4q5n1yDQ8ciHD5SRBcvRXU/5QyAJ1UaeK08hADApRcLuj+Gt1810PslIB22fggg==
X-Received: by 2002:a05:7022:6885:b0:119:e569:f61e with SMTP id a92af1059eb24-11c9d84bc2amr26089780c88.23.1764579899796;
        Mon, 01 Dec 2025 01:04:59 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm54908307c88.0.2025.12.01.01.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:04:59 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	agruenba@redhat.com,
	ming.lei@redhat.com,
	hsiangkao@linux.alibaba.com,
	csander@purestorage.com,
	colyli@fnnas.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v4 1/3] bcache: fix improper use of bi_end_io
Date: Mon,  1 Dec 2025 17:04:40 +0800
Message-Id: <20251201090442.2707362-2-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251201090442.2707362-1-zhangshida@kylinos.cn>
References: <20251201090442.2707362-1-zhangshida@kylinos.cn>
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

