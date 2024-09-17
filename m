Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFF217BA4;
	Tue, 17 Sep 2024 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726586552; cv=none; b=sWSqrTcI2+8M2USfI+Qu+7MeZIzXm1+yHlz795C0GpNZPoca/JCY7YPnHu04ZbBgoUKNRvOMxCQOF5jDjycAxf51Ps6rSaTm67hUNnhrbus9AvFOvWYrZckFM+5YgzlxLwODz4CVQfKijCCaexQgqVi3kluYBSv118ZBzGJFGmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726586552; c=relaxed/simple;
	bh=b17dV6kcYCKjtkCgvF4MqWi0LIWAWld8+sLS8KVrnNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q+vnGLweqc5iTRdLc/WGmm0EReb/R6eOGtEUc8OdDsrvj8SLeWjnFG5VpkfTOOr4AaMeL3kS0dwhp8oM8P2P/aqqJPZFtJB+uLPfCDE1d77iWF9C5wYrVCZavSAUSUy6/77fK251WybxvGleNk60LJTJDTUQIUZ19pfjPBgRf+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXPZ7FsD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXPZ7FsD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9826C4CEC5;
	Tue, 17 Sep 2024 15:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726586551;
	bh=b17dV6kcYCKjtkCgvF4MqWi0LIWAWld8+sLS8KVrnNg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=nXPZ7FsDTlchEG+c7929e2Sf7D4yuNZs/KU/cPNCc4xj+BkoXvIHzOA3/9ZQdVfm4
	 PBKe/jSEQEF82HetQgKXZ9u0h9CsRxKnVlnszHg8F+cT2q5ZG842wTB5dvNsVS3yNG
	 IGADHuNB26kxG3TRIordt22pyy6OGDFzewFPdXKF3eJ03yMwFlLaKOknx3d+VHxsmx
	 f3rElLXPONblsZKK4KOp6YgmJl9Sr0IAhVnKrQNRk8YXScvnLZbQ+7p3bJOB2eVQJa
	 7o5bQt6HdlFRTS21z1Zl04o6F97YFfd4Ki5VHo362RJXAZCnjIrUzCSxfTgYp2FPs2
	 nyWa+Qxdiw+cQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C77CAC58A;
	Tue, 17 Sep 2024 15:22:31 +0000 (UTC)
From: Daniel Gomez via B4 Relay <devnull+da.gomez.samsung.com@kernel.org>
Date: Tue, 17 Sep 2024 17:22:18 +0200
Subject: [PATCH RFC] blktrace: add i/o alignment information
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240917-blktrace-algn-v1-1-9fb54b7b1dfa@samsung.com>
X-B4-Tracking: v=1; b=H4sIAKme6WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0Mz3aSc7JKixORU3cSc9DzdRENDYyMDY1NjQwsjJaCegqLUtMwKsHn
 RSkFuzkqxtbUAq9kXRGQAAAA=
To: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, gost.dev@samsung.com, 
 John Garry <john.g.garry@oracle.com>, Dave Chinner <dchinner@redhat.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>, 
 Dan Helmick <dan.helmick@samsung.com>, Daniel Gomez <d@kruces.com>, 
 Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726586542; l=6584;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=JygrMCTMhPqX/bAPRMl20ITyAtI+tYOaIShANk2aGlU=;
 b=8mwlKU1v1feiAFYqL5Z0fOTBZ/cJLiS6UtnWxVXzTXO9WPZQ6SrTPGrgd5Ar2yXHEumZtQMHM
 EeF05YyiVFRA2JQc2Iisq0RLzDK7A4smn7CIZ22sYd4U3gRUvnOjZiL
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
X-Endpoint-Received: by B4 Relay for da.gomez@samsung.com/20240621 with
 auth_id=175
X-Original-From: Daniel Gomez <da.gomez@samsung.com>
Reply-To: da.gomez@samsung.com

From: Daniel Gomez <da.gomez@samsung.com>

This patch introduces max I/O alignment boundaries in terms of LBA and
size in blktrace for issued I/Os.

Tracing alignment information is important for high-capacity and QLC
SSDs with Indirection Units greater than 4 KiB. These devices are still
4 KiB in Logical Block Size (LBS) but because they work at higher IUs,
unaligned writes to the IU boundaries can imply in a read-modify-write
(RMW).

This patch enables blktrace to report alignment details via new
alignment parameter, which will be calculated during I/O tracing.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
This patch introduces support for tracing maximum I/O alignment
boundaries in terms of Logical Block Addressing (LBA) and size within
blktrace for issued I/Os.

Note: the term alignment has been previously discussed here [1], where
it was suggested to use "largest block size granularity". In this RFC,
alignment term is kept, though further suggestions for an appropriate
term are welcomed.

[1] https://lore.kernel.org/all/a7f9079f-6f47-4a47-a327-98497bd33dfe@oracle.com

Tracing alignment information is important for high-capacity and QLC
SSDs with Indirection Units greater than 4 KiB. These devices are still
4 KiB in Logical Block Size (LBS) but because they work at higher IUs,
unaligned writes to the IU boundaries can imply in a read-modify-write
(RMW).

More information about the motivation can be found in the first LBS
patch series [2].

[2] Subject: [RFC 00/23] Enable block size > page size in XFS
https://lore.kernel.org/lkml/20230915183848.1018717-1-kernel@pankajraghav.com/

Additionally, Dan Helmick's talk [3] provides further context on the
importance of I/O granularity and alignment, specifically in the context
of NVMe.

[3] SDC2022 – Optimal Performance Parameters for NVMe SSDs

The graph below is a representation of the device IU vs what is
considered here the I/O block alignment.

    |--- IU Boundaries ----|      |-PS-|
a)  [====][====][====][====][····][····][····]--
    |                      |
b)  [····][====][====][====][====][····][····]--
    |                      |
c)  [····][····][====][====][····][····][····]--
    |                      |
LBA 0                      4

    Key:
    [====] = I/O Block
    [····] = Memory in Page Size (PS) chunks
    PS: System base Page Size (e.g. x86_64 is 4 KiB)

a) I/O matches IU boundaries (LBA and block size). I/O is aligned to
IU boundaries.
b) The size of the I/O matches the IU size but the I/O is not aligned to
the IU boundaries. I/O is unaligned.
c) I/O does not match in either size or LBA. I/O is unaligned.

This patch enables blktrace to report alignment details via new
alignment parameter, which will be calculated during I/O tracing. For
the example above, the following values would be reported:

a) |16384|: I/O aligned to 16 KiB boundaries.
b) |4096|:  I/O aligned to 4 KiB boundaries.
c) |8192|:  I/O aligned to 8 KiB boundaries.

Finally, this patch requires some minor changes [4] in the blktrace
tool. If this moves forward, the changes will be submitted accordingly.

[4] https://github.com/dkruces/blktrace/tree/algn
---
 include/linux/blktrace_api.h      |  2 ++
 include/uapi/linux/blktrace_api.h |  1 +
 kernel/trace/blktrace.c           | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 122c62e561fc..17f1a21ffb5a 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -26,6 +26,8 @@ struct blk_trace {
 	struct dentry *dir;
 	struct list_head running_list;
 	atomic_t dropped;
+	u32 lbs;
+	u8 lba_shift;
 };
 
 extern int blk_trace_ioctl(struct block_device *, unsigned, char __user *);
diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 690621b610e5..d6df0c10ece1 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -110,6 +110,7 @@ struct blk_io_trace {
 	__u32 cpu;		/* on what cpu did it happen */
 	__u16 error;		/* completion error */
 	__u16 pdu_len;		/* length of data after this trace */
+	__u32 alignment;	/* i/o alignment boundaries */
 	/* cgroup id will be stored here if exists */
 };
 
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8fd292d34d89..8330455458b8 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -208,6 +208,39 @@ static const u32 ddir_act[2] = { BLK_TC_ACT(BLK_TC_READ),
 #define MASK_TC_BIT(rw, __name) ((__force u32)(rw & REQ_ ## __name) <<	\
 	  (ilog2(BLK_TC_ ## __name) + BLK_TC_SHIFT - __REQ_ ## __name))
 
+static inline bool blk_trace_lba_aligned(u32 len, u32 algn_len, u64 lba,
+				      u32 algn_lba)
+{
+	return !(len % algn_len) && !(lba % algn_lba);
+}
+
+static inline u32 blk_trace_align(struct blk_trace *bt, u64 sector,
+					u32 len)
+{
+	u64 lba = sector >> (bt->lba_shift - SECTOR_SHIFT);
+	u32 align_len = len;
+	u32 align_lba = align_len / bt->lbs;
+	u32 alignment = bt->lbs;
+
+	if (is_power_of_2(len) &&
+	    blk_trace_lba_aligned(len, align_len, lba, align_lba))
+		return len;
+
+	align_len = bt->lbs << 1UL;
+	align_lba = align_len / bt->lbs;
+
+	while (align_len < len) {
+		if (!blk_trace_lba_aligned(len, align_len, lba, align_lba))
+			break;
+
+		alignment = align_len;
+		align_len = align_len << 1UL;
+		align_lba = align_len / bt->lbs;
+	}
+
+	return alignment;
+}
+
 /*
  * The worker for the various blk_add_trace*() types. Fills out a
  * blk_io_trace structure and places it in a per-cpu subbuffer.
@@ -296,6 +329,9 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 		t->device = bt->dev;
 		t->error = error;
 		t->pdu_len = pdu_len + cgid_len;
+		if (((what & 0xffff) & ~__BLK_TA_CGROUP) == __BLK_TA_ISSUE)
+			t->alignment =
+				blk_trace_align(bt, sector, bytes);
 
 		if (cgid_len)
 			memcpy((void *)t + sizeof(*t), &cgid, cgid_len);
@@ -597,6 +633,8 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		bt->act_mask = (u16) -1;
 
 	blk_trace_setup_lba(bt, bdev);
+	bt->lbs = queue_logical_block_size(q);
+	bt->lba_shift = ilog2(bt->lbs);
 
 	/* overwrite with user settings */
 	if (buts->start_lba)

---
base-commit: 4f3e012d4cfd1d9bf837870c961f462ca9f23ebe
change-id: 20240916-blktrace-algn-a11320353182

Best regards,
-- 
Daniel Gomez <da.gomez@samsung.com>


