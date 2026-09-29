Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4AF208D0;
	Tue, 29 Sep 2026 00:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641721; cv=none; b=KmGosbnFIP2h1Xkr/xQ3LJ2g04ON013GT4XSmSrlodezBZs+ZKmCciuzDHYe9qFkBns1fXaxo2xpIC2i8IFZW0NgfwBlOVMBG5OkgthbraOak1H3V7TrXVDi38ZMetzTxWY42hADkDIFBn1lS9OWyqDCRsnorATtDSknMe3yhtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641721; c=relaxed/simple;
	bh=N73YZGTEjER5pXSSrCj7iIHn6U5+AeuWLihxcXY0U+g=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=uv2/HhUGgBAQK8KEfUt5LPlEMfO7Itj+h0YHhq+bAwvfISmsdOEXOOza4UhURErZPsdKdLV40xyTqiSczg6nKgQZcj/7LFfOS8VTBKsSbJicANF5br+cYvEK/qmftj/2bcH/f30F05FwTgubJIa0sS6ZplSLb4SDOqNhHIe/NxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G52t+k+h; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G52t+k+h"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B1401400098;
	Mon, 28 Sep 2026 20:28:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 28 Sep 2026 20:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790641718; x=
	1790728118; bh=M18dl0+3mCCmz2MKP1eaJXrxikAp+9CKrTTAIetuXrY=; b=G
	52t+k+hXkop5iWOxnZxvs1HNTD4KLJC0KXmUYMuq/NVtzFd+nAgdofn6XezMkpMj
	seACHN+cyqWI6o5IEZU60UKBb+szHIW7vRKTpBmNJbr9IG8R3BGQGFH+xBClPWKA
	e+s6YFOwKmanHq/+AKexSduz5vqFKyWaTCbguskAFdiAPXGlCGYLOpZ+WyhndoO2
	EK2dMnD8+CSHSpwfXdTr3QGW3Ndiip4lcNM9bTRXugMeWqE6VUJVsAe3K5wMvxLq
	H+qvIYoz5iolmii87Aqij0uaN6E+4GZZZNaydLKHkOnlYAJMTG/ZFbd5Z8Y7n6yK
	q2k11Rh0DSioMvEzMei4A==
X-ME-Sender: <xms:Nga7aiE5FvQpFhGnbh9BH9LUhU2b5gDB--lsajHgMcSEKvLUw-JsFA>
    <xme:Nga7avX27Q1lJftSuYPJHaZ_2UZM3PacO1kAHBLVgY4ycIqMdMi63AKrYmidotwab
    d6xW55-TJXvfesj5xrQLYqv-QIsG4mxUTK5O3q6MyQ0AO38UY_EtTI>
X-ME-Received: <xmr:Nga7auWU0VxMWE5glTr7pgnFx2zn9pnJH2ZXE9UBSfinfIA1j_MPVaonX-id-4HpMqpUOVHtsg2H-yL8JorGfardmATc82JhqSw>
X-ME-Proxy-Cause: dmFkZTFvVkWPdiE6nn+cl7P5xFBnKNzOXHNZ4eKj943n85xMEwwpwQBbZRt/UNf7hnM9sC
    uPVrP+UcbyvTpTEztDA8nAWIESxoAkKOJn2ZUxFSHZfDNcOaKpw6lXv6HRCZND1bjjgwdg
    Mh7qh5SeHPDlQIXJhO8R3txfGbQI4PC4ZB1pH8qfRIdGu7t4AnBmaOA3cwb7EPXDSJZH//
    2UbY+9RQfSl8M2+YPxgK2SBGR6qPQcEBVIJZQzobCDMnvCV15N3RS/fnKB+ImKobBaBcwr
    /KDXrG+CP3YzyTcVqEkrW2Zjxmph7hjAwlZ5ISpjHPjUSP+bSzaZssoh57/wWBy4TtPylk
    6G3V9YnnPO77fdTwFS57JD6INUnHY72EcrNwyda0tv4e7xWrUwaZEWi3NcMce5YswE9nqh
    zQ74AcGtqcMzfcPOyKFO/nsc4s6XmUGApmK5njyZmNU5eFvFTEfxlbQlmlyyQLa5vVDvy8
    A0ah2ZuVlZ6Is2lWL93WWOT+KJYciYIijhv1wj2/fa3XFHUzPKyf+JjpH6OWbG3EWbDqpb
    zm3b/bgXBLV/lZaaJEROx7bb9BCgGZdOIW9V15NmMWwLnR4jW9dua0hDHr6sBKQAXpgPyB
    mu9IDXTvY1u26+feXVfUmHHJGaOS8KcKU2uTDN657hDijyUrWFhcXuigAMIA
X-ME-Proxy: <xmx:Nga7atID0tyakWJ77yQGRFo3fR0rH5KP8i895B1Tn5ajNbdi8AINxA>
    <xmx:Nga7amAhkN0EzKmiUC9lbOUPpB7HUMNTX5sWFPfvUNSHp0_JrOYTRg>
    <xmx:Nga7alcrZ-YtdqU5fnMjDa2fQuj06sSeeEnbCsMWvfvGzOiaouJTTg>
    <xmx:Nga7at3NkbJaGfQjbuu2UEMTRrtcOJPD-_g1-tVQp5iNtkUhtIllzA>
    <xmx:Nga7amG4wWxCxx3x2FpCMGknLYXXtoeB33IS3pEV6BMWfFZTR82CaG2H>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 20:28:35 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Stan Johnson <userm57@yahoo.com>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <327be6ca3c92c3411b5dfaeede014ed65a2d0f0f.1790641175.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1790641175.git.fthain@linux-m68k.org>
References: <cover.1790641175.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 1/3] swim: Return -EROFS when opened with BLK_OPEN_WRITE
 flag
Date: Tue, 29 Sep 2026 10:19:35 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Write requests are not supported by the driver and produce IO errors as
shown below. Avoid this by returning -EROFS when opened for writing.

[ 4111.690000] I/O error, dev fd0, sector 2 op 0x1:(WRITE) flags 0x800800 phys_seg 1 prio class 2
[ 4111.700000] Buffer I/O error on dev fd0, logical block 2, lost async page write

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 6f37a01219c2..49c894af7c13 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -639,7 +639,8 @@ static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 	if (mode & (BLK_OPEN_READ | BLK_OPEN_WRITE)) {
 		if (disk_check_media_change(disk) && fs->disk_in)
 			fs->ejected = 0;
-		if ((mode & BLK_OPEN_WRITE) && fs->write_protected) {
+		if (mode & BLK_OPEN_WRITE) {
+			/* Write support isn't implemented. */
 			err = -EROFS;
 			goto out;
 		}
