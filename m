Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA3519E7F7;
	Thu, 16 Jul 2026 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197169; cv=none; b=aB96DPmncowH7klxT4ufFnCyhz4eD+ZNYji5fsPTQaMvAVOCYmMg3+IHeAP5yEeYD8PXiYpP/go8PskC2T8KtRY1M2rFpat2E8RqjrJKDIvTP1qZd8jU7qCALA4QMGNmxuGDqQXpeSSuh850xZYaQMuE97i+0+gQBrRVukEyjJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197169; c=relaxed/simple;
	bh=FMM8KpjE40LwwAIT1qntlDYzJALDnK7ajpePNTGy8Wg=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=Rau3+c3AjM3ub0Zs6HeOmwuukCKky83lwYmh9PB8zkqoqXLa2h7ltr5SMbz1GSFm9HI2Ia0qEkybDyO2Vw1rXBgDbX1TsKg6DC+AcYGSxdVDB9wb60Zu9qcOsH218Pq/gTgXlWy4r+QHiB0Ds6+OXflIcVubrwV15+UdpvwjL/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QjJLmKsb; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QjJLmKsb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 56AE5140010B;
	Thu, 16 Jul 2026 06:19:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jul 2026 06:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197167; x=
	1784283567; bh=DgF22wdqtJtH94iuaDMprm/3xbSplJyJEAvdJ2VsNSc=; b=Q
	jJLmKsbREtc8gxHtBzgs4ZVhCymnV1K641BOjcA7/YphSMHLUe7gBwSFqk/EMuC/
	qZfrdhx7a5KveyJxXj/wTGL7+T488H56No3X2g7YbNmArkQzd6QdPYAtIgPWFmiC
	K92JnYlLw1ItwJAq3oEdaaa5J/C8uzO+YRWGRAaKdl8LtctcUAyB1basOmO+amjs
	Rrhdn0v7dLszcDkq8ZnKuVDC3SlysDS6d/TuKthW5/Kg6+3J6BzCw3tIA+qSjEm0
	L7b+7atar55G/8PyeLU0QA5NFeA4F81yAySUmGX+OmwszCKne3TKL691bS5befav
	MXeK6TBK5VwA2LZ7q7axQ==
X-ME-Sender: <xms:L7BYatQcWy3UofHh1ytg2-Pk5pKdOalyXj4TSVLLyqJxi7HIUzFRUg>
    <xme:L7BYag0eb-kbo5VySD0FsVh26HDXipepWYSt5FHHWmyPx98bZzAGvgRM5eABs30zq
    vyBSSyJLZmSxJywLOaawML6-HNpycEMKryMiWpGogdiKJ_NYK6_iQE>
X-ME-Received: <xmr:L7BYaivVJafWF6xPBS1M6Bkr-No6u57l-DkDEU43e0Vvh5gLwAB9vq5ikR9x6DQT_07knFPZLXiminZCPwAkcQITG1tVgJd0Iio>
X-ME-Proxy-Cause: dmFkZTFltWOiqi3GJy7/GjNP9KLpSvE6YkRxm2Q3A+Dj/aP0Z6dA9iIiBN0USRzNJCcteS
    K/D0kvNTDbqtTANaUA/xfgoZfMpszLplr5/pvHVqKKo5s0RVWCO2umMrR+nQZw0OKxwLXK
    KaQRMPKUEdI+qra509DzvjLAVS5kcbe0yFLHbQq8WitTPnaA9a//q0SseAu/arIDWD3AGb
    W1DzaVjmh3YVxjd6oh9EZ+C9JcqMLUvXWkcNjeyN/Zi7JLie6B4Pll4f+m9WsP9wdaNbE/
    iZiUd3GAI7vwYmV5kLRtY/IqoaNmE03sbAQ65XKcDP6gxXaEdq+cc/kMIqclO0/e7Ytpj7
    0H8+JkXJMCgLSOGSp4Y1q8U8Rs8AJntyf66X/TJTNBLjSdeub0yyzXhI9OBMlTcUDixmWw
    SAeCuL47Z5N86zr6N2W+weGeEq3Af3ZvjXkO1bCZtHLjBGkQyUadBnr38IE+/EiBYo9Sez
    r7iGeZjV0EYqmFd9Wk82CuPRb+RXVWXYu4KMiULZROec1trRwJtyCkC7VR+cJ0PfbWgf4w
    0xyC/YmVqM6+LdrrnpHwGzKUc4UiZuGmmUkur6ffJEzHobG/ulANx4Lft5c5tFnoMu5wcH
    OCgpo5GfVnb0zrb0WVRnzROFeZV5CNvaQvNxpN3Ci1BGUc9zwuO2Dekc8Mnw
X-ME-Proxy: <xmx:L7BYamhgrYSYHLSfP3uc_S50_uRpMLcb0umUIrRd_Xo3MByoU-zF7w>
    <xmx:L7BYaj863OXmmZyIQHr505PcAX12Ls18TstId_wDV4tM2fU4QvzurA>
    <xmx:L7BYapuEFoQTnx5f2aD6GpJwsbr9xecOhXW0lRjRV8Uq84pfyjWZZQ>
    <xmx:L7BYanpG3ElZLQEI63_VyhknZkHSFOoa97HUTM-Vg0vE98QV5w_YVQ>
    <xmx:L7BYauC2E5g-fv5gudNc4xaaQB79Jbxs9l1EilkWzwLM0y88Vd3hgcc6>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:19:24 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <c680a69ca18822f0f27dbba0f9a22949431dcd08.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 13/31] swim: Check for CRC errors
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

After reading either the sector header or sector data, examine that flag
in the handshake register which holds the result of the CRC calculation.
CRC validation has to take place with the last byte still in the FIFO.
This flag can't be checked by the caller because by then all bytes will
have been retrieved from the FIFO. Return an error code when appropriate.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim_asm.S | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index 31fc63b074dc..f40e19e48021 100644
--- a/drivers/block/swim_asm.S
+++ b/drivers/block/swim_asm.S
@@ -42,6 +42,8 @@
 	.equ	max_retry, 40
 	.equ	sector_size, 512
 
+	.equ	.Lhr_crc_error,		0x02
+
 	.global swim_read_sector_header
 swim_read_sector_header:
 	link	%a6, #0
@@ -128,12 +130,15 @@ crc0:	tstb	%a2@
 
 	moveq	#max_retry, %d2
 
-crc1:	tstb	%a2@
+crc1:	moveb	%a2@, %d5
 	dbmi	%d2, crc1
 	bpl	signal_nonyb
 
 	moveb	%a3@, %a4@(o_crc1)
 
+	andb	#.Lhr_crc_error, %d5
+	bne	signal_nonyb
+
 	tstb	%a3@(read_error - read_mark)
 
 	moveq	#0, %d0
@@ -212,17 +217,20 @@ data_crc0:
 	dbmi	%d2, data_crc0
 	bpl	data_exit
 
-	moveb	%a3@, %d5
+	moveb	%a3@, %d2
 
 	moveq	#max_retry, %d2
 
 data_crc1:
 
-	tstb	%a2@
+	moveb	%a2@, %d5
 	dbmi	%d2, data_crc1
 	bpl	data_exit
 
-	moveb	%a3@, %d5
+	moveb	%a3@, %d2
+
+	andb	#.Lhr_crc_error, %d5
+	bne	data_exit
 
 	tstb	%a3@(read_error - read_mark)
 
-- 
2.52.0

