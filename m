Received: from mail-ej1-f97.google.com (mail-ej1-f97.google.com [209.85.218.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1344B42C4F6
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345049; cv=none; b=L0Hnv78guLuXJGem2BWl/n1/h/LNIQWpDtWOur6JlBT2CYo0og6qpVS0D5NDrzHusTed3LmQhHzffMPzWBEsvX2JuGCLeSOwKx2MKJI23MyNvKb3b2XZ8qHX0YtZjrPKHaomfbavL+aiJMZSoHL/1RDTiHJCgsXz969a4xHHO40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345049; c=relaxed/simple;
	bh=0qgKzcRkiIVyNpkzKqzraDzrTs55TNhNxffRzLDnLXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mej7JmWYsNhKn+E4zrxe++2H/q5py4STCiJu4lJurDcOEA0w/5ggMYlpA0a+FZP0nnbot5wcGyZnhGWvpUITd2eypbh7fuhLA38t0x0Zb7EfRV0eE/0PxYN00cVxFs2m9WmBrPeN0ir3+bGCaLPfFoK1Zg+lt+4WgT7pkB6w2Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=L3pdf1Hl; arc=none smtp.client-ip=209.85.218.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="L3pdf1Hl"
Received: by mail-ej1-f97.google.com with SMTP id a640c23a62f3a-c1676648c1eso7290366b.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785345045; x=1785949845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RqZoonqZ0uag0x1qThpmE0Jlcr9KhM+cawrPE7VRM5k=;
        b=L3pdf1HlDRfoV/dE15TVu0DSVwehdsA86Dn+OgTZr4PGncxDABTKh5IJLk93b9M+it
         ycxN4Bvn8z9BOj43hKXtZdvdsD5G4C1XQZaWxjkbcJd+O5P5q/Z/RjhUNL3jl2zVxPno
         ukretvFdKOWEsWFagmdpCqw4A7ZD+SZqX9xNKs1+fO5U2EHjoDYteXxM+s3FsBzK9wae
         LUPTXyBE04jL+RDbQTkZPAAcxXx0XFVJX8XIlQi6cb54pczZ5vvS6ubXScV/z2WaSAUf
         3Mm3hJIeWmzM5H2xS5ETX+X3/pItXRkm65hY8Ddk1SzSK1IdsEZ+Rf3CzSqIZnHGY3dK
         bQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785345045; x=1785949845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RqZoonqZ0uag0x1qThpmE0Jlcr9KhM+cawrPE7VRM5k=;
        b=MOZr131b9zy2Yuk/bv5bAgTahO+lFoZz2yfvi2e9Wz87GA3tMIYWTN0aaavftJdM+w
         /u23fgB4N+VGZ34h3HlMRGcxfAAlAMoa2apg758xnxgjhk7eqB+vmSJehtB7+rKj67Li
         LRkqRHIiWYfG84ctByjiN007VLr3zofhfo3BqoBa+iZYVx72NsLewXblYzGQG4VrUOBs
         0QOlrvukwNn8Di/1ufL7UBfOmr1NSNWRTXZrZWbakIC+EqTxZeq+NpAczu1QEKLe7CFf
         SW3gRNzxO076rLb95jC9ihM3X5fmKPtTwXkRFNxhMfxtAiK5mrwfieuic066lXaNaVoP
         1kdw==
X-Gm-Message-State: AOJu0YzXlC9B3zCBkbHFdBjmCQ7F7fyJSymQNQQw9/JXu8fp37txbmrN
	zyazYCGdEG0laRtVYFIwDAsFcgxwsdOKoqxJnehjGtFsU+uo/dGBKHUTCiK9vKcQ+tEUONVrBGY
	I7gsLxjTXUWfFXTXqpAwWW2vvh9sOcJY2bag2B/KYhAoyr6zeKcA4
X-Gm-Gg: AR+sD13VVyPQpyyH/tThgV5MBZxGnMz2G3lTs/2Bqj6ctkAHO2roS6zR05CPRDbFBVH
	cbUXfZzRuKLxK88LRrSuIjoqtSGunSmzN1tNIvsneuXuXoKBrjuZWzTN1ozzd/Fh/ZU0LsxX90C
	dxOuLgVzxfSeSuAZqkoP1NU2zjPHab3CcrZDI9HdpkU4NtWCs6RmBZvUT7f1toda/r+FhKTVrpJ
	lYD3BjAUBFJkGSEipJ56dteMwrKlZuZlY8v0U1Wz98XJgGvpl96eqQBUMzdtn3IB0OKvhp4s36N
	YFK2PN8EFlA7aUqAQ/PnMauUSvwuzNXEs7wv52CJdO5pSW7WDt1JmBxiWhdTe1KWboOfpCNA76z
	YSoB+y03Jeu6Fd/b7Bw==
X-Received: by 2002:a17:906:4784:b0:c12:732a:fe52 with SMTP id a640c23a62f3a-c1f952db03amr171690866b.4.1785345045299;
        Wed, 29 Jul 2026 10:10:45 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-c1f8404bfe5sm23717466b.73.2026.07.29.10.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:10:45 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id E75C2401FA;
	Wed, 29 Jul 2026 11:10:43 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E52F1E4017C; Wed, 29 Jul 2026 11:10:43 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 2/3] ublk: check for ublk_unmap_io() returning 0
Date: Wed, 29 Jul 2026 11:10:40 -0600
Message-ID: <20260729171041.45061-3-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729171041.45061-1-csander@purestorage.com>
References: <20260729171041.45061-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the userspace ublk server passes an unmapped address as the data
buffer for a completed ublk read, ublk_unmap_io() will return 0
indicating no bytes could be copied. Currently, this will result in
calling blk_update_request() with nr_bytes=0, which doesn't seem
supported. Fail the I/O with BLK_STS_IOERR in this case instead.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 098e046505ad..2cbc359dc196 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1588,12 +1588,18 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
 	/*
 	 * Extremely impossible since we got data filled in just before
 	 *
 	 * Re-read simply for this unlikely case.
 	 */
-	if (unlikely(unmapped_bytes < io->res))
+	if (unlikely(unmapped_bytes < io->res)) {
+		if (unlikely(!unmapped_bytes)) {
+			res = BLK_STS_IOERR;
+			goto exit;
+		}
+
 		io->res = unmapped_bytes;
+	}
 
 	/*
 	 * Run bio->bi_end_io() with softirqs disabled. If the final fput
 	 * happens off this path, then that will prevent ublk's blkdev_release()
 	 * from being called on current's task work, see fput() implementation.
-- 
2.54.0

