Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D096FB0
	for <linux-block@vger.kernel.org>; Thu,  9 May 2024 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715274134; cv=none; b=TNgQExo7h4LZxCWjBrFNyg0JXvCimrMhYWWwXEi9IWf6zCaOLeUG0C6hudR5gQfesNZXUxq+ZfPfwuyrxbUGdJxe9PBMrveWUjZY/VK0NoIgewN5gyMsnfxmaYMUNBIEvqLFx6cnVIYPM+O8WV4n4+OGowqW73SplkOZ3PaTSpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715274134; c=relaxed/simple;
	bh=DtExn3EaGc/EfpsnRbnVgkyhyvGdLhXBs53EEL8IUww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a9yXYSCetznlyHsvDtmF8+FOMBC4B/PsRxj1GO4s1vhEk6n3xpB0ge1kaeKeNY0ucbcWbEtHc6+Kt3A5aplja+ViBhzw8dZOFOZWAUSlLsa2EGTVNxAPpNHI9LigyUi/iPtstSNb+iPlILevYZZxEaCQC1h9qeWCSa3Nq7Cnfq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0nqns0Nz; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0nqns0Nz"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VZyx00hTlz6Cnk8y;
	Thu,  9 May 2024 17:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1715274130; x=1717866131; bh=A5Op8ee3JY+tIS9DWFF2MuZJTVbeqb0ttgo
	60Eiq8Vg=; b=0nqns0NzEHXkJ/rLH87zwGK5nhdFGGFt3s2IvDEFeN8COwRmPmQ
	tQyQow8elFLJhVtsDZU3WDElNpZQH8VJBxg+fZnjtY7rgJh6UFKFq16VYgJdIABx
	/keriow3eF1gvChZ+Q/RVaygDWczJj4tRRmy+sKAVAKgMdeMpYu9FJwQwLt0nOw1
	PU30ocXwyBJxuVGR6Kyy+UHfQGFOQBKZfGXzS01a7osuX1GX4dJN/W+GKChR2EU4
	c7W+JZVf5hf9rDnvXsPDmQKT+6ZG1OPSijtd3ZGJPpIRmGnThLWox7mVlMbUsb4S
	lad/dfAEzEsw+Zddj/X9+Z3nxyNDxeXImMQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wipcbLBDp8b6; Thu,  9 May 2024 17:02:10 +0000 (UTC)
Received: from asus.hsd1.ca.comcast.net (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VZywx1y2Rz6Cnk8s;
	Thu,  9 May 2024 17:02:08 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/2] Fix the mq-deadline async_depth implementation
Date: Thu,  9 May 2024 10:01:47 -0700
Message-ID: <20240509170149.7639-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

The mq-deadline 'async_depth' sysfs attribute doesn't behave as intended.=
 This
patch series fixes the implementation of that attribute.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v1: replaced patch 1/2 with a patch from Christoph.

Bart Van Assche (2):
  block: Call .limit_depth() after .hctx has been set
  block/mq-deadline: Fix the tag reservation code

 block/blk-mq.c      | 12 ++++++------
 block/mq-deadline.c | 20 +++++++++++++++++---
 2 files changed, 23 insertions(+), 9 deletions(-)

