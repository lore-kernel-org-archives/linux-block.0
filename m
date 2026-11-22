Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795360910;
	b=G5mkMuIcLk5FHmR+YlWe4JBX/oAMjK6AEZ8cz+Z8U4cPZIZ3JZTHXlXskFxRxxVnUBrZ
	 7dST+pEiA94o5h+H4HNZeq+75nQrxp73u5qfPLzer3SgGLFALJLAc7x5smM6aopNlkpeh
	 s/znku9f0iOaLR5vpqvO7f3lPleGEhw5eNMIyhiJTCpZAShJGwzVmoduogIgePqQQLEul
	 lGEmIgjC/ow21n0ugQ0c5hEYuPVizMoyTb0VUOuKA+a+LfCK0l6UDSo7iLqlrZ4qiCzYb
	 /4gBk8O3TqiRaQMHYyTqD1zTy7krH8YphSpt4zy2y4WowuYBGSAN5XasiXMaR0qi+RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795360910;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=F+I6BMzskhaBkNn131+nOHuhnEqj2ntJ9K1Ch7/kHzU=;
	b=EwK60dvc6RTRPwfXJZc9hogzmaybrX+WRcitWIocGWrLXzGnZNz/aG4MxDsiOBRXuCMW
	 /p/12sencrHo+0g4fl8Qrc8w+j2VfjyUfo5w7b3jpC2frNDKlqCBDJ92XcbSLTJtdAyLX
	 8Evw6sRZMCzmG6j7a6MZs7k98cxnjQlYFlbufaSvTgH9ckV+y0tn8D+tGsF0SWXVfzSKV
	 fdNT2PuRehRj4Sd4RnsyXneZDwDz/CnthCx15QDa/C8MxN3YqPCU/RIFqZVaoYZovKxwk
	 LnKd+JJt2rqmF9DWG1NMXJpBjvv6GWOZpPmrc0oJtbgl875KRMQwSDfcmuuKJDOjCDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=z5kVN5tb;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77448606A320
	for <linux-block@vger.kernel.org>; Sun, 22 Nov 2026 15:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77448606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=z5kVN5tb
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jXXqF0RDqz5BNRx;
	Sun, 22 Nov 2026 23:21:45 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1795360905;
	bh=7TVER/Dsyuz1t+0sSmrqKzeyTx07d/XDv9Jwk3uQt1Q=;
	h=Date:From:To:Cc:Subject;
	b=z5kVN5tbiQuwl/m+FEIyZNslBfQoMe+/nMbt3HDTvXBZqugg0z3FthqikTsERvBX/
	 hhgSwCnfoSlnyNMk52MkNIxkssTq2N97KQQPB9k85OCcwl3IF6vBgOP6GgKpa04ji4
	 yG/VTrntf+Rr+iqJKPYCgoMwWXbfASwVIf77IUvxQjF0lwOxT9b5YPxz4DrwSMdxM9
	 +TGzTLx4sacXUEcfY/1xDtayEHl6R/aB5fnVoY29MlaipYigDKvSi0F4TUmfBHDLGI
	 5o4fFX2+xdIN0DN/cbWC/dCWJ+pM3YEvy0Iv5qC1u6OjI8qC+y8fwtnb7iHjDK7+NN
	 yGFNJ/Na86isw==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6AMFLc6f037907;
	Sun, 22 Nov 2026 23:21:38 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 22 Nov 2026 23:21:40 +0800 (CST)
X-Zmail-TransId: 2afc6b030884cf8-6b891
X-Mailer: Zmail v1.0
Message-ID: <202611222321403031Pk7f3Tfpgbp9XT5FmLgI@zte.com.cn>
Date: Sun, 22 Nov 2026 23:21:40 +0800 (CST)
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
To: <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBicmQ6IHNraXAgdW5hbGxvY2F0ZWQgcGFnZXMgZHVyaW5nIGRpc2NhcmQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AMFLc6f037907
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 22 Nov 2026 23:21:45 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B030889.000/4jXXqF0RDqz5BNRx

From: Shao Mingyin <shao.mingyin@zte.com.cn>

brd_do_discard() calls __xa_erase() for every page index in the
discard range while holding the XArray lock. Large discards on mostly
unwritten RAM disks therefore spend most of their time looking up
indices that have no backing pages.

Walk the populated entries with xas_for_each() and erase them with
xas_store(). Keep the existing range rounding, capacity limit, page
reference handling and allocated-page accounting.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested in a QEMU/KVM guest with 4 KiB pages: BLKDISCARD over a 16 GiB
range containing 64 pages took a median of 61.4 ms before and 9.16 us
after; a fully populated 128 MiB range went from 2.28 ms to 1.80 ms.
Each median uses 63 calls measured over three boots, with data
population and readback outside the timed interval.

 drivers/block/brd.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 00cc8122068f..11fa833a3f1b 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -182,21 +182,22 @@ static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
 	sector_t aligned_sector = round_up(sector, PAGE_SECTORS);
 	sector_t aligned_end = round_down(
 			sector + (size >> SECTOR_SHIFT), PAGE_SECTORS);
+	XA_STATE(xas, &brd->brd_pages, aligned_sector >> PAGE_SECTORS_SHIFT);
+	unsigned long last_index;
 	struct page *page;
 
+	aligned_end = min_t(sector_t, aligned_end, rd_size * 2);
 	if (aligned_end <= aligned_sector)
 		return;
 
-	xa_lock(&brd->brd_pages);
-	while (aligned_sector < aligned_end && aligned_sector < rd_size * 2) {
-		page = __xa_erase(&brd->brd_pages, aligned_sector >> PAGE_SECTORS_SHIFT);
-		if (page) {
-			put_page(page);
-			brd->brd_nr_pages--;
-		}
-		aligned_sector += PAGE_SECTORS;
+	last_index = (aligned_end - 1) >> PAGE_SECTORS_SHIFT;
+	xas_lock(&xas);
+	xas_for_each(&xas, page, last_index) {
+		xas_store(&xas, NULL);
+		put_page(page);
+		brd->brd_nr_pages--;
 	}
-	xa_unlock(&brd->brd_pages);
+	xas_unlock(&xas);
 }
 
 static void brd_submit_bio(struct bio *bio)

base-commit: d09b6d9d1fcce0770c1824c8b2b8ab153f2672d2
-- 
2.27.0
