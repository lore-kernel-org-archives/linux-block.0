Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFA240097D;
	Thu, 16 Jul 2026 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197199; cv=none; b=TvFuqoRsILNUqf//epjzGqp8ZGxImyfcucZ0Rxoid9Mw7d0FZcqS94Wdjgr1tO75Xk/lfRFged6//yhtXsi7CMJK7h99ywTO6qWJCbe8IDb1XCqJX5gX2XmHZyLxrSuK+Sevn6ECSzuB/KEPkiHAAE4s9ylZ8iEan0VCQ/I4qaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197199; c=relaxed/simple;
	bh=giRgepT9Jr5MnZNs2gedsWC/lnHHNxFC8o+bXHCcsc4=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=NhaRgKI3KL1hGMEx/u4hKDNZXpT+RmzHSOwCnKpYcc30ut3lc8g+8jRYOqXivDNbsM+HAVu71V4SDlPQd4SZe1jFSkFMKBgbDtclX06d7b8pQicymQ/Ag8jdTrqBbWmkSJX0z0zikEFsYreuGCe9tiheAxD6Y9mG4wHQI9cw248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nZD0YqqO; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nZD0YqqO"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 61C5A140010F;
	Thu, 16 Jul 2026 06:19:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 16 Jul 2026 06:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197196; x=
	1784283596; bh=Q3bn2vHSQ3mKVdFh1En5/GbczEmcB6U58nxHknuUKfk=; b=n
	ZD0YqqON2Dz4OfZQgPPrTkVHoUgu65waixhTYEWkzVGaKPsfRMmd0Rd5TazNh6bA
	4pZDSWDtMziaeitox0pSVrgLFrSwMdmZUapzaBCaiPNdz2gFesdOWgpxKIEtjcXC
	EqYs1b2gurj9dzFOoQ/dmofLl4YukEMX4q31zydHULvQ0anGG0lMJwFDeO/NLLwd
	5BR03wf6XFVy984paEaxwCcjOe76FydS0rTEZj4+//V2RRYV/0z3hI2ze1wGyNsb
	HuU2wL7DNNrJVJ0ee6Y3FtThs7FdakLTMo/vQGsgaV82g5uktPBkV7GA/Y9SYNOM
	djO++NxJIBffq3Rl8xMwA==
X-ME-Sender: <xms:TLBYasP7iw-PfcNAIC-uAQghyBi3vwNuoOYQz4nVjC241g5fFIHSnQ>
    <xme:TLBYatDD3OYmkI4VzI3SVMykjtyQZzZU1zpBrkX06UnOAETOo0BZD3Eq08Xr_GAcH
    XY0dbfVJTTF9gCnVc6nUjuFePMBZGvxcnHQMSmKQRQK-Oc97Elgi4go>
X-ME-Received: <xmr:TLBYajKbhvvl4eWFk7ruOHkfOFet-UQADuU2OUBv-dESg9sf6ywm3LuS30VMPjM85qsSqGlqhDBSuS6kcD_49n1uAgqM1MMgNPI>
X-ME-Proxy-Cause: dmFkZTFltWOiqi3GJy7/GjNP9KLpSvE6YkRxm2Q3A+Dj/aP0Z6dA9iIiBN0USRzNJCcteS
    K/D0kvNTDbqtTANaUA/xfgoZfMpszLplr5/pvHVqKKo5s0RVWCO2umMrR+nQZw0OKxwLXK
    KaQRMPKUEdI+qra509DzvjLAVS5kcbe0yFLHbQq8WitTPnaA9a//q0SseAu/arIDWD3AGb
    W1DzaVjmh3YVxjd6oh9EZ+C9JcqMLUvXWkcNjeyN/Zi7JLie6B4Pll4f+m9WsP9wdaNbE/
    iZiUd3GAI7vwYmV5kLRtY/IqoaNmE03sbAQ65XKcDP6gxXaEdq+cc/kMIqclO0/e7YtpSR
    JfO/en4pjK5Kad2Sdk7RdNqk0LJyxxtd1CQiOygB8i+bapzdZBYNqo2270RCe4sO4hIF66
    ss1BImlFKN4sg3Mog3aLfSv7y4XRNDNxDxW34RN1E1ilhqLU5qTuWU6Oo26OK/+mVz1Whn
    QH5FB4LkCido5+BUztF/RIFbzMFnU1YkO4XypEs1dk4Qlb42+vvguCmdMZUh2PZSnURTO6
    GfiKEjPnXTxBeVXctnVUZWp0mT5Zj/BiIyJd7C0N1H0/ItZmpPE0QGIr8NFCmjP+G9m+zU
    5byPhf7WX2fWu+GXKeKK2Ylq7JpYJgwc9OohRRgS0vGpTmqxFSo9jCYrk/8A
X-ME-Proxy: <xmx:TLBYamP7PwRufsp1SMkV73pJlzeGyiGq3z33Ubgau5R0sQ9VDufDJg>
    <xmx:TLBYah656XdtB3ujljk1Fb9ccwQwWGMjCK1G1ntBTo-Job5rJMJJHw>
    <xmx:TLBYao7jZSu8BFGPfhuJ2tbirrmghjRICWuaWVGfwmH2SU9E2-7_DA>
    <xmx:TLBYavEF-hfvQ3X_SbKp82L_EroMGShzFm7MV-1qpbMoWaKBnokNng>
    <xmx:TLBYai9fWzUOxNgTwdDb9g7yLVU2dV7cK0-G9aGaXncHBLGVZHtW2jVc>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:19:54 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <afaeaf8ed29a73e1b361519b542269c4a57a1713.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 16/31] swim: Fix buffer overflow
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The effect of this bug can be observed as swim_read_sector_data()
inexplicably returning -5, or an error flag indicating that a mark byte
was read from the data register, or other odd behviour.

When copying bytes from the chip FIFO to the read buffer, the driver
keeps count of the remaining buffer space using register %d4. A counter
in register %d2 serves as a timeout. The driver polls (%a2), the handshake
register, until flags indicate that byte(s) have arrived in the FIFO.

        movel   #sector_size-1, %d4
read_new_data:
        movew   #max_retry, %d2
read_data_loop:
        moveb   %a2@, %d5
        andb    #0xc0, %d5
        dbne    %d2, read_data_loop
        beq     data_exit
        moveb   %a5@, %a4@+
        andb    #0x40, %d5
        dbne    %d4, read_new_data
        beq     exit_loop

Note that the exit_loop branch depends upon a flag in the handshake
register and not on the remaining buffer space. Hence there may be no
branch to exit_loop after %d4 is decremented to -1 (i.e. full buffer).

        moveb   %a5@, %a4@+
        dbra    %d4, read_new_data
exit_loop:

Here is a second decrement of %d4 which can now reach -2. But the buffer
bounds check is a comparison with -1, which is now ineffective. Hence the
loop will continue copying until %d2 eventually reaches -1.

Fix this bug by terminating the loop as soon as %d4 or %d2 reach -1.
Reset the timeout whenever a byte is copied.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim_asm.S | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index 5caeba3a75d8..ae767da671e3 100644
--- a/drivers/block/swim_asm.S
+++ b/drivers/block/swim_asm.S
@@ -43,6 +43,8 @@
 	.equ	sector_size, 512
 
 	.equ	.Lhr_crc_error,		0x02
+	.equ	.Lhr_fifo_2bytes,	0x40
+	.equ	.Lhr_fifo_1byte,	0x80
 
 	.global swim_read_sector_header
 swim_read_sector_header:
@@ -192,16 +194,17 @@ read_new_data:
 	movew	#max_retry, %d2
 read_data_loop:
 	moveb	%a2@, %d5
-	andb	#0xc0, %d5
+	andb	#(.Lhr_fifo_2bytes + .Lhr_fifo_1byte), %d5
+	beq	1f
+	movew	#max_retry, %d2
+	moveb	%a5@, %a4@+
+	dbra	%d4, 1f
+	bra	data_crc0
+1:	andb	#.Lhr_fifo_2bytes, %d5
 	dbne	%d2, read_data_loop
 	beq	data_exit
 	moveb	%a5@, %a4@+
-	andb	#0x40, %d5
-	dbne	%d4, read_new_data
-	beq	exit_loop
-	moveb	%a5@, %a4@+
 	dbra	%d4, read_new_data
-exit_loop:
 
 	/* read CRC */
 
-- 
2.52.0

