Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE181A683A;
	Mon, 17 Aug 2026 01:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931764; cv=none; b=nH9vl0B4IEZ6B6ywFJYADGJPZ3n6/OhM4gdM2UvFGQUvhtMAlk8mCr2SoX6hXNHGCqOXi78+Wr0TTKfG9iYms4wwhzXMuQU4yMg7Rr9RwklW2Ep4M3bINxIKiXzTKtT/GO1M4OVhxqU3/LIwiDGKtOAvyQfc6LlhpENl1+MCgEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931764; c=relaxed/simple;
	bh=nJY7w7cEh+7c64BYyL0LKpy2zDQj/yRgCMwLxC8ocPY=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=G/s06AHS6rlA+sTvOVDeE4Mybz3cj4OTQIhk2QAO/EwbaFmHy3onXULt+yJfXXorimQ+0PSEsV4eNr3q+VKxA9DbsuhgW0exQV0oj3oqazGcRsGd/xRqJaearwa3Z3tBD5aviwhgcTY2pxuzsFgZjWnbbO3fbpLPzjgfCeS1mTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mPfE/3uK; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mPfE/3uK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 681941400031;
	Sun, 16 Aug 2026 21:56:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 21:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931762; x=
	1787018162; bh=C0D7P8G6hTvt2FE5SH/vyr6jLBpriqH6H04iEj3x/3Y=; b=m
	PfE/3uK6SPRJn5iEend28lghiBAtoaA+UtWOjMDu9LxAsTbHkkGA8DeQ0dgcjOgf
	2bqMnWyu/yEAk53SonwJaWAKq2aJNRwvHYxGvLvNdCxAcNTyhDmXt7CMysikVbmg
	t79ex910osHnPwUlVdFE1xubwwT+wWhSIRzx9aEFteMt0MJ1i3FCecLB4Y056DMq
	Xcov7UyK1umECRm/lido+y7nmS7Ioh8sqQNGy6IVnZfba4WaE8U9gZZlxQU5k/F+
	o5DIV5joqDr4Pq89CsqSMh/chb0q2wC9nlGrdzd5s8CgaaYKKBcaRaMYBvERPmm9
	FDdMjMV9M+SQLSOwM440Q==
X-ME-Sender: <xms:MmqCanxadYTH0nPbx1uIThJTufZ4GbzAytuFexS9lIcOhFO5xybnIQ>
    <xme:MmqCapVO4Blb3nhnbhINC3u016ovfYn4mFtcEkgCakJyksLaIWdl0-SVkuzQfOvL0
    UEXpXVcUOMGy2gtTAUkk_0yOEloYDMI58OeqHEMs1HLsjbK8sNMxokN>
X-ME-Received: <xmr:MmqCahOvUaavQs4e6cwKFTiDrPQsUyhfgyBc1kte3KNNjpPB18RY4-u__i8dnCQ1PY2MiPZhHI-PhIjjdZ9Y2PdZ9_Rd4495kTw>
X-ME-Proxy-Cause: dmFkZTE1zBPzp57EvI2WKCa7xOaCPMCOsnXZwbAcoEmj89wsUSdGt4GdBKxObmiMx5fcBp
    oypA2ZnWqmNfQHyLmgxVrQMcSmueK9FdyVbmzq7gcarPcOKIILF6wzhnATo24VW++U4bpr
    H/QRyZHAzEFnt2ybb1uKoVu70f7UxZRvsSsh3NqJpyFBtN9ZF+RelgIUc1c09+DZsY84pi
    EI1TKCZbprgJbTC2I6+Tci8LWUg14CgVvKLIKZgqG1lXgt7dQKZ4oclWRDyn7xEZQn1FVL
    lHur/i8a25kfG09je15e0Arc8jCgfeXyJqv4H+/huMUpP2k1jpTXuNoi3NegLnN4iF7ypZ
    pi2DFaF5FS5iOoYoM7rq/ms0yxnRVMNUpX4YF6ekyQ6ZrxoOUfHlZFru41YSd8dfx/iRqL
    3aFNH29LfPK14Lj6qiJ+cgTN86xsvlIwNHZqawzQVM9GG7Ixe2XQFg7yiFSBcS0rh9B7XM
    ZMhlT+YV7MzzATHBWLo6qKIR76qiAJJHRMo10ZKMOfjjCiQQ2+7b6nvN187Cr1gluqV2FE
    KExQrGxOFbHjhoFpnoV5DJud9c5b20d4Nuanvy3cAMhloHJh1qbEXTW9HqPNJ3U+g1Sm3/
    B9gUo0rt6FCIYSJcDecKDGLm3XADVD4+MzAWX072SStw2lzYLwoi/rT52A1g
X-ME-Proxy: <xmx:MmqCajCY_6HJismubI0fyJqNWydD1485DVVZ9dCivSY3GUVvfnoRjw>
    <xmx:MmqCameqWxzjwRhB8DZZxInwIQPKj64JOqAia79KkgQN3W9e-KMZaQ>
    <xmx:MmqCaqM1_Uu2xI2GoISFq9Cg2Ob_gM0xUWT9ouGG6m63TmYQokxO9w>
    <xmx:MmqCauLWgs0W6QQisXTM1mHw_UOZWKw404MM50zD_VlWXxkrLc_VxA>
    <xmx:MmqCak9KECbKaQkbVKu-zNz2sGBcwwLe74yissC60rbXauXpR9PqO4SR>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:56:00 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <36bdb4dea76a9277765149755ea3a6ee23f96873.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 11/32] swim: Handle FIFO timeout error
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

When polling the FIFO for a mark byte in the sector header, don't
return zero if the timeout counter has expired, return an error code.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
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

