Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AD1153BE9
	for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 00:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777250121; cv=none; b=L1zGIk2EoFGwLLugJVgmyVOcZhK5omMuxxB/rSdKG5TKGopcKU9i+nfUr2aA4fBBuUUg19CtOX5QcS4BAkrDL/KqL89galsWfeyZ/1SZtuj/9KXOt8wYV5pl8MxIH3WGn/fWZ7omIOVjyMTrmkj7kuJ1thtFEWtczmCTPrX8zxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777250121; c=relaxed/simple;
	bh=qCRZIqiWXNSIX+3h/kuw6yzKVaJCunHyh9LGPehHfd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwW/pEYdMacp32g+AA2po1UNpTdCzsQiJyDxgYD/5+953FQKacMYc+ZB+3/Aoi9Kw4QqL2xP54A3cuPWARdDaaM46B1VwAfkMxg8f8MaihUwklof6pAW9uvlWXcJi5HFKJOMHJzOdfjR/3SFUfmwo9gM8oId1Rh5WqI3cK8iot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/clSY2y; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/clSY2y"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56d933b555cso3046487e0c.0
        for <linux-block@vger.kernel.org>; Sun, 26 Apr 2026 17:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777250119; x=1777854919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+zpjgxAVJgKXc24LXLllrzJ6IfhGOraTuvZ7a74jdg=;
        b=D/clSY2y/us1q+2bN/mAAn76cwIGflZeAj8P/Q8bsR5tLEAH3bb8LAGFa/ZgUhd74R
         AYa+Ch0tNQ9M04svbffeJpuBzY1quhIym56dARINVu3FPxb6V2el2oTiQpblO4fyZHbN
         n1p7B75F2vk7wJ7LSwznIGZsPrrMRVUlL5v4jCkU7zwOcDYOutvvNbbRPtt/kVL1x0be
         BrZpbPP4kerWeoyOgf0/bvyjZNWOrQebW43aKWn47pvq3LqB1yyrYsq3IVsj4AZMOhle
         Vw0dVR684FsZq4fKuq3eUexNHW+icVlQHbU4VS36nhw2Z9JOMGOBv/xCWOSPOnsWVYik
         1NdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777250119; x=1777854919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+zpjgxAVJgKXc24LXLllrzJ6IfhGOraTuvZ7a74jdg=;
        b=kSP0MFT7ma4wdAUNwoM+HbsYyeS+pJrF9GJYHqV2yF2xRyZu/g5BjPIevRathEN1tN
         8A8ueqEpE5WYedbJp51KXBYvg7GtdoMytt8WSc3rtcbqOgw63GswnGXh+KPsMnNXAusa
         kQ3ILp3QYhI+dJfWd1iBH3OQm574D6pSEGhL4+9/bzcuXHbeRhcGMXEp5m+yTpdw33T0
         eIgBSYrw7UzkXRzY9ZdH2IR5xpBnsFaI0tzUgeNVzK+Fnla1lv0IYnIUL3fx3CiPs8pD
         qQfGb+OVTWUIKuj9WxlMUColUzx8TZR/Fe+K7HGCP0coMPkBYzHlefI9TJ9k/PTTVyO+
         NC8g==
X-Gm-Message-State: AOJu0Yx+VtI9PueG1lHTPiNPBRim2I6t756ejoRvfXhhgWbPPcdq9IP6
	CEUq9eGOZE7K10mlnfN3pFQtNCeZxdqNPFcoBjHQMb8SdT4eedBfHA1C
X-Gm-Gg: AeBDievU7w9o1VyXLiBvSgcinCnvPGjciU2e1w4t2PJQBbu81dFdLMtEnyzwoSuaG5N
	r90dFwFFiRrryNiea5MEcWSiOWPKxq7uU6bpF4wMcj6GkxyY8ekU8+eLePCEDCqVSll0XLz8Rdz
	m4ihz3Aip/9ygJt8h1WOi8Lb5y2IZmw7ChDAy5dRvSq0fHPPExoGdxnXfPIGX4AtkIa1dKKBycs
	UZSAo4TC+2E1IWqjuRzkLuBGLoteZ30LiHxctFnzIuAiH1cyhbqgMll1Vo2Rs3MC9n5I+SCNOLh
	RSHuafEmHzMQFJwbeh0u8by7WR864p/ultgl+SJ33nr0yOokVJIv64VUa93xjkfwikHiFHt080k
	MTF6N/tlf2dDz99FCunxbBYZm1/kIGU415g/qJp2JF99JpPEDM+Lzq4KVjw2tUXYo+D5f7Z2Cc5
	JaXKm7r2dif1vh8/yFZSwVEHcVA7moHG4by/4gy5B0Vu8U38u+9RIq
X-Received: by 2002:a05:6122:f84:b0:56c:db8b:504e with SMTP id 71dfb90a1353d-56fa59fbc9fmr22750523e0c.13.1777250118829;
        Sun, 26 Apr 2026 17:35:18 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa9351ca8sm16854880e0c.18.2026.04.26.17.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 17:35:17 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: linux-block@vger.kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	axboe@kernel.dk,
	Chao Shi <coshi036@gmail.com>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH RFC 2/2] nvme: set integrity metadata size for EXT_LBAS non-PI namespace
Date: Sun, 26 Apr 2026 20:34:57 -0400
Message-ID: <20260427003457.1264511-2-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427003457.1264511-1-coshi036@gmail.com>
References: <20260427003457.1264511-1-coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is an alternative to patch 1/2: instead of downgrading the
assertion in nvme_setup_rw(), it addresses the root cause at the
integrity-profile level so that the assertion is never reached.

For PCIe namespaces with extended LBAs (NVME_NS_EXT_LBAS set, flbas
bit 4) but without PI and without NVME_NS_METADATA_SUPPORTED, the early-
exit branch of nvme_init_integrity() at core.c:1834 returns false
without populating bi->metadata_size.  As a result blk_get_integrity()
returns NULL (it checks q->limits.integrity.metadata_size via
blk_integrity_queue_supports_integrity()), bio_integrity_action() returns
0, bio_integrity_prep() is never called, and REQ_INTEGRITY is never set
on bios dispatched to the namespace.  Any such bio that reaches
nvme_setup_rw() triggers WARN_ON_ONCE because head->ms != 0 but
blk_integrity_rq() returns false.

Populate bi->metadata_size = head->ms in the early-exit path for the
EXT_LBAS non-PI case.  This is sufficient to make blk_get_integrity()
return non-NULL, which causes bio_integrity_action() to return non-zero,
which causes bio_integrity_prep() to run and set REQ_INTEGRITY on any
bio submitted to the namespace.  Requests that reach nvme_setup_rw()
then satisfy blk_integrity_rq() and the assertion is not reached.

blk_validate_integrity_limits() accepts this configuration: with
csum_type=BLK_INTEGRITY_CSUM_NONE, pi_tuple_size=0, and pi_offset=0,
all checks pass (pi_offset + pi_tuple_size <= metadata_size, pi_tuple_size
must be 0 for CSUM_NONE), and interval_exp is auto-filled to
ilog2(logical_block_size).  No generate/verify callbacks are configured,
so no actual integrity computation occurs; only the blk_integrity_rq()
predicate is satisfied.  Capacity is still forced to 0 by
set_capacity_and_notify(), so new bios are rejected by bio_check_eod()
before queue entry.

Tested: Compiled on linux-kcov-debug (6.19.0+, KASAN/DEBUG_LIST).
Boot-tested under FEMU with NVME_SEMANTIC_DATA_MUTATOR=1; ran 4
concurrent dd processes plus 500 rescan_controller cycles with no WARN,
BUG, or Oops.  The EXT_LBAS + ms!=0 + !PI combination was not triggered
during testing (FEMU's mutator varies flbas and lbaf[0].ms independently;
flbas=0x10 with lbaf_idx=0 was not produced in this run).  The
bi->metadata_size assignment path was not exercised in testing;
correctness of blk_validate_integrity_limits() for this configuration
was verified by code inspection.  Provided as RFC.

Found by FuzzNvme(Syzkaller with FEMU fuzzing framework).

Acked-by: Sungwoo Kim <iam@sung-woo.kim>
Acked-by: Dave Tian <daveti@purdue.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 drivers/nvme/host/core.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4e20c8f08e4..76fb788024f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1836,8 +1836,29 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 	 * insert/strip it, which is not possible for other kinds of metadata.
 	 */
 	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ||
-	    !(head->features & NVME_NS_METADATA_SUPPORTED))
-		return nvme_ns_has_pi(head);
+	    !(head->features & NVME_NS_METADATA_SUPPORTED)) {
+		bool has_pi = nvme_ns_has_pi(head);
+
+		/*
+		 * For PCIe EXT_LBAS non-PI namespaces the block layer sets
+		 * capacity to 0 (we return false) to prevent block I/O, but a
+		 * cached-rq bio may bypass bio_queue_enter freeze serialisation
+		 * and reach nvme_setup_rw() with head->ms != 0 and no
+		 * REQ_INTEGRITY set.  Populate bi->metadata_size so that
+		 * bio_integrity_action() returns non-zero and bio_integrity_prep()
+		 * sets REQ_INTEGRITY on any such bio, preventing the WARN_ON_ONCE
+		 * at nvme_setup_rw() (addressed by patch 1/2).
+		 *
+		 * NOTE: only metadata_size is populated; no csum or PI profile is
+		 * configured.  Actual data integrity for EXT_LBAS non-PI workloads
+		 * is untested; this patch is RFC for direction discussion.
+		 */
+		if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
+		    (head->features & NVME_NS_EXT_LBAS) &&
+		    head->ms && !has_pi)
+			bi->metadata_size = head->ms;
+		return has_pi;
+	}
 
 	switch (head->pi_type) {
 	case NVME_NS_DPS_PI_TYPE3:
-- 
2.43.0

