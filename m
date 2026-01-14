Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F64B342509
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768418903; cv=none; b=B2N6Br+Tdxc+6Qo1wWxAu9p7zZVr6v3u8r6zzTI/K2AotrzpWFo6Gz9swqoXcAcNdCWG8M4xD5o/socrz68umOLVh3Opi7nDkQ2f7aaygUG9/WNdFSJLBZicyJzsWEO9W5zQc4Dwu+M5fVkP9LYtCnDyWOnjBkzCGVIAmhGq7Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768418903; c=relaxed/simple;
	bh=cUH5bM5HFzfTWJm5cSou4PcyQsw2Y0xdVVI4/JbnNDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQpv+8salNQIk4hd+tdlusoMn+pnezPEkBA7OVUTPp6r/t5Wq2Iz4xrWDcIEuZPWw5BGhx6y4GboAs+4gzVfghWqhR2BtFcmejqvYA4SJn+pjNwiU1E/XB7H5AsV7QR8pbixwVZWQs/mzDxG6v3TZcurWmGlmAL2eGkEBwD4Qrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2kZWXDtG; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="2kZWXDtG"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4drx3p06JZzllB7X;
	Wed, 14 Jan 2026 19:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1768418900; x=1771010901; bh=2f10t
	uGrtn5UdpS24AjOqi8BIthVBlCIHtZIjYdR/GE=; b=2kZWXDtGsLRMT6fph2F/1
	mdYHrt7jrzTyeNGomQoYx7TBTbBkLSrPiSq+F/w8O+CbheaFEytOzx9hYEcoln40
	SqVB1enQ7EvLJ/mZ23bSMklNHbwRBmcRooYtkITxdMF98ceVP3zHma11hws0/qdB
	o4Ul03qTI7iDvRekiGTSJusUIGZEaofPkVT2UJ7AolHFSNxF0d3JNgHyjs1QpByd
	skY9z1PZpwedLhXZjcddV97/slXzAMsVWOtB9Nf5sXVgzIlpjD4O1Vr/53FiFSKO
	U7nXietLGKcskaymX0zovQHuJzoYmydKBu+LcTr+qW/cPIR+w5Xvcf1o/Eg5NQB/
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 12Vi8SbwvgAN; Wed, 14 Jan 2026 19:28:20 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4drx3k0WPZzlhpcd;
	Wed, 14 Jan 2026 19:28:17 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] block: Fix an error path in disk_update_zone_resources()
Date: Wed, 14 Jan 2026 11:28:02 -0800
Message-ID: <20260114192803.4171847-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260114192803.4171847-1-bvanassche@acm.org>
References: <20260114192803.4171847-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Any queue_limits_start_update() call must be followed either by a
queue_limits_commit_update() call or by a queue_limits_cancel_update()
call. Make sure that the error path near the start of
disk_update_zone_resources() follows this requirement. Remove the
"goto unfreeze" statement from that error path to make the code easier
to verify.

This was detected by annotating the queue_limits_*() calls with Clang
thread-safety attributes and by building the kernel with thread-safety
checking enabled. Without this patch and with thread-safety checking
enabled, the following error is reported:

block/blk-zoned.c:2020:1: error: mutex 'disk->queue->limits_lock' is not =
held on every path through here [-Werror,-Wthread-safety-analysis]
 2020 | }
      | ^
block/blk-zoned.c:1959:8: note: mutex acquired here
 1959 |         lim =3D queue_limits_start_update(q);
      |               ^

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Fixes: bba4322e3f30 ("block: freeze queue when updating zone resources")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 1c54678fae6b..8000c94690ee 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1957,6 +1957,7 @@ static int disk_update_zone_resources(struct gendis=
k *disk,
=20
 	disk->nr_zones =3D args->nr_zones;
 	if (args->nr_conv_zones >=3D disk->nr_zones) {
+		queue_limits_cancel_update(q);
 		pr_warn("%s: Invalid number of conventional zones %u / %u\n",
 			disk->disk_name, args->nr_conv_zones, disk->nr_zones);
 		ret =3D -ENODEV;
