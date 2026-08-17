Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930381A3029;
	Mon, 17 Aug 2026 01:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931782; cv=none; b=n7FuxMl1+pvFGPdNzlRLPNAmddRTJb/BEVG7uP4uVW9m2SSPXd3dFzJtFcKGoOeX2NqF+9Xwm4ep9OuLEz9L9n4+GW9bGSSXkWkxaGAu34O0QP+xW0Ibk9YRj7ynbGiG3tPdIIYBOdHHw6rZBLmXtghAG94XnED5UbGJ7YXWqNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931782; c=relaxed/simple;
	bh=44/ZRL7/HGCIU26qbYzj5CcYMEYWu9EnyTQimXNoBkM=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=ukh57gg6dk2bdWToWBiFB4cIfISJ0aJtFVwB1/yWdOM35Et4K7p4DXOvqdIqDXtYu9TuCmhQQTmrMdPIw4eHxwX+/Bo9uIPd8jm0cDvOrx1dtJZZ7Tc5KLhD7oa6L3Qe6XRoGNxaKPclPEZZt+hrSVjKTjb14N6kgMpxKshD2dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aVvTpbtt; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aVvTpbtt"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id ACDF7EC021C;
	Sun, 16 Aug 2026 21:56:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 16 Aug 2026 21:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931780; x=
	1787018180; bh=F7GzA5duFkcfyqTyz/fbHTzN443JBmphJA1KpCKAhLs=; b=a
	VvTpbttzdNprtxJoT8shrbwVaOvTuJkwXP2ELladn61nkKwOvtBHITzC2SdK1KOL
	aaI92wzQwQ/sGIiETv61iTxnvo4mUG0YvxCuyuSDXsBS+cFgTFqJI4EMZcrR40FR
	GjpMFzwWM0OcIKpqkzfz6Zgmdb+ykg7xIaREIiM5ks6WLF7scsuNxIScmkMNCeJO
	7tC5ureE/ecMUj3ALltW63M/RYrxum1uxnDk4Q4nZVaKzIH//X9xGYhkjR72QSL0
	F5utCvJcvmIRGLBsWla6kblxj8u6hR4t+2QXCv1bEuWx5C3RTZ3C9OjdkNNaQR8f
	jXUn1XgaNHQXyQ557d6Jw==
X-ME-Sender: <xms:RGqCaoZ-jw5Exa65vbXA1sqbl4jyTwCGL5buNywzzD9NcmveL7pzeg>
    <xme:RGqCateimkimYkbIknP-VJvwaK_-OKh45nD2ckn4jTatqVy0pE1G7Bn9PyOpg5gpx
    wXh6ZYNbhy_ZhrzEUEw12Nj6nzFOY3A-9mWrUpoCNlpJ4hEKgf1vM30>
X-ME-Received: <xmr:RGqCai3bMtyVI2BYRsPYsVmvRvQGgCMJPUWBYK5trWEgPrmXncpNh-YC3U-MTCzFvNvBNlkHla84qMgPQUM-gN-4opfoSPnbqoE>
X-ME-Proxy-Cause: dmFkZTEwVqJtQHEwNT59EY0ApYPfZBP0Ja94nLydKMHdJKlh4zUdbhZ4q8N1TJVlNLX3Jv
    UG9KBkDhcBzUW3289fayQ1J+ppWFRD446qIAFVyGuquh32EhwbVebEJGoODlbz4hP14Erq
    Tcjcfi9/5+2rPPMs1Rkxsj0k0e2xO2GH5lY4VVdKIG8VeU2vajU+FMxwg/fEJDgrz1L6RJ
    d1Tth/Mq5Cy68H4bxVP4faz7GKaqaQIynBu/2nSxBla0bgf41aEpoAjjJxWypL04u/vTxK
    x5WjWw0TaNT770B0rDvEjO+uKu7yRxr/X4qfgY6A9PKgCt1ahfj+WIbkeb4e64+QxwGFCY
    R2OU1mMru1mpl76eDy1f94zzxtqRH1tzCz6w9xRxOe/jkQrVlGcLQX6y7IpGjts393pJGz
    7GUxKutW3tbpk9DfU7XdZOj98btvooOyObXA/ToSXETdHjJs/B8E9ByklTprg6/PyCtsLQ
    4Uvobj/dF3+g4nbd7RZ+SdENtkYkhyZBR+rOig+0eOWajfoEne2JQpUDfMHVPqa0tfiJZ4
    viBOj0EtkB1H02uNzJ8QxNT04Q7/9v4GDCWhfNoLtN/IsjdputeKIUrIek2LIvTLy4BhJx
    ITvnMKdmd8oKENJtr5uRbovFkR1cxCC0VuU4leSSZst3itsuu8h9Bkh7/7Mg
X-ME-Proxy: <xmx:RGqCakK7dhSISISobuqj7O5-ZZAKRWuk_46FYw1BAk-oSQK1gRhYlA>
    <xmx:RGqCahHFL9MzKs5Oy-ZFiIAcQ35t8kWIJODWlF-tnEX3Mdi15Mez8A>
    <xmx:RGqCagVM-bSS7AUduxGdtDgcMr_Rw4fPoHscW6-Up5owF4jRlsSUVA>
    <xmx:RGqCapxqTJuXy_5Hb0vRSzACLf_Nsi3kz0ITs0T1PYheTtparcXM-Q>
    <xmx:RGqCauNR49EXmLBqySb3FLmCelWnLMS6ecM85STH5672gL_jdM_S5wNp>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:56:18 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <e0e0bc9e29713a62746c71ba2bafdf4c9a8b3c99.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 13/32] swim: Check for CRC errors
Date: Mon, 17 Aug 2026 11:17:10 +1000
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

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v1:
 - Load handshake register a second time because that's what MacOS does.
---
 drivers/block/swim_asm.S | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index 31fc63b074dc..533e3bf02fa9 100644
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
@@ -128,12 +130,16 @@ crc0:	tstb	%a2@
 
 	moveq	#max_retry, %d2
 
-crc1:	tstb	%a2@
+crc1:	moveb	%a2@, %d5
 	dbmi	%d2, crc1
 	bpl	signal_nonyb
 
 	moveb	%a3@, %a4@(o_crc1)
 
+	moveb	%a2@, %d5
+	andb	#.Lhr_crc_error, %d5
+	bne	signal_nonyb
+
 	tstb	%a3@(read_error - read_mark)
 
 	moveq	#0, %d0
@@ -212,17 +218,21 @@ data_crc0:
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
+	moveb	%a2@, %d5
+	andb	#.Lhr_crc_error, %d5
+	bne	data_exit
 
 	tstb	%a3@(read_error - read_mark)
 
-- 
2.52.0

