Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674036;
	b=gv2z6UKioviOzhMPaKsmbZG4wWQvMDW3t56ZgBhBlfkoJgiksVi9Na6tSMDUzKeIYjcX
	 P71tgyagkJdYL8J5naFZ26RltAyDwcjF5pGIk90czCLbCYT3RIxxMpFGQUrnFmhqz9qR7
	 9SHx1j2Coiq+1rKTKKEXdPzzk/PeK5v209j04GmfkpRvIknvuMr0mDtyvBqW/BM4xvZAT
	 vnsJ9TijURmJERzXmXuINEtYeR1z+aySnxUk+mZts/+/ZDsuO9DhqenBRRMatxLmsR7zj
	 x21340DY1vUhBMM9lz757jDQgN7Lz2C0X6vTCRfkSbbuCA5fhPNUg2yc+D6SeqYrX0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674036;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=p1kQxs3bANvsyismFuTLlcI8zV+SjZ75q5bNTjnq76M=;
	b=2yjbQaL1ObsZJFEEiegXw/cMkish/7ucJAE/ymeJpLh8lXZ1nEZgDijrCSHp77QLp9SW
	 DdXazfLs4uZkBV8yjW3EcksYxJQ9j6nO/SCRNC+X/2hEiFASoM6NeKRUgrFrADYuLwvRM
	 /ZXyZ+AnH/Ky6cyMfN+u9dKRmc/GkwLm+7nnQLSim+ZIHX7w1PhQPPNEPR6O0z2ZxDuM5
	 JRXJC1AGxjDdXTh1pnKZ2rxj7ZI185aNd3KWeMY/1umB0m41TNR7BU9LTfBgQKpp2rfAq
	 sR5dmfLSs3eHBR4tr8UNrPdLx71j5FCyARSVaaXXGPP2OvnQ0MedBnEY3MRN2IBRnug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=EEK6+clL;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB4260A260B;
	Sat, 14 Nov 2026 16:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFB4260A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=EEK6+clL
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jRfpB2hb5z8Xrr9;
	Sun, 15 Nov 2026 00:33:54 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794674034;
	bh=OsixfxYyH+pb1boFiLUyWsJVY4ci0p0pP60R3pBRhuU=;
	h=Date:From:To:Cc:Subject;
	b=EEK6+clLyRfBD2kGp2W7HupYmXZXQPIa+ECxPap+6ojJx2UyxOBsssWX5i84cp1Dk
	 KQKzwhVyJAa7gwFkf92vogHJK52lX3b/q3nplcZje+rV5munnnV3lWOkDBHWBCSu3e
	 0rxla2UeJzwEmsoWb5LNlEV6+TB78wbl8Xh035QWQzq9MLwLGFfcIMoaSJZccNvt+u
	 JGcG585gofBUbbAgLlOv/5wFTgm/1u/whN/ON/XZhnVXTyC05LUVx5vFJJ03VMrsLS
	 iW10WD4cvBUmmNHVi8GJ4+eYP7+CvZEI7X/bwWUO9NgXpjjoD/pnszXdYNQJ4VWJ6d
	 fhvhRMrsl6DeQ==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6AEGXkba085735;
	Sun, 15 Nov 2026 00:33:46 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 00:33:49 +0800 (CST)
X-Zmail-TransId: 2af96af88d6d2fb-292d2
X-Mailer: Zmail v1.0
Message-ID: <20261115003349683IFDCSTYhPzQtBozUiO8qN@zte.com.cn>
Date: Sun, 15 Nov 2026 00:33:49 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIXSB1YmxrOiB2YWxpZGF0ZSBhbGwgcGFyYW1ldGVycyBmb3Igem9uZWQgZGV2aWNlcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AEGXkba085735
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 15 Nov 2026 00:33:54 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF88D72.000/4jRfpB2hb5z8Xrr9

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ublk_validate_params() returns as soon as zoned parameters are valid,
skipping the subsequent DMA alignment, segment and integrity checks.
SET_PARAMS therefore accepts combinations that it rejects for a
non-zoned device, including integrity parameters without UBLK_F_INTEGRITY.
Invalid parameters may reach disk creation or advertise an integrity
format that the server cannot access.

Continue checking the remaining parameter types after successful zoned
validation. Preserve the zoned validator's errors and the requirement
for zoned devices to supply zoned parameters.

Fixes: e84025d2a9cb ("ublk: add DMA alignment limit")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on next-20261105 in an x86_64 QEMU/KVM guest (4 vCPUs, 4 GiB,
4 KiB pages), with CONFIG_BLK_DEV_UBLK, CONFIG_BLK_DEV_ZONED and
CONFIG_BLK_DEV_INTEGRITY enabled. The same userspace program submits
ADD_DEV, SET_PARAMS and DEL_DEV through io_uring to both kernels.

Independently invalid DMA alignment, segment boundary and integrity
parameters without UBLK_F_INTEGRITY are accepted by the original kernel
and rejected with -EINVAL by the fix. The integrity test uses valid DMA
and segment parameters; enabling UBLK_F_INTEGRITY makes the same parameters
valid on both kernels. Valid optional parameters are also accepted by
both. All five checks pass on three independent boots per kernel.

Separate userspace function tests cover 4 KiB and 64 KiB page-size
boundaries. The QEMU tests exercise SET_PARAMS only, without START_DEV
or block I/O.

 drivers/block/ublk_drv.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3d322fa1bc83160f51fbd97fb89b17ee94bc1213..ce1c192e3590cb8ddfeb495629540a653658513a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1011,10 +1011,14 @@ static int ublk_validate_params(const struct ublk_device *ub)
 	if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
 		return -EINVAL;
 
-	if (ub->params.types & UBLK_PARAM_TYPE_ZONED)
-		return ublk_dev_param_zoned_validate(ub);
-	else if (ublk_dev_is_zoned(ub))
+	if (ub->params.types & UBLK_PARAM_TYPE_ZONED) {
+		int ret = ublk_dev_param_zoned_validate(ub);
+
+		if (ret)
+			return ret;
+	} else if (ublk_dev_is_zoned(ub)) {
 		return -EINVAL;
+	}
 
 	if (ub->params.types & UBLK_PARAM_TYPE_DMA_ALIGN) {
 		const struct ublk_param_dma_align *p = &ub->params.dma;
-- 
2.43.0
