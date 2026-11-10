Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.207.19.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291557;
	b=2to5DQAxdG16s3/yg+W1fLI+jZEqTkmkyDeuMSG/40wNzXINuToYWnrxgTb4SYMA9CeV
	 7RjSm/pGycOF2JiVqp+QRXVNcFFUOGD61fwN7M/roPI7yFvUnIsKh8iWPepSizcCcrdzY
	 3SF7lgT0TmfoLn8xGxOwdzIRnGo51w1tH1ks2TLneOpNmZ5yHnibllzZv9JkQHbnZjnRG
	 UWerB/iqrgFtdHuVJefvkYWNh7mgHDW6xcH7IJ5K532WuWkHNc/Q2SNI39ZbKQb/mXQCk
	 W7K4LdnURtlkNxeRplboMGE+x7U7Avqi/TShr+IgMV7LMdWWGP6eQ8pSqcNC9oElXZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291557;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=9q94mvokRieXKGnBs5b3tHNUDFssGR+0bJKc/5ZbmjQ=;
	b=0Ik/gziF1Widly8clJzmNJ2M69sslmJIYrY2zGehAsYe89UGpz34Zeqcsu2O50rXIHbN
	 O/FPQLBX8OyPl7ehU17zMahliRSVpPwn0N+Yanb9Q6e/C26lA2a511fbCDly5/X2rKAi/
	 yaAPBRnwh1+8asIQvruQOxjrknJUA1TxtFu4yhQQ+otlk2y6LvIuLsQdAl3zIM+UVVZiD
	 FSNYa98intopVqPoTNFCClMc2Tk8sjzoBgEb8OAXcFHUIkm02xMQHPrnm9uJax5wPoxsj
	 S3osYYmPxZEus0IpHw2+aVR+a+J0bH5fNJ3Fy6eUpnobQVwq5ftzTXMIMGcCYEtO8NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b="F//K2VJF";
	arc=none smtp.remote-ip=54.207.19.206
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A819606A31C;
	Tue, 10 Nov 2026 06:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A819606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=F//K2VJF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794291518;
	bh=9q94mvokRieXKGnBs5b3tHNUDFssGR+0bJKc/5ZbmjQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=F//K2VJFUm9rWsrH7Ksi5mVAccXUYfI69FjrvwlQHa7Py7Y4BgVLBPMX5ppSgca51
	 baYZ5DW5T84IRCZ+CeoxF+eZBcmHyRhfDKslCfuvqnHyJi/Mpd1cN/iX++xKQ8jg0S
	 z3lc90vlkRUApohCeuayW+VwV9EBUUUc7nMb92y0=
X-QQ-mid: esmtpgz12t1794291513tf0e25603
X-QQ-Originating-IP: 07VSOn+NQ9s9MIkOvzvN6mHo447AMd8/90EHHXccR+o=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Nov 2026 14:18:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10405181404545203304
EX-QQ-RecipientCnt: 6
From: raoxu <raoxu@uniontech.com>
To: minchan@kernel.org
Cc: senozhatsky@chromium.org,
	axboe@kernel.dk,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	raoxu@uniontech.com
Subject: [PATCH] zram: Avoid duplicate slots in batched writeback
Date: Tue, 10 Nov 2026 14:18:30 +0800
Message-ID: <F24EF6333964B482+20261110061830.272091-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OTFxv0hUyOzL3HZrZ3lvIrpTptYJIhyFo+tUNN8fHnBytFZkmKbAqhDi
	A5Myvr6CBE4l17QBj9DC0xkDUBnp2lXjT0FbJDXHDdhW4kOdpFkQ5G8FUNCvX3Qf7/zOXoa
	XI5++ZApWRM0tgc9LH33gWPM3ARdMfRVUH27FBNgFU50arrKGpbNsfygso+qDDb5soWVPUO
	JrUo3BOM7ZBkA8tFuI5+dvtPAtX1Dxbxju2rl72M6IcWka9F0innUflPBn6HhJszSYD21xJ
	CYHW5mdD8Gy/LHnIrs32q5pjmgyy1ouus8CfZG29HBzvu2gnSc4+JjkWfPG0n91EPCNYco/
	rdyFC7GqFWDkzyPWdNIPktyCm4pifw1AO3ef1BAzsrh6Ls77Qwyizr2Qgp/Awey4Ikb1v6G
	aixcffqAi/U39Ec1/uy0ZapZriV0TXTWF5wTBvoSa9LgB//wyRPH9dBq705RP45pa6QzeVe
	3dmTCjSkuJZHte3A7nSPfzKQhHlVj7tNYye/Kq1PuAmP/CscoeLhdNt/XSjKQjdM48HxpQf
	Ct52bN67Ys/X12gEHLD3W+oTokiaoPyt3CDfUHjjVtdlPfXxzdOei3IRwWowM5BksG2PVJZ
	G5SlFCwYhO25yrmSxK5W3FUW+snET8E8whg4xnK6FKliU3T2EBIOhko3+ycsCuX/54BCqKv
	DWmAbYuFsjVqUFmPhserZ3j+HWthyE5XObQyzH0RJjYFyu2+sERWeQMUEMapcF+I9NckP/U
	7k6zzANEidev8zsPMCXEXlm5iwiAPYfUuKVAf4X2oLwNTBSozcyp1NjBh5aQ1BNzWYiqXVF
	EijlwM7PGpw9eS/4USLEXuW4TovrkwFxnkneXjFIhlZae9fpjA8gxF5eE2SlRKzRpEyrS3f
	CfK+gT2Rg1tpBGq2/jiPBOtO7pc1zAqqZBByuiO9zWUMWndyG6LOYs40e0n9Xhit9UID7oH
	AIo690TL3UDWK739NsbIbGpWv3KkOoQKIB7MF9LwGZOVaT0feH2foajkiFF8UYrEGTshJsD
	L/hXKl1JrRNcfzpq9C8ZK2zqEyEt06AtLFKOKMh26Fn9zpn18NSp/po68b8r8=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

The writeback interface accepts multiple page_index and page_indexes
parameters in one operation. Their ranges can overlap, but
scan_slots_for_writeback() only excludes slots that are already being
written back or marked as same-filled.

A slot selected by an earlier range is placed on the post-processing list
and marked with ZRAM_PP_SLOT. Without checking that flag, an overlapping
range can enqueue the same slot again and submit it for writeback more
than once.

Skip slots already marked ZRAM_PP_SLOT while holding the slot lock. This
keeps each slot in a writeback scan session represented by at most one
post-processing entry and leaves the existing release and reuse paths
unchanged.

Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/block/zram/zram_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ab064c84b092..50a25989a23b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1215,6 +1215,9 @@ static void scan_slots_for_writeback(struct zram *zram, u32 mode,
 		if (!slot_allocated(zram, index))
 			goto next;

+		if (test_slot_flag(zram, index, ZRAM_PP_SLOT))
+			goto next;
+
 		if (test_slot_flag(zram, index, ZRAM_WB) ||
 		    test_slot_flag(zram, index, ZRAM_SAME))
 			goto next;
--
2.50.1

