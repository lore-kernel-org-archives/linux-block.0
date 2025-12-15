Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386A8313E2C
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788951; cv=none; b=dQMSmSpWhdaqrRSTF++bVbfA4igpy7QDqckig+1miADZlWVS8O9sTy3FzFYoL4KFCcQkEkBj8wyOGMIDvUWB3r4z/KCdpgX1NawpUpwE0GuIVqU1wqL0xQ7Q0xSdp3rIrvVZrggtrLbObRL7/+HzC4cvW36GakFypokJCh0zmlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788951; c=relaxed/simple;
	bh=4Tie54CDNbTI/pb3KabrJIFdXk+kf8cvTiT0m3fItb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t+q3PMzPX5BATf6L4QsTA+tLve3so6Mmds5oFLs8/KR+ZZ5FNg/TpDtD6Lu4Jy8y01D2SZD+lbkxmRsCGWzrWkBa+zQpfuaE3HzriFGZWEAALqgLB4wLpgGGJuYecr/FXgR1Pf+xO6eOsK9tbR0JaFglZL/KUytVCPM0YHM0iDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUnduup9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUnduup9"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7f1243792f2so2013303b3a.1
        for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 00:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765788949; x=1766393749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TA45cfF16J5xm4R3MV6ZvCgbkvtpLEhAyJMF2NOv6Q4=;
        b=bUnduup9m4mWUN6BdacNjTI84k0A+Jfy/cxJffF8qVyPccpGs8+JeTznFzyAL8SQKV
         CjXOO1vxtvMYR1or6lhZpiq6U++YnCuZtWT5uocp7dNy/UhpycFeD5n4x9j+8HbX70Yh
         kxAmomnjhXRUqSHqbiVtwnZXPExoMdNW6f2yejsk6INSBthN8GjLAgHwLgDsoiAzski4
         PYrfKMVdSCjT1IhmX2Yywcy+oDepuH7QavpIv4vZJzLWkUbJb3hq1L9+YkHHeFMamMbX
         b7wBHzw5bpzRHlnZu6eklwMd9K5sqfu4lTOToX7+YDM+MY/pAZy72oURyltUmwbYhz5C
         2cLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765788949; x=1766393749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TA45cfF16J5xm4R3MV6ZvCgbkvtpLEhAyJMF2NOv6Q4=;
        b=aFZ8xcpmsZTEbj/D6NE+Pp1j6UxnmVxBxSOjux9VF1mmGKf1+ZgdQ6IjDF5lDlMXYw
         2u903QFAIQ9xJl1CN9AjNH4erbULbU0tzn3LSPYB+WYorA2YIwugYJloI7sAACcU4wv8
         08+lRLc6HeiYC6pFmJm8q+u6rDtiQQrXYy+KgCJH7AkyQ1cowJUszimlYOLItZvGuVmK
         xJSSLqPNdkNFLKI2ytKjSWEucuI1NiXL2AFBFA/AfQvDqnUpKh+Qv08veLP3jaQwE0fV
         X6IEtokzuy+LPvbJU+SMja3WEz/+FqsnhMg+V6RWVbNzi+u1/3ox2+mBOdaLykZYHxzN
         vMkQ==
X-Gm-Message-State: AOJu0YwqhgTQuWVqxbY1HTxxVIJVAG0sv4nnV+rujvIcwkKbCofEHtbE
	hzT1ROEz9xRaYgaFNGqy6GRCuA2wrW3c1TuV9QpCAw5t20sK8vC/U2Y3UiLjt1SPt+E=
X-Gm-Gg: AY/fxX56LWKklIfQ/zvRKGRlDKCLZr1h7ksWScgOqC51PhGrMjEtxURZcLKhDXsPHEX
	+epBOXmFVIyjXMHSb4en6RfTeIsowMq+6lQP5+eI3Zxvj2oBdfaXTtLDyou7Tj65orR1DJdgFAB
	kaAGD1roDBN0xromU3SbiwrfbzD+c9Uvc1PQRL74RV5XguVP5d3POp94N5Zbq8V04wg4ULrNUxY
	a+zedB08zbw3pSOqsQsLXemhuo1Es7+E2wO5F74sHTgBpVC5NILXMnjTsvsP/B84H4QQ6AhSsxG
	u8YMZpXFUNv9rYBDqn6PjXgO52GCUmQ+b2hzSkFnu+BGr4UiqEEtoK+Lo4kkTfpRpwjLuscWysu
	AmxHaxXMJ9Hz4RUW6zgfOk9wa0UQL9QSY859ic0pIPhKZrKfen5YV4w/NriynmXAyAQ1f52aC1m
	P+30XnSJIK5fi9wGVXRMh76dtfXzOAgZn+hSeGKyP4UvB83srufp1eHgG1lA==
X-Google-Smtp-Source: AGHT+IHgo3RXZmHyAanQiobnXtwK3uTeMCXmUhyowjXMyKXVUgAdEjuJP1p4ezWTKsWtrwuXD+ljUg==
X-Received: by 2002:a05:6a00:339b:b0:7f6:2e6e:5289 with SMTP id d2e1a72fcca58-7f6696a3b80mr8535662b3a.49.1765788949389;
        Mon, 15 Dec 2025 00:55:49 -0800 (PST)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c2379e40sm12003114b3a.5.2025.12.15.00.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 00:55:49 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Yongpeng Yang <yangyongpeng.storage@outlook.com>
Subject: [PATCH v2 1/2] loop: use READ_ONCE() to read lo->lo_state without locking
Date: Mon, 15 Dec 2025 16:55:18 +0800
Message-ID: <20251215085518.1474701-2-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

When lo->lo_mutex is not held, direct access may read stale data. This
patch uses READ_ONCE() to read lo->lo_state and data_race() to silence
code checkers.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
v2:
- Use READ_ONCE() instead of converting lo_state to atomic_t type.
---
 drivers/block/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 272bc608e528..f245715f5a90 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1858,7 +1858,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(rq);
 
-	if (lo->lo_state != Lo_bound)
+	if (data_race(READ_ONCE(lo->lo_state)) != Lo_bound)
 		return BLK_STS_IOERR;
 
 	switch (req_op(rq)) {
@@ -2198,7 +2198,7 @@ static int loop_control_get_free(int idx)
 		return ret;
 	idr_for_each_entry(&loop_index_idr, lo, id) {
 		/* Hitting a race results in creating a new loop device which is harmless. */
-		if (lo->idr_visible && data_race(lo->lo_state) == Lo_unbound)
+		if (lo->idr_visible && data_race(READ_ONCE(lo->lo_state)) == Lo_unbound)
 			goto found;
 	}
 	mutex_unlock(&loop_ctl_mutex);
-- 
2.43.0

