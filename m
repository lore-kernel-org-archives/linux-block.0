Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AEEC38BFF
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 21:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091F822525
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 21:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgBXVlH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:41:07 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31498 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbgBXVlE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 16:41:04 -0500
X-Greylist: delayed 986 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 16:40:39 EST
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01OLO5ND008700;
        Mon, 24 Feb 2020 22:24:05 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 09/10] floppy: cleanup: expand the R/W / format command macros
Date:   Mon, 24 Feb 2020 22:23:51 +0100
Message-Id: <20200224212352.8640-10-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20200224212352.8640-1-w@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Various macros were used to access raw_cmd for R/W or format commands
without making it obvious that raw_cmd->cmd[] was used. Let's expand
the macros to make this more obvious.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 drivers/block/floppy.c | 194 +++++++++++++++++++++++++------------------------
 1 file changed, 98 insertions(+), 96 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index d771579..0d53335 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -309,23 +309,23 @@ static bool initialized;
 #define PH_HEAD(floppy, head) (((((floppy)->stretch & 2) >> 1) ^ head) << 2)
 #define STRETCH(floppy)	((floppy)->stretch & FD_STRETCH)
 
-/* read/write */
-#define COMMAND		(raw_cmd->cmd[0])
-#define DR_SELECT	(raw_cmd->cmd[1])
-#define TRACK		(raw_cmd->cmd[2])
-#define HEAD		(raw_cmd->cmd[3])
-#define SECTOR		(raw_cmd->cmd[4])
-#define SIZECODE	(raw_cmd->cmd[5])
-#define SECT_PER_TRACK	(raw_cmd->cmd[6])
-#define GAP		(raw_cmd->cmd[7])
-#define SIZECODE2	(raw_cmd->cmd[8])
+/* read/write commands */
+#define COMMAND			0
+#define DR_SELECT		1
+#define TRACK			2
+#define HEAD			3
+#define SECTOR			4
+#define SIZECODE		5
+#define SECT_PER_TRACK		6
+#define GAP			7
+#define SIZECODE2		8
 #define NR_RW 9
 
-/* format */
-#define F_SIZECODE	(raw_cmd->cmd[2])
-#define F_SECT_PER_TRACK (raw_cmd->cmd[3])
-#define F_GAP		(raw_cmd->cmd[4])
-#define F_FILL		(raw_cmd->cmd[5])
+/* format commands */
+#define F_SIZECODE		2
+#define F_SECT_PER_TRACK	3
+#define F_GAP			4
+#define F_FILL			5
 #define NR_F 6
 
 /*
@@ -2124,28 +2124,28 @@ static void setup_format_params(int track)
 			  FD_RAW_NEED_DISK | FD_RAW_NEED_SEEK);
 	raw_cmd->rate = _floppy->rate & 0x43;
 	raw_cmd->cmd_count = NR_F;
-	COMMAND = FM_MODE(_floppy, FD_FORMAT);
-	DR_SELECT = UNIT(current_drive) + PH_HEAD(_floppy, format_req.head);
-	F_SIZECODE = FD_SIZECODE(_floppy);
-	F_SECT_PER_TRACK = _floppy->sect << 2 >> F_SIZECODE;
-	F_GAP = _floppy->fmt_gap;
-	F_FILL = FD_FILL_BYTE;
+	raw_cmd->cmd[COMMAND] = FM_MODE(_floppy, FD_FORMAT);
+	raw_cmd->cmd[DR_SELECT] = UNIT(current_drive) + PH_HEAD(_floppy, format_req.head);
+	raw_cmd->cmd[F_SIZECODE] = FD_SIZECODE(_floppy);
+	raw_cmd->cmd[F_SECT_PER_TRACK] = _floppy->sect << 2 >> raw_cmd->cmd[F_SIZECODE];
+	raw_cmd->cmd[F_GAP] = _floppy->fmt_gap;
+	raw_cmd->cmd[F_FILL] = FD_FILL_BYTE;
 
 	raw_cmd->kernel_data = floppy_track_buffer;
-	raw_cmd->length = 4 * F_SECT_PER_TRACK;
+	raw_cmd->length = 4 * raw_cmd->cmd[F_SECT_PER_TRACK];
 
-	if (!F_SECT_PER_TRACK)
+	if (!raw_cmd->cmd[F_SECT_PER_TRACK])
 		return;
 
 	/* allow for about 30ms for data transport per track */
-	head_shift = (F_SECT_PER_TRACK + 5) / 6;
+	head_shift = (raw_cmd->cmd[F_SECT_PER_TRACK] + 5) / 6;
 
 	/* a ``cylinder'' is two tracks plus a little stepping time */
 	track_shift = 2 * head_shift + 3;
 
 	/* position of logical sector 1 on this track */
 	n = (track_shift * format_req.track + head_shift * format_req.head)
-	    % F_SECT_PER_TRACK;
+	    % raw_cmd->cmd[F_SECT_PER_TRACK];
 
 	/* determine interleave */
 	il = 1;
@@ -2153,27 +2153,27 @@ static void setup_format_params(int track)
 		il++;
 
 	/* initialize field */
-	for (count = 0; count < F_SECT_PER_TRACK; ++count) {
+	for (count = 0; count < raw_cmd->cmd[F_SECT_PER_TRACK]; ++count) {
 		here[count].track = format_req.track;
 		here[count].head = format_req.head;
 		here[count].sect = 0;
-		here[count].size = F_SIZECODE;
+		here[count].size = raw_cmd->cmd[F_SIZECODE];
 	}
 	/* place logical sectors */
-	for (count = 1; count <= F_SECT_PER_TRACK; ++count) {
+	for (count = 1; count <= raw_cmd->cmd[F_SECT_PER_TRACK]; ++count) {
 		here[n].sect = count;
-		n = (n + il) % F_SECT_PER_TRACK;
+		n = (n + il) % raw_cmd->cmd[F_SECT_PER_TRACK];
 		if (here[n].sect) {	/* sector busy, find next free sector */
 			++n;
-			if (n >= F_SECT_PER_TRACK) {
-				n -= F_SECT_PER_TRACK;
+			if (n >= raw_cmd->cmd[F_SECT_PER_TRACK]) {
+				n -= raw_cmd->cmd[F_SECT_PER_TRACK];
 				while (here[n].sect)
 					++n;
 			}
 		}
 	}
 	if (_floppy->stretch & FD_SECTBASEMASK) {
-		for (count = 0; count < F_SECT_PER_TRACK; count++)
+		for (count = 0; count < raw_cmd->cmd[F_SECT_PER_TRACK]; count++)
 			here[count].sect += FD_SECTBASE(_floppy) - 1;
 	}
 }
@@ -2303,32 +2303,32 @@ static void rw_interrupt(void)
 		drive_state[current_drive].first_read_date = jiffies;
 
 	nr_sectors = 0;
-	ssize = DIV_ROUND_UP(1 << SIZECODE, 4);
+	ssize = DIV_ROUND_UP(1 << raw_cmd->cmd[SIZECODE], 4);
 
 	if (ST1 & ST1_EOC)
 		eoc = 1;
 	else
 		eoc = 0;
 
-	if (COMMAND & 0x80)
+	if (raw_cmd->cmd[COMMAND] & 0x80)
 		heads = 2;
 	else
 		heads = 1;
 
-	nr_sectors = (((R_TRACK - TRACK) * heads +
-		       R_HEAD - HEAD) * SECT_PER_TRACK +
-		      R_SECTOR - SECTOR + eoc) << SIZECODE >> 2;
+	nr_sectors = (((R_TRACK - raw_cmd->cmd[TRACK]) * heads +
+		       R_HEAD - raw_cmd->cmd[HEAD]) * raw_cmd->cmd[SECT_PER_TRACK] +
+		      R_SECTOR - raw_cmd->cmd[SECTOR] + eoc) << raw_cmd->cmd[SIZECODE] >> 2;
 
 	if (nr_sectors / ssize >
 	    DIV_ROUND_UP(in_sector_offset + current_count_sectors, ssize)) {
 		DPRINT("long rw: %x instead of %lx\n",
 		       nr_sectors, current_count_sectors);
-		pr_info("rs=%d s=%d\n", R_SECTOR, SECTOR);
-		pr_info("rh=%d h=%d\n", R_HEAD, HEAD);
-		pr_info("rt=%d t=%d\n", R_TRACK, TRACK);
+		pr_info("rs=%d s=%d\n", R_SECTOR, raw_cmd->cmd[SECTOR]);
+		pr_info("rh=%d h=%d\n", R_HEAD, raw_cmd->cmd[HEAD]);
+		pr_info("rt=%d t=%d\n", R_TRACK, raw_cmd->cmd[TRACK]);
 		pr_info("heads=%d eoc=%d\n", heads, eoc);
 		pr_info("spt=%d st=%d ss=%d\n",
-			SECT_PER_TRACK, fsector_t, ssize);
+			raw_cmd->cmd[SECT_PER_TRACK], fsector_t, ssize);
 		pr_info("in_sector_offset=%d\n", in_sector_offset);
 	}
 
@@ -2366,11 +2366,11 @@ static void rw_interrupt(void)
 		probing = 0;
 	}
 
-	if (CT(COMMAND) != FD_READ ||
+	if (CT(raw_cmd->cmd[COMMAND]) != FD_READ ||
 	    raw_cmd->kernel_data == bio_data(current_req->bio)) {
 		/* transfer directly from buffer */
 		cont->done(1);
-	} else if (CT(COMMAND) == FD_READ) {
+	} else if (CT(raw_cmd->cmd[COMMAND]) == FD_READ) {
 		buffer_track = raw_cmd->track;
 		buffer_drive = current_drive;
 		INFBOUND(buffer_max, nr_sectors + fsector_t);
@@ -2429,13 +2429,13 @@ static void copy_buffer(int ssize, int max_sector, int max_sector_2)
 				   min(max_sector, max_sector_2),
 				   blk_rq_sectors(current_req));
 
-	if (current_count_sectors <= 0 && CT(COMMAND) == FD_WRITE &&
+	if (current_count_sectors <= 0 && CT(raw_cmd->cmd[COMMAND]) == FD_WRITE &&
 	    buffer_max > fsector_t + blk_rq_sectors(current_req))
 		current_count_sectors = min_t(int, buffer_max - fsector_t,
 					      blk_rq_sectors(current_req));
 
 	remaining = current_count_sectors << 9;
-	if (remaining > blk_rq_bytes(current_req) && CT(COMMAND) == FD_WRITE) {
+	if (remaining > blk_rq_bytes(current_req) && CT(raw_cmd->cmd[COMMAND]) == FD_WRITE) {
 		DPRINT("in copy buffer\n");
 		pr_info("current_count_sectors=%ld\n", current_count_sectors);
 		pr_info("remaining=%d\n", remaining >> 9);
@@ -2470,16 +2470,16 @@ static void copy_buffer(int ssize, int max_sector, int max_sector_2)
 				fsector_t, buffer_min);
 			pr_info("current_count_sectors=%ld\n",
 				current_count_sectors);
-			if (CT(COMMAND) == FD_READ)
+			if (CT(raw_cmd->cmd[COMMAND]) == FD_READ)
 				pr_info("read\n");
-			if (CT(COMMAND) == FD_WRITE)
+			if (CT(raw_cmd->cmd[COMMAND]) == FD_WRITE)
 				pr_info("write\n");
 			break;
 		}
 		if (((unsigned long)buffer) % 512)
 			DPRINT("%p buffer not aligned\n", buffer);
 
-		if (CT(COMMAND) == FD_READ)
+		if (CT(raw_cmd->cmd[COMMAND]) == FD_READ)
 			memcpy(buffer, dma_buffer, size);
 		else
 			memcpy(dma_buffer, buffer, size);
@@ -2497,7 +2497,7 @@ static void copy_buffer(int ssize, int max_sector, int max_sector_2)
 /* work around a bug in pseudo DMA
  * (on some FDCs) pseudo DMA does not stop when the CPU stops
  * sending data.  Hence we need a different way to signal the
- * transfer length:  We use SECT_PER_TRACK.  Unfortunately, this
+ * transfer length:  We use raw_cmd->cmd[SECT_PER_TRACK].  Unfortunately, this
  * does not work with MT, hence we can only transfer one head at
  * a time
  */
@@ -2506,18 +2506,18 @@ static void virtualdmabug_workaround(void)
 	int hard_sectors;
 	int end_sector;
 
-	if (CT(COMMAND) == FD_WRITE) {
-		COMMAND &= ~0x80;	/* switch off multiple track mode */
+	if (CT(raw_cmd->cmd[COMMAND]) == FD_WRITE) {
+		raw_cmd->cmd[COMMAND] &= ~0x80;	/* switch off multiple track mode */
 
-		hard_sectors = raw_cmd->length >> (7 + SIZECODE);
-		end_sector = SECTOR + hard_sectors - 1;
-		if (end_sector > SECT_PER_TRACK) {
+		hard_sectors = raw_cmd->length >> (7 + raw_cmd->cmd[SIZECODE]);
+		end_sector = raw_cmd->cmd[SECTOR] + hard_sectors - 1;
+		if (end_sector > raw_cmd->cmd[SECT_PER_TRACK]) {
 			pr_info("too many sectors %d > %d\n",
-				end_sector, SECT_PER_TRACK);
+				end_sector, raw_cmd->cmd[SECT_PER_TRACK]);
 			return;
 		}
-		SECT_PER_TRACK = end_sector;
-					/* make sure SECT_PER_TRACK
+		raw_cmd->cmd[SECT_PER_TRACK] = end_sector;
+					/* make sure raw_cmd->cmd[SECT_PER_TRACK]
 					 * points to end of transfer */
 	}
 }
@@ -2550,10 +2550,10 @@ static int make_raw_rw_request(void)
 	raw_cmd->cmd_count = NR_RW;
 	if (rq_data_dir(current_req) == READ) {
 		raw_cmd->flags |= FD_RAW_READ;
-		COMMAND = FM_MODE(_floppy, FD_READ);
+		raw_cmd->cmd[COMMAND] = FM_MODE(_floppy, FD_READ);
 	} else if (rq_data_dir(current_req) == WRITE) {
 		raw_cmd->flags |= FD_RAW_WRITE;
-		COMMAND = FM_MODE(_floppy, FD_WRITE);
+		raw_cmd->cmd[COMMAND] = FM_MODE(_floppy, FD_WRITE);
 	} else {
 		DPRINT("%s: unknown command\n", __func__);
 		return 0;
@@ -2561,16 +2561,16 @@ static int make_raw_rw_request(void)
 
 	max_sector = _floppy->sect * _floppy->head;
 
-	TRACK = (int)blk_rq_pos(current_req) / max_sector;
+	raw_cmd->cmd[TRACK] = (int)blk_rq_pos(current_req) / max_sector;
 	fsector_t = (int)blk_rq_pos(current_req) % max_sector;
-	if (_floppy->track && TRACK >= _floppy->track) {
+	if (_floppy->track && raw_cmd->cmd[TRACK] >= _floppy->track) {
 		if (blk_rq_cur_sectors(current_req) & 1) {
 			current_count_sectors = 1;
 			return 1;
 		} else
 			return 0;
 	}
-	HEAD = fsector_t / _floppy->sect;
+	raw_cmd->cmd[HEAD] = fsector_t / _floppy->sect;
 
 	if (((_floppy->stretch & (FD_SWAPSIDES | FD_SECTBASEMASK)) ||
 	     test_bit(FD_NEED_TWADDLE_BIT, &drive_state[current_drive].flags)) &&
@@ -2578,7 +2578,7 @@ static int make_raw_rw_request(void)
 		max_sector = _floppy->sect;
 
 	/* 2M disks have phantom sectors on the first track */
-	if ((_floppy->rate & FD_2M) && (!TRACK) && (!HEAD)) {
+	if ((_floppy->rate & FD_2M) && (!raw_cmd->cmd[TRACK]) && (!raw_cmd->cmd[HEAD])) {
 		max_sector = 2 * _floppy->sect / 3;
 		if (fsector_t >= max_sector) {
 			current_count_sectors =
@@ -2586,23 +2586,24 @@ static int make_raw_rw_request(void)
 				  blk_rq_sectors(current_req));
 			return 1;
 		}
-		SIZECODE = 2;
+		raw_cmd->cmd[SIZECODE] = 2;
 	} else
-		SIZECODE = FD_SIZECODE(_floppy);
+		raw_cmd->cmd[SIZECODE] = FD_SIZECODE(_floppy);
 	raw_cmd->rate = _floppy->rate & 0x43;
-	if ((_floppy->rate & FD_2M) && (TRACK || HEAD) && raw_cmd->rate == 2)
+	if ((_floppy->rate & FD_2M) &&
+	    (raw_cmd->cmd[TRACK] || raw_cmd->cmd[HEAD]) && raw_cmd->rate == 2)
 		raw_cmd->rate = 1;
 
-	if (SIZECODE)
-		SIZECODE2 = 0xff;
+	if (raw_cmd->cmd[SIZECODE])
+		raw_cmd->cmd[SIZECODE2] = 0xff;
 	else
-		SIZECODE2 = 0x80;
-	raw_cmd->track = TRACK << STRETCH(_floppy);
-	DR_SELECT = UNIT(current_drive) + PH_HEAD(_floppy, HEAD);
-	GAP = _floppy->gap;
-	ssize = DIV_ROUND_UP(1 << SIZECODE, 4);
-	SECT_PER_TRACK = _floppy->sect << 2 >> SIZECODE;
-	SECTOR = ((fsector_t % _floppy->sect) << 2 >> SIZECODE) +
+		raw_cmd->cmd[SIZECODE2] = 0x80;
+	raw_cmd->track = raw_cmd->cmd[TRACK] << STRETCH(_floppy);
+	raw_cmd->cmd[DR_SELECT] = UNIT(current_drive) + PH_HEAD(_floppy, raw_cmd->cmd[HEAD]);
+	raw_cmd->cmd[GAP] = _floppy->gap;
+	ssize = DIV_ROUND_UP(1 << raw_cmd->cmd[SIZECODE], 4);
+	raw_cmd->cmd[SECT_PER_TRACK] = _floppy->sect << 2 >> raw_cmd->cmd[SIZECODE];
+	raw_cmd->cmd[SECTOR] = ((fsector_t % _floppy->sect) << 2 >> raw_cmd->cmd[SIZECODE]) +
 	    FD_SECTBASE(_floppy);
 
 	/* tracksize describes the size which can be filled up with sectors
@@ -2610,24 +2611,24 @@ static int make_raw_rw_request(void)
 	 */
 	tracksize = _floppy->sect - _floppy->sect % ssize;
 	if (tracksize < _floppy->sect) {
-		SECT_PER_TRACK++;
+		raw_cmd->cmd[SECT_PER_TRACK]++;
 		if (tracksize <= fsector_t % _floppy->sect)
-			SECTOR--;
+			raw_cmd->cmd[SECTOR]--;
 
 		/* if we are beyond tracksize, fill up using smaller sectors */
 		while (tracksize <= fsector_t % _floppy->sect) {
 			while (tracksize + ssize > _floppy->sect) {
-				SIZECODE--;
+				raw_cmd->cmd[SIZECODE]--;
 				ssize >>= 1;
 			}
-			SECTOR++;
-			SECT_PER_TRACK++;
+			raw_cmd->cmd[SECTOR]++;
+			raw_cmd->cmd[SECT_PER_TRACK]++;
 			tracksize += ssize;
 		}
-		max_sector = HEAD * _floppy->sect + tracksize;
-	} else if (!TRACK && !HEAD && !(_floppy->rate & FD_2M) && probing) {
+		max_sector = raw_cmd->cmd[HEAD] * _floppy->sect + tracksize;
+	} else if (!raw_cmd->cmd[TRACK] && !raw_cmd->cmd[HEAD] && !(_floppy->rate & FD_2M) && probing) {
 		max_sector = _floppy->sect;
-	} else if (!HEAD && CT(COMMAND) == FD_WRITE) {
+	} else if (!raw_cmd->cmd[HEAD] && CT(raw_cmd->cmd[COMMAND]) == FD_WRITE) {
 		/* for virtual DMA bug workaround */
 		max_sector = _floppy->sect;
 	}
@@ -2639,12 +2640,12 @@ static int make_raw_rw_request(void)
 	    (current_drive == buffer_drive) &&
 	    (fsector_t >= buffer_min) && (fsector_t < buffer_max)) {
 		/* data already in track buffer */
-		if (CT(COMMAND) == FD_READ) {
+		if (CT(raw_cmd->cmd[COMMAND]) == FD_READ) {
 			copy_buffer(1, max_sector, buffer_max);
 			return 1;
 		}
 	} else if (in_sector_offset || blk_rq_sectors(current_req) < ssize) {
-		if (CT(COMMAND) == FD_WRITE) {
+		if (CT(raw_cmd->cmd[COMMAND]) == FD_WRITE) {
 			unsigned int sectors;
 
 			sectors = fsector_t + blk_rq_sectors(current_req);
@@ -2655,7 +2656,7 @@ static int make_raw_rw_request(void)
 		}
 		raw_cmd->flags &= ~FD_RAW_WRITE;
 		raw_cmd->flags |= FD_RAW_READ;
-		COMMAND = FM_MODE(_floppy, FD_READ);
+		raw_cmd->cmd[COMMAND] = FM_MODE(_floppy, FD_READ);
 	} else if ((unsigned long)bio_data(current_req->bio) < MAX_DMA_ADDRESS) {
 		unsigned long dma_limit;
 		int direct, indirect;
@@ -2706,7 +2707,7 @@ static int make_raw_rw_request(void)
 		}
 	}
 
-	if (CT(COMMAND) == FD_READ)
+	if (CT(raw_cmd->cmd[COMMAND]) == FD_READ)
 		max_size = max_sector;	/* unbounded */
 
 	/* claim buffer track if needed */
@@ -2714,7 +2715,7 @@ static int make_raw_rw_request(void)
 	    buffer_drive != current_drive ||	/* bad drive */
 	    fsector_t > buffer_max ||
 	    fsector_t < buffer_min ||
-	    ((CT(COMMAND) == FD_READ ||
+	    ((CT(raw_cmd->cmd[COMMAND]) == FD_READ ||
 	      (!in_sector_offset && blk_rq_sectors(current_req) >= ssize)) &&
 	     max_sector > 2 * max_buffer_sectors + buffer_min &&
 	     max_size + fsector_t > 2 * max_buffer_sectors + buffer_min)) {
@@ -2726,7 +2727,7 @@ static int make_raw_rw_request(void)
 	raw_cmd->kernel_data = floppy_track_buffer +
 		((aligned_sector_t - buffer_min) << 9);
 
-	if (CT(COMMAND) == FD_WRITE) {
+	if (CT(raw_cmd->cmd[COMMAND]) == FD_WRITE) {
 		/* copy write buffer to track buffer.
 		 * if we get here, we know that the write
 		 * is either aligned or the data already in the buffer
@@ -2748,10 +2749,10 @@ static int make_raw_rw_request(void)
 	raw_cmd->length <<= 9;
 	if ((raw_cmd->length < current_count_sectors << 9) ||
 	    (raw_cmd->kernel_data != bio_data(current_req->bio) &&
-	     CT(COMMAND) == FD_WRITE &&
+	     CT(raw_cmd->cmd[COMMAND]) == FD_WRITE &&
 	     (aligned_sector_t + (raw_cmd->length >> 9) > buffer_max ||
 	      aligned_sector_t < buffer_min)) ||
-	    raw_cmd->length % (128 << SIZECODE) ||
+	    raw_cmd->length % (128 << raw_cmd->cmd[SIZECODE]) ||
 	    raw_cmd->length <= 0 || current_count_sectors <= 0) {
 		DPRINT("fractionary current count b=%lx s=%lx\n",
 		       raw_cmd->length, current_count_sectors);
@@ -2762,9 +2763,10 @@ static int make_raw_rw_request(void)
 				current_count_sectors);
 		pr_info("st=%d ast=%d mse=%d msi=%d\n",
 			fsector_t, aligned_sector_t, max_sector, max_size);
-		pr_info("ssize=%x SIZECODE=%d\n", ssize, SIZECODE);
+		pr_info("ssize=%x SIZECODE=%d\n", ssize, raw_cmd->cmd[SIZECODE]);
 		pr_info("command=%x SECTOR=%d HEAD=%d, TRACK=%d\n",
-			COMMAND, SECTOR, HEAD, TRACK);
+			raw_cmd->cmd[COMMAND], raw_cmd->cmd[SECTOR],
+			raw_cmd->cmd[HEAD], raw_cmd->cmd[TRACK]);
 		pr_info("buffer drive=%d\n", buffer_drive);
 		pr_info("buffer track=%d\n", buffer_track);
 		pr_info("buffer_min=%d\n", buffer_min);
@@ -2783,9 +2785,9 @@ static int make_raw_rw_request(void)
 				fsector_t, buffer_min, raw_cmd->length >> 9);
 			pr_info("current_count_sectors=%ld\n",
 				current_count_sectors);
-			if (CT(COMMAND) == FD_READ)
+			if (CT(raw_cmd->cmd[COMMAND]) == FD_READ)
 				pr_info("read\n");
-			if (CT(COMMAND) == FD_WRITE)
+			if (CT(raw_cmd->cmd[COMMAND]) == FD_WRITE)
 				pr_info("write\n");
 			return 0;
 		}
@@ -3253,7 +3255,7 @@ static int set_geometry(unsigned int cmd, struct floppy_struct *g,
 	    (int)g->head <= 0 ||
 	    /* check for overflow in max_sector */
 	    (int)(g->sect * g->head) <= 0 ||
-	    /* check for zero in F_SECT_PER_TRACK */
+	    /* check for zero in raw_cmd->cmd[F_SECT_PER_TRACK] */
 	    (unsigned char)((g->sect << 2) >> FD_SIZECODE(g)) == 0 ||
 	    g->track <= 0 || g->track > drive_params[drive].tracks >> STRETCH(g) ||
 	    /* check if reserved bits are set */
-- 
2.9.0

