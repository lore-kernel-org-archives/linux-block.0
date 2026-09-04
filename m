Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068434457B7;
	Fri,  4 Sep 2026 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514525; cv=none; b=nG+/zo6HDI0JlX7r6pBjFxuxWgEGo2lJxxDEhDZYzin/RLtZGy6gBR0AS3XhwEhSbasjTVlo4LoVX0KS4aB8UokqDB6b3k5Zv8fYN9WXeoASMNos6BXUV+FneQy3ZVe7n8QAD2xki6r9Y89e940i5iTcampHhHQj4sR2UJLSmb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514525; c=relaxed/simple;
	bh=QtlXqpEs40Gx0zhBD5P+C6OV/WvfbVGFK8YipoEWUF8=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=tYFSRLqDMh3pr2tx/CcYPiYjz/wqJlxtbWUxGpyl17MIRUwO0wr4YV3kvfRVYie/4T+DK37h4NOlTR+VH2R2P9j/CO/hJ+aHzOtvPSCBYYQFMU47yeq7Le8ptkupkRWOeAFV5WMQBw17HJgjV/aKW53sqGyLmCCIL/91hjpF1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sgw/oVb+; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sgw/oVb+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0D85CEC0195;
	Fri,  4 Sep 2026 05:35:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 04 Sep 2026 05:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514522; x=
	1788600922; bh=pzf8Qzh6OOrpTQYpzT3PZyzI8Y2lS32XCjDQuYjY91g=; b=s
	gw/oVb+BxkeH5/pOMrYTWH59TCLgRprhIrc1ML5ndgyuH6b5O1OZB4dg0V3P22Cv
	kGgTnUFKEOOOivhuM2vtsTp5xRpe8mjPO4R7Dtv8nqV2q9zIksXn1ky2BAkOUYgq
	pdvFdAR3mF3E4K9VJ/CKcCmthPjLT0RT4013O41t7vqD2+5MmsPGCpAnvjO9Wpe0
	6UBjvk0szugAFQecXHE7gXwN0nXgvmH8rhgHSFUgEiboUeY2SVrfecQTXhlU6KF/
	/NxPCuPjTwpsfS+Xee7Fa0IdlcRfhoPhChHvXa5R3DwvmFgI7H8BCiL3X7uDW2Ra
	v6G4oll6GQ9q/MQAn5dZQ==
X-ME-Sender: <xms:2pCaakAMNO06ibZ-ij-MY2f3sBq3L3m5-gh1E3692m2Exk9gycUlHQ>
    <xme:2pCaagkXeN-efniu1nlHky9Vxr9hon6gq0Jya5SLzO6FBg83m1H9nJFgfPITQ9HbU
    6Ok5vpq-XVvCaBWsjqvCWmY84JYSR--xq0B6Bw97IaSv7tcQrFCyoMuxA>
X-ME-Received: <xmr:2pCaandA-ohChSEwfLJIHZay83JJta1Xvcdv_I4Zf78t6Pp4gN26gsptqB0UUM45iGaGw15-esA_yhqiu9U5IZm5U8OXqV_tqJc>
X-ME-Proxy-Cause: dmFkZTES4bQ21oAzpNnp51xfFHSMQBPKtrMCV5iYYMBFJYMMGuku2wDZqHLDhf7MMkpQep
    sMe4CyNnIEY4dUJg6qGIApiDz7xq7NkSCScmKgrMc4345BLDBaaFf6c8TLqowSoQSjBNao
    tQAjHxJbuqzVv3VzZRZEacp4FA41Q9OcL5NDtbJMFMDUCcPGJR7zU6OainbhxZYK3NU11B
    Fa2x5PyGrJHtwPQxOc1oyHJXrbM2nyqpGGOSM3yceNTB7ODw+A07JKEQZT40T9t1sfxdOY
    Z+GEWRwgrC3pQuxmclLHPwxPnQJ8sX9Nh9G6tEyIm0Ldv+rMccWy5ZFRy0U8vBhf8uuzM2
    iqBHWc+uytA7yiE1aAPvhIklNaTpbrN3BHuGDYwqSHmKcQUFLc/ziuR1j+H0sqYFu4Z51D
    ljbU2otf1srST9dKXyFd4AvNPQhxvClcyImBUY5evKMEzeJGY9hAXAh1QcH+Boq3vwe+Ei
    R/fTk++tfq8IuZWhQ66OdTTI7IiqYyvgJ543t7fti3IXZQva4fZqemxlcJ/0YeHlSPKINy
    PnKQxi5eW9LGlWMpHTEgtM9DGXWU0os4hIePnEWVHpwbXBOJ0njEpLIZtOysNiUgFmusET
    zFyJ+E6IcUnLeq1DVp+OVxPVXcj5GOxXIxx//PgofvBW9m3uNYQiVT2M795A
X-ME-Proxy: <xmx:2pCaasRXlVY4NwIREuU9z7zYYTEzgGEK1SVu7JH1oq_MkNGhk_GbSA>
    <xmx:2pCaams0rX7jaIVWu7HIqx33PsD-6CTf89b8LBUv5_ExhPp0512V8A>
    <xmx:2pCaaleRZB5ghEHIJkMWoTMbc7vOKcENNPQ9P7_e1laEqBxasw4LBg>
    <xmx:2pCaaoaa2OHvFgsrm_FSsvmGgMfxIgUUZ39c37kwUBZBBJHZlQVtTg>
    <xmx:2pCaasxZcDR6Hzkeblc65qV1POdMMJAn3qNefB7V9G6_-S02tqhiXWk9>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:35:20 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <dc4c1944edecb6778534b7b5535e6b6dd8d852ae.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 24/33] swim: Don't needlessly re-read sectors
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

floppy_read_sectors() is confusing because the `track' variable seems to
conflate tracks and cylinders. Rename this variable, eliminate a division
operation and adopt suitable integer types.

For readahead to work effectively, small sequential reads should not
require waiting for spindle rotation. Unfortunately, the present algorithm
is very inefficient and does a lot of unnecessary waiting.

E.g. if the device is asked to read sectors 1 thru 16, and if sector 9
happens to be under the heads, the driver will proceed to read sectors 9
thru 18, but discard the results, while it waits for sector 1 to arrive.

If sector 1 couldn't be read on the first attempt and needs a retry, the
driver will proceed to read sectors 2 thru 18, but discard the results,
while it waits for sector 1 to come around again.

In between reading sector 1 and sector 2, the driver needlessly calls
swim_track() and swim_head() again. But what's worse is re-enabling
interrupts after each sector, because on a 68030 system this can result
in a full rotation between sectors (which would be a 200 ms wait).

Floppy drivers usually implement a track cache that can be filled in a
single rotation to solve such problems. But I think there is a simpler
solution.

After stepping the heads, use a sector bitmap to record sectors that were
successfully read from the present track. Read (or retry, if need be) the
requested sectors in whatever sequence they become available. Keep
interrupts disabled until the whole track has passed under the read head.

swim_read_sector() assumes that it can search a whole track by reading a
fixed number of sector headers (essentially, fs->secpertrack) but this
assumes no false sector headers are matched in the sector contents. To
prevent that, call swim_read_sector_data() unconditionally after any
valid sector header is matched.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v1:
 - Use GENMASK() macro.
 - Use fs->secpertrack instead of hard-coding the high-density value.
 - Don't use a failure counter.
 - Use unsigned integers where appropriate.
 - Call swim_read_sector_data() whenever swim_read_sector_header() is
   successful. A NULL pointer is passed to indicate that no data is to be
   copied into the buffer.

Changed since v2:
 - Loop for fs->secpertrack + 1 iterations because the gap search will
   match the index gap as well as every sector gap.
 - Reinstate the failure counter because that way interrupts aren't
   disabled for too long when a medium error is encountered.
 - Improved commit log text.
---
 drivers/block/swim.c     | 99 ++++++++++++++++++++++------------------
 drivers/block/swim_asm.S | 12 ++++-
 2 files changed, 65 insertions(+), 46 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 9bfda4b07ba9..637810d86e37 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -180,9 +180,9 @@ struct floppy_state {
 	enum media_type	 type;
 	int		 write_protected;
 
-	int		 total_secs;
-	int		 secpercyl;
-	int		 secpertrack;
+	unsigned int	 total_secs;
+	unsigned int	 secpercyl;
+	unsigned int	 secpertrack;
 
 	/* in-use information */
 
@@ -452,68 +452,79 @@ static int floppy_eject(struct floppy_state *fs)
 	return 0;
 }
 
-static inline int swim_read_sector(struct floppy_state *fs,
-				   int side, int track,
-				   int sector, unsigned char *buffer)
+static unsigned int swim_read_sector_range(struct floppy_state *fs,
+					unsigned int side, unsigned int track,
+					unsigned int start, unsigned int count,
+					unsigned char *buffer)
 {
 	struct swim __iomem *base = fs->swd->base;
 	unsigned long flags;
 	struct sector_header header;
-	int ret = -1;
-	short i;
+	unsigned int i, bits = 0;
 
-	swim_track(fs, track);
-	swim_head(base, side);
+	if (count > 0) {
+		count = min(count, fs->secpertrack);
+		bits = GENMASK(count - 1, 0);
+	}
 
 	local_irq_save(flags);
-	for (i = 0; i < 36; i++) {
-		if (swim_read_sector_header(base, &header) ||
-		    swim_read(base, error) || header.track != track ||
-		    header.side != side || header.size != 2)
-			continue;
-		if (header.sector == sector) {
-			/* found */
-
-			ret = swim_read_sector_data(base, buffer);
-			if (swim_read(base, error))
-				ret = -EIO;
+	for (i = 0; i < fs->secpertrack + 1; i++) {
+		if (bits == 0) /* All sectors were read ok */
 			break;
+
+		if (swim_read_sector_header(base, &header) == 0 &&
+		    swim_read(base, error) == 0) {
+			unsigned int offset = header.sector - start;
+			unsigned char *buf = NULL;
+			int len;
+
+			if (header.track == track && header.side == side &&
+			    header.size == 2 && header.sector >= start &&
+			    header.sector < start + count &&
+			    (bits & BIT(offset)))
+				buf = buffer + 512 * offset;
+			len = swim_read_sector_data(base, buf);
+			if (swim_read(base, error) == 0 && buf && len == 512)
+				bits &= ~BIT(offset);
 		}
 	}
 	local_irq_restore(flags);
 
-	return ret;
+	return bits ? ffs(bits) - 1 : count; /* No. of contiguous ok sectors */
 }
 
 static blk_status_t floppy_read_sectors(struct floppy_state *fs,
-			       int req_sector, int sectors_nb,
-			       unsigned char *buffer)
+					unsigned int req_sector,
+					unsigned int sectors_nb,
+					unsigned char *buffer)
 {
 	struct swim __iomem *base = fs->swd->base;
-	int ret;
-	int side, track, sector;
-	int i, try;
-
+	unsigned int try = 0;
 
 	swim_drive(base, fs->location);
 	swim_READY_timeout(base);
 
-	for (i = req_sector; i < req_sector + sectors_nb; i++) {
-		int x;
-		track = i / fs->secpercyl;
-		x = i % fs->secpercyl;
-		side = x / fs->secpertrack;
-		sector = x % fs->secpertrack + 1;
-
-		try = 5;
-		do {
-			ret = swim_read_sector(fs, side, track, sector,
-						buffer);
-			if (try-- == 0)
-				return BLK_STS_IOERR;
-		} while (ret != 512);
-
-		buffer += ret;
+	while (sectors_nb) {
+		unsigned int cyl, x, head, sector, n, n_ok;
+
+		cyl = req_sector / fs->secpercyl;
+		x = req_sector % fs->secpercyl;
+		head = (x >= fs->secpertrack) ? 1 : 0;
+		sector = x % fs->secpertrack;
+		n = min(sectors_nb, fs->secpertrack - sector);
+
+		swim_track(fs, cyl);
+		swim_head(base, head);
+
+		n_ok = swim_read_sector_range(fs, head, cyl, sector + 1, n, buffer);
+		if (n_ok == n)
+			try = 0;
+		else if (++try >= 5)
+			return BLK_STS_IOERR;
+
+		buffer += 512 * n_ok;
+		sectors_nb -= n_ok;
+		req_sector += n_ok;
 	}
 
 	return 0;
diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index e06aadb411a1..73d5ced1abe3 100644
--- a/drivers/block/swim_asm.S
+++ b/drivers/block/swim_asm.S
@@ -198,12 +198,14 @@ read_data_loop:
 	dbne	%d2, read_data_loop
 	beq	data_exit
 	moveq	#max_retry, %d2
-	moveb	%a5@, %a4@+
+	moveb	%a5@, %d3
+	bsr	.Lmaybe_store
 	dbra	%d4, 1f
 	bra	data_crc0
 1:	andb	#.Lhr_fifo_2bytes, %d5
 	beq	read_data_loop
-	moveb	%a5@, %a4@+
+	moveb	%a5@, %d3
+	bsr	.Lmaybe_store
 	dbra	%d4, read_data_loop
 
 	/* read CRC */
@@ -240,3 +242,9 @@ data_crc1:
 data_exit:
 	moveb	#0x18, %a3@(write_mode0 - read_mark)
 	rts
+
+.Lmaybe_store:
+	tstl	%a4
+	beq	9f
+	moveb	%d3, %a4@+
+9:	rts
-- 
2.52.0

