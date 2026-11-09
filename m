Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235879;
	b=mglk1AUfwn5mmQYaubvsOeY6oXc4Mus5pCWCW9VIAndR4MpenKzWbETOqXLKYbGFCh4w
	 qSuf/ZfHvCJlfDVkF3FudoKeOk9KbYTlKlTuwQMc87PU8PbGqH43R5gAzqn0R/+yLylut
	 /zSVYSQqMGZObgKWeLOCVuBQXyxnQc1TZHZsuJmqI9hWOP4unAbObeyDkImmpj5USw0sS
	 eBPKZ95dxNBWjlPEhAWJpULr75XlehX4BsI0BFM6TX7loUVyCHz/DveZl6oVKw8m0YfyJ
	 0VIAgdSswNLkS+G0q6nkob3AZ6f9vaoQmDf0mwNEu0l0ckWaYrqvX5a1TeQPpZpMl7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235879;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=uLSflaxjO4OBevq7ky/l/4hrZCoxCuKgi5OqqZAksoc=;
	b=a3uJ5bPvHu+NZnpdBSaXI6+WVomRAku7tOz40Lev04jYuBKZy7EOWA8roKKZ6vRgV6Vh
	 xBjrPgHDQ2p0QWrw3DWajLj/K3K0zBOOAu/gSoE62y4QeZ031SQHls2/P8LeGwd7wG9DA
	 x22H3EBZsx6RETugvyYncBNW1r7xTs/4NHsyGLdmRA8RS9oolNnwesbMfiHM8zpKkalwu
	 NPcdOB5lWTHKqGrblfDwOfaPfa+cyoLZGESGjN3SQZ9Afbm5kRcSivKxB2KLHQMhUbQrL
	 MtyDB3dNy1x4FM1seloAndDQiQCrL+fwETHOZypIiygpCgzMPLgdv8nhQbiYI3v9i6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=HEAG+Oi7;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B18606EE8A;
	Mon,  9 Nov 2026 14:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3B18606EE8A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=HEAG+Oi7
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jNXm23mFkz8Xrkn;
	Mon, 09 Nov 2026 22:51:14 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794235874;
	bh=O0K5SqWPqnmgeQwtJ4LKSu5Ulb1IYQAL+e00tsD867I=;
	h=Date:From:To:Cc:Subject;
	b=HEAG+Oi7dQzW2ds1iDc2EOc+P/nT4MYWjvP6gUKHndN/P08BdqVmcWbzUte1UnYFL
	 PlxPCEmy8Sv8c+EK39xWA7Dy+WAseMRNiijXg9edXuJQ0VCTdw5IT13UDfSZEWURW/
	 umrS2ABfKJkA5nJcRmC5/Ib9DR1G13vNYgRJKQ3BiOj94bcsu/G0KJB3eDF6UxtAVw
	 KGCJKeUIzcDcJktMEqw1D5GGNQnObUPSh5X2E+gDR0VtatLwfHMponAHpqFCBGuYVC
	 sCaOtUmqOySptzXemKRll5wH7prYBCLEYJAq5HHLXcx9/qSf/9nNiMmhOdFIkN7ZuC
	 Ih0ur3M0c3jng==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6A9Ep6id088728;
	Mon, 9 Nov 2026 22:51:06 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 9 Nov 2026 22:51:10 +0800 (CST)
X-Zmail-TransId: 2afa6af1dddedbd-74b87
X-Mailer: Zmail v1.0
Message-ID: <20261109225110056QQJAEflTHzwYHzwXlMBb_@zte.com.cn>
Date: Mon, 9 Nov 2026 22:51:10 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIXSB1YmxrOiBzdG9wIHJlcG9ydGluZyB6b25lcyBvbiBhbiBlbXB0eSByZXNwb25zZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A9Ep6id088728
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 09 Nov 2026 22:51:14 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF1DDE2.000/4jNXm23mFkz8Xrkn

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ublk_report_zones() treats a zero-length zone as the end of a server
response, but only breaks out of the inner loop.  If the server returns
an empty report, done_zones and sector do not advance, so the driver
keeps issuing REPORT ZONES requests at the same sector indefinitely.

Finish the report when the zero-length marker is encountered and return
the number of zones already reported.  Use the existing exit path to
release the report buffer, including when the first response is empty.

Fixes: 29802d7ca33b ("ublk: enable zoned storage support")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 drivers/block/ublk_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3d322fa1bc83..5c14daeaebbf 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -693,8 +693,10 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 			struct blk_zone *zone = buffer + i;
 
 			/* A zero length zone means no more zones in this response */
-			if (!zone->len)
-				break;
+			if (!zone->len) {
+				ret = done_zones;
+				goto out;
+			}
 
 			ret = disk_report_zone(disk, zone, done_zones, args);
 			if (ret)
