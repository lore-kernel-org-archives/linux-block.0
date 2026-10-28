Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205949;
	b=F9uDhKBcF9eXdPCUjgiWWVEo0vAEhTVcL0QStSmIIujofEzU/hrH686Q8p1/8kOjE26O
	 wDbOqOE4zCPCp5bs5Psb02JchcMgrJBQVKxdWTSUSoUBRfDYosg9+UitCfZMN55txYtBt
	 eEF4UDVSX22kzeyOrkoEN+TxSXr/9OH7deh7aYnJg79EsT9sTT/qoI8L9OYi7pEGQpIW5
	 Db11f/6eF1xCEAYs6rxV3yCtZh2HOMedxa0E/k6GSaOKSoFJo8OqIyrYOvtMP14+ip9ip
	 /a+IdCuHGbbaPOIwV99d+b8CHNm5Y1sodDeTAcWz0ONAXacygHJW9s400CrHlJuDtRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205949;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RVYtNnJT0mZ9d3d89Cr4tuAShGn0eqLJS/Cuzaqnc/E=;
	b=NJQcWhKONE4sFPKStASgCKIyJ7LOKrF9TV0LQQ7nrKSsxgIpVm+W1YKEb6yEwoUyDNUA
	 XagBjn3xl1wH2Jayq4a1Frjz8M6PihL95z3Vrt4BkSzbtvXZ1QCyf3cqFa1hqUgBy5ysp
	 vvdhhn7sW9ql+7ReFYUBDrWAwS+o+ISZ5D5uCZU2jxi2RnDpihKX/U8Ng4Ph53ujYHY9c
	 1ZDBSmynRrQiOGY5kkTEtHwiAsj4lJD/9BbYOCRuZeK97QseoHNnNpKIkzB6RXHYoUISr
	 1ERaQsnirZfyoE3tZr5Rvu77fIcMl24kE78TmUCEsTL66YW0cW/yNoQ4zNbdzOLA7Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EYvHSxh3;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A44606A325
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95A44606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EYvHSxh3
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-847ac7ccd85so793443a34.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205948; x=1793810748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RVYtNnJT0mZ9d3d89Cr4tuAShGn0eqLJS/Cuzaqnc/E=;
        b=EYvHSxh3zeAkP5JgUdYGNqgRzaXEzcvtiQVFv/rf/OxB5l9EupXsIsTwgJSmb5sk1C
         lXMhskGnEUfmHe/hcxA/oxKaWr33a2q+BhySS6B9rdXG6Iog9620mdNt6Zo+jEyCI/JP
         0N/obrphgeh5la6Z44xRchKpsSgWb/8S6uG/SleTZ274NVWteXdThZdBjwohmco2gGFR
         6Nx0CAryi6cydiP3O9PFQDPo+OepjMG+Ale/0hqzS8OWsxlr7clkfVHgl/dXPr7F49eK
         XIESu5g2b7fEZ0O08cgl7tGd2c6OicK1HGp3C4Qp0vqW+1hWANrPdg6q2llwvZj7NUWK
         Sj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205948; x=1793810748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RVYtNnJT0mZ9d3d89Cr4tuAShGn0eqLJS/Cuzaqnc/E=;
        b=X+XZUrJutJ+GvAYrCIFW9QSzVflnJNbTyu2NZq1yiJsE/qM+Ylig7xyufaB6OBwIhu
         GyZEGiXzFY9ZH/5Mo/fC8J2opvZvxMqPLrXVQdaMasG3wAZdMFjqVWW8bxqUD45+yN5x
         yiEr8GW3JtP9ryOimtBfmfFNCSo1WheAeLvbF3tl5LLHQWUhZF9J6CJT3F12+z/j7qco
         y+7r2vWiGMvAIJHrwaDKvfD1A4H4408cH36yb1B9vjtRK8QHDUDSdz3g+HhTIMg1Il1O
         bPfWuudcuAzmHvGpqrDKiIichuA77HF9Vp/L2181VB82E0ElDshjEKTukn3ulf4beJ9l
         Cgvw==
X-Gm-Message-State: AFq9FYKlQBIS3jBKC0T+HUmE0Wmmgr4RcbHgylo7EiOuKUYY0bXWpRFG
	Dw2cCseT4KK87IpZSEn5WucL+nkIqLvPaa0C8L2Mnz1RpmamgczCzc53k7Lf486ZtEgM1TyPew4
	K3G911iw=
X-Gm-Gg: AYBFou3B3ghwcSzYCHppOr4PovWsgZr4FdWWSPOT3ZZPcoVcfuol5rO8NIiHQph5LXt
	wdJJQ/PXC33DTtvlYtsXwG/JWN6wrjaLmnnRqHhLRzaEdlfEo0mk1M1SuxOwACREX5i4WCpF5Pl
	5o0VYmacnmDZBKHzqHbX/EUVujM9AMpdaTmblLul8pkSk+pQ9zq4einACwJhUw1hG4oyN26lU7P
	150K2OP/ju9uPKEKzrCA4ncQzxG9NHHnrhrbWJ/83DADSTksZU/S8HnYofvYVUwXGBBfzskLqTn
	tUgJSu2Fut6llhNrs8bVsBsAIGuJ9O+LZkMBqcUw5LOrHPReyOBYjLivJW2NZz3LKSSRKqhuNBV
	LwtrZLOv0IuNnz/RsMfjxwRLMGlEt13PrE3088oeslXMP3Va6O+lFS2v5d1/2W1o7MpdTHOEj3b
	tKSQg2zC2QyvyKg+X916TNWw76kNfskxtDksmRErwPJAb5VTYIN67ibiWOYj8Y2r+3l3LhwlBzu
	dl2ALhO4aeiiYeuezoEzRlOW5nAw3r9gVdb1qextoN6JovtkcrolofnkAMoXFqZUWkrHH2bHYGu
	fWK+knUzvL6MM5uqCQhhTlVcDMlZr52qDzyPMK3tRPPdaJvz1oQWKXUvESp06OC2eDTlUGnXOxQ
	luLF8aG52Y36XgIwoVJw=
X-Received: by 2002:a05:6830:90f:b0:7dc:dbe4:3f21 with SMTP id 46e09a7af769-85aba80af99mr2356978a34.1.1793205948629;
        Wed, 28 Oct 2026 09:45:48 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 72/98] nvmet: fix NULL dereference of PCI endpoint targets
Date: Wed, 28 Oct 2026 10:42:15 -0600
Message-ID: <20261028164415.1262013-73-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
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

From: Josef Bacik <josef@toxicpanda.com>

nvmet_pci_epf_create_ctrl() calls nvmet_alloc_ctrl() without a queue,
the admin queue comes later from the host. nvmet_alloc_ctrl() passes
args->sq to nvmet_queue_tls_keyid(), which with
CONFIG_NVME_TARGET_TCP_TLS dereferences it, so every PCI endpoint
controller creation crashes on such a kernel. The debugfs tls_key file
passes ctrl->sqs[0] to the same function, which is NULL until the admin
queue exists and again once a fabrics host has closed it while keeping
an I/O queue.

A queue that isn't there has no TLS key.

Fixes: fa2e0f8bbc68 ("nvmet-tcp: support secure channel concatenation")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/nvmet.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e354a71514ae..5c2021b89ec4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -964,7 +964,8 @@ static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
 static inline key_serial_t nvmet_queue_tls_keyid(struct nvmet_sq *sq)
 {
-	return sq->tls_key ? key_serial(sq->tls_key) : 0;
+	/* A PCI endpoint controller is created without a queue */
+	return sq && sq->tls_key ? key_serial(sq->tls_key) : 0;
 }
 static inline void nvmet_sq_put_tls_key(struct nvmet_sq *sq)
 {
-- 
2.56.0

