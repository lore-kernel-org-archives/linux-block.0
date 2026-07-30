Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5754C41CB2E
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441587; cv=none; b=QpeVKPmm9Tv0OIfwlM1lbguLrgoHMEiVIdnG9KZZD/TUwjpV7gKpqTrm5XAKe7+XBQr5xw4VnLG2BMU435VyozADb3jQuCzv8xKCMnoB54JEWeauCVtKq4RUPtsY1/+Dxg+eUCCl1MepPBLcr+MGCTRT6LjLT9QIuIV2G0zYDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441587; c=relaxed/simple;
	bh=hAz5S1dpj0bmAq3RfOpYbvZNaPPN2OY8J6Gxnm3dfBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6AbZCUahBZHlwFfHKolt+wnXTTTMIA+bMQ4XpObsuFkJiI2QzVFflsUmqz8fsnx0oxm/qt29ZVERnh7f9oQbFGo4wZMGStt8odkkWpeUe120nORjkFVVloTN9qnTg2Yi4g3gFHohpXAyktLK4JrNgRq0f0iScFLqYFJ1ZfJcDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=jkhAm06P; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="jkhAm06P"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hB0R20thKzlfvpx;
	Thu, 30 Jul 2026 19:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1785441577; x=1788033578; bh=hAz5S
	1dpj0bmAq3RfOpYbvZNaPPN2OY8J6Gxnm3dfBk=; b=jkhAm06PQVINT1hm3bfp+
	ADRiDI/becmuQNSPAz2xAMlVtQCz/T2U+0oZNYPZWM145VhZkcmqo7sScWw20IsI
	txC40V8t/A7PhKmNfo2z0sczaE1i6PiAmlA/tlxKxMOHZqsLoYVdMEeawYvFxegL
	DAKlnZTFSzlNDGVEU37OwjPAS667+C/6ewLgNZ2zwM82kFtae+XUgmLFbFAE0wIm
	HNc9PVCemCXKh+duwtHG1aYteLKoUjyshAE7lXeEfhlX1NRyeGgdz1W5nv9XCwy2
	rvDWoub0ohzvsgMqwmOepu1D4ZnDgn2cstVbEfXeItuJmtCl6zl3xmqVVGY4TzrI
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9YfKln6FKx9z; Thu, 30 Jul 2026 19:59:37 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hB0Qt4BSgzlfpLs;
	Thu, 30 Jul 2026 19:59:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Jack Wang <jinpu.wang@ionos.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 11/12] rnbd: Enable lock context analysis
Date: Thu, 30 Jul 2026 12:58:34 -0700
Message-ID: <2928cf978a2384d16e4bf4742c67dafe1d8aff05.1785440858.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <cover.1785440858.git.bvanassche@acm.org>
References: <cover.1785440858.git.bvanassche@acm.org>
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
