Received: from mail-lf1-f98.google.com (mail-lf1-f98.google.com [209.85.167.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB4B20487E
	for <linux-block@vger.kernel.org>; Sat,  8 Nov 2025 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762642872; cv=none; b=hBK6ykaz70qxBvisUC9M+E4CPbRL4FF1KXex/QQXwg4/ma2XRtOvVM6zpcKBfLutlpSArrILDk3liVcIbmBVQxH7y9sEyo9/1DGFhXiBmJBCw2Pgq3bTq2PwDgR1WvqQKYPKDozu9ky0rO3zbycPZZPQPOMY4FnJzg4SHffWI7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762642872; c=relaxed/simple;
	bh=g4ddBgla8YQdcKEudweh6zNN2rYBzDIa3qmJAJdcF6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WaojWVsMVdWQC7dZooRxbc7CZgfy6jDWDMlYGVoWPpOI5QjFga7F4vATBPqFXEZ8FOnRr+8SZOZanjGBST+o7BilE6gkacGedCSUrNtcSPfIFVdAMES1OL5E2GQC3uY8EQEz2sB/rIYpEL11BmlScvG9uz2mWyjbdpbd07EvbF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Jo5KQ9mj; arc=none smtp.client-ip=209.85.167.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Jo5KQ9mj"
Received: by mail-lf1-f98.google.com with SMTP id 2adb3069b0e04-59441206c1dso211502e87.3
        for <linux-block@vger.kernel.org>; Sat, 08 Nov 2025 15:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762642869; x=1763247669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WVuCf9VQVlr+A9p95nOr8A77FSbZ2C8bh+iEVyLBwI=;
        b=Jo5KQ9mjrWkROXOpc+iIpMpaOZ3/m/DMk1TbuJj7xM+2zIEjgOSVtV4KOuFvNTNCeE
         UENVkG/dRlkFf8pQptGe3IBx6AQa6w3mDM7ouHj8hIw7vrXTUZ3dDPNuZqiIA2dm+PEd
         lMfWXFBjAZakv/wU029F8jfnyNQ4Si6f5uh98uK4LSaa0wrVR/4xy/s+1Ke5KmYJUkFT
         o1/GBXfLrYhselble9edRnk+BtOsHMbYVhDMogJD9mx1I+dtHmBaR+UCgzck94YI18QS
         2z9kCa5FYWUz7pa/IHC3L5rINPraZMg/tfydK/Q6m7nmQSVNZVmLV4wq61AdBDpb5QPq
         G0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762642869; x=1763247669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+WVuCf9VQVlr+A9p95nOr8A77FSbZ2C8bh+iEVyLBwI=;
        b=MKXodxjA8W+BOcP7axdIR+4Cq+CpS+6PLYdBNj5TGQm+P8pZZZN4YfcmVnfNjO2heD
         XJ4GS7He2qfy2gIU9azQIoRGXWV8/FC6qApDJHnYNFYAIuw363YGzCy6OgcqtJDAF5r7
         +BUngFVtblSA9M8gUlU0K1lsPrrlpSidvXjR2q+zST1uJaamf1GxAwSr28AnmFOeylkM
         dLpZurVczNt0GaeZPIomSZ3G5D5qmxPS9VrDh7kENy0ZWfBMOYkCDzFAxqOKXWYnD0AA
         fD4ZAEn9glGx77l9qNCrQy9iMb1subHs3gg1OXqhdRqN2qye+PeQJ/88G0lHbsLWCfzX
         xsDw==
X-Gm-Message-State: AOJu0Yx+vzzHAfVHmailnMtzxOdJeTjs8g7lb4cze+9FczvwDI567eNw
	2JEre0cOKuzwopoATHYgYOMzp/OLjPAaBZrRL2Z0rnlx8vpNqxEu7TZkVxHJqmr6Mm7MaVQQxxF
	Ac1e89EukeqUpzi2zfzPZfLYBs6wE2vi01giHgSSVZVATLyR2Q0Cl
X-Gm-Gg: ASbGncvrVwkXKccbtj+jYazY4Nubdy5BwrZSREaLOLV0pd3a7pHFQo6odIuTPfk+MaR
	qCw2Iotb7Ak/d3KSQ7J0yBFh9HYraVl6uQZIr6M7lM27DFHMaDa5+dkOBpsVIGK42U+neGTU1nM
	Lze7K6IRDaBP0BEq5vUd7gXvqmtJqsLYLwDnC9NqBt+1NfPUGezuGtNFyxZRGSTEmWh+i7PJsjl
	REb4GgNM8TLkTrlZCixp0vb0Ig0wC8tmZQdW1w7UVx9cQf7BYg3/yaj0cRMJIsMPBBh//SHA71+
	AtIiiLc5Z51QnCRM50WEwnUeZXbfyeANq9undDL1YtgHpDqyyN3t1Gu1Y5As5mNhfPk1fNDcWpe
	dXScG+CupUxXySdaC
X-Google-Smtp-Source: AGHT+IEi0Gyq93gG1HUhWiqGcWqqJYy3lxU5f5qNsMzYHUTOHbtDZ+IHRkCB2VavnTbM6L9xIJZvppTQtWuf
X-Received: by 2002:a05:6512:3c8c:b0:594:2d0d:a3dc with SMTP id 2adb3069b0e04-5945f1dc4f9mr582180e87.6.1762642869025;
        Sat, 08 Nov 2025 15:01:09 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-5944a39e420sm1385687e87.54.2025.11.08.15.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:01:09 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6A50234052C;
	Sat,  8 Nov 2025 16:01:07 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 68074E41BD7; Sat,  8 Nov 2025 16:01:07 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/2] loop: use blk_rq_nr_phys_segments() instead of iterating bvecs
Date: Sat,  8 Nov 2025 16:01:00 -0700
Message-ID: <20251108230101.4187106-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251108230101.4187106-1-csander@purestorage.com>
References: <20251108230101.4187106-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The number of bvecs can be obtained directly from struct request's
nr_phys_segments field via blk_rq_nr_phys_segments(), so use that
instead of iterating over the bvecs an extra time.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/loop.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 13ce229d450c..8096478fad45 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -346,16 +346,13 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
 	struct bio *bio = rq->bio;
 	struct file *file = lo->lo_backing_file;
 	struct bio_vec tmp;
 	unsigned int offset;
-	int nr_bvec = 0;
+	unsigned short nr_bvec = blk_rq_nr_phys_segments(rq);
 	int ret;
 
-	rq_for_each_bvec(tmp, rq, rq_iter)
-		nr_bvec++;
-
 	if (rq->bio != rq->biotail) {
 
 		bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
 				     GFP_NOIO);
 		if (!bvec)
-- 
2.45.2

