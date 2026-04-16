Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com [74.125.82.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D561ACED5
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776298971; cv=none; b=E8wcZBqmsJ/rRLIogLCRLq/G0Th/Un/f8dFwoR8HfElfTsJSrXiBHV1LJkL4qcIj6gUhg5D41XqAu0n904TuglPqTX+ImQmJtks91SaYOyNWneKudL9N6H1h5kxYQhz8rVuDrmMftad3oMCUGtrkH1TaHPZw7T/pO2cK+bW30hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776298971; c=relaxed/simple;
	bh=D1sF5rCpyJ8v1Q/Gw4hLl9PjXnZwN2O7sQ73iHxyGO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3xO2yergKKEkwApChX0SFQjFhMn9rmdBAOy16hA6fjzLtf7LuWiXHgdYNgsc119X5IM93vDeSqKbiVTu0YTgiUuuYniJ7uYMAKZ7o12ZOdpgz13icg8s88JGjWq7FBC1EsLDzNP+MA6txFig9KvTmHhDLkI7/XHDW+epZfvt2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Z4gt3sjs; arc=none smtp.client-ip=74.125.82.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Z4gt3sjs"
Received: by mail-dy1-f228.google.com with SMTP id 5a478bee46e88-2bd5658b901so367336eec.3
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 17:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776298968; x=1776903768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePLDDsMaoT6WX22t4kx7uDAhAvj4BaoTe7M9oy5w3tM=;
        b=Z4gt3sjs7HJOg5E1Rhbzz43BV0kwY8dMsAmzdD/tuifVtfLydTShtX2/qQmkGD3T30
         9Nnejmw1T9pK1E5ePw9Cj15I1zEzIiHzYpKTzMII6xi5ndDVrX/DruADAvAizl+iWQaQ
         ciaZEKelqJn9pWp3JyMSyDQvBAC18BdebOUSEB1ULtYpfJcXVxxvnxtEUWoLEjmYOpbR
         L0WDu0VGPzQp3zVukilu42+UvgbPmy2qu7pverMeEWb3Cz7zvxGrhuYoesL8TltK6EjF
         yWcHkQLPInhgMqX9I3o5OGltw2TWgrzLOv+7RUcZufkaVJxHoxpzg6FeQiJJnSBEJOfb
         DwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776298968; x=1776903768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ePLDDsMaoT6WX22t4kx7uDAhAvj4BaoTe7M9oy5w3tM=;
        b=QOqXnuw5FoqGQrWkRB8yVzF++5OtUrrzJylAD60FPT8e3JIXdbXrqujnBOny9NeTRn
         yB5Gx1tWtGnwrycljOuXHJN18OcZE/v05N5U0RDPI6zPDHVTw6JxQoVbWWMnTcRd2JuM
         LtOydUktOI+I8iRy1MdpekTBdrks8t52m+B/esi4MIYmq/He2IDuMZ9Bh5scl7M6FHtx
         d62pudMWqmhUy3BQofFntkIi5LleAayXDgMC5f7u5XBoJBngaDpGcr540YwfJzsCOcKX
         A3Ud/k0wGgt3d81SOGZOabCBT3yv+7imxQkvtMdkRAD1Grw4yvNGdc1eDiXNuP6qakBw
         eXlw==
X-Forwarded-Encrypted: i=1; AFNElJ+PTlJ4QGom7gj7n9HHEw5ArxCLkCPRI5WAEEF5SZ8PwOFHxFwgcHeoOqV8Bfzay/IPSAGyFgjUQHwt7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCgbB3Ul0bsiQKioph3kzCN2KZA9mpczqp8ETTce9ZMZ2wy3vP
	H2L/JoKCK3QEKZjN9v0oAJC+zPWrshwIBH9b4FOVUXzNyp0GxEJZQ947g7JLnB4mw6qJo6itqo3
	B7ZsJR6DOyq3UXYQHZ8/yiwFmOzi6tZh8xKGta0eLN5vACWPxMTnt
X-Gm-Gg: AeBDievP5encbFtvVBvdSpEaPPMzOfyX8roR7zFY2YZlbqMHD6m6mZM6fCuTuqLofn5
	XjwnKXEUXMPTwmtCxEN03D7RIN6aIu3HxK7ZcyhdardefurkJemtZCa53vuv1inWcRu70Hu/Rcg
	ScrPFWqR+3SsLISCBWP+9mCCc+bzLjscOBZVRYh6BfexUK5sWvqsr4pNVPPO9FzPdhvYV8ZIyM7
	lJrKSErei7cXfX0n0oskptzp9YaK72QdTBjbuc1fo7xtJVTj6ggBMOjz+T5j6mWcERF0PHZVDX0
	Ehobxm+cE+cER5OAw5EOUwAurNi4cm2tfyghSILTTGkQhKI2itruTuSWbhMTN0z/oXi2kkzwNoh
	29iCEcQqcVGAwaiH+CK2bTEsZSQ4d7roxYT7Q55xJ8n1GZYFywQ==
X-Received: by 2002:a05:7300:ac81:b0:2d5:9438:2a02 with SMTP id 5a478bee46e88-2e17d815b51mr60486eec.1.1776298968089;
        Wed, 15 Apr 2026 17:22:48 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2de8ea899b9sm240344eec.18.2026.04.15.17.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 17:22:48 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 49AC33405AE;
	Wed, 15 Apr 2026 18:22:47 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3F4A0E41B93; Wed, 15 Apr 2026 18:22:47 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 5/6] t10-pi: use bio_integrity_intervals() helper
Date: Wed, 15 Apr 2026 18:22:13 -0600
Message-ID: <20260416002214.2048150-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260416002214.2048150-1-csander@purestorage.com>
References: <20260416002214.2048150-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use bio_integrity_intervals() to convert blk_rq_pos(rq) to integrity
intervals to reduce code duplication.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/t10-pi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index e58d5eb6cefb..787950dec50a 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -541,11 +541,11 @@ static void __blk_reftag_remap(struct bio *bio, struct blk_integrity *bi,
 
 static void blk_integrity_remap(struct request *rq, unsigned int nr_bytes,
 				bool prep)
 {
 	struct blk_integrity *bi = &rq->q->limits.integrity;
-	u64 ref = blk_rq_pos(rq) >> (bi->interval_exp - SECTOR_SHIFT);
+	u64 ref = bio_integrity_intervals(bi, blk_rq_pos(rq));
 	unsigned intervals = nr_bytes >> bi->interval_exp;
 	struct bio *bio;
 
 	if (!(bi->flags & BLK_INTEGRITY_REF_TAG))
 		return;
-- 
2.45.2

