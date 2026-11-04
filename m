Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803184;
	b=1G5j4haawjQRn3q154QcNXpocgBeGEgu4cyz/ANUdap0BUbB5PfNpSBYsol+S/poFQuv
	 AOTOZTFzHABCET/oqk0LnCN1cr7Gu28gek0/hOLkPowUiSEMW7cZCS8kha66FPlTNs/lg
	 vzByk+1M5Njb09W3dLCb841v9g/++pXFaFlty0gFMlFebEaNqOLl3nz6NQPQBCUtfjyAK
	 wMXPx4UNEn9gxRvntZrsvvpqYyq/4aYwfwoZQwwjU83mJoF463zD/i0tVS2gBds9mj7F0
	 jNUm2Ogy3poXKb2Ou020VGBxmnpFhD7A7cuzAi6FAUBw7FxgII45ulijlz+GXxqFeJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803184;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vWAUioNlml08tns8OmIh5lWoP6sA2CHZkVMFWUAY6dE=;
	b=O7p6pFifLwfTpWBaeCVOqU6bDp9ERBfYwSJ5HI45A5NGIP5O68rDHU2H12oxyOkPj0YY
	 4J2ivd5642eADWOGULahcpuYOVWYfKHLh74BP9DX1AiTr/MFgHAuq4TPMF07t/8QAVQQL
	 KhSCqDO7n5ZoMCr0KpsxmRrieEeYVDaDFOKgzSW5Emq9b2CLlofGpc6RNHZ69+BgBSHwV
	 3FjTDFkp2jw8hJ/DCtFpOUboPxZD8uIntv52hVFStu1nldmIHkLdNwJtOqrnKftLLRldJ
	 hNRe9hWVlNcF2uGIYrjo8xPFV/h3m0TTpSXhU/4qNY/i9f2eAQBSwkICr0QvWjhENyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=VFNYiTk3;
	arc=none smtp.remote-ip=162.62.57.49
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207D1606A31B;
	Wed,  4 Nov 2026 14:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 207D1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=VFNYiTk3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793803172; bh=vWAUioNlml08tns8OmIh5lWoP6sA2CHZkVMFWUAY6dE=;
	h=From:To:Cc:Subject:Date;
	b=VFNYiTk3HZHAtlSYP144+5LfvHpr7bIMVAv68aiCEXE1z8f0O+dUq01Fv850igIzf
	 rfBWhkahIjaGahp0H7Nf0OSWiz+0p9iK73yH8Os+fMTCAgjTPVRw/x9RzE2Tdxwc/i
	 uLSaxG5hjiYTWhxpuYqKD/ElpQoyDGBVkGdXJ9MQ=
Received: from shuai-VMware-Virtual-Platform.localdomain ([223.88.55.29])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 9DC90C39; Wed, 04 Nov 2026 22:39:28 +0800
X-QQ-mid: xmsmtpt1793803168tsgi7cg9a
Message-ID: <tencent_2BD24B2CAFF21D4D0EB86262EC13D8EE6408@qq.com>
X-QQ-XMAILINFO: OPbu+gyh5MQo/22CT/fkGfhx+YFn8vJTeKrQ7IxBsLolg0jRCoQ+Gl4DexhrCf
	 xzGfxlmKU/J/UdFYp2+3XtqC7Hu8nhVsxQODlQNroL5fIjafDXGczSjy5je219PCoYrXKOE/kxsR
	 +8C2RlPXSqRGdJAEblO5LOCDD76ugQgOrRntR2Jm6RlKss6C/9Mt5DyQPC6DAOgQKVS35vZIB8xa
	 MKsUfNL1E/Ifth0MikVBpFxuAH2lDRD3AKX6/McbXehw4GcISSijeO6Zh3sVTrG4oJBh1ALSOuLx
	 bLW+r2KIxQIbrIfS+Ac7a5BF+ZvBMWMnlk1L52NAFVfix79DNXxcXyd6V3VovG/kUK/YCiUTld4X
	 YFHX46/MayAzBMzAR2ghp4QP7YokgOoi2uIzXBIfigv8VQLBBAgWaWQ1UdtM14NEBqzPvRsucgvn
	 /O1EMt8SMGSaLo4vZrC415lFrCePbJz/vGjmIh0tVGFvgfyusORmUY2Mc9x3SeungIv2ppwtK6y0
	 pcm+P8YYGZw14w3T5OfDADypvFlcCIq8FUQ9Up9viTlLpije6slL/RAa3s2cw+ZjNinRKTUPoExB
	 uzHdVT4+esv9B9oyeXxS9g9UNcRNoM8MykMsRsMxTfV0dgFdCH+AbdEGURjAfLuNlGaPGv1sHIiw
	 U3dPPTFWT0aGQVLkgwuafrYUEJ/x64M2fi4OzXbCHCNNfsy5eb1TTJqMAsi2ATWqMtegRJDpoyl5
	 x3LaV2KmKqCmtPPm4hT8ZDQOxZZhIxWF5nbJwfxbcxt+2yoVry1r5pmTlQn4fDZrgzM9NQR3Kjrz
	 bC95uzvJ3orX8QVocVADwXTv0Zaz3bFzrSrM4HJQlot+fs2l2afet/3c813CYx4pcAg4tRYdoJw6
	 vKEmo/KXbNBfc92auye9lqhCjDe9TQXD9XbBrr4ht+k3cJ/uiRQTNAw7OKy2/Tm6mUYOLPMW64Dl
	 QS/lFwygBVpp1K+Rj4J7NHaILMMVwFBwN4MlzMbtmz50iwb+ecoQ/BZfeL693jyR/Mw0cPSpLHn/
	 HkBO6LsOthl/wlK+Fpk1+suKZzTeFMbUVjMYXPlybg8So+trciPlxHPzVuh2Hu+6uI/wnLdFsd0Y
	 VVShE76neGbstJWq4lBkhVOTzNw8jS2l/rj/hM
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Shuai Liu <847807867@qq.com>
To: axboe@kernel.dk,
	rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	dlemoal@kernel.org,
	johannes.thumshirn@wdc.com,
	mkp@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+2fca70610179be6c24a4@syzkaller.appspotmail.com,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH] blktrace: always record v2 format for the ftrace tracer
Date: Wed,  4 Nov 2026 22:39:22 +0800
X-OQ-MSGID: <20261104143922.317295-1-847807867@qq.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The legacy BLKTRACESETUP ioctl creates a blk_trace with version 1, and
__blk_add_trace() wrote v1 (struct blk_io_trace) records into the ftrace
buffer. The ftrace read path, however, unconditionally parses entries as
v2 (struct blk_io_trace2): the 32-bit pid at offset 28 of a v1 record is
interpreted as the v2 action field. If the pid happens to equal
__BLK_TA_BOUNCE (14), print_one_line() hits the uninitialized hole in
what2act[] and calls a NULL .print handler, crashing with RIP 0x0.

The relay path is the only consumer of v1 records (blkparse); ftrace
always wants v2. Drop the version switch in the ftrace branch and always
record v2, keeping the existing 0 -> 2 normalization for the sysfs path.

Reported-by: syzbot+2fca70610179be6c24a4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2fca70610179be6c24a4
Fixes: 4d8bc7bd4f73 ("blktrace: move ftrace blk_io_tracer to blk_io_trace2")
Signed-off-by: Shuai Liu <847807867@qq.com>

---
Tested with the syzbot C reproducer on x86-64 QEMU: without this patch the
kernel panics in print_one_line() with RIP 0x0; with it, reading
/sys/kernel/tracing/trace returns 2958 bytes of correctly parsed events.

Developed with AI assistance (code analysis and patch drafting); all changes
reviewed and runtime-verified by me.
---
 kernel/trace/blktrace.c | 72 +++++++++++------------------------------
 1 file changed, 18 insertions(+), 54 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8cd2520b4c99..a9e9fc30e5ef 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -385,66 +385,30 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	if (blk_tracer) {
 		buffer = blk_tr->array_buffer.buffer;
 		trace_ctx = tracing_gen_ctx_flags(0);
-		switch (bt->version) {
-		case 1:
-			trace_len = sizeof(struct blk_io_trace);
-			break;
-		case 2:
-		default:
-			/*
-			 * ftrace always uses v2 (blk_io_trace2) format.
-			 *
-			 * For sysfs-enabled tracing path (enabled via
-			 * /sys/block/DEV/trace/enable), blk_trace_setup_queue()
-			 * never initializes bt->version, leaving it 0 from
-			 * kzalloc(). We must handle version==0 safely here.
-			 *
-			 * Fall through to default to ensure we never hit the
-			 * old bug where default set trace_len=0, causing
-			 * buffer underflow and memory corruption.
-			 *
-			 * Always use v2 format for ftrace and normalize
-			 * bt->version to 2 when uninitialized.
-			 */
-			trace_len = sizeof(struct blk_io_trace2);
-			if (bt->version == 0)
-				bt->version = 2;
-			break;
-		}
-		trace_len += pdu_len + cgid_len;
+		/*
+		 * ftrace always consumes v2 (blk_io_trace2) records, no matter
+		 * which format was requested through BLKTRACESETUP. The v1
+		 * layout is only meaningful for the relay buffer read by
+		 * blkparse. Recording v1 here made print_one_line() read the
+		 * 32-bit pid as the action field, which could call a NULL
+		 * handler.
+		 *
+		 * The sysfs-enabled path never initializes bt->version, so
+		 * normalize an uninitialized version to v2 as well.
+		 */
+		if (bt->version == 0)
+			bt->version = 2;
+		trace_len = sizeof(struct blk_io_trace2) + pdu_len + cgid_len;
 		event = trace_buffer_lock_reserve(buffer, TRACE_BLK,
 						  trace_len, trace_ctx);
 		if (!event)
 			return;
 
 		tracing_record_cmdline(current);
-		switch (bt->version) {
-		case 1:
-			record_blktrace_event(ring_buffer_event_data(event),
-					      pid, cpu, sector, bytes,
-					      what, bt->dev, error, cgid, cgid_len,
-					      pdu_data, pdu_len);
-			break;
-		case 2:
-		default:
-			/*
-			 * Use v2 recording function (record_blktrace_event2)
-			 * which writes blk_io_trace2 structure with correct
-			 * field layout:
-			 *   - 32-bit pid at offset 28
-			 *   - 64-bit action at offset 32
-			 *
-			 * Fall through to default handles version==0 case
-			 * (from sysfs path), ensuring we always use correct
-			 * v2 recording function to match the v2 buffer
-			 * allocated above.
-			 */
-			record_blktrace_event2(ring_buffer_event_data(event),
-					       pid, cpu, sector, bytes,
-					       what, bt->dev, error, cgid, cgid_len,
-					       pdu_data, pdu_len);
-			break;
-		}
+		record_blktrace_event2(ring_buffer_event_data(event),
+				       pid, cpu, sector, bytes,
+				       what, bt->dev, error, cgid, cgid_len,
+				       pdu_data, pdu_len);
 
 		trace_buffer_unlock_commit(blk_tr, buffer, event, trace_ctx);
 		return;
-- 
2.53.0

