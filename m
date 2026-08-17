Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BE94B04AB;
	Mon, 17 Aug 2026 01:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931880; cv=none; b=jZWRgTcpbIgtfxaOPS4Eeftk/nRyv1/4hbL2BQHay6P8O/C+yT+vOcO2IDmln7oV8SxR2sbiekp91cNz84egb0okzwQ4iEee9V8UdjmIHvnJzPrjppotaX2FhGyDIzeu/JKZdgKvTUxrhoo7MTRobom/mHq/rjOft0ve1Bd+DY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931880; c=relaxed/simple;
	bh=dcg3iD/gt+2/vgZQlnLDpzysml77R8xvheYAw0NtM3A=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=do2se8++NNEouNv5NaKHW1CJVz1E8Z+WMj0MvvazXTBPUyO6K5PYOCIcAimPtJTqyysbEjiBaceYpnhRgnhoEEhf1Ji9tj7pYy5hBGuAs6hAAAAnzsQSGBwgM5w/27l5rh9NNnR2bmPNnVlZ31pdcBwPDAu2MX43n7dbAeZ5Fow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JJCaTeY6; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JJCaTeY6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE947140007C;
	Sun, 16 Aug 2026 21:57:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 16 Aug 2026 21:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931878; x=
	1787018278; bh=piO4sKeFDiSymjcTWTcDPAGYkgwt0JPmd8ouLvlS69o=; b=J
	JCaTeY6O2qvlFg9+jAdMFMsbMUF2GlM5REPfq1hvq2ZpXxqFafjYrSUjGNsGTfVR
	uBvdDK1fu5JwHFY3Ib3beQehmIFK75RT25xq+IhmMUAraIyh1Di0LP/u3dDeFZYj
	aFy/nOkzKOpsl+rnT8X93ZnOcJlkh0ykCaG/G+bqMpbblaYxeTKCys6D0ggEVkyv
	RGnT3j4zXurOCyqvw6wqdWgW9gqvC/PqEEd7r2x+rH7ZTr9oh/wXbmNN/bDpo10U
	Dmky7UEdpC3Dc+UOr8NxtEW55EdU7KBAwagdzu430DMkfCqW5Hys6pbOHCP+RVo8
	XwFgRLO0ttaYKQepLysBw==
X-ME-Sender: <xms:pmqCarj-eKRSOygOdUuXN-md87t9zS8_uBGoyqQmPwwjLCv9K_9Vtw>
    <xme:pmqCaiEkS3AGtuHtx1_5qMXt-4Bm-ETXBros_ScO2w-JfN1nrRhJHvFRCJPaOX8L-
    jmDNZgroBwYvdhBQmF7Aqw4XP0O2WJB2rD9Zsk7iNH9QdmwvCePcSw>
X-ME-Received: <xmr:pmqCaq9jurL3FQypPxrvak60_OKYk5p5I8gT7-3vnlWzF2788-gvC2c8AqVUw4SUFiroQFmeu_PoGl9Q2gvX1TZBWO9W2fP_KrM>
X-ME-Proxy-Cause: dmFkZTEwVqJtQHEwNT59EY0ApYPfZBP0Ja94nLydKMHdJKlh4zUdbhZ4q8N1TJVlNLX3Jv
    UG9KBkDhcBzUW3289fayQ1J+ppWFRD446qIAFVyGuquh32EhwbVebEJGoODlbz4hP14Erq
    Tcjcfi9/5+2rPPMs1Rkxsj0k0e2xO2GH5lY4VVdKIG8VeU2vajU+FMxwg/fEJDgrz1L6RJ
    d1Tth/Mq5Cy68H4bxVP4faz7GKaqaQIynBu/2nSxBla0bgf41aEpoAjjJxWypL04u/vTxK
    x5WjWw0TaNT770B0rDvEjO+uKu7yRxr/X4qfgY6A9PKgCt1ahfj+WIbkeb4e64+QxwGFlH
    Rowr8rfLosiD3NnFBEg1Ru3PCr44RkW31KWsVl1QD+waiaEuJK+eFWka+r6KcC+3jZ/K36
    RmMC+JhCWP4fF6IeqSd65BZmHNBsKVur5g+hzM5nY/9TqnKxTHZl18RPVDlIkBUCqUpCwZ
    kV3u2t8rUoMSeqvkGPrXGZsHzqImSNQM78hBEcbAC804mijjhT+4ujPOASMQmMav6UV4F2
    cZWG2768elp3c5FzRlO/KLG3/88C2uC8iedvu3Iun/9zYLWbSPiXeTrNmS48z4crrV6WTp
    6kUt2crzVhyvFii+od5zvhkkHPs3dDMUwlwlh0IFoIE/BPJG2UPz1gS7RAEQ
X-ME-Proxy: <xmx:pmqCapymqMTCGAmW5VmXhe2gTiupNQv_whqagJQtvyXNdFzBdXOpig>
    <xmx:pmqCamPW27Rmzo_ld8R0XvY5N7XYFMSDU0Rrs3x8e4OuzsOXSx_iZg>
    <xmx:pmqCau9XZHYW23KEMmSUA5YZz6FptR20yYBSYoqRAk0giv8yIeh7fg>
    <xmx:pmqCaj65TArnNMH1K_ZxF1Q7V8Zm7v1BFR2tl4GrIyvrItJHKiu_dg>
    <xmx:pmqCakR3LKhPb9UlpGiqMkXYyedFWI1J2JfUF9TRDsghuC30JnYSf6iS>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:57:55 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <d395b4ee6b491943c9c53919dbe8f4c4c97ca406.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 23/32] swim: Don't needlessly re-read sectors
Date: Mon, 17 Aug 2026 11:17:10 +1000
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
in a full rotation between sectors (which is a 3 ms wait).

Floppy drivers usually implement a track cache that can be filled in a
single rotation to solve problems like these. But I think there is a
simpler solution.

After stepping the heads, use a sector bitmap to record sectors that were
successfully read from the present track. Read (or retry, if need be)
requested sectors in whatever sequence they become available. Keep
interrupts disabled until the whole track has passed under the read head.

swim_read_sector() assumes that it can search a whole track by reading a
fixed number of sector headers (essentially, fs->secpertrack) but this
assumes no false sector headers are found in the sector contents. To
prevent that, call swim_read_sector_data() unconditionally after a valid
sector header is found.

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
---
 drivers/block/swim.c     | 96 ++++++++++++++++++++++------------------
 drivers/block/swim_asm.S | 12 ++++-
 2 files changed, 62 insertions(+), 46 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 38b1643f3702..e35918bdf9d2 100644
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
 
@@ -452,68 +452,76 @@ static int floppy_eject(struct floppy_state *fs)
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
+	for (i = 0; i < 5 * fs->secpertrack; i++) {
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
+		if (n_ok != n)
+			return BLK_STS_IOERR;
+
+		buffer += 512 * n;
+		sectors_nb -= n;
+		req_sector += n;
 	}
 
 	return 0;
diff --git a/drivers/block/swim_asm.S b/drivers/block/swim_asm.S
index 9a7d7466e846..10f4c42ee3ab 100644
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

