Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B45F440652;
	Fri,  4 Sep 2026 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514425; cv=none; b=tV7HbyaH5AScF8VC2SQzaYC/ST3KzShI4OxK7WKnLqZ+kjlASS0q0JEqOK4FBcixDezaguLtqijgL0ra+t/4u092+WN8lrOn5zjScBGi+v+HrZ5iw76N6ovr+pWfkq/CmM0p+2PArEjX0oTzLG0Jd3BD0k4AX+KqIGDfefWziJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514425; c=relaxed/simple;
	bh=4OYXX5SpESInibJI4MeslwBwhiXx63rU2H5QhopBD3s=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=sjJGB0oJHABORB9wk6MSX4YyKg3JWA8a4XELO7907cKZPfymOeGhNTzEcDpE9/b+MFozy/68BQHXGOJhZf5istHPLWPoAQhh/4uFfT6Rl7iX/7tGuP3ZXhwFRAj6d7VBiO6yx4YmxOVGZdPmuwnsGhWVX0GvyfdiRGo5wbK2aJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uMslS3Jm; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uMslS3Jm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 74A4EEC00CE;
	Fri,  4 Sep 2026 05:33:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 04 Sep 2026 05:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514423; x=
	1788600823; bh=QCHuIWCvGbUQzvcn6gYtNQdR8/7gekyyFIaPN78HB6k=; b=u
	MslS3JmouF5curpkNaW9Uo0pM5P/a4zHfsn+i2OWLxvtI7Rdi1R7nZywXAmqbizo
	Uks55TUgRxocndsrjK7j5DSdaEwyuKmJdBXUNB7gyO3hfJR66/kZInD2bpGe1AIT
	QwBG9rsOVxigrsBZmkt8LtCzcvpK0cK4CSq7+gaEJp4mriXTEaVQy+MuWpO2ReAK
	0NcRLQ7lGe6vrLpncqjYSUFy30Jea1xbcGj7J0cRhBLuGmzwX3OJFqXRebExfo06
	nrbw+j9VsEERjpDl8rCMPsWcEJYfqd2mLm9VV1j3FHA5RHZ2BrV5y0aNAUeltkg1
	1nZQY+Z7QgEXxdeRNDuAg==
X-ME-Sender: <xms:d5CaanIZAMDMyzu47KHE_jKG8ph9EbSK-go8BYSu01tJrnDtrrXqDg>
    <xme:d5CaalOhTHoWySIRfDJGHOMmREF5rtsSRV_PREkbEeVdZFYLzurhCB9ifNkaBR4St
    SglNYUxDYZ1Cp3JlL04Dlny9mYk4hDvePcMX0UDq8yZkBabVytFNW-g>
X-ME-Received: <xmr:d5Caavmd7xHADN3YQdas96x-LlVDFQkwfaN0bWrE1hk361vSmY3lQ5zwXDIH8V6h8iHNuzBqOpUpZOoClsYxWRN08GBArUCuhOg>
X-ME-Proxy-Cause: dmFkZTEe+0K1AexRW5VKg6Igspc49h8df5hxyd+FQ2UxEzuyTDi2ZhdiSThGiBIwkdDgU9
    3rC08hmhwBNxNoNuM+ycNNv31fkYVLn6pBr27tqKRLQMq1NV3DFc39Iqyivnkegn2UfxIv
    roQdqcH3VVXGJWlrRZqsrGKoS9rmBFYj7GFxW36+XXMnxcw5HiNtvMvRco3OYXN6UY/K0t
    SqGzE69/GT65xt5VU7CUtrbe1RJV9Of5WXGGzQneXN7Ylc6viWLtf2PMOfqRj9Ut2W6+Hz
    DfFSoa/BAnz3IHwFnQcu4acvCfz7MIdPrcCNMUsADy4T129cFo7Yojs7dtan6e38DtGhKx
    CHMxqjHvqVZbseXgody3wEkNfLA89naeRQlGa1Fwb7m0EJxWAr7ePz89Nuf/5R87ByIVEY
    fn6Mh2o20T+KO+isw/ciZ2vfYHuGKoa5qz7KXa138cMst88dUwq1OiX6USyI2LGzihGfN/
    POxpesFjYQuCZYBiYiJz1ntmSnJn1MgdW6JTtM36ESYvk6SymsUwL4+WKU//KTFn79Dt/V
    CcVdi4KHw6+tERB7wtlJ/3Q026blZmqUhbpqWluXyRgx+iJlVBNt5KvJobXAwblTRwa+lc
    xKEd9JbVIj5nYgNykldGpULGlaHax7rG+W1HCKTlzvfzWBcbrFl8ooEaEcdA
X-ME-Proxy: <xmx:d5Caah706AjzIQgn7TAz6HSfUuLhVDtiucX096iJyJprEbyfmm0KCQ>
    <xmx:d5Caar2it7kmF0rRIGYiXlgA1OiWd6c-dc5QTvuU8GdtxRe6o2J7Lw>
    <xmx:d5CaakE2i3BHWrm2S-Gecw3G5PB-o8nJduERwZsVz-AqeN7WISK1rQ>
    <xmx:d5CaaigOL4jyXHEXIwNPZf3EZ30qrBJGGjCJOpwq6DSo5sxC3Ex5UQ>
    <xmx:d5Caas27ics0iuVOADae-RIJbornsOdCNlx8PjpN1wIMbciY8YFiHoyK>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:33:41 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <efabd807f4ecf5cbc05b60e91ed69aa4c10691a8.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 15/33] swim: Check error register during sector read
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Clear the error register only once before a sector read operation. Don't
clear it afterwards -- the caller needs it. Check the error register in
swim_read_sector() and return the appropriate error when necessary. Fully
validate the sector header. Don't terminate the search loop early just
because an erroneous sector header showed up.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c     | 13 +++++++------
 drivers/block/swim_asm.S |  8 --------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index cf5470cfd775..53a54a96feef 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -483,20 +483,21 @@ static inline int swim_read_sector(struct floppy_state *fs,
 
 	local_irq_save(flags);
 	for (i = 0; i < 36; i++) {
-		ret = swim_read_sector_header(base, &header);
-		if (!ret && (header.sector == sector)) {
+		if (swim_read_sector_header(base, &header) ||
+		    swim_read(base, error) || header.track != track ||
+		    header.side != side || header.size != 2)
+			continue;
+		if (header.sector == sector) {
 			/* found */
 
 			ret = swim_read_sector_data(base, buffer);
+			if (swim_read(base, error))
+				ret = -EIO;
 			break;
 		}
 	}
 	local_irq_restore(flags);
 
-	if ((header.side != side)  || (header.track != track) ||
-	     (header.sector != sector))
-		return 0;
-
 	return ret;
 }
 
diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index 81c824923336..fcf574ced85e 100644
--- a/drivers/block/swim_asm.S
+++ b/drivers/block/swim_asm.S
@@ -67,7 +67,6 @@ mfm_read_addrmark:
 	movew	#seek_time, %d2
 
 wait_header_init:
-	tstb	%a3@(read_error - read_mark)
 	moveb	#0x18, %a3@(write_mode0 - read_mark)
 	moveb	#0x01, %a3@(write_mode1 - read_mark)
 	moveb	#0x01, %a3@(write_mode0 - read_mark)
@@ -140,8 +139,6 @@ crc1:	tstb	%a2@
 	andb	#.Lhr_crc_error, %d5
 	bne	signal_nonyb
 
-	tstb	%a3@(read_error - read_mark)
-
 	moveq	#0, %d0
 signal_nonyb:
 	moveb	#0x18, %a3@(write_mode0 - read_mark)
@@ -166,7 +163,6 @@ mfm_read_data:
 	movew	#seek_time, %d2
 
 wait_data_init:
-	tstb	%a3@(read_error - read_mark)
 	moveb	#0x18, %a3@(write_mode0 - read_mark)
 	moveb	#0x01, %a3@(write_mode1 - read_mark)
 	moveb	#0x01, %a3@(write_mode0 - read_mark)
@@ -191,8 +187,6 @@ wait_data_mark_byte:
 
 	/* read data */
 
-	tstb	%a3@(read_error - read_mark)
-
 	movel	#sector_size-1, %d4		/* sector size */
 read_new_data:
 	movew	#max_retry, %d2
@@ -234,8 +228,6 @@ data_crc1:
 	andb	#.Lhr_crc_error, %d5
 	bne	data_exit
 
-	tstb	%a3@(read_error - read_mark)
-
 	/* return number of bytes read */
 
 	movel	#sector_size, %d0
-- 
2.52.0

