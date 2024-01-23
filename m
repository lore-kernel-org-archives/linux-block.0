Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342598003C
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031638; cv=none; b=hOKtEtk6nOasIj0NxFPmbcv2qyFOB5ieYpbrc2y9p2sKYC3LXhu1tglHNPO/s2oJucoQopf9sumoQuHNsPP+n9GcH9xECNyNt7vkgH1VzpuLd4cdNa5n+JbrcuhWxN8l5JgUPCuAcqb8aoPkexmVBnOV/HOb6ayMm5zD1YGpiPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031638; c=relaxed/simple;
	bh=FJNWVgzbabsKcp7psepexXCA4FsLqAEPlAXmmOysrV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQjYZ2CcaCw3b0hOQG3gL7edGNIqX/G6fccCyAhbcVUvuZE9w66HJC9qnKWPUlitzejxVXmYHEXzu/W+6I/vHPPc8S82OL+avQicPL6J8G8f7Bcv9Ku4FOHAgZIxHAedbAuHNX4WnJoIQkZLNsW3xI2ZiNH+nS4XZ8hofhsRoZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vhGEk/C4; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vhGEk/C4"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so51897239f.0
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 09:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706031636; x=1706636436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFwFEWjrm/jIbIn3f2kPlUx+1yILSk4z8zlrLMpPL5g=;
        b=vhGEk/C4/+UOZI9z1tGvjS1wqm2vto1enjyEVD4KkFab7fL23EAtV0LT6uCRkLp4YK
         epjR1jGFAh914iFsB5H7sQTALHbBm/eZPsQqBbdj5JoWbw/S6nvT+n5BknkHKmztaKkE
         wAsWhFB0ziALez70fmiDe/za3WMCvKwkRIRxFUJKG2xmMIHGynCJd+Es1yajZ3eGhfcz
         W6vMHbgdfm7MBFOq65fL6lovz70B2Mdhqleo1GAGSWO4B9cmhfoNj5vUan5fcqFAqjla
         G+T8u7SNM6VVN6M45jmxyOFUKZlVngwKQcF0Uh/jJsIpne2QHWsU80wZXDVYBLrwJ/jF
         i+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031636; x=1706636436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFwFEWjrm/jIbIn3f2kPlUx+1yILSk4z8zlrLMpPL5g=;
        b=j8XKkDPWoOxcPiwsgMV2awwaE6db9S3SCSOdK4n8iIkm4yLBAB5fClNDG3TOlcuAwI
         NWv4TwzGKKCOdjN588fKk2Yxjcbi+Dc1kkfpVcL3KaUAGfi0lazBIFmlCqRbaofKOkj+
         wPOibdXqbejmjBLpNf0iSRf7WPkWfSqwnimvCy11na1QC7F9pfxNdmFY+W5I8Kpn4MOB
         CkSGdfnZr/lVJLi7a0REZc3RhbaAP5m7zUVCuzz5UjRpn2jmuUUdqs3Um5yWcDyl2Hml
         0Yshk4BPZgg0XeRbMaPGyhmE2QKhF+DcwqTb1zeQFYLK+2ccmDTsLV5oYA52o2mgAWZb
         I16A==
X-Gm-Message-State: AOJu0YwHJvDKLgoGSTPp8BITdb/RtHEFPLGiDcoga1EHSZOtW1jYXvRY
	LZzYfdo124VLPa6d+pHKaI95SR/kjE62A74h+cdao7tNE0+VByQe2hWq7UxtjfR5PvCcm7DBGdf
	sV7U=
X-Google-Smtp-Source: AGHT+IFWXJ0VDUPEqcYzpxQvcGlKbTJJzCCNtKNHfiOSeOZJBd9RrTAzAsZkPKy/vYB8xDZ6CbtCAw==
X-Received: by 2002:a6b:4f09:0:b0:7be:e080:6869 with SMTP id d9-20020a6b4f09000000b007bee0806869mr10098460iob.1.1706031636037;
        Tue, 23 Jan 2024 09:40:36 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l15-20020a6b700f000000b007bf4b9fa2e6sm4647700ioc.47.2024.01.23.09.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:40:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/8] block/bfq: skip expensive merge lookups if contended
Date: Tue, 23 Jan 2024 10:34:19 -0700
Message-ID: <20240123174021.1967461-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123174021.1967461-1-axboe@kernel.dk>
References: <20240123174021.1967461-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do several stages of merging in the block layer - the most likely one
to work is also the cheap one, merging direct in the per-task plug when
IO is submitted. Getting merges outside of that is a lot less likely,
but IO schedulers may still maintain internal data structures to
facilitate merge lookups outside of the plug.

Make BFQ skip expensive merge lookups if the queue lock or bfqd lock is
already contended. The likelihood of getting a merge here is not very
high, hence it should not be a problem skipping the attempt in the also
unlikely event that either the queue or bfqd are already contended.

Perf diff shows the difference between a random read/write workload
with 4 threads doing IO, with expensive merges turned on and off:

    31.70%    +54.80%  [kernel.kallsyms]  [k] queued_spin_lock_slowpath

where we almost tripple the lock contention (~32% -> ~87%) by attempting
these expensive merges, and performance drops from 1630K to 1050K IOPS.
At the same time, sys time drops from 37% to 14%.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bfq-iosched.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 5ef4a4eba572..ea16a0c53082 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -467,6 +467,21 @@ static struct bfq_io_cq *bfq_bic_lookup(struct request_queue *q)
 	return icq;
 }
 
+static struct bfq_io_cq *bfq_bic_try_lookup(struct request_queue *q)
+{
+	if (!current->io_context)
+		return NULL;
+	if (spin_trylock_irq(&q->queue_lock)) {
+		struct bfq_io_cq *icq;
+
+		icq = icq_to_bic(ioc_lookup_icq(q));
+		spin_unlock_irq(&q->queue_lock);
+		return icq;
+	}
+
+	return NULL;
+}
+
 /*
  * Scheduler run of queue, if there are requests pending and no one in the
  * driver that will restart queueing.
@@ -2454,10 +2469,21 @@ static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
 	 * returned by bfq_bic_lookup does not go away before
 	 * bfqd->lock is taken.
 	 */
-	struct bfq_io_cq *bic = bfq_bic_lookup(q);
+	struct bfq_io_cq *bic = bfq_bic_try_lookup(q);
 	bool ret;
 
-	spin_lock_irq(&bfqd->lock);
+	/*
+	 * bio merging is called for every bio queued, and it's very easy
+	 * to run into contention because of that. If we fail getting
+	 * the dd lock, just skip this merge attempt. For related IO, the
+	 * plug will be the successful merging point. If we get here, we
+	 * already failed doing the obvious merge. Chances of actually
+	 * getting a merge off this path is a lot slimmer, so skipping an
+	 * occassional lookup that will most likely not succeed anyway should
+	 * not be a problem.
+	 */
+	if (!spin_trylock_irq(&bfqd->lock))
+		return false;
 
 	if (bic) {
 		/*
-- 
2.43.0

