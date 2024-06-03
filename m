Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D045A137923
	for <linux-block@vger.kernel.org>; Mon,  3 Jun 2024 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442821; cv=none; b=bUj4ENoUl6AimbGZnt3ez80Bim0tIItgSmiCQa0c/1+1N7RwBYq8tOgdnFRsYD6306VNDaguiUxQHJoCPAN+EQl5bgT7qAz9W3T7Z18va8MXQAqOdZHy8iiapNIQp18e46wRsPD94ocUz2wwRYRIstOLgPxvo+8USjQZI79NPqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442821; c=relaxed/simple;
	bh=5tryiqGWz7woo9GeAI9cW9IgeIA3mnTyekQazR6n7B4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SuY+SF0VUysyLpcmhAwsUTmqdYAbn/gHhjDBPp+osRt3KYvr034qpLePIHZzGVUok6R5nyQEiRtK/zIQCwQshNunRPEOnbyq8fWmZ7qdxGOyHyRPmAUTNxKoNFuOPCfQI4LPY5hS3zUuBd33MR5EAcNO3IIJkAa+4eivw/4kcFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=VC5X3SyU; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="VC5X3SyU"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5295e488248so4989130e87.2
        for <linux-block@vger.kernel.org>; Mon, 03 Jun 2024 12:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717442818; x=1718047618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bgq00PUjrhCM1KT9z8TW3RB/dgS4Xp/0LzoRpKh5jRs=;
        b=VC5X3SyUAX39DOqxIZieCJeam9lTh7o1tGDRr39FCQjSum+iV0kRiLYJqXbT/XadTx
         Zd4C8geUfvFnvXlVPvq51RbcxsGSgCgw66Y5MB4QdzG9y339gcj3ffadEK262Tqsz9u0
         xE9Hdf6mEAwFJDmCoSEabrpdvHy68D2E9GDv16HAIDqwss6QEFo2Fa84Q6YkfhTVBiCM
         zuc9VxnowYCjcU5h4RX8m7fJIAdq9f5k9LmqmuSJVEBm/MfOc1B2LAKeNAzG3O3GgVb8
         1o3SH6UeVfxCa2/fVPXL1QDHrPb5N+1OHdk9F7Ok/qVXmjwjBvL8mLQ1nHbyxXSZTIO7
         WlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717442818; x=1718047618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bgq00PUjrhCM1KT9z8TW3RB/dgS4Xp/0LzoRpKh5jRs=;
        b=LLlR4GGHZTVeKKdy1oebQ0i1fKBKQBKwSREcRtx9IHNlpK5P8BslrG9g2GVebmff9+
         H59y7Trt0DhyAlnjOVzpoEQe7X1JqNkg/RPStIlbCdQh/GG7J8mxacALwASnr60Dku7Z
         4CwQyyMuzk82cj47OP4MNI6fR4dUCVTOxqxaKlFPWRLul/8U0kMiS2iS+gSQR9D59InB
         n9Q9BJjxEXcZ5E43SevlPZXc048aokWKMHVIB7rXPpxb9DcK/a06cIden7Ww/nSlk0N7
         7m10KdalJKSiCfN749Y9pswHZZiXw6OTt0I3GIT7LcN+XUzo4NrxIz/ZxU53+JhND4jv
         J62A==
X-Forwarded-Encrypted: i=1; AJvYcCWvgnsZLc+digayi4TI9HHACSqew0FcugsaSi0yxhimVaf4KdEC2fdARtK/AfMIlS5vpMUA2EE93SQnN4M0BHtdcNIo6AO7bKgWsHs=
X-Gm-Message-State: AOJu0YzBciusnNm1lWxNUJlBz/y0MRz7Mb6iO/+BaBt7D2Bz7foyH5tT
	NVH7XO4p9YRnzckrL5kZ+rLKB8gq2xISml1zwTi+x835MG7sV6RtVz1kgkv895Q=
X-Google-Smtp-Source: AGHT+IEEdiuK70dIt0kRQ6ZqIyfF8/dtIItu00A5a5CGgt7ADEjKNbKwIlbZf+kUgc+loKojBUe4Pw==
X-Received: by 2002:a19:a40a:0:b0:522:3551:35f5 with SMTP id 2adb3069b0e04-52b89564058mr6258471e87.14.1717442817779;
        Mon, 03 Jun 2024 12:26:57 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6900c692b0sm235052066b.151.2024.06.03.12.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 12:26:56 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	John Garry <john.g.garry@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] null_blk: fix validation of block size
Date: Mon,  3 Jun 2024 21:26:45 +0200
Message-ID: <20240603192645.977968-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Block size should be between 512 and PAGE_SIZE and be a power of 2. The current
check does not validate this, so update the check.

Without this patch, null_blk would Oops due to a null pointer deref when
loaded with bs=1536 [1].

Link: https://lore.kernel.org/all/87wmn8mocd.fsf@metaspace.dk/

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---

Changes from v2:

 - Use blk_validate_block_size instead of open coding the check.
 - Change upper bound of chec from 4096 to PAGE_SIZE.

V1: https://lore.kernel.org/all/20240601202351.691952-1-nmi@metaspace.dk/

 drivers/block/null_blk/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index eb023d267369..967d39d191ca 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1823,8 +1823,9 @@ static int null_validate_conf(struct nullb_device *dev)
 		dev->queue_mode = NULL_Q_MQ;
 	}
 
-	dev->blocksize = round_down(dev->blocksize, 512);
-	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
+	if (blk_validate_block_size(dev->blocksize) != 0) {
+		return -EINVAL;
+	}
 
 	if (dev->use_per_node_hctx) {
 		if (dev->submit_queues != nr_online_nodes)

base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.45.1

