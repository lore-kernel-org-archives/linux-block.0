Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2912E3EB0F6
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042821; cv=none; b=av3VfdTeLPIHz4oaBEUV3E9VYb6p0OmwRo3Bu7Q7AgE1bDIxCAM0SNcxeh7z7upowzrB538P4c6AY3ZWiImn9qy69x8yjUZ2ThmHabnAkP7ujmELbFHRWJmHCS7JTpCceHWKxvmOYS3O6Gpk5qiZiXRES0B0+vAmZ3tcyrv5JO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042821; c=relaxed/simple;
	bh=hAz5S1dpj0bmAq3RfOpYbvZNaPPN2OY8J6Gxnm3dfBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUoOx6iMuu9FvOJ4atvE99vhdL2KAHjZ4B1l4dChOjL6Fe7tY4kRlSt/LDs6sSEg43UoECB04DLbz5jpPFzXUrNSowz6389vYQJrdGGPSEqwTb+u/4lTvf9zsJDPsgNEqFPRgKUen6cNlAuUZARuZ4gYqbRpBC5iwB7Dk70gAis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=dCi2AC5K; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="dCi2AC5K"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjgR4mflzlh1Mn;
	Tue,  9 Jun 2026 22:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042816; x=1783634817; bh=hAz5S
	1dpj0bmAq3RfOpYbvZNaPPN2OY8J6Gxnm3dfBk=; b=dCi2AC5KK9S2bzOaXrXdp
	9GOHkVpJWSX0HlQo40vA/uPAKQ1266ZbFMvcZ9bx6fQEoGzBQnjjbKsUqZXKae+Q
	Et4+CA788YMnfuVlbAA4aSnFOS8N2gbsX7AxNNJc+Za89kUhA/7Xb4G8F1RpBmtm
	+rFKDvG1byVxToPB6NBvBKtYCLgfQVok/vUiYuxRWXTlDmbkyp1+Wh+g3GeCXg7t
	n76wVGCHcOYQaMdv6H6shy+Uz+QbjcU2vaHzPaAHKdQpo1CHBanTCjZ445YGxFOg
	i6gTMmuQP/paTp6FOpA7bIO+df+mOuB0/znN1kKl/w7NB4asQfoqM2MG9EedzdCO
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id bdYmf3heCL1i; Tue,  9 Jun 2026 22:06:56 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjgL2cnpzlfdfW;
	Tue,  9 Jun 2026 22:06:54 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Jack Wang <jinpu.wang@ionos.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 26/27] rnbd: Enable lock context analysis
Date: Tue,  9 Jun 2026 15:05:13 -0700
Message-ID: <87e1574f8c0f416d1364400cb7d21d6baf6f91cb.1781042470.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <cover.1781042470.git.bvanassche@acm.org>
References: <cover.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let Clang verify lock and unlock calls. Enable lock context analysis in t=
he
Makefile.

Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/rnbd/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/rnbd/Makefile b/drivers/block/rnbd/Makefile
index 208e5f865497..42c2cccdb53d 100644
--- a/drivers/block/rnbd/Makefile
+++ b/drivers/block/rnbd/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
=20
+CONTEXT_ANALYSIS :=3D y
+
 ccflags-y :=3D -I$(srctree)/drivers/infiniband/ulp/rtrs
=20
 rnbd-client-y :=3D rnbd-clt.o \
