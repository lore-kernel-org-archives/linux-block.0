Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270401E4AF
	for <linux-block@vger.kernel.org>; Sun,  3 May 2026 00:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767461; cv=none; b=TS0I6QGuS4WPFXMYrNLmhcVftUxgCXoFYznD8KcxOkN7DqDdM2FrErrm9X4BGnYRAD8v1Bs4lDD43zHC/PUcl5v/QQMRvWbNDPOs0UrwI8aHeGyuvGGfcul1byk7Eb2LXljHKrMlCBbpxOVCtUQWqQBSQSyNNxjx9PhtJiC6PDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767461; c=relaxed/simple;
	bh=1eDVujvedOmU6wVjW9gvYBqOF1iWnmP9s/zew37diJU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GV92zq/7X3Lob7HVmmSdaoqnKZ8u83KeWhBO9GXd6qBIeKK6Ix7WkMQmkhZkm7yfw1DWc2/tvawAncVPD6oGU0uqgBU/oudX0UvU4WbQaKg/iI31WL8LSWQITxJuQYshkIx8Pkmu+mhepOV51n9KGkYOLRX6F7P3JYwqGafv6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UVhz4tmS; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UVhz4tmS"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12e683ca86bso2933583c88.1
        for <linux-block@vger.kernel.org>; Sat, 02 May 2026 17:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767458; x=1778372258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dk2xk2A0NiqA7ayNXkXUbXMOSECieHzDuDpYWSAHMHE=;
        b=UVhz4tmS0moxZHE0v6Br6YpQBVDomvktfOhuMXpBc9e0tAFNTkFa+eq/vKJpbI5Yje
         Mx0l8eCD+R/ZzNTKh8xOFueJGVQ6FB0GOLgWSF3Mt1kgqUcQif8rf0ZrXId/uZMycqvv
         yzAOMUlvyNDJlqwfh6Lu5Fe/iMoBhjMopc2mrZs5b3Kwd8fX9B1Es9ZjafS4TP2MIFOd
         nKdGEq9IYxtdh4HwG+NY92DN17+FO1dozEviYnNouF3qmpm3IuGZz20YeCOQwdeQucWy
         83JI3/xOVUInRA8UdS8Uq1wCpnOFhdURIPIZ3k2ULFJcE9M22qOASoaPNxIOvE8vECN0
         0WuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767458; x=1778372258;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dk2xk2A0NiqA7ayNXkXUbXMOSECieHzDuDpYWSAHMHE=;
        b=awoASnObB5MfgNtCVEbUbheVrzNH3V1942JEk+bVQIjZnEuZaTmBbRffluUT1HqYDx
         Ljdh3QG9rT9YH9Rp/myIeI7brsFfSuvrA+z85FftTVRF4je4u9FWlcttpLAHZNlaYTan
         XF8d789CX3qrTt4036ZxhpN9MIpH4m/rv2fmTuJFWrGLasHERSqBSFz4CDlhirTiIT1H
         p+joOZAky3AeqKKhKQ481QIWuNNLY7m+C3diM+49KEA2gzYV8aTF0aQpfgzxo0bKrpNa
         ipnvzwDZV1F0Y4cgR4R/WvjMkmHWvb8D24iLJf9tiGUhnA0ApvTh47coHyum6peY+v7y
         Be5A==
X-Forwarded-Encrypted: i=1; AFNElJ+/tcCC3ImKT+WKnqUeMWccd+bZVAfeVgQd9kKLi/9JFsWUQpkaOCnyf2R4OEfY1ZCyCvKNBh1d90AdxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrvcxsb4gUGQdJWzcnA37ScecPtZHj0pEBD0fx5yH/J03hI2/Q
	dX8W53tH5hNMIq4edP1mOvvmbFHDCadVuUo7hXykCp23GtLlipDns/TaCdZuJ3fM19WwvxP5p++
	8EK9j5AQ9hZ71Mg==
X-Received: from dlag5.prod.google.com ([2002:a05:701b:2505:b0:12d:dbf8:a2a8])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:f9c:b0:12d:de3e:86aa with SMTP id a92af1059eb24-12dfd86e4c4mr2227104c88.40.1777767457805;
 Sat, 02 May 2026 17:17:37 -0700 (PDT)
Date: Sun,  3 May 2026 00:17:33 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503001734.858296-1-cmllamas@google.com>
Subject: [PATCH] block: restore mempool reserves for non-block
From: Carlos Llamas <cmllamas@google.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Commit b520c4eef83d ("block: split bio_alloc_bioset more clearly into a
fast and slowpath") prevents non-blocking allocations from falling back
to mempool_alloc() after the initial slab allocation has failed. This
was based on the assumption that mempool_alloc() would simply retry the
slab and fail again (for non-block).

However, mempool_alloc() also attempts to dip into the pool reserves,
even for non-blocking requests, and this option is no longer available
after adding the early fail. This was noticed through the SCSI generic
module which calls blk_rq_map_user_io() with GFP_ATOMIC.

Remove the check to allow mempool reserves to be used for non-blocking
requests, restoring the previous behavior.

Fixes: b520c4eef83d ("block: split bio_alloc_bioset more clearly into a fast and slowpath")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 block/bio.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b8972dba68a0..e8f4934593b3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -576,13 +576,6 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 	}
 
 	if (unlikely(!bio)) {
-		/*
-		 * Give up if we are not allow to sleep as non-blocking mempool
-		 * allocations just go back to the slab allocation.
-		 */
-		if (!(saved_gfp & __GFP_DIRECT_RECLAIM))
-			return NULL;
-
 		punt_bios_to_rescuer(bs);
 
 		/*
-- 
2.54.0.545.g6539524ca2-goog

