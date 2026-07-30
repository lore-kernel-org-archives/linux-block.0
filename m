Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5E23C454E
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441588; cv=none; b=mLYbTYfKKW57nQ9VEp3ZdAhdtLsnuGHr5hCx0PZvqnENDEwTBLv8epfPdi25E7xT/j57UFQn7u80stSDGgmDzjetmB7wzujoU9qzphfMfFm4mmh3d24o1I5VJJGAdDJyC3gn+gfV1FDefhRYyCIls9mT4m+tskigct+HanHYSf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441588; c=relaxed/simple;
	bh=kHxBotN/SwrfFbk4j+imwZTP9ygr70pQ06/NEOLoxNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDHvw+aigRWgmCOyeNLnHuLR+2IsQjFMMtHYanZI0xgt9WSji/cdXzzHk1vN6fd6S+ncxWMvtYxIMEBoioEH727MNUtznPSjEYXTk3zEFDoem7M/OLpQ/fyf9ZaL9Pqsy7uDf3yKPcv18IlwxoA6oH5y7nQYxrmOktKWTn3UWXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=25lVbKyf; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="25lVbKyf"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hB0R32Xg6zlfpLr;
	Thu, 30 Jul 2026 19:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1785441580; x=1788033581; bh=t5fDN
	pr2qQLkJvzCEQhXxsJFK3s4Hc+5JqUskXdsgIo=; b=25lVbKyfj0E0SA77aZN5K
	DCw4/W/Q62srKuUSGaQXt3NYyCEZpRcxy0dRjtLWeTVkr/5aaicVWu07X2JjFB4x
	xlEVYwGYMODIW+9EMqsmaiSqIcMr3kYV9Cbk80o08WRP3NzE1Hf7W5xtHs/dAb4a
	o9KJdG3XVpE7fNGeh0v2nAC1K/zb2NmFjrc+X5cMsTk5pYMdbzXGo8Hr0C4tPRg+
	TBbroGxdmhHpUq+LWR3rYv14kCxIN1Laff+795sgMryzgvGkdYVbeq/ktQodBUYW
	nEHoKSzn/FEU5NFycMRoODnf+VXjdM4sPVFCQz1k770DgLD8D74EHRMjUEvMxGs9
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IzkA6HYWbH4d; Thu, 30 Jul 2026 19:59:40 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hB0Qy2Prpzlfvps;
	Thu, 30 Jul 2026 19:59:38 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 12/12] block: Enable lock context analysis for all block drivers
Date: Thu, 30 Jul 2026 12:58:35 -0700
Message-ID: <cf04896c812147e509ea174ad31b278f98c4b43b.1785440858.git.bvanassche@acm.org>
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

Now that all locking functions in block drivers have been annotated,
enable lock context analysis for all block drivers at the top level of
drivers/block/.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 2d8096eb8cdf..e17f6381b798 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -6,6 +6,8 @@
 # Rewritten to use lists instead of if-statements.
 #=20
=20
+CONTEXT_ANALYSIS :=3D y
+
 # needed for trace events
 ccflags-y				+=3D -I$(src)
=20
