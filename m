Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366902;
	b=W/s8K2uW8oxAYMiiMhtFJq4OxiM0LFj8/I1hbt/8eMLT1nuLCTBl8u9oHdYs4ALuEoWl
	 s3EW4ER89iyG+xJQRdHo6opt06bEpPjJmxSf4jva7b+C9xYI8u0dvfHV3eVaQ3kyif9sj
	 +JyyKAdJ501UQkiyOmVCVjFspaUnDEc0uGrjKS0eIqZ/jT/Q64YvLZYYCx68yRbAOkhiL
	 TMXifIRR6EStCG3OeLc1uYAJV/wTlStjghR0eU6vufZkGsMJMU7yjDr++X5KNToye4cuc
	 uXN2x+sXBtWdEqXsxBzxpGhDpVAbxScP/D1hbWJi3JoBgB8hjrA/IVrB1CRaFtZqsvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366902;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=vSUHmE4vytXRZsVTE0GVn4B6yi9H36WZeuZp8buKn00=;
	b=JRz0aZ8LnHSWWcVLDrbzatWCz6pylv8mougLaAh9+sxvbmL70OnC1YFGpFh7T5zgJ52c
	 DbPbaH7wyzjr/Ze309vF3SlX4morql1hZrug09Fmv4kpWo9lsDyURNLqa8vGSPWYw2dxk
	 tO+CdiqyBx7zE5UKEJPT4rCQd4E1f8kjhK2ujCTBy2Xw5meql00DkGZkboO3Vmj+4OnGc
	 K6a2o1AQ/CRAAlVJaKr2YEob8STnGebqq8dkMPv4sSrTRVQMsl3f8Cc3AFlMGiT+2c+hV
	 QT58b71YeJ2+q+XKxXUkHAMTMOxZtVLi6csPJkFMTTBiaDKqesG0WM1Pam9e178BT6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=TdnfqtEv;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4054C606A31C;
	Wed, 11 Nov 2026 03:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4054C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=TdnfqtEv
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jPTCk4KZxz5BNRx;
	Wed, 11 Nov 2026 11:14:58 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794366898;
	bh=u1vkrHhsgfeiJpzw0tLA8Qp7ipFlGUM9uSXBo2WgUsE=;
	h=Date:From:To:Cc:Subject;
	b=TdnfqtEveey6qysOjcHuOxZha8th1RHtykzw2EGqkwurEudmkA937oum/D8qPTimK
	 F6jqaGIMUZVoeNA+plr5D1Nwkm4gwAXx2Cu8LVFdo3CV/uX5kQRYLma20towfiAy1z
	 pZWdBICg+70brliY20vxTNvZQOVf0xygYXp3RbvBX+hJCfnJZPWUPBBFaJIb7HVF4u
	 ZVn0f8nOjwdBKi2uZVoG0KT64L/KnPU9Vt7l+cBQNHsYSuxChloLSfbxK01bCu1P/h
	 LVtwMqTApK6gvu2FXVhSB3DwQpWCGHU3i2voF7K8VAULMb5c10C7Csuc8M8ajl/A67
	 uwBdEMsZ7lCrw==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6AB3Es4t021158;
	Wed, 11 Nov 2026 11:14:54 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 11:14:55 +0800 (CST)
X-Zmail-TransId: 2afc6af3ddafe12-55106
X-Mailer: Zmail v1.0
Message-ID: <20261111111455541qAdd9RB0rUfpsuO-qYSne@zte.com.cn>
Date: Wed, 11 Nov 2026 11:14:55 +0800 (CST)
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
To: <tom.leiming@gmail.com>, <linux-block@vger.kernel.org>
Cc: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyXSB1YmxrOiBzdG9wIHJlcG9ydGluZyB6b25lcyBvbiBhbiBlbXB0eSByZXNwb25zZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AB3Es4t021158
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 11 Nov 2026 11:14:58 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF3DDB2.000/4jPTCk4KZxz5BNRx

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ublk_report_zones() treats a zero-length zone as the end of the current
server response and keeps asking for the remaining zones from the sector
after the last reported one.  A response that carries no zone at all
therefore advances neither done_zones nor sector, and the driver issues
REPORT ZONES requests for the same sector forever.  Both BLKREPORTZONE
and the zone revalidation done when the device starts hang, and the task
cannot be killed.

Only a response with no zone cannot make progress.  Terminate the whole
report in that case, and keep following up on a short but non-empty
response as before, which is what sd_zbc and virtio_blk do.

Fixes: 29802d7ca33b ("ublk: enable zoned storage support")
Suggested-by: Ming Lei <tom.leiming@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
v2:
- Stop only when a response carries no zone at all, so that a short but
  non-empty response is still followed up from the advanced sector.
  The v1 form ended the whole report at the first zero-length zone and
  truncated such reports (reported by Ming Lei).
v1: https://lore.kernel.org/all/20261109225110056QQJAEflTHzwYHzwXlMBb_@zte.com.cn/

 drivers/block/ublk_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -661,6 +661,7 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 		struct request *req;
 		struct ublk_zoned_report_desc desc;
 		blk_status_t status;
+		unsigned int i;
 
 		memset(buffer, 0, buffer_length);
 
@@ -689,7 +690,7 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 		if (ret)
 			goto out;
 
-		for (unsigned int i = 0; i < zones_in_request; i++) {
+		for (i = 0; i < zones_in_request; i++) {
 			struct blk_zone *zone = buffer + i;
 
 			/* A zero length zone means no more zones in this response */
@@ -704,6 +705,10 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 			sector += zone_size_sectors;
 
 		}
+
+		/* An empty response cannot make progress, stop asking. */
+		if (!i)
+			break;
 	}
 
 	ret = done_zones;
-- 
2.27.0
