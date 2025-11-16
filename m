Received: from sg-1-21.ptr.blmpb.com (sg-1-21.ptr.blmpb.com [118.26.132.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4A725A33A
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 03:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763263278; cv=none; b=geodLPaMcU+calp/XVeeGx8NrmZhuK4e5+ccUib5D8m3R2FAbuwUJv4jE4V1/nhwG4dsZz/wiyyvjPqXeThEppI4EtIN9Gwdzt5L0J4GZi3kJ9UQyJkQMm7x3yalVEiBWCKVH6B+wSoRhLZhROSF19hGI7nft7zByII+3EJdCww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763263278; c=relaxed/simple;
	bh=FZNMdtRtUfUxNdy4QdXCSCmt4xOJ7MT8+JdG5v6Ibfc=;
	h=To:Cc:Subject:Date:Message-Id:Mime-Version:Content-Type:From; b=Srd6aqO2wXs/j0EbwCeWW//NVWXkxXfW9OsFsE2EcgnPktWG1v985BWszymFUK6uoafmplVxJqCpOH37O32sXBqWBq//+Qglel/lpjsh7v7On/XFiroMYd+EHVuoCaHWfpp8PMdC+687rzWfoAEVfjqPJa+PLVgbcUpHATXPaLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=rK4YoloM; arc=none smtp.client-ip=118.26.132.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="rK4YoloM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763263266;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=V5pD+6bsRTv/jpBF2wM9rdVnX49qLttYqX6g4dDhpiQ=;
 b=rK4YoloMVXpobVImwa42nYhC8n0gu5JH1cpGCo1TUnG7Gc+roMyAoeu0R9ujhBme0vx9yV
 AfmBhd6PlHL/suTLxid0Jt6+2XYvL/iq5/tnPE0Xq3TouJZJgeuGvZItk3CGqyGe0VNlM+
 +md1Tl+pbviwvohMpyDqTrbpWs1oipICB2VgHCeokgzI2CHriFWko4c5352HOFegos1o7U
 1q8fJMYgpq0zpKU5JL1YBuNFvByh6/efHcqdaXBuDgGlY/TYAmDdI7XQwkHU77RrbnIEQx
 AIIbg0l+zcU3JeZVQHjk0lG0la187P5TwejT3lUgFcD0uI9jRFNIzcOhDRo8Tg==
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Cc: <yukuai@fnnas.com>, <nilay@linux.ibm.com>, <bvanassche@acm.org>
Subject: [PATCH RESEND v4 7/7] blk-mq: add documentation for new queue attribute async_dpeth
Date: Sun, 16 Nov 2025 11:20:41 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <20251116032044.118664-8-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Received: from localhost.localdomain ([39.182.0.135]) by smtp.feishu.cn with ESMTPS; Sun, 16 Nov 2025 11:21:03 +0800
From: "Yu Kuai" <yukuai@fnnas.com>
X-Lms-Return-Path: <lba+269194320+af033c+vger.kernel.org+yukuai@fnnas.com>

Explain the attribute and the default value in different case.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 Documentation/ABI/stable/sysfs-block | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stabl=
e/sysfs-block
index 0ed10aeff86b..aa1e94169666 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -609,6 +609,40 @@ Description:
 		enabled, and whether tags are shared.
=20
=20
+What:		/sys/block/<disk>/queue/async_depth
+Date:		August 2025
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] Controls how many asynchronous requests may be allocated in the
+		block layer. The value is always capped at nr_requests.
+
+		When no elevator is active (none):
+		- async_depth is always equal to nr_requests.
+
+		For bfq scheduler:
+		- By default, async_depth is set to 75% of nr_requests.
+		  Internal limits are then derived from this value:
+		  * Sync writes: limited to async_depth (=E2=89=8875% of nr_requests).
+		  * Async I/O: limited to ~2/3 of async_depth (=E2=89=8850% of nr_reques=
ts).
+
+		  If a bfq_queue is weight-raised:
+		  * Sync writes: limited to ~1/2 of async_depth (=E2=89=8837% of nr_requ=
ests).
+		  * Async I/O: limited to ~1/4 of async_depth (=E2=89=8818% of nr_reques=
ts).
+
+		- If the user writes a custom value to async_depth, BFQ will recompute
+		  these limits proportionally based on the new value.
+
+		For Kyber:
+		- By default async_depth is set to 75% of nr_requests.
+		- If the user writes a custom value to async_depth, then it override the
+		  default and directly control the limit for writes and async I/O.
+
+		For mq-deadline:
+		- By default async_depth is set to nr_requests.
+		- If the user writes a custom value to async_depth, then it override the
+		  default and directly control the limit for writes and async I/O.
+
+
 What:		/sys/block/<disk>/queue/nr_zones
 Date:		November 2018
 Contact:	Damien Le Moal <damien.lemoal@wdc.com>
--=20
2.51.0
