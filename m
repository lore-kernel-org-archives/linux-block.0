Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB715369D51
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042821; cv=none; b=mEJ2xwjkh7nP+EMI26leXF+3Jcp7bIqogwpLqc7i3F9FN3Wu2LsUqD1XWmvWfNS9zL4SDVSzBujvG7UjgCKaax7PQ/7efphV664PbkTU8Cwk5PWhYH/fvFqEP5exIRWpJN9e7C0UbXfEXtGbWo/yErN8jCgEDcgXkjnz3JEmcVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042821; c=relaxed/simple;
	bh=kHxBotN/SwrfFbk4j+imwZTP9ygr70pQ06/NEOLoxNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECwiNsgIwqXqhQQioocOhDWCD4mIFxt0jebC6IPqi610hdysPQ0gKOmAl1QJogMND3hsuQjQATTqbWwWlvM/NtMHuwX9vFJyuVNHSzHWEfNfsvzSUhZeBcHc7VPyhvazzxQj+BMT0I7jlSUUleYl3vpmMqmc0fcNt3J1YSZqw4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nENuuMvn; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nENuuMvn"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjgS3pQHzlfdfW;
	Tue,  9 Jun 2026 22:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042818; x=1783634819; bh=t5fDN
	pr2qQLkJvzCEQhXxsJFK3s4Hc+5JqUskXdsgIo=; b=nENuuMvnnx+wThByBUx7z
	UPJZIstQBrFxrg5zwlS32DMZC3PLVbY0cC9LvR69mDT0F46gDH7TXXFK9b+jOe68
	pwBsKIGqG9316ErT38I9aTlk6qDEZLYqsklBKycBKzc9nmCN8/YS6ekOyx3+fHJ1
	lzkSZHymu+8kfr/wKG5v7R3Op9T6ZaHbk0Ss5fI86qhZa3p3JgSmgUNWobd89CZg
	jTNQ2Knl8wV3MD5rspN24hiMhD9I24/UAVJdknZgUKewrU5C9Xnn3uyKGsjUgVLn
	s5t5fgM6CS4t2SJb6SPVYgFSXVOOCovB1fZ2hr/5ui3wCmYb2g+9OBSXjlZGZK9v
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id v1S_U9ukMwSB; Tue,  9 Jun 2026 22:06:58 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjgN67mMzlh2rZ;
	Tue,  9 Jun 2026 22:06:56 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 27/27] block: Enable lock context analysis for all block drivers
Date: Tue,  9 Jun 2026 15:05:14 -0700
Message-ID: <ab2c5036f7a0aae23da07e54c781289494650c48.1781042470.git.bvanassche@acm.org>
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
