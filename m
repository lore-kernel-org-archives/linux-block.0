Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A34325494;
	Mon, 17 Aug 2026 01:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931722; cv=none; b=uMFzJUgRv9S9KrJdkvgIOZx17ksMfpKPtN0cO3jCTJGbC95M9+nPbYhKX9nVR+5+1tXLcuyeb49Nsxq+tPmZVlky8WHQB/Ywv9kS2T+LDYU1D9Zenc4T0M9mAoJSqAlhw905jmbntIVTaEkzik+k5U2SyWA/eVTnarkjiBo5hI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931722; c=relaxed/simple;
	bh=aJKOZOWoXveCddxLIqL10UrkhvVmgi/l2ePVG1uejgU=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=RSX/fhd8q/sxlZIhAskSMCHcXS1MhzQySulsznjsteSMzaWEPHcbJrhl66RVDxQ7IH2fAl2NrmmFclvVpH9cOZ5sYp0lZkYZCWEN+76vJ1iyiD9Qb93kgnOOTIXSQzBkkACJwElH28YAv/cKWpP4avsc1VIoXbWYjYKj9R0oSCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hu5NZrEH; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hu5NZrEH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B84831400031;
	Sun, 16 Aug 2026 21:55:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 16 Aug 2026 21:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931716; x=
	1787018116; bh=xUoVj+IinLNg7uHC8by8czUyQwiMCVAzf8OSJGcKYhg=; b=h
	u5NZrEHRUdVkh6FxSz83zb2kb6WgXwaWgnFpbLrmuBVPh4iZdjn57pGn8Jf+UD+g
	LnliotZByGKPmlREzUoQLl099l5dCgl9aFeI0mHfkskQiFHkfWa7Y/sZ1AeKkRB9
	WXpkOPG14ZXg55oxhMIDg2GkzVk1sVA5p3U8khAEZk9JSy8/08BHm8IXKnSKRouv
	4ePCkNeHvNOpvk/wLSI+ZxIXPbNkuLsItqmHgJGmcIZMRDLH+pfkv6NGQnJvUMsa
	gAnpNHDFNswjlQLy8tDeH4m+7cn0T2FbEYGf9aqoiKjmq88nVKgNqHmUpFjVxWGI
	0E9//5Eh16RvdDon73S7A==
X-ME-Sender: <xms:BGqCasVkF09EG6gs4F2-PGArMi2rEflSLTqcnsMkPd6yXbjBCvRPCw>
    <xme:BGqCaoNB9eC12pFpmamQ4hYpDc0RbmDBFY9w38PvzYAK_1HxOoSGRqQZswE4nLfW9
    myHA82mqL4ikO8ykIGXhM5gUB_uBubfr9kn5UDxAqwWgEaZKTkZcwRK>
X-ME-Received: <xmr:BGqCauCRda6GJeVKsr7r02vIpmwtimypDR5cadOFKGPsdvT5r5_IomuHGoIxZukS_WrvPu76CddbS3ov_Y4f8B8yEMO7HJSx5Yg>
X-ME-Proxy-Cause: dmFkZTE4hc50xdhPXg/illULTp+C8DYFyqEdlu6WRFncsb6QnuuT/gcUnwV28CSittpzBY
    CanXMgLJ3D2f99+6fhcgPhKU62j4D/361qP39o0jreF8A1XJd9tbHbTT3THo+0Ngxn+KIR
    xmSykI00CRbwgNWRv8pmFJk9w9o4Guyae/9OdRSlW4+G/cXS4TLBuEOOa7VrQ1zx7uzt0k
    aiRQ8f78TROqGsNBFEeFBQ0S+1oq+UQzE0LFPz+xu5GHoHcx5q9+AQ38+8xzR6IOKHtWR9
    dd2Vu8AeIxRK7b1SVEdgm5fqxWGAl0hW++r8vV0P6QNaTx9jFo8LB1mZXd3D6ux6m/Q5E8
    uvWxtEZoMMZpY9HdayMAGqzvF1TB8jQUKNoq7nonerJPHLCssG+6cKFubfqrIQ+G5BM2DO
    kg0vMt7oUM8RSfRu0O9geTe23mDtykPQYBa8U134dxB4mXsvRwdi4yp9+JZe4egRihEyu9
    nTasSenVI0H5uFf4zL5NDqkc0TIICcNkXlZMWuBTZWRqVzTza80XAIiqv0hPYoTdXHSt2F
    Ml/d/u2iMIuOv7adwFj+rpE1yf3cJngh4thUTK2pN6YkrPvGEggDIFjV0uq71kUrBSntmC
    ITP4A0Uw/RHWj6U3n2leNNKCep7Emfe3JfU1eJqis+MuyoZ8nsd3VFNXujNA
X-ME-Proxy: <xmx:BGqCalcaKzc46xnX13oteSb_juvzkD0crUcKEzPfJQnZHFHESrUM9g>
    <xmx:BGqCatN-IWabhj_Sae2PrH7ef1bl30-1o3VF9D8IjMPDHkAoPEEljg>
    <xmx:BGqCalIg96D2ZFhKJEU7vLulY6psZte8PQnHvCmrH9O41qeXqyJkKw>
    <xmx:BGqCatJskljElfcOt42ywI4JSIHQK7M90oJcrsGFrFjw5I5cUEEWvA>
    <xmx:BGqCavk1pOFijNR2XgoOsMn4CykPP9jh50f4si77Woz9ECONk8Io6hDa>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:55:14 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <ac0d80ac0af32f69a5b0f06845de267d8459b361.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 06/32] swim: Configure parameter memory
Date: Mon, 17 Aug 2026 11:17:10 +1000
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

