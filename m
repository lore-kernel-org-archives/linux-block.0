Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF3A19F464
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598393; cv=none; b=NNbcXPUEZ49xf0rCatzP87a2BwuWFzXBE5sS/hTmTtiTCNoWbCBQUgE2yOJfaeL3hyFpVjL7TbQMgxvZeq86J/HDLGYON20HNdppEK7ABzETjmGHHkaJ6iWfkl8XgOsgyAGvtq703xmvmhdmgiMbnj9g6S6nCr0W7qMI3FMysTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598393; c=relaxed/simple;
	bh=LEpDSilONijSZtjffkLmwnfO9ID7ivGsWaSqCekM89w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wmi0yL4MBIhvKI8PxdvpdM5x5TMxvUaKM95TRKjanaGt7h0R5QXNYaaMFaug8k4lIdLN1lx9VdnKHK9kIr3ezWq2FHZ4VRNpv7r90v4YzCMJ3jtVVHPuQTpdgqAMRhimDV/H9RyPLth6MEzauZM8t50UZLrxEBzLHTw/um+mOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=EfVI+XYR; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="EfVI+XYR"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bhQH42PxYzm174R;
	Tue, 15 Jul 2025 16:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1752598383; x=1755190384; bh=j8Bq9BNJcQfLYfphuzpwrxx1Dr/X8dwAACb
	Uxbv805Q=; b=EfVI+XYR8RuYjkNfGBl9wyaFBdHmY2FyBeAwHuvZb+Q+58QrcjT
	z0VP3ON3IkMv4F68OQlh+A7kEQ+QaNn9o6SG8z4892scVaTnyCUlM4O1Np0zyWZt
	HeKj9fxApdrYylLjXNL9MmyLcKGj/0VFHMmoOnQyt+Ptb9bozyVWt6DKiHp1c8tI
	u0PKKyklfa/loLlburFh8dTxnGaPV2Z9370cEJHJukz2ahCkgBBp/hx6FHQh6nOR
	4lmYmpdsnPXc8SzMB5+QbE1osATFUZT4ZZ32WagxlaiNtAJ6OijaQmgdJlKf4iTc
	FsBZQp2L7TvbRQ+EXMvWWj8bNmU0e/a3KQQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9VOQ70yc4fRu; Tue, 15 Jul 2025 16:53:03 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bhQH06jPczm174L;
	Tue, 15 Jul 2025 16:53:00 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/5] Remove several superfluous sector casts
Date: Tue, 15 Jul 2025 09:52:34 -0700
Message-ID: <20250715165249.1024639-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

This patch series fixes one bcache bug and removes superfluous casts of s=
ector
numbers / offsets. Please consider this patch series for the next merge w=
indow.

Thanks,

Bart.

Bart Van Assche (5):
  block, bfq: Remove a superfluous cast
  block, genhd: Remove disk_stats.sectors casts
  bcache, tracing: Do not truncate orig_sector
  bcache, tracing: Remove superfluous casts
  block, tracing: Remove superfluous casts

 block/bfq-iosched.c           |  3 +--
 block/genhd.c                 | 12 ++++++------
 include/trace/events/bcache.h | 15 +++++++--------
 include/trace/events/block.h  | 34 +++++++++++++---------------------
 4 files changed, 27 insertions(+), 37 deletions(-)

