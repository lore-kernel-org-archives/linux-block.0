Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DD04B048A;
	Mon, 17 Aug 2026 01:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931793; cv=none; b=B3HkOskdaQWa3awNzmyqI/haUUIOtBR9GbS08v4M/GODfQZp68ybNavC5mcAzpVQuDyYMX0NjtYQhuoK2TN0KnkC+utECIMrejluQflmsnWQG/WnqlItAaEFypFoJOQ9ofSpFtJGbbCGWxItjy+7K7f/p3+8WpFlIA4/VQDeHSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931793; c=relaxed/simple;
	bh=h800b0SLL1yXTqsziZO+d9p/r9DkirvrbCuczpwuJn8=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=VVFvMzLuLUTDifUDhdYvKv5MmToLIlNpD8Y3CVUyC7idKKYzlMneEW68nBB5aJfzKORCiGzWeENEfVorhUXHJZsOSuGQlQu0PuYdh+/gSiTMqNSeHLEQAvfTFbVdbRjorY7NPolj/ILN+SyXofC7UpFJBtFDOGewcbcHozVbGIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kwxx8G7p; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kwxx8G7p"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 31D8114000AD;
	Sun, 16 Aug 2026 21:56:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 21:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931791; x=
	1787018191; bh=2XCcGiJN517zeM0UpgHY6PdfhcNj2O0lodW6qOVkvAk=; b=k
	wxx8G7pTuRzjmYBAvTuF37II6cgp4xAacnYNyiOcAum6HukxMTcLzhr44JbyEVfn
	4QVnK9TKw6siw0/IyoUKghDW7HJQsARzpDmljkgKjUio+sGdWK2qX4ZDWk1s0Y+A
	CcPwI7PrXmCXouG7Nj1hlwrZfPGKB7jRUu2ZR2fLz8qo8oiqijxxDncYa2HH8DDo
	s/TqMvFJXAewn5Iys7SLS6wCEiJ1XJvhKkdnaSzGBbFFUrY0mtc08VrVZzTECDMp
	24z+WNthWkGO4D2xyy09kwBr4BoBZ0a+AfnZ831Iz4t9UMMaKvjaQqXT25DupEWv
	nDKjfbD8DteB2sSGozQxw==
X-ME-Sender: <xms:T2qCakJM2kpphXaKHOaYH4AC60IdIhjTXVAjfzxYyDYSvrJFbkpfHQ>
    <xme:T2qCauMjm9rJNgd9F8ZSOX1WLvar8db8yxHBKrGCupeWA0_7LiSZtDvxte6yiA760
    QFzbjc8-QcfnP7CDAFF0ej4YLKs2RCISh95vEeNDv-EFgq-kP1od9Oc>
X-ME-Received: <xmr:T2qCakmVatloRBr20F3qozj762wPwSc7xK3_QmU3bqgX3LdqSZEY_yapnbkAPGDSpxScf75yKWLpHW_ocX4zKwzsEfdF1qfppx8>
X-ME-Proxy-Cause: dmFkZTEsDyF1XWD9XZqwh3C8Ho4JdRPUx4eqRjvYLt3EaX4KJjDKM6ktwFb9sBwbsZO0OP
    nwePXvFi/sBzBtYAc7ZrYAY3kjrOX72CwO8MkzLy8r6s+q8K39Zv9O3cVcfro15oqirg8t
    3/oeh/EnTvjsUqUpiO4ELw2DdtnIYwSxABH/Bxa6LXRBjDCK03fXlOZ4WZ+0OhrCtfYKiy
    I9mWMFXybSO0+mvHRGbhEIjpDzbcG6MyhaqTxdFh098Si9DUXUOVp+5mKFVdQtjRQ8IEW8
    XrKBIr8yfBevzX1wyM8jFpD1fw2ieud/BexiMnUPIQnwCzGFBoA9NcQx3eemHljzM4mHsc
    KzBxcMpfeaEsOZy0EfQ9XGID5v8pVZJb9GKQ1/gAqGegm75a3c/0OdHPR71WprG2y6f77J
    DhPNrhDpAbu0K4/xJr4uSBz4lhkmYGjlYPb7gsVYmtnQ8iW0webxB6i0Naag2ZLYlNdKb6
    k98RuuPQ/9a2dIEJ96Y7JJX0+67b11e5coffmqanX8frMvDqY00iOYySOX9vnbQIdNQAWY
    27rhOx5xQb2LrI092KHJ/wfJlqLnfZAxEC3YlND+bg2k/1QJP+bAxmaSstCIJBWl1iadUY
    xmR79yjptgU0QmFeY1Gp+Z4UoT/HOdYJtO4QFdwxWTd0LmuiRFhjmv6H25CA
X-ME-Proxy: <xmx:T2qCai4hNtCKRDzwL9yUP47vCy018EJYn3qpbS9nmQ1lL8PZdWNspQ>
    <xmx:T2qCao0y0Fbx89gwLBMBRwOH_FGULh4iOx8PN4dQKhVS1AI26irlFA>
    <xmx:T2qCatFR9Vgl1Lc-gyXTQ9-cVE3cbQb8P0y2gOGr3wJKJq7UkhMhrA>
    <xmx:T2qCangq4BrMLPCnbrJvaq6OEQUIjlGcHCtY-vOjBUiLevIlR9ksvQ>
    <xmx:T2qCag4z1nvLkvfKn_prtLrgAEXF4UIWPRDK1a6xXxrQ0TDh1owvoCQY>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:56:28 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <daa0b154ea6e7291191b43bba166767fd2cbd1e5.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 14/32] swim: Check error register during sector read
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Clear the error register only once before a sector read operation. Don't
clear it afterwards -- the caller needs it. Check the error register in
swim_read_sector() and return the appropriate error when necessary. Fully
validate the sector header. Don't terminate the search loop early just
because an erroneous sector header showed up.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c     | 13 +++++++------
 drivers/block/swim_asm.S |  8 --------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index c9cd0748c878..33374498d621 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -483,20 +483,21 @@ static inline int swim_read_sector(struct floppy_state *fs,
 
 	local_irq_save(flags);
 	for (i = 0; i < 36; i++) {
-		ret = swim_read_sector_header(base, &header);
-		if (!ret && (header.sector == sector)) {
+		if (swim_read_sector_header(base, &header) ||
+		    swim_read(base, error) || header.track != track ||
+		    header.side != side || header.size != 2)
+			continue;
+		if (header.sector == sector) {
 			/* found */
 
 			ret = swim_read_sector_data(base, buffer);
+			if (swim_read(base, error))
+				ret = -EIO;
 			break;
 		}
 	}
 	local_irq_restore(flags);
 
-	if ((header.side != side)  || (header.track != track) ||
-	     (header.sector != sector))
-		return 0;
-
 	return ret;
 }
 
diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index 533e3bf02fa9..aa61ecc1af96 100644
--- a/drivers/block/swim_asm.S
+++ b/drivers/block/swim_asm.S
@@ -67,7 +67,6 @@ mfm_read_addrmark:
 	movew	#seek_time, %d2
 
 wait_header_init:
-	tstb	%a3@(read_error - read_mark)
 	moveb	#0x18, %a3@(write_mode0 - read_mark)
 	moveb	#0x01, %a3@(write_mode1 - read_mark)
 	moveb	#0x01, %a3@(write_mode0 - read_mark)
@@ -140,8 +139,6 @@ crc1:	moveb	%a2@, %d5
 	andb	#.Lhr_crc_error, %d5
 	bne	signal_nonyb
 
-	tstb	%a3@(read_error - read_mark)
-
 	moveq	#0, %d0
 signal_nonyb:
 	moveb	#0x18, %a3@(write_mode0 - read_mark)
@@ -166,7 +163,6 @@ mfm_read_data:
 	movew	#seek_time, %d2
 
 wait_data_init:
-	tstb	%a3@(read_error - read_mark)
 	moveb	#0x18, %a3@(write_mode0 - read_mark)
 	moveb	#0x01, %a3@(write_mode1 - read_mark)
 	moveb	#0x01, %a3@(write_mode0 - read_mark)
@@ -191,8 +187,6 @@ wait_data_mark_byte:
 
 	/* read data */
 
-	tstb	%a3@(read_error - read_mark)
-
 	movel	#sector_size-1, %d4		/* sector size */
 read_new_data:
 	movew	#max_retry, %d2
@@ -234,8 +228,6 @@ data_crc1:
 	andb	#.Lhr_crc_error, %d5
 	bne	data_exit
 
-	tstb	%a3@(read_error - read_mark)
-
 	/* return number of bytes read */
 
 	movel	#sector_size, %d0
-- 
2.52.0

