Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EFF43F8CD;
	Fri,  4 Sep 2026 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514346; cv=none; b=H/S9VQ3XSPHnydlbOccO+m5LrTTyLzXJ6M8UYnFguO8y5MXWTmBewYvt+Dweyny3AaVkKQWuns+0aVo/fLPx3OHw0rNxzk+jQ9ub1R1sqDCvx96rUTd+5V6M64IWiKPgQoRji4G52g0V1rHnNpVq4U54pqcy+SIZ1lsPbNRjds4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514346; c=relaxed/simple;
	bh=aJKOZOWoXveCddxLIqL10UrkhvVmgi/l2ePVG1uejgU=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=qu+11Bqdpb3+eU2rpj3pArU0Y5zLeed/K64zJaBusx/mjBK19IG3TSw8Nbk2hYISboZt9w4bpEw94a3KjPnhbpY9gKycCZ9hPojtXxNWVBmyFcmqgBNAbe3/0sNgCLl4ivZAvbktP8WrizIy3Ovfm/7sTOudcC1K7gqVUIJejwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GZYHYAhH; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GZYHYAhH"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EFC6314000B4;
	Fri,  4 Sep 2026 05:32:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 04 Sep 2026 05:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514341; x=
	1788600741; bh=xUoVj+IinLNg7uHC8by8czUyQwiMCVAzf8OSJGcKYhg=; b=G
	ZYHYAhHDC8p4OxMdQ0NKfgwmmO4Kl2XZRcDUg52pDIBey7QJtQy/c/tNtKYCz1C3
	WzLEnvlOVX6StRJHrE8IYM8a72Xkomi723UOCwy6qf4KcWeyn/MJuUJWEgTTcXOl
	N31ed+x6nQ5KrtpWy0ZAV2OpQ9RAYGRUfIc+6n+t6AGgshgadBEmDFWfJOndbA/8
	4JnmrTdozmdJskbPtYKI1JX3lqptg+CiYVtKcDkVUL/QZddtNKx5jG0e60V9kCE/
	EpxhU2ccb37PeUn+1n7k9t2d9KkGVSpkyk5xMcYY2A0Uh8/Ttf8ABhed7facsUmN
	rMD8h96kvOi6YJVJioVLw==
X-ME-Sender: <xms:JZCaanmHMfNKJf7z6CofLtcBUCVrljsK_kDUVepo-oaTa4-1V2y6XQ>
    <xme:JZCaaifAM1H8L8GEeybj1EAC8zZDOB0Hsj2pY2CkNdxec19-PbqAT4CIzhdW46uMR
    DRl5qdcougL1yKeArFZ5BGR0RbcHkQj45leg7YGGQzyDrXRQF5jAakP>
X-ME-Received: <xmr:JZCaarTVCJZAGOBbhROqOL5ek0SgX9IVCzI8WSXxkgD4V_NCfBPdU8ByVPY9_x3OS-56Kb1Y3SFfZ-VYKHk2kFxmWskPnK9iVHo>
X-ME-Proxy-Cause: dmFkZTF3auZDjEg8eBmaXoTiNUJDm36RpkU4OxNFVDzQbhXoFzPOd3Tywmiq9TcLhKbpyz
    RtcGsroltMWANqUKCBzA6jAZ/q6gwveBRqnbifBxBFmnUcKWRgTVt+8JgUfvW63RYwPFMX
    rQCMFgYat6SS5wSRSSuueIm+gtTMdXWEQ9JvjvwnVdqT7PvvrwtNrG6ptAh1E18JsFlUOU
    FY+OqaHaH+nKcgRcnMziwPz9yDlE96QQVIMo7+0M2GINxA5LefOsEBPICH+QVll4DUoBax
    jPX+GU5ty42mRSGbQYM10LF3CaX+omFSKyOeAaAbIoNGHhwVd91Wfn6+YFLGNdELAmbsIU
    A9TP8/dgcF08MrLpN/3dACip6RO+sUxAGYHlyZ2c3nR5yccEz0GuyuYb0+wnPr8B5J9Qmt
    +Qt8BAgncoIzqGZeMnx1CcwmI+S60/CycgwKJLT3Y38kzF1xWuFJAXYkh19/fv4mmkjPz2
    S4rQmv1r0rrzShVHfdQnCCZBiBYmOcs23/cW4H7JmjwAgqeGPC+SKzjtcS4/1bPGJFrqCS
    YIZb9Dt7sqKRfg84ASPahSem1rrGjlwe3KCL4xdOOzJC9eD0b+t4tBaB2hiXu5CW3Rl3LO
    Dx+pZs7XRPwi2vyvr0deNFsMXVksw6Xr1vimcbrtnttJM5P+AducejVr1OWw
X-ME-Proxy: <xmx:JZCaaptzP3_xasZU-6UlH4xlFUlQVXeyjZJpfgjbxH0-T9ueLnnj7g>
    <xmx:JZCaaseYrqGwHCKdoGGNod9GQ_bYFf_vYTChlX8SjuHkPJXC4EexYQ>
    <xmx:JZCaajZlTEahnnxYu1Xz5uicEz6U-NqpT68dqjsJN_-KS2h05RdWpQ>
    <xmx:JZCaauaZ9ZPFQpcNQucxdvV-Jxj80aYytb-G-Py7bWh3pM137GOW_A>
    <xmx:JZCaarPBxj6KXOJWJOqEvrdtEXwV3NfGfmajwUnMCDU5CF11aR0rDpGx>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:32:20 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <eccb76911fd255330b05eb3174ac15c29bb41a23.1788513996.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 06/33] swim: Configure parameter memory
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The original SWIM chip has a 16 byte memory to store parameters which
control read/write timing. The SWIM 2 chip retains the last 4 parameters
which control write pre-compensation, but omits the first 12. Hence
SWIM 2 can perform reads without any parameter memory setup but SWIM 1
cannot.

Configure the SWIM parameter memory with the appropriate values so that
SWIM 1 can read too. The parameters used here were observed in SWIM chip
memory, using Macsbug, while MacOS was reading from an MFM floppy disk.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 190b2e1b5b0e..c2d7ad3f065c 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -796,6 +796,17 @@ static void swim_cleanup_floppy_disk(struct floppy_state *fs)
 	blk_mq_free_tag_set(&fs->tag_set);
 }
 
+static void swim_set_parameters(struct swim __iomem *base)
+{
+	unsigned int i;
+	static const u8 mem[] = { 0x18, 0x41, 0x2e, 0x2e, 0x18, 0x18, 0x1b, 0x1b,
+				  0x2f, 0x2f, 0x19, 0x19, 0x97, 0x1b, 0x57, 0x3b, };
+
+	swim_write(base, mode0, 0); /* reset parameter memory index */
+	for (i = 0; i < 16; ++i)
+		swim_write(base, parameter, mem[i]);
+}
+
 static int swim_floppy_init(struct swim_priv *swd)
 {
 	struct queue_limits lim = {
@@ -805,6 +816,8 @@ static int swim_floppy_init(struct swim_priv *swd)
 	int drive;
 	struct swim __iomem *base = swd->base;
 
+	swim_set_parameters(base);
+
 	/* scan floppy drives */
 
 	swim_drive(base, INTERNAL_DRIVE);
-- 
2.52.0

