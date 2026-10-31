Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793456273;
	b=NIDTlWZkpmm/TpGTUWjn8cyIHyLOnz+yG3lsxjSdc796YAPf5l0DHCD6KAJ9s8K6C2oW
	 bSQB0++YeJ+fCpmnK3onsVm2Xrg28Mzo1HOsr5OCGza7VyWQb0YNN/xrWCKhhKCw4eqiK
	 As17W3bgWt+vcqjgYZdhamkGhzuu/9xarYHRuT3D7dXjujtEf9XPudDRthdXmm8+IFKve
	 jWakpIbtsxsLssi44Lg91GxtLYb/kz58NFMOp6q1sJ7gQiQTrzdfZoHO+NO/kq32zKQab
	 v0smBMvnbRY2aeQZ+8O6N5f0oyHHXioOVVzMWZzQTCFB2nx2Qr4cDLqL5xGWMZ3jWvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793456273;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=FrmqSblbH1f+almrQ6tAcUEfONgXREHACmYUQ78K7lc=;
	b=24QcBTMlrTX687JH9LHshHrltOnu5X6mGsuwdEW8MfrFy+mhO/huiT57StOZn1gQyDhm
	 IYK1xJgs4QKLUwsLi03cJCblDivLrSCHRLXRLvbAEPMKrgb3W4VwUpe96Hdoys3T1Wb38
	 w2g8k7VYkS6iN45ISVO8fGsAHSrzJLKSN0ejr6dInJ0p49aAIEe4kdAGIsy+PTsW/ppJd
	 29U6epkbgmTnzmky/SQUClKXhegDFZcM1fAUr80Pb7x5r639soW1h53yN9kri7Vlw0ZhI
	 52GEafPBvZWhrIOmHoE5hFMTnqFISSM7o+8dKRjitXXnlbGkpu18+05H++508zNt9Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D365E606A31A;
	Sat, 31 Oct 2026 14:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D365E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jH0RR37PWz5B1C6;
	Sat, 31 Oct 2026 22:17:39 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 69VEHYSB047536;
	Sat, 31 Oct 2026 22:17:34 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 31 Oct 2026 22:17:37 +0800 (CST)
X-Zmail-TransId: 2afa6ae5f88176c-0516d
X-Mailer: Zmail v1.0
Message-ID: <20261031221737569WQ3bg8y80Ht7JdTCWwlkL@zte.com.cn>
Date: Sat, 31 Oct 2026 22:17:37 +0800 (CST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>, <hch@lst.de>, <linux-block@vger.kernel.org>
Cc: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB6bG9vcDogZml4IHRoZSBlcnJvciBjb2RlIGluIHRoZSBibGtfbXFfYWxsb2NfZGlzayBtZXNzYWdl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 69VEHYSB047536
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 31 Oct 2026 22:17:39 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE5F883.000/4jH0RR37PWz5B1C6

From: Shao Mingyin <shao.mingyin@zte.com.cn>

When blk_mq_alloc_disk() fails, "ret" still holds the zero returned by the
preceding blk_mq_alloc_tag_set() call, so the error message always reports
"err=0".  Save PTR_ERR(zlo->disk) in "ret" before printing it, like the
blk_mq_alloc_tag_set() and add_disk() failure paths do.

Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 9145e0f98d56..b7cfd5a39f16 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -1343,8 +1343,8 @@ static int zloop_ctl_add(struct zloop_options *opts)

 	zlo->disk = blk_mq_alloc_disk(&zlo->tag_set, &lim, zlo);
 	if (IS_ERR(zlo->disk)) {
-		pr_err("blk_mq_alloc_disk failed (err=%d)\n", ret);
 		ret = PTR_ERR(zlo->disk);
+		pr_err("blk_mq_alloc_disk failed (err=%d)\n", ret);
 		goto out_cleanup_tags;
 	}
 	zlo->disk->flags = GENHD_FL_NO_PART;
