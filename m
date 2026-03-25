Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6E634B1AB
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475204; cv=none; b=AT8qj1wOMefLR4WtXlHetzkDP8xppoQpw/7pZgsDLm35Zp2Yl48wgbO9rsADdOQW8ZadMXxl076KKWW4Vx4WDyQq0SgrjUnndXNTwi0LEJCLhkfKzVJA3JCpLkPFpACDfGTDKD5a8jgQTk9z0hO7wv5SYDv41E7PhcnSTma3X58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475204; c=relaxed/simple;
	bh=kHxBotN/SwrfFbk4j+imwZTP9ygr70pQ06/NEOLoxNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZQfenpW5DHBKcgHKRgGZjxZPM3r9tm1pZMzLoexO8IPoEHErcSW8QkV0c8X/19Eyh+a1Yw2XH34fBEqdAyIVOwWHPvrI5VlRX86j3n6/eSILbJk7N2+yMRZJME3zsPIA3dZjED6mU4KbGo5T1xis8Vk9FsKJ8JfRgLXvnK4gKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AzC9oirw; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AzC9oirw"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0q73YJQzlfpMC;
	Wed, 25 Mar 2026 21:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475199; x=1777067200; bh=t5fDN
	pr2qQLkJvzCEQhXxsJFK3s4Hc+5JqUskXdsgIo=; b=AzC9oirw8Ta1KcYuY6R7X
	zQbKQPeqPoU9jYUm0TNlFAyNtprmhzsvdakzlmkp1I4o/9QnyDp2kO7a2xbLplTq
	0DUamHnQKKuWLEK1414ubtLeSHiLRYkFCCIEmxaqmzT3xEOoKwJKeZTGrdvMNkO4
	sNk6zdsUWhC61hI8wc8OP8JETjt8sA5CvsBYajof8f9FSPH7Zv7qJTrRupCd9CCG
	a9Qf/2WY7GXdJbAjh2/PDcHqg2gaTJRYPm8HmXR5cJVU+eaOh4HT5hkTjxQ1aK8F
	fYPmzNVp94mAme6u6LyN3onrT3viCSCYN7VYJacpJ38YlQvJX7PXLdgFgW1WjnX3
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Tpm4ObWTmqbN; Wed, 25 Mar 2026 21:46:39 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0q161W2zlfdGT;
	Wed, 25 Mar 2026 21:46:37 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 26/26] block: Enable lock context analysis for all block drivers
Date: Wed, 25 Mar 2026 14:45:07 -0700
Message-ID: <20260325214518.2854494-27-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
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
