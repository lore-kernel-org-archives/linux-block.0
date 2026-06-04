Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D79402BB1
	for <linux-block@vger.kernel.org>; Thu,  4 Jun 2026 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570438; cv=none; b=nUs9yvuOTQ/Z/l4mCWCaoY7yTtA/ixyLo+CF7ZZbG2K4IZiDTPefUfpIx6sxrm3broLXLmHzj76dDIXO6h5ouEy7GkujVrblxvvE3r+h8kUlqVJu00HVx89fSp0orp8VLUfZ7gN+pT8NpXTN+gVfjhl3327lewy3Nc9ZC7W10+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570438; c=relaxed/simple;
	bh=Io9ITUXSj0LTQnMufvmsQ1CkkL5Mo1qd632MU+iM8n8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bp+Yi+zWsci6/dSeGZqZ4WBj/t2mFNHsWu0J9HkfrcDo99hrtPMBvWRtt2+fLnKj9k3idoboYskdf7bLYiRLlcsv3jnVfPhaJWciFrzjxdCLJfCJzKJtf07oGSLclKoWRXoSPYHinirGwVja5DUi88RohL3rkmoEbFO1KpClesk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ky1x4Zy8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ky1x4Zy8"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b613a17bso5410865e9.3
        for <linux-block@vger.kernel.org>; Thu, 04 Jun 2026 03:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780570436; x=1781175236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hv3p41LzNcNXVGo+Q2K308cugCyQNysAliX7a7EgUho=;
        b=Ky1x4Zy8/M/bCodGBFayfM1b0lVEoxJ7Uu3bGrfetz8Lwb0yJ7OrL4VDDj08uDG4Fu
         LmJdc12eArui3KbDe2fqhTD1k8DWKTX9yyOZgSGgqspfxZ1VM+uo6ogQGEEv+wXzlBAf
         l9of+VL05Y4E9KSOe2X+spYhG6b08cTb2ftZAvS06N/sAEuAUY4lGGZnzXW+vI7uYw5D
         CiI+if2HutpN6Bf+QSBcWVaoUYhdAbGL3hHhUJvz/fGhjlm3sHC+oZlHc1/Lo+mSeC04
         v8LsmIrxDEAQorNx3KYWqu2UJkqVCaYT0c1LPjQAORkZCorH8owRrmQriRSXVlIGnmR2
         lsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780570436; x=1781175236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hv3p41LzNcNXVGo+Q2K308cugCyQNysAliX7a7EgUho=;
        b=ZUf0waBRIYDoJtrCLUPKPslgets2Rz2+JIBLKnn4LDYZmU26+N3gHs/gY9Ps+FVOV+
         o+dWdcchoMGYQJeOfa7BdZV9uOWBPHNTG2HVnJSse6N6ucd5J1nNA1Ij93nBdBzYMqSz
         Mdrdwecq9PcJCf131zC8FAzAUP+dyL3zH4cXc0g2jHu5gpvaUPsoxD4MFlJPeEcgCtQe
         mpSFQtMVke1zhC9jOv0zm9E47w6WzwA8R6reC8Vf9jQfQbK4o3yiojxKCUlMkv5DoO/W
         slX/WxONwV+uGR9Z7+ZynsTHVtayzSJdp7iMz5qLr8SIA/dAMqdAWjsh/rcIrbeUsqIq
         lxYw==
X-Forwarded-Encrypted: i=1; AFNElJ/O1ljE+K3ZnsVOJ2j97sSnrlqINQ71BBDCj/UKt8Jom907lCAjdwyg6el5liUhZNNOAwslg1VxrOnm3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvI2jg+lvzmL0rXF393KgqkdXPzlcnT/ivFU28YcoDEMXZKvoG
	/msS44BJgIMjmSVJDMrbNyKB19sZrdcoyzBB+Je4ji8MhrGjiy5PUEdPoFS8n1Ofkhw=
X-Gm-Gg: Acq92OEuKmPYygynjO5/qXpM7L9TJyWGHvWA7+ryfUhDXIc5lvO06VF2NxwQgd/wieA
	TnwRP3GM834ZAfBWUStTud55ln/5pKD71fgFbpS6SoVLwxrPJGS+SFnzHQMs+sDjI3VPVu+u6Zd
	ZWe9t9XJk7Tdh0qmVe7xUP319Jpo9CfoIKNKKWRi9Jw3tUlAHGKkLahM1FcX6lCNI75dRXbnqod
	08He3UTJhJIzt3XbaCfb6oAoOn2LqaMDhq0cofaUBmTWwGuXUTzI6Ai9U4Kf0pXw4BukBm/O8MN
	zq2UI+3kahvvGybKNSqKvEkpUqmFMGwS6XOqsRfZI0Pnsju48KVzG0r6eb/bLQDh5voTg0Q3/On
	sJvfc6YeIHgOzRXr96I8gMwYzRPpdKjt8Do5BVfGJi5WK6at0EU/68I0ECc6DCe0u8Vyz85z4QM
	jhrewooliF72YUI+vWG6WEAEg3KHhbr2bs0jMNmuvtcvifFrvjhzf8iBnuiQ==
X-Received: by 2002:a05:600c:1f96:b0:490:53d3:47a9 with SMTP id 5b1f17b1804b1-490b5e7962dmr116193935e9.3.1780570435822;
        Thu, 04 Jun 2026 03:53:55 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm58181695e9.5.2026.06.04.03.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:53:55 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: Add WQ_PERCPU to alloc_workqueue users
Date: Thu,  4 Jun 2026 12:53:47 +0200
Message-ID: <20260604105347.168322-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The refactoring is going to alter the default behavior of
alloc_workqueue() to be unbound by default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU. For more details see the Link tag below.

In order to keep alloc_workqueue() behavior identical, explicitly request
WQ_PERCPU.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>

Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 block/blk-zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 6a221c180889..bea817f3de56 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1924,7 +1924,7 @@ static int disk_alloc_zone_resources(struct gendisk *disk,
 		goto free_hash;
 
 	disk->zone_wplugs_wq =
-		alloc_workqueue("%s_zwplugs", WQ_MEM_RECLAIM | WQ_HIGHPRI,
+		alloc_workqueue("%s_zwplugs", WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU,
 				pool_size, disk->disk_name);
 	if (!disk->zone_wplugs_wq)
 		goto destroy_pool;
-- 
2.54.0

