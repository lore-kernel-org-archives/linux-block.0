Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589E32771B;
	Mon, 17 Aug 2026 01:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931813; cv=none; b=H5HJxAtbHFVUXUp8IRs9KgngmzDXz3oeO4pIA+gIuBu9mmWLuORgE/g/yg5TpMYkUrhJRc3dI31FMdsdug6Fs/AaAXmZ7x7+5h/butLgpTR7U6Dp9EOwFBryMrcvoo0mlURUj27pK7IWk2XWB9Wl0gSePbL0EnvsIIvOfg7zfGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931813; c=relaxed/simple;
	bh=kIRVXxiHAFWBOsDWJvjYHRzxcMfbKtgsBiLcjgEojVk=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=uDUtt+5GAc0aBIsVK0T+z1+ScoEPLSIg/v0GxDImagNqEY34Tzb5UfOnnCGB6Y3CVySTig6hxYQGCrAe8vTnFaZItsTWciDddMxvQE+PQIhV1G4eInMhe4wdP5qg2Sae083ZovFuJ11RDyilrPGQ1o1QaFIYf0Km9hsy0grOh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a0Bxpjn7; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a0Bxpjn7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 897F6140003D;
	Sun, 16 Aug 2026 21:56:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 21:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931811; x=
	1787018211; bh=sjmM9kNz7iMxJa1zB4a5hCIKdwdJLVx+hNWizdsOVcM=; b=a
	0Bxpjn7YRgDF92E+7lxNxGxNYYvVGiNbG0LPXK+e1qW7aEag9fcIGeyWTWaZa/vQ
	fAf1gLs+12gQCQR5cZCAPOPyCVxIFZgcb8Y7xtSLlLdX5qjsIh372WngwEu9+pOB
	kcq+G501kD91Ei9z+it4iXbwmIibYrH+5fbc2gNLuhZgJmkJIZklcBdfPsCby90L
	uEEkmjnAThIuxcnpoc2XdgGEsW7ulwzn7ktmR8EvGXRnOApl9bMgRZBqP3ka2Kis
	JnsLeIrHkSyFGFxjH9dDeXiMhV/Vedh49liYj/KMM3GfStNakitq91yBcZzlYKY6
	qp/aoTukCypXJVPRpXhwQ==
X-ME-Sender: <xms:Y2qCahoYEwAxZ8eXkucYerlers6jxfLTK1gJGeC_9g6PdIUN6-wLLQ>
    <xme:Y2qCatv-DUbyBvRHdc8VMTTav308lJ5olX5ue0FIFlPiv9YgrB9QjnV9K1vRpJ2w6
    z_BAzYKBW7YGXr9cP4OhRf5SMA7N2r29wVNd7rVeCE9APDf--qkh5Q>
X-ME-Received: <xmr:Y2qCauGgrLZaSfjRskYRHDaVDXRDkjEzgifTEsQ1HMPRrtjiJKVuwyKCVRXQKwjwtfioCq0vPeFIzvopVqXa-YULZa0E4KQ2KZU>
X-ME-Proxy-Cause: dmFkZTF+LZrjPxVw93I7r7IUsrJw4pR3uVZgXLPXemG6QZUfPA5a4YUs/S/zk6lomzsGMb
    MGBn9dYhCmFngaHvlYDRM1EczTPkCQ+QOfTwzRhqHKg5IZ1NcIqtclWYhUqFGff76FfpWy
    IvJPv1xdpXPmAe8sBub9BcA0ZFTTc7HKhdlyedSIDG0q3UYjUgUsHlpcHJKc7w0vsjcgZZ
    6jlXW4TtDBNy3oAUn9/o/QGRqKEmCWDKDkhlZYkut/8A5B4ZErSmX3K+5A7BgErzGatd17
    NiDEVnOaC99yXXiRY3OJ4Ko6eO/q6fqVX44LE41wJ/OXh7VR5YOGJq42qd7GfimvUSZJrK
    8j7+X1hY6a/hJ74ab/xyl5hrhP7W5DX9/LoehISlJapzYQw6/VP0H2k+8QF/CFWHjkbmkb
    h0mVTlPXCMl1V7o6B8Rig6ocwBQ6CS4tv/gTk3rxzwxxFmkhdsVIoMwI9ggGsqB4ve/G3F
    fpCnRp0uuzL5DbVU66uXTslZP4QC1AEXF/pLTQkdKZqov+DzM7wTRP5ZxPq7+08BIF5Lyh
    lFqtXcPd4dYGB6f8a3XZgqb8oHfpW/sUE8PkRo//GtBh4jcRqvANkPrfLaLm7vy3upSZlb
    /oHjMltz8RTlr+mdHpWoue8OxGk+4G/iaaWvNza4+TKi2W1tEjpajO95BM0w
X-ME-Proxy: <xmx:Y2qCauag39sUBdy1ObNlJZL4KGz8CtvRvinFI-hx7qkavQA4hYpKxg>
    <xmx:Y2qCauXjWuS9V7Ue9pJkb9jAF5RQeSNoF_eceh3RRjuPBPQv31GAlQ>
    <xmx:Y2qCaknkdwVbTijFP1w8wtNkgEj2dzRv8UkD0eNoHNcmbK7C_ed1Ug>
    <xmx:Y2qCapBXsPRsRvCDhxHSXxSil0rl6RypyrLZm3UOuPUyR3cmK77xvA>
    <xmx:Y2qCalXuhTYSbDqdhKmPvlTTki9eMk3A8hbKuYN34P066w7ghI6nci4F>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:56:49 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <28a58cdcd1777806de85ed6577f19b9d8e310e6e.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 16/32] swim: Fix buffer overflow
Date: Mon, 17 Aug 2026 11:17:10 +1000
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v1:
 - Avoid jumping to a redundant AND.B.
 - Avoid a second handshake register access when there's already a byte in
 the FIFO.
---
 drivers/block/swim_asm.S | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index b12289bed2f0..9a7d7466e846 100644
--- a/drivers/block/swim_asm.S
+++ b/drivers/block/swim_asm.S
@@ -43,6 +43,8 @@
 	.equ	sector_size, 512
 
 	.equ	.Lhr_crc_error,		0x02
+	.equ	.Lhr_fifo_2bytes,	0x40
+	.equ	.Lhr_fifo_1byte,	0x80
 
 	.global swim_read_sector_header
 swim_read_sector_header:
@@ -189,20 +191,20 @@ wait_data_mark_byte:
 	/* read data */
 
 	movel	#sector_size-1, %d4		/* sector size */
-read_new_data:
 	movew	#max_retry, %d2
 read_data_loop:
 	moveb	%a2@, %d5
-	andb	#0xc0, %d5
+	andb	#(.Lhr_fifo_1byte + .Lhr_fifo_2bytes), %d5
 	dbne	%d2, read_data_loop
 	beq	data_exit
+	moveq	#max_retry, %d2
 	moveb	%a5@, %a4@+
-	andb	#0x40, %d5
-	dbne	%d4, read_new_data
-	beq	exit_loop
+	dbra	%d4, 1f
+	bra	data_crc0
+1:	andb	#.Lhr_fifo_2bytes, %d5
+	beq	read_data_loop
 	moveb	%a5@, %a4@+
-	dbra	%d4, read_new_data
-exit_loop:
+	dbra	%d4, read_data_loop
 
 	/* read CRC */
 
-- 
2.52.0

