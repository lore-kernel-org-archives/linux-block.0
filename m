Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C0A3FFFB5;
	Thu, 16 Jul 2026 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197269; cv=none; b=hXmuicpy/4PYJmUhIG+Xj9nR7I88XvpLtra2BUxW+UaHwETjCBn5kePdrh7Bon7Ka/Cwd8SHcIMl+fipYyOdsDKNaxSDNtzqVKwjDNlDVOr0mxPe9kWbzX0cH/IomVl5ce4uOkFi5oHrSs01BriZfJ8dc4Nq8Yuq2yfWdr2iUsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197269; c=relaxed/simple;
	bh=xfjRc7uZHqGGkrV+4rQM/46pKoDJBnA3Xrk2IFx8mgA=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=dbKGLlNowo7QtpdRwWJyCni2r6OrRFJDvRFdyttZJEmIjzR/Lmb1nshlVLV/XK5yxYhHy5Sq/BKh5kXlCIH9HB/Bn89HF0SBSo/T3rKkBqUdixL2GwrbFM5nzAx8/7f3ZqUbDF1n6t/2Dy1IV3OLkjkJQbDI78ocBV7EE/nDUGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MXRgbKmT; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MXRgbKmT"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 4BB6FEC01A3;
	Thu, 16 Jul 2026 06:21:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jul 2026 06:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197267; x=
	1784283667; bh=KBZb2FNbwsNJnGYhwKC1YhMoYJLkvcqUjOKlXzwZa+o=; b=M
	XRgbKmTJfiEYPuNj22J+pQf56LwSu3U4FolrAHqD5oYX2MGY+bS8KtimduXYaIGN
	J/skdZluYIFu7/NWdICB0/Hox2ZRK7DVvgQFZhefkzNW5rcUodIW47x6rIYVGYI0
	i1isarYdAOQL229wbBjXaupebnGId7RHKTcWgbrTdT6CgPrpSTrt+RMmeGCl615/
	96m5a0/d7/UkKEFpGChWObC+QVDhiiq+yaI4T2XwN3uBGlXtNN+meyJzLmC/jUi8
	E+aKjaQOWkJZloXJ65NWJL9aVG42fwavvfKkoyD7a6GJJneHMo3zIFapzak5e2Ai
	bSMBNsVkkuEcAuVG9XPCg==
X-ME-Sender: <xms:k7BYart4kipxk2G7_77Ls0TnoDNBIH1PKcxUfYFSOeO151tFwiB9SA>
    <xme:k7BYamjJhoFPem-luEVmFQjuqlaUuELXp0urs5Mu7wKiBIlsEeIx5kVyu6_wqGaK3
    PijoI9lJdtYRSFtLlJ9w7QSYxu8RuU71M97_pLbgax4FrjY9ZDQDZQ>
X-ME-Received: <xmr:k7BYauqMEY_85O3Ff4WwMVWrh0UF53iBki1CNsDA4YQqGXbbQCQYUj-vCiaPJUupcIqdyFH-eWPhBprcF4XR3IBlRz9lrmLsAm8>
X-ME-Proxy-Cause: dmFkZTGGGewHkjpARU5mNGplDlBlY7p1odKmymFrbaV8Q3+bQsnQg5xAUvXrrFQLL3CMBN
    9OSeY8TluGCuzgV+6h5sHMBhm4tUYGi/0KgjlrhR0aTheYnJ2w9fc0FJjykw30cCwVzUFL
    VGxlKRb4ZAcUJiaZQDcagjySXR0/ef0ba8eFQaLtttRWf9QsrK03r3YkHui/deCxQth/F+
    L64jeKVJRY1u0e8lxhds+DWKKAvmh18CB8YPb28fqoWrUOliAkLNFtF3+XFb6ws0WJx78w
    nPtgmyMFrfwQ7SNoPNjar/gw4XUxnklUoqg+oB4Zx6dZBtlIjsZ3+1UWIFq+f7P2FdyPoo
    9CmLQ6XzmlVGkdC9Aun5nc07FHvO9zB2chwQfIG1cvcEjR0h550uRFmwSB+1tvNT8ZYtyd
    809Rp0TYyvclWF+ywgSjNUqapI1Zxd2mC6nRkWVQpghG5BUG9qnuBMAMxWfJDxBcb1QkWc
    94qt8TS68+BVvL1rsRcCbv7laxebDdxtiKwkadrACz0WFMfjtCrZjYFS3dEDX/tsq+DTtl
    q+7EjXkF8G7FFVMRTsLvquvotrKPqdd9ijds/T0dEF3D44bJgLqRWPydXi0x4SiRtFxf6o
    uQemSPjTA66Blv8Wtj1z0RyyBi8Ww3uqyCQK4C5M8uX4Kce15BTewFYqR15g
X-ME-Proxy: <xmx:k7BYars2NBESqQyC1sxvCg-lf2UT_7W8UOLaGpUStuTVcBBHup94RA>
    <xmx:k7BYapYNWG5r_yrQ2n528V6dHmzqLsVCVZ4q4--Vfs2smaJnaIVfaQ>
    <xmx:k7BYaqaq4yZZrdzOkKjm01B5iqiVRKcSbxh5BdTs3-7sa7_uZWSAGQ>
    <xmx:k7BYailbh4dFnS4eFR5fvaI_hUf8lZc8YCIfFeVUo9dU-swNNHi7zw>
    <xmx:k7BYaieXrQNGxpkAE6YoFsD4oLYK-Qf58oNmZffd2c_YmQlH_lJStHr9>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:21:05 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <740e314f4ff30796afa466c6a3d8cfa42e9b1af8.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 23/31] swim: Don't needlessly re-read sectors
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

floppy_read_sectors() is confusing because variable names seem to conflate
tracks and cylinders. Rename the track variable, eliminate a division
operation and adopt suitable integer types.

For readahead to work effectively, small sequential reads should not
require waiting for spindle rotation. Unfortunately, the present algorithm
is very inefficient and does a lot of unnecessary waiting.

E.g. if the device is asked to read sectors 1 thru 18, and if sector 9
happens to be under the heads, the driver will proceed to read sectors 9
thru 18, but discard the results, while it waits for sector 1 to arrive.

If sector 1 couldn't be read on the first attempt, and needs a retry, the
driver will proceed to read sectors 2 thru 18, but discard the results,
while it waits for sector 1 to come around again.

In between reading sector 1 and sector 2, the driver needlessly calls
swim_track() and swim_head() again. But what's worse is that, on a 68030
system, re-enabling interrupts after each sector read can result in a full
rotation between sectors (that is a 3 ms wait).

Floppy drivers often implement a track cache, that can be filled in a
single rotation, to solve problems like these. But I think this solution
is much simpler.

For each request, use a sector bitmap to keep a record of sectors read
successfully. Read or retry, as necessary, the requested sectors in
whatever sequence they arrive in. Keep interrupts disabled until the
whole track has passed under the read head.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 91 +++++++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 39 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 0bab7ed3daa8..dae401e649d7 100644
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
 
@@ -455,68 +455,81 @@ static int floppy_eject(struct floppy_state *fs)
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
+	int i, bits = 0;
 
-	swim_track(fs, track);
-	swim_head(base, side);
+	for (i = 0; i < 18; i++) { /* A track has at most 18 sectors */
+		if (i >= count)
+			break;
+		bits |= BIT(i);
+	}
 
 	local_irq_save(flags);
 	for (i = 0; i < 36; i++) {
+		if (bits == 0) /* All count sectors were read ok */
+			break;
+
 		if (swim_read_sector_header(base, &header) ||
 		    swim_read(base, error) || header.track != track ||
 		    header.side != side || header.size != 2)
 			continue;
-		if (header.sector == sector) {
-			/* found */
 
-			ret = swim_read_sector_data(base, buffer);
-			if (swim_read(base, error))
-				ret = -EIO;
-			break;
+		if (header.sector >= start && header.sector < start + count) {
+			unsigned int offset = header.sector - start;
+			int ret;
+
+			if ((bits & BIT(offset)) == 0)
+				continue; /* This sector was already read ok */
+
+			ret = swim_read_sector_data(base, buffer + 512 * offset);
+			if (ret == 512 && swim_read(base, error) == 0)
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
+	unsigned int failures = 0;
 
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
+		unsigned int cyl, x, head, sector, n, ret;
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
+		ret = swim_read_sector_range(fs, head, cyl, sector + 1, n, buffer);
+		if (ret != n)
+			++failures;
+		if (failures >= 5)
+			return BLK_STS_IOERR;
+
+		buffer += 512 * ret;
+		sectors_nb -= ret;
+		req_sector += ret;
 	}
 
 	return 0;
-- 
2.52.0

