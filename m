Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFD12FC00B
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 21:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154274; cv=none; b=SaUCey7ESAZ35c9oCFmTkfxVae+lUf8/BGpW3FuxLI5cfRB9AN8gXPBt7eI0WU9zMIomT09NNYzmf7eEJOsYfPu2x2GyqwamnWlW/H2kSma08JAMtKy2prq4Lsg/dBqeQdPaoeicSJHK/nWA7oIQEJ7oHKbYbtJmEXQHQK0doMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154274; c=relaxed/simple;
	bh=iAoeejJHzHLq9AowoPtgzGtAR7le5I7zVHg2FfwzRwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ejMJF/WzYgtx/bIHnglgjFdH/SlvofFpCZ1jHHfJl1i1tpsy89r6Qi0Hb8dljiMqV0e9jVl4BjGq7sTTzlxKZ4odNlIFcjLlJicyImKNrQ05rn63reTCHs2X6uQwIiaPtnhV6TszR4BzqbxNuwEtuECZv3YI7O0i4TL4ecorpU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=01CFr4yf; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="01CFr4yf"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d7V4w18xFzm1y32;
	Fri, 14 Nov 2025 21:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1763154270; x=1765746271; bh=+sWqJSWpG45dKMbGA6vwPwqRSlUHHHQU2e6
	K2VeAF1Q=; b=01CFr4yfCM6gf8td3eaNslAotozTrYepEI3zbbHkxPurzpCRH3I
	zrdxnRr5Hww20nWYAHFE52YosqVX49gz9kbL6vSgh4qcKI6r/LXRI8aCpKTfUtsZ
	Bkxz0Rwe/VjcxGXa8D1o7s9MgQ1Afw9gHEkldqMIWQNsnhQeHtEoQOdmJQprZqqB
	KM+++CeqBGNsbZxau4qAC/5sapIrG0kKKHKi0H1uQLnU9x7ICKsUFWPzxF1Snax8
	GpkHBGIPA+Z763EBQatkvbQHFoJMtB0UA93+cW+S0fDqFaxnefafO5Zg1RHHHngd
	nqK8Oinfou/k3tR3R6UUP1Gkd6JUtjjXNGQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sA2Z7ZIhCEf6; Fri, 14 Nov 2025 21:04:30 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d7V4p2qqLzm1DtP;
	Fri, 14 Nov 2025 21:04:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v6 0/2] Fix a recently introduced deadlock
Date: Fri, 14 Nov 2025 13:04:05 -0800
Message-ID: <20251114210409.3123309-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

This patch series fixes a recently introduced deadlock triggered by modif=
ying
request queue sysfs attributes if the dm-multipath queue_if_no_path attri=
bute
is set. Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v5:
 - Added a new patch for include/linux/backing-dev-defs.h.
 - Removed the data_race() invocations and added __data_racy annotations
   instead.

Changes compared to v4:
 - Use WRITE_ONCE() to update bdi->ra_pages.
 - Move a data_race() annotation from queue_io_timeout_store() into
   blk_queue_rq_timeout().

Changes compared to v3:
 - Added two data_race() annotations.

Changes compared to v2:
 - Dropped the controversial patch "block: Restrict the duration of sysfs
   attribute changes".

Changes compared to v1:
 - Added patch "block: Restrict the duration of sysfs attribute changes".
 - Remove queue freezing from more sysfs callbacks.

Bart Van Assche (2):
  fs: Add the __data_racy annotation to backing_dev_info.ra_pages
  block: Remove queue freezing from several sysfs store callbacks

 block/blk-sysfs.c                | 26 ++++++++------------------
 include/linux/backing-dev-defs.h |  4 +++-
 include/linux/blkdev.h           |  2 +-
 3 files changed, 12 insertions(+), 20 deletions(-)

