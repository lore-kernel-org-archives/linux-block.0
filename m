Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F1D27C16F
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530868; cv=none; b=u1+0pZFYPMCmsey55tONyWL2qpUGbX7SzXloyNuMtWR98n+IdoahzzhA3FFL3YGINfLqPST4oZVADUuZHlR9LAMffMYe2N6EvfwHQ4ovK37jXzRTKE6ZN0XHT1AZz6aB7/npqZULG2/aG/LkNY7GmpxMRmaeZAv9Sq0BQD1VsVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530868; c=relaxed/simple;
	bh=kW/DwVkxNOnEbo1a4gTlVHFHPlWOXWPJvJuJO3BeUMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n8AncOccb6ld9jG+bdqa4KNghuECpcFb3LjZOPKC2XFkwJ7N+ngAP1B4eaXRANJHJuQ4QV/ZXvieZ/GBfo4BKuSayh8n6wLSSCOlek731PWOXusN63raiu0ZQFBxhAiNAoYMdbctpbPSSHuIN1NTSN1BxsXwWwWSsTtdC+P5Gpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-441d1ed827cso2905775e9.1
        for <linux-block@vger.kernel.org>; Tue, 06 May 2025 04:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746530865; x=1747135665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5GgZRZD/L8csWJFbnAXPLR0XYntr51fyV49ak2W5xU=;
        b=nNmJWSa37bN+XQ+LXX3YYhhRdTwgT++rLwoDrNd+MPvmF0Zm6KXVa60ZIgMMTstQed
         MGap/+o9zTgiabZbrsDPMzu6mOl3LUfM4iEAHZsotbK22wfXQ39SsO0DYVC/TuoV6pyZ
         8x6QZkgYE94myx0tX0SrWTmLPk7rtY27B2XSDTHcoe7mjkL3XlhjrQr77Kh9XFmK49lX
         +hiW/50Q9hDe1KOWYHvxQbAdh3XCytOviPnEsLVCevx1pO5oPogKjOJqb76nXQSv92y+
         lJWpXMlpTqUYtEZp2syoynCvfXWF/AHiQfudJqBwOA2teq2Xm2Vbcv/L+y5kS9Xa5gf7
         9yxA==
X-Forwarded-Encrypted: i=1; AJvYcCXAWUETwVmjutYZzQm6JmZpxZq4VxLR3DUzpwvifXFXu6ju2QyJudfYkkfxP9fhAFEvDIZZYpI5EeajOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsKV9yOFrvardFNJK7ime2BVtoArSOvJ//wMVgJLGrXG+2Zsvd
	Y3g2DtKcUO41cfIMfzF1VCeyJhjSbSeX7QW+NdHNFl4EqiHsuAgrItaTdA==
X-Gm-Gg: ASbGncvLfwK+UqDtTswEDR/K1goyzqf8VQLke7hnfDudNJnx4SLgEeCyVUtfFsk0NHT
	/poV/tDu3PQK9tUfr8g0JveaJ/6FunkTRKJMNbmhusi8iVswZX+chwQVLFUu0O/l7hfVdFK+dfB
	7KVW6rgPUfgEd2IE1ARNDSIePjE/f8LBXFKMuOtShpoYkRRT202P5jssUVp79NyzpEPByhfzEIY
	rMuILC/TuFKdk0l5THEV564kIh8M0X91TdQesa565xY6JhIkYi6ZQdMSabmbV7wpBro72Le5mbx
	lbfamH78yrP9CYYQMhwwMn3ganB5Zbvw2nLsVwUAxtHKkXTFG7m7NHkpQkuUoiaj4zopev7srqQ
	8i7SmLsWIIoNdKZWGFBZbUnE=
X-Google-Smtp-Source: AGHT+IHXcGqz3Bt3miJP51F7T+9yJ48SpjUKETiVNAZDwqaTrjPvlo/diWb45o4Wpw5sTKGIbAFdyg==
X-Received: by 2002:a05:6000:ecf:b0:3a0:aeba:23b1 with SMTP id ffacd0b85a97d-3a0aeba23f9mr1179147f8f.49.1746530864555;
        Tue, 06 May 2025 04:27:44 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7133d00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f713:3d00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b16f00sm13129754f8f.84.2025.05.06.04.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 04:27:44 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] block: only update request sector if needed
Date: Tue,  6 May 2025 13:27:30 +0200
Message-ID: <dea089581cb6b777c1cd1500b38ac0b61df4b2d1.1746530748.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

In case of a ZONE APPEND write, regardless of native ZONE APPEND or the
emulation layer in the zone write plugging code, the sector the data got
written to by the device needs to be updated in the bio.

At the moment, this is done for every native ZONE APPEND write and every
request that is flagged with 'BIO_ZONE_WRITE_PLUGGING'. But thus
superfluously updates the sector for regular writes to a zoned block
device.

Check if a bio is a native ZONE APPEND write or if the bio is flagged as
'BIO_EMULATES_ZONE_APPEND', meaning the block layer's zone write plugging
code handles the ZONE APPEND and translates it into a regular write and
back. Only if one of these two criterion is met, update the sector in the
bio upon completion.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk.h b/block/blk.h
index 328075787814..594eeba7b949 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -480,7 +480,8 @@ static inline void blk_zone_update_request_bio(struct request *rq,
 	 * the original BIO sector so that blk_zone_write_plug_bio_endio() can
 	 * lookup the zone write plug.
 	 */
-	if (req_op(rq) == REQ_OP_ZONE_APPEND || bio_zone_write_plugging(bio))
+	if (req_op(rq) == REQ_OP_ZONE_APPEND ||
+	    bio_flagged(bio, BIO_EMULATES_ZONE_APPEND))
 		bio->bi_iter.bi_sector = rq->__sector;
 }
 void blk_zone_write_plug_bio_endio(struct bio *bio);
-- 
2.43.0

