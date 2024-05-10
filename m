Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6C44D9EF
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715372619; cv=none; b=Ad9+e8Hggg7qxeyhBAbKdnodH8F/H7tDos+H3bIvKyPwbDXSVH3iGsjJ1tQ9JPpbG3zV6dNMXrVZka+noPO0+kweoeaSEPUQPvifGEfiEGoeYS0+v2UjxcHl3Q17jP8dzYtCFlmb8SLLrgnRQlZoBb31Sj0mzVwsmZFau5w2oOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715372619; c=relaxed/simple;
	bh=SU48rvFsJmciPJZDbPt/sSt+K7l6wEHLMj/VbI3UBU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7dR5X0ClOFepBfWRfBjAZXX2oxDfRPH8ls1jDf7jxPW5tI8dEQQgUUrOf9KAJWthQGpKFg4QOlFJQ6uNyDUDBtzQOZs6EpLsVkoWOeU4sqbvFDW/TRKTl2sKxZHwmj5ua+ID5buP0SEewenh3AO6OyxiNTtE/qRdzD6Vc1XlpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Qjve3fli; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Qjve3fli"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VbgLl0s2bz6Cnk97;
	Fri, 10 May 2024 20:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1715372604; x=1717964605; bh=ncpBU
	YtPwyHbcLGHAP9rZjdTni9O+34Sb/jyhW2bRmA=; b=Qjve3fliwSN+4dt9/DjV1
	xyUDw186+m8I7CNedSADT3xoTD04kng16UEk0HnejGpO84ISirQKOLeGX7cFNBAb
	Q+gsAY1xTcP2fpGER1zawSoZjG25LiJvO4ih6yqhK5E5WdUcjgTM38DPfi58bHdX
	UcD+THO1TEE8Hkv+zoM4Bs+z04wgDbwU/LmZvjGOSzWYti0+/Q4uxoE9CH6YMaiR
	UMAsrkKe743WnBAoN2x2AiUjfqs8lg1H7giy9novTrkWXN0FllzzpzXY4gNgETUy
	e5vr0SenN6skYqQKILE36l88fJR08A5eFAH2vweuzfFt/jfugG16Qn2TeN3Gx5B2
	g==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id yr2wsDA8Ulx1; Fri, 10 May 2024 20:23:24 +0000 (UTC)
Received: from asus.hsd1.ca.comcast.net (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VbgLg18CGz6Cnk8y;
	Fri, 10 May 2024 20:23:23 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Josef Bacik <jbacik@fb.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 1/5] nbd: Use NULL to represent a pointer
Date: Fri, 10 May 2024 13:23:09 -0700
Message-ID: <20240510202313.25209-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510202313.25209-1-bvanassche@acm.org>
References: <20240510202313.25209-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch fixes the following sparse warnings:

drivers/block/nbd.c: note: in included file (through include/trace/trace_=
events.h, include/trace/define_trace.h, include/trace/events/nbd.h):
./include/trace/events/nbd.h:61:1: warning: Using plain integer as NULL p=
ointer
drivers/block/nbd.c: note: in included file (through include/trace/perf.h=
, include/trace/define_trace.h, include/trace/events/nbd.h):
./include/trace/events/nbd.h:61:1: warning: Using plain integer as NULL p=
ointer

Cc: Christoph Hellwig <hch@lst.de>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/trace/events/nbd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/nbd.h b/include/trace/events/nbd.h
index 9849956f34d8..390d98a05c9d 100644
--- a/include/trace/events/nbd.h
+++ b/include/trace/events/nbd.h
@@ -72,7 +72,7 @@ DECLARE_EVENT_CLASS(nbd_send_request,
 	),
=20
 	TP_fast_assign(
-		__entry->nbd_request =3D 0;
+		__entry->nbd_request =3D NULL;
 		__entry->dev_index =3D index;
 		__entry->request =3D rq;
 	),
