Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E173FE344;
	Thu, 16 Jul 2026 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197150; cv=none; b=s2TR4ooFBzgCtFazHofnonOjO0oKVSqb5U6ayv9psHS/9wkOBW98t3XX7t9NiJ8Jqur4Bz9RNHw0eaO0YClRm/MJ87lZpK0njs2Mr6QAI3mR2JMjxIuzLFiSr20U6YhRRMejb6cP3RXn/I1+ZO4rh5WLq1JoTWLYuc+cltAMX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197150; c=relaxed/simple;
	bh=MsM/mWDZGBe4MPg03zmUSoqOIUGG+5Bz4xPqtAgb3Yc=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=LjewPiGRcMfjF8+3NjLIKTP1FiuQp5XZr2dILqRhJ4jUsiku7MLO6GM3rX9F0txALQHfsw65G6WDMGWg3zFnZ9C9eu3RC//fiIwDPw4zJVb2gWwm+yQ71DFvQay6MRAHWgZ/ELjpP/YavSMzDoYV1krtRH0CpmQd8ib/qIqYmpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pHDoj9Qa; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pHDoj9Qa"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id F3EF0EC0193;
	Thu, 16 Jul 2026 06:19:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 16 Jul 2026 06:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197147; x=
	1784283547; bh=M76Bsd9R0OeFm7J7j+/74+8vjRRl6Fo1xJGFqhQjpW4=; b=p
	HDoj9QaKx2I9ImNiPhLvFeZ664cnGnhZIrJKTYHbl88bs7agvt3kjumLkay7yOmY
	cNYW0bzkJLwSYYt4zK9F7nmds61pY/0GSsxoslbah623a53cEDKc6ZvvLc5maI17
	vMSHwwGj5HLg2/+Vw8+OM5KoR+MJrsOgj1oBtiKh8nMUxc5Wa8cBF6wD5OScTfnr
	+AOnZjg5bJ7RNbppEgzVL+RiqVca0dQCpTtuGqkUvdcsxQstGgW7ZuM+5MBQ/Oyw
	SDxhzC7CtHAHlwaI95Lf65z0dz2PgRZSUccZIhVQcFhP3awiniNs2FRE1CXZ/6G8
	odKXo4Fzx3gqJICSUPvEQ==
X-ME-Sender: <xms:G7BYahWyBSQTvRpr3uBeY50YXN6J7AgOLHxsBYV8KtZLNJAXZnanKQ>
    <xme:G7BYaroQFSiLoKgzdriUlMRTmctQRjIEf8StJlVrm4NAW_EBhbPVDYCQe9kkpXzia
    dVbTeT7XCrt24tYF67ropoql86WyFrFOboVjog0xnMGk7JyehFv_v4>
X-ME-Received: <xmr:G7BYatSWUSnvKektdW6eqU6wzLnuWLU3MI9dSl6H-hn7bdTXpOO7aykbV97CPuhSWfM-TfnaftLZFQzWYozs6UQ3HQpeopuA2D0>
X-ME-Proxy-Cause: dmFkZTFltWOiqi3GJy7/GjNP9KLpSvE6YkRxm2Q3A+Dj/aP0Z6dA9iIiBN0USRzNJCcteS
    K/D0kvNTDbqtTANaUA/xfgoZfMpszLplr5/pvHVqKKo5s0RVWCO2umMrR+nQZw0OKxwLXK
    KaQRMPKUEdI+qra509DzvjLAVS5kcbe0yFLHbQq8WitTPnaA9a//q0SseAu/arIDWD3AGb
    W1DzaVjmh3YVxjd6oh9EZ+C9JcqMLUvXWkcNjeyN/Zi7JLie6B4Pll4f+m9WsP9wdaNbE/
    iZiUd3GAI7vwYmV5kLRtY/IqoaNmE03sbAQ65XKcDP6gxXaEdq+cc/kMIqclO0/e7YtpnB
    YtJUTDmOxutmFNcPqHLc9xaVrUBpRpHAdWvXtgOB808WLUJiLdCj/JSyDf3mPa39ApASG7
    8vVwe513DdAytexZ4pt2OTV5JY/zsnQ9k3X3k5Z7txc8QMyXazTwJAiVxu11tEFdtNb927
    M5w0Wcwzh0D8DHqTzhwdHaJ5LAoz9JPYV7ShUj+NgMk9WBk6eer3u2qKhw5Rli4cAN6miC
    mpFsK8FzAOuGYiVePqwMfOWUCyf18SKLu7Ur9T6GZYv39m20eFavpE5GngeLcq3F3M01xC
    G6tFfq5w0kC4ssceXWw8FPOsyqeKcYFTj1ARm3BLHDSWWE9Ju45o0heOXrQA
X-ME-Proxy: <xmx:G7BYal2rGFcy4DHOndNfeLk7AwvuoII5QTvUqcukyQpPIUPYVsviVg>
    <xmx:G7BYapBCv3Id0AYplPFueqP1wETGLVyvcTx0sGfL4fdiKGiTd8a4Mg>
    <xmx:G7BYahjV5WJVLXceu1e17gYD0KaSKSpf0Lp8agNs9P7SjJwyW0Y9CQ>
    <xmx:G7BYarPZrQMETnOewvPashcKx6TdtRs2zDTJxvPJ9JHFk-R9kO-Zkw>
    <xmx:G7BYasFgdl2wylVhKFlYrqoj02Pp6u_GULSX4PFZGbZPTo36lJAFcwU0>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:19:05 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <8e4b8cbf93d5091df2fa3d652eaeb3793a2388b0.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 11/31] swim: Handle FIFO timeout error
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

When polling the FIFO for a mark byte in the sector header, don't
return zero if the timeout counter has expired, return an error code.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim_asm.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index 3d7a2d87595a..208622ac4aeb 100644
--- a/drivers/block/swim_asm.S
+++ b/drivers/block/swim_asm.S
@@ -79,7 +79,7 @@ wait_addr_mark_byte:
 
 	tstb	%a2@
 	dbmi	%d2, wait_addr_mark_byte
-	bpl	header_exit
+	bpl	signal_nonyb
 
 	moveb	%a3@, %d3
 	cmpb	%a0@+, %d3
@@ -136,7 +136,6 @@ crc1:	tstb	%a2@
 
 	tstb	%a3@(read_error - read_mark)
 
-header_exit:
 	moveq	#0, %d0
 	moveb	#0x18, %a3@(write_mode0 - read_mark)
 	rts
-- 
2.52.0

