Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6B22C683
	for <linux-block@vger.kernel.org>; Wed,  3 Apr 2024 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179450; cv=none; b=fFqsmhvhKhFaVMY7pcFx1MV7p5ABaO5FF/KYhnl4XJGSZer8hmZuUlgZTRl4cQ+IXb72yRPSvGcSrqZYSwxUpLoNmQByyyWpwl5kKjpA3D6tpkY3WKdhW4DaIMFtbqwnXge1EwZYHuls5KRqMtmwZOfJk1g41fcLepPYGfnRteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179450; c=relaxed/simple;
	bh=2zD08erzhYzj8fAootPB/+CKjY1CNlGtyUrCaNSo2ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZWI4657p1uDGVtTzHh8eka9dEeDMChRs+akjdc1dM3GXPVDj1FnBdFpbPEVlYXkTkciYhkdg/fvy7V8A2TGBgLMewcE4hi6G6OJZSo+2vzelRQqQommoLN98WAmI9i1bEyOpyDWuHYfjjm8ydTIh+YNuiPUTeAqVyNcjqLuTkeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XaZH0PwR; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XaZH0PwR"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V8yRr3YwXzlgVnK;
	Wed,  3 Apr 2024 21:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1712179447; x=1714771448; bh=w3psQ1HSWcWe3VmeeAqlxuWiAqKm8YmdVfD
	sz+lYqSM=; b=XaZH0PwRm0x67mpQd6MYYXef6eHF5rz1AxWejlHTmYqqfNb6KDA
	JkeUeFx2XZliM3ZEJKS+JGQrMUq50s9TgWwsXNEch4hZq69/i6OYQMJIquVcRxbD
	QeqTcPh7eE+i27aajE8ZM/lDjJn3+qKlseM1J4MStulWGiq1yXhVJaIHzo0CaEC1
	tJG+UUq7un6bUmen/Y0uD+pvKIjkT4XP3YtESe9euCHujc8IfTSDq/q0GtaXjrwE
	G0EvFWWSf9jWRRPZOI5gFMn2DpFiA/GTslgB3JbeRo3Q1Awez69Ph3iTHVN+Qj4d
	T61hJtwdGT9DR4y00L9hoSK3RDxC+nhFyxQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id eWYc8tZxl1Eh; Wed,  3 Apr 2024 21:24:07 +0000 (UTC)
Received: from bvanassche-linux.mtv.corp.google.com (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V8yRp69j5zlgTHp;
	Wed,  3 Apr 2024 21:24:06 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] Fix the mq-deadline async_depth implementation
Date: Wed,  3 Apr 2024 14:23:52 -0700
Message-ID: <20240403212354.523925-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
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

Bart Van Assche (2):
  block: Call .limit_depth() after .hctx has been set
  block/mq-deadline: Fix the tag reservation code

 block/blk-mq.c      |  8 +++++---
 block/mq-deadline.c | 20 +++++++++++++++++---
 2 files changed, 22 insertions(+), 6 deletions(-)

