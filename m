Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AE5442B06;
	Fri,  4 Sep 2026 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514416; cv=none; b=o1ZkY8hM87ePK8vuSp7nU9ayA9uup1Caq9Gkj6EAGsPOT7M/RQUXmSQFolPlGM8MLvEY4Gd13gBnBn1qKSKWoJmnSLfWbasd+NKPMzCXT7dA8Id3tFMsy0jWmf1H1sGP6N0sFs1SxUgbl93lTGao64VjfvTnVYQX2B2833Llm9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514416; c=relaxed/simple;
	bh=ei4bAlhk/mvOZzmuTTqI+R6yphimZOyPyFnV8JFrLLs=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=YUuGlZrZ7TxgW3LUF8v5unrBuOu0yF2kPSjt6IYdFmNqWzqNyFMsQQHd6AJyOykOkjWT+5LUtDuFFjDvEhsqZkd6GpyReamUuZKkHXf1avnrP8yzQRp0xkn88MokIX4GxLW9xdRKQUHTR8GiBZdJbKn/tOY+x1FIIdvhDAuoqVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RWhItfEs; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RWhItfEs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E908EC00A7;
	Fri,  4 Sep 2026 05:33:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 04 Sep 2026 05:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514414; x=
	1788600814; bh=JeP79JHs0w/YH5LKkBWHZdiQJUzezgc3yjKNX3Xjfbg=; b=R
	WhItfEs4MDOZV+5dmr6dVorOjnD/Ni7OrHBEJHpY5tTzrNxmqsEkzptAaHcfnHqa
	vm/5vUNUk6Dtlq0icwsIWpFyVB5xEmLGEuju//9o6amMjEHduSBrdGYJLjJ/VROT
	MQTHmUa7hE+KmPnW0p3XJ/fuuMtcbsi4tZ8KiIzhI7mGeeg+bDF8O+eM6aoJJ/YK
	XQ5TCVss/wjsqSkKPHmhMb5YKf9J1PDF8waFCU0I+x1H+kyCdUye1JtH0kLVZiy9
	BU7c7kqjKkPwN9OrBlzyVp8rUNL6Di1cZDKZ4aU01F/qBr+DGIjuJO2TxVxSnDbd
	NErSxZGZhUybzp1g00wHg==
X-ME-Sender: <xms:bpCaamoBi8-iQ9bIuBgZFRAUbsnQoxZjuF-7AHfaN8QLl9E6IYe3Ww>
    <xme:bpCaaus1es3oQJLfCqckc1P_AgjK1wYFNxj9OsYwZgyG6p6hEJMDCXnL3cUu-EZqh
    utSvGAfkZ7lY5Gns7CG28LhC7mEg8SQAdS2UphLjs1tYg6vmQNrXiwV>
X-ME-Received: <xmr:bpCaarFy-DvFaZBOD6EEQyXYzCbat4NC-y0ndL1hBUMD3CJMB2qKxW-fF2_OrADPcivElS69MvU5iCvWpNWbvwCSyrWezU7hSgE>
X-ME-Proxy-Cause: dmFkZTE/Rtk6l3I9tqvKoBpTJTveLUphHYcAK1aitBUQpDNIkosRB8EZMISuuCMYAipC6D
    +/RTzVL2d8a+m6Bc5TLrlQP47Nx+3FOLDvdMZZODUHaNQCGx6Jl+5UqsvedKuq/7/WUY04
    OmEz+pLiYAf9GcyLmpfzp0aVKrXxd+9inPzR5hoQc0Z3i9dss0KA+I7vBV2rZxbdxVflTp
    xLONIFohUrs/qTWq43lfJzhGtby2UyWXImtl6Q7ZHyI+A0TXzowQGCvI570zM+3ljALuqE
    7N56HcamhyVJ6EIMvw6h3IZoA3f+em6U6oCLhwkvVheXLFnUHBZ2gdnuYSSZDXmPlOumn1
    sw2w2YvRVIUBiZALeGC9znY5TFqZUtfl8y8+H5WHy2VkuqXi4n77/1lApc+Xv6jhaC1Y2q
    FDEdB5Beu00sx+/sYZhvkAokwOwV7T8/LQ9UPv6AkRnCLenPEF+dboTfMdAzupqXN/t/XJ
    NYmlIu1OhmR8FXX+tzQgMQDmw03htAHiOxtsCWje1r3atth2rKfwPDzYc4X+RX6/pFA1LP
    RJOAErthwRAXYdHy3XEI1dlORYHzt1OWq4QGS6Pk7ZUewEpCVeL0dlGis5mqyrSfnlqVbW
    1duUoTtTUFzwaWg4WLY9zOBhyVAWimYHFf2YWiJNRB4Xwc4d+l4WvgC5sVLA
X-ME-Proxy: <xmx:bpCaanbWaIfbMytGn8VEC1Nd84_Y8mVaI2ETxJuXRQpwUXhnNN2xkg>
    <xmx:bpCaajUSpnSMt0H-yi7wxEHXNYApYVLzpqJb95I0L5T8dvBOKCS-WQ>
    <xmx:bpCaall81hLBwaE7Q_INFTWvY9DxlhNOnavRNrjMcw3VCn63y6-lUw>
    <xmx:bpCaamB2VbHQLH57qf819A07gA-Q1Xm4gRZRJUg6uFeiiApGrhTEsA>
    <xmx:bpCaajYBDG99qEbg04gAN8fVlmVfdHteKHXPQyS5RndM17ZMrhj-rzUB>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:33:32 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <9bfcd0414192d1b95803c16701d62732ff6e8f3f.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 14/33] swim: Check for CRC errors
Date: Fri, 04 Sep 2026 19:26:36 +1000
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
Changed since v1:
 - Load handshake register a second time because that's what MacOS does.

Changed since v2:
 - Tidied up some hasty changes which appeared in v2.
 - Dropped reviewed-by tag due to unreviewed changes made since v1.
---
 drivers/block/swim_asm.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index 31fc63b074dc..81c824923336 100644
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
@@ -134,6 +136,10 @@ crc1:	tstb	%a2@
 
 	moveb	%a3@, %a4@(o_crc1)
 
+	moveb	%a2@, %d5
+	andb	#.Lhr_crc_error, %d5
+	bne	signal_nonyb
+
 	tstb	%a3@(read_error - read_mark)
 
 	moveq	#0, %d0
@@ -224,6 +230,10 @@ data_crc1:
 
 	moveb	%a3@, %d5
 
+	moveb	%a2@, %d5
+	andb	#.Lhr_crc_error, %d5
+	bne	data_exit
+
 	tstb	%a3@(read_error - read_mark)
 
 	/* return number of bytes read */
-- 
2.52.0

