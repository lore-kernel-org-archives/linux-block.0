Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7F1409617;
	Thu, 16 Jul 2026 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197072; cv=none; b=n8r1MjebCp9i0xim2uou5g8hsMVLT4SP+yYxGM1nPLWm7VdkDiyorCwaXvlP6ZOyC1xbINqcz4yAlBKcHM4Vv9cdLt8evJnC8yGZoVG5D/X5YyN5fUFchGPd7AgV4d6xbtOox3mM8AEEjaFRBhK5MF64F36WJVp15BJMioQcC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197072; c=relaxed/simple;
	bh=+ED9bGLfCj2ULtCGDcF/Qybj9F9+KT03hRNUfjn4Cp8=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=KJIwQkq+RPP0uED7jd/cKapo4ZGXf1I5qtg8Tm/cmcvi8YjeGEL/OoY2PI1hPh+IeBviySLprFZSjekCO7CdTSpz3OU47cHlvrjrgsVHJ7nWDtJMFZFIq56ZPEYa0wZk/gbgNYWJopLw9b13HZq2dYorhokBm9w4933gfeW+6UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GJNNxpqV; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GJNNxpqV"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5467E1400037;
	Thu, 16 Jul 2026 06:17:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 06:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197065; x=
	1784283465; bh=V4ERdnqRHxj1IlTmBQQDKdDKxCAXp+z+RvXlcdWK8+E=; b=G
	JNNxpqVA9POjDac6Tv9XTyW4g95A9WBzin3JpbaX9531fViiar+GUKWqoo36se0i
	6kCwLZcQszrEQ7TtvPcF5DTIGNNLCaX6HhKeqinyJXDP5bThJcu8PFu8aWKUsifP
	WcxKeS/9g8QBNRUmW8svPWLsZVz90zwioZ+2Wpepefp8y4wqM6y3iJX+0cc+ffL+
	rLTi2F+MfUQBDj4eBAnBBo8gF55YnQd63F1bEYU6cEWAJ68NgBqHgIaCqrsks84P
	bdulewMVHEYIuzM30jirOSHYKwUY1M7RqygFEr8wXAYDpQX2Hv9ZUnE/Tqr1Tnv8
	tkDM+l9yaKzkzh4hRkorA==
X-ME-Sender: <xms:ya9YalaNuPOpf7wPkGVCrR_n-8lLou-tefddcyS3xPbRKfvHJqKhgA>
    <xme:ya9YamfRJMaf-yO2dwNdpPCWS-4mGFn6CY3WpY4U6EoVe0w061LcPkKV2rwj1tfcV
    LkKzHWLQMsXjMYxOuf0duv1qPPJrJqOkhpTp34XfbaTeo71WdEuPJEr>
X-ME-Received: <xmr:ya9Yan0OnkLmjqmzIzbwaECNQ1SsGLeNxgYu5MUy6FjTLCFQYJxmXj-wwfkK6LV89NdZNw49VBhDkUc233FDVTncnx7kTe9yZU0>
X-ME-Proxy-Cause: dmFkZTGb3GsDg4I/pRE/TpDC71guVZdXuK2M9TvbBMaiwkUPRRJjvuUrSYrpkSmPBKBcBs
    5bhxnz415ZQxte+o8pIlUuGgQFF9qxxMqg6s6Zn2OXWFYr+Q+bNOFIrOn2e4640fogHZ5n
    Fo+7YAFsP8GbOhqjewRYmA0Lo9wYJN4qisfSs4lX+NnfUXjEBw2owCKPtCiVuC4WUeVNiZ
    C4miJZvZyO51/J+/mwA/b4tcc2M6AouyiB34rtb/sBXdiuGw+XUvPBJn3dWO6XSRkA4z5C
    +1SYX7/d+Zd2+/QDjR1ncIBkEZDzNTDwKeI/4OiZy/mubN4/DMnpJZiT1cU/O/9pckhcTQ
    vNWXhCI0VM5p5aaml0jGMFut2v5qLT+4ERLSNndaiKwzqrfJIGPZPiAMFTgvAgGwu4FRD+
    udccZz545jlFYo5qpe0sPubKR1Qx7PMQDRv/wusQPhDsKF57I+G6IQetxv1O23ZJUpRlAt
    0sScUOXqN5IHxkoU/J9CXGrRLy4ivvxYLEpaMZwKJHzSBCJCndiGWBlZ2t/nPDk9YwfPbl
    Suf99/3AN33ebYcf7ZnYMr6y9nS3H08NbC9vvFAIxSpvaxpPWUYA3L78z6F9MOm7vChsFT
    YDqTA749rUN378x9lQTSzGZBz520SqrhTas3kzxL39JD/jyBLfNqoQyyA15w
X-ME-Proxy: <xmx:ya9YalJ09a3MkcvVEyn4lUUI03cR6GOLGpvLOM6ksFkpkyEk3R_k6w>
    <xmx:ya9YauHwKIN8RocWZ7fBDYAxMdCNLK8GsZmY8cAkGep-AK6VyOc0NA>
    <xmx:ya9YapXTLUPiVSZsLEHAI_i5sIiWd2JXnKmcaGFFqzzjcLZ7BaiLTg>
    <xmx:ya9YauyCNTLOMdfX4MpsKy5LK3qWp7YEA4T9zEmqBQaj4XzjZX1LmA>
    <xmx:ya9YaqIQ1XowSRmi6Xg0lILJ-ESSFgtDNqqeck054b6rLdaTlmgc_qAA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:17:42 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <899351f6515677eb6323d11ac2a84346924b2fb4.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 03/31] swim: Enable the drive when probing
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

According to the ISM spec, the MOTON bit "causes the Enable 1 and Enable 2
signals to be turned on to the drive." It doesn't actually turn on the
motor. When selecting a drive, enable MOTON. Disable it upon eject or
release. This fixes detection of the Sony FDHD drive.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 2c52a210f4a6..2a400e544959 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -154,8 +154,9 @@ struct iwm {
 /*----------------------------------------------------------------------------*/
 
 enum drive_location {
-	INTERNAL_DRIVE = 0x02,
-	EXTERNAL_DRIVE = 0x04,
+	NO_DRIVE = 0,
+	INTERNAL_DRIVE = BIT(1),
+	EXTERNAL_DRIVE = BIT(2),
 };
 
 enum media_type {
@@ -311,9 +312,15 @@ static inline void swim_drive(struct swim __iomem *base,
 	if (location == INTERNAL_DRIVE) {
 		swim_write(base, mode0, EXTERNAL_DRIVE); /* clear drive 1 bit */
 		swim_write(base, mode1, INTERNAL_DRIVE); /* set drive 0 bit */
+		swim_write(base, mode1, MOTON);
 	} else if (location == EXTERNAL_DRIVE) {
 		swim_write(base, mode0, INTERNAL_DRIVE); /* clear drive 0 bit */
 		swim_write(base, mode1, EXTERNAL_DRIVE); /* set drive 1 bit */
+		swim_write(base, mode1, MOTON);
+	} else {
+		swim_write(base, mode0, INTERNAL_DRIVE);
+		swim_write(base, mode0, EXTERNAL_DRIVE);
+		swim_write(base, mode0, MOTON);
 	}
 }
 
@@ -447,6 +454,7 @@ static int floppy_eject(struct floppy_state *fs)
 	swim_drive(base, fs->location);
 	swim_motor(base, OFF);
 	swim_eject(base);
+	swim_drive(base, NO_DRIVE);
 
 	fs->disk_in = 0;
 	fs->ejected = 1;
@@ -652,8 +660,10 @@ static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 	else if (fs->ref_count > 0)
 		--fs->ref_count;
 
-	if (fs->ref_count == 0)
+	if (fs->ref_count == 0) {
 		swim_motor(base, OFF);
+		swim_drive(base, NO_DRIVE);
+	}
 	return err;
 }
 
@@ -682,6 +692,7 @@ static void floppy_release(struct gendisk *disk)
 	if (fs->ref_count == 0) {
 		swim_drive(base, fs->location);
 		swim_motor(base, OFF);
+		swim_drive(base, NO_DRIVE);
 	}
 	mutex_unlock(&swim_mutex);
 }
@@ -804,6 +815,7 @@ static int swim_floppy_init(struct swim_priv *swd)
 	if (swim_readbit(base, DRIVE_PRESENT) &&
 	    !swim_readbit(base, ONEMEG_DRIVE))
 		swim_add_floppy(swd, EXTERNAL_DRIVE);
+	swim_drive(base, NO_DRIVE);
 
 	/* register floppy drives */
 
-- 
2.52.0

