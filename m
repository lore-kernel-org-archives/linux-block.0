Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1A02D6E49
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927859; cv=none; b=ShK/1s5owfoALQ4kPHN1/ZMM0OciZ14mkrK046PFEwp2DCM3L2RtkYHhcKIAaA8FmjSqVoOFj/xI0qa59TIL3P2k8efAfEXRVweDwscUIFXo+zj/vomB7FDhh+mMppIx59AV38CudZ8xyuHBfxap9BiUzlIrUFGMTRUVry3dJ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927859; c=relaxed/simple;
	bh=WyujT6t8+wFo5KWA+dj87nmleNSyhfjHYeCEMBJe7jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5yPtKVYlOkoxcAEq1Qbb+eV+G52LGN8EsU3H4iwWu1CrNVD/zLDVdQx3eRADsVTqPW7mAKz0LhCrzD7Ta2E8AVCo6t+QDJFn/AOFkcEjJStzE56tXu5oQakBsyqZ1rfcv4QjyHA1gY7PkDNYzDo/n3YQILwgygyvc9qMWp9OeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SIrjBTVF; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SIrjBTVF"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4c0zmd2Rmzzm0ytX;
	Mon, 11 Aug 2025 15:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1754927855; x=1757519856; bh=RoUfp
	OLwiVarujsHUJikUOw5XcHTa9UCpbc188nlx8s=; b=SIrjBTVF3SE+s+d7QdfwD
	YtTJLjZJ23BCddqU04nc1MKlf+XFvkWfwfI4pk2hz57Xd3upjZs9R3HCPZGUGdcr
	69Rhp4VaBZbevzVIGRMT7o3lMlz3hQonV1WLZwEwUsbv8dKHs36niofTF3wrxjaG
	TnGVacJPPIeHXkDLm682QqebO+xUnvLlhiIJGgREY1X8f+FIcdTEAzoGxuVwqsqP
	11zl3iJZbFO5NTwNRLvxfpANmxUD2xCHvLO+lw8VXv1hLjqv9UJVRcRtcyr1czBc
	Lf8JmExif8GCb+zG/969HGymeHWx+LQ49uv6rpRUYv+j/FpYAiVAozDHyKdu7D0b
	w==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tMMswv40KyNG; Mon, 11 Aug 2025 15:57:35 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4c0zmR1sQ6zm0ySS;
	Mon, 11 Aug 2025 15:57:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Coly Li <colyli@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kent Overstreet <koverstreet@google.com>
Subject: [PATCH v2 3/5] bcache, tracing: Do not truncate orig_sector
Date: Mon, 11 Aug 2025 08:56:50 -0700
Message-ID: <20250811155702.401150-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
In-Reply-To: <20250811155702.401150-1-bvanassche@acm.org>
References: <20250811155702.401150-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change the type of orig_sector from dev_t (unsigned int) into sector_t
(u64) to prevent truncation of orig_sector by the tracing code.

Cc: Kent Overstreet <kent.overstreet@linux.dev>
Acked-by: Coly Li <colyli@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Fixes: cafe56359144 ("bcache: A block layer cache")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/trace/events/bcache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/bcache.h b/include/trace/events/bcache.=
h
index 899fdacf57b9..d0eee403dc15 100644
--- a/include/trace/events/bcache.h
+++ b/include/trace/events/bcache.h
@@ -16,7 +16,7 @@ DECLARE_EVENT_CLASS(bcache_request,
 		__field(unsigned int,	orig_major		)
 		__field(unsigned int,	orig_minor		)
 		__field(sector_t,	sector			)
-		__field(dev_t,		orig_sector		)
+		__field(sector_t,	orig_sector		)
 		__field(unsigned int,	nr_sector		)
 		__array(char,		rwbs,	6		)
 	),
