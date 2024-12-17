Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE96EEB2
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734475113; cv=none; b=jpuYrKKjMifohRwbl/lqdcqaPxUyZXjnjn6hFuzSCUpKXWDTEtCgnRfmokK0PjF7z/RlCMpubo2R5wfwZN13eK59WCC9M6zbmI/OlD74y0+gZGZEGLZ4s2GfKfLxeO/nLiKWJlIz3cWjIQFIAXRfhWWEaW5p0GMEUe7Ujd8qnzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734475113; c=relaxed/simple;
	bh=ZmUQU3cdHQ2y5NuNBiEsR/4UV+YQTq+H9GWA8FVoSl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z1x23JQef1AiA3PzgviIiMiHhwdDbmRoZ2FirBNMqkG1UXO4oMLwVxx4XSs7Zr5oerD4lNMFwJoq+9DXZLxL9VlNmtiOfPoKDungDMzBBLNh+fbetz/4QDInpeQjAI9OFsaGC7IlSdRHwQYIszMFy6oQm1rPSgxMldPyZmPkarE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AuPRoLiJ; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AuPRoLiJ"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YCWtZ6GKVzlff0M;
	Tue, 17 Dec 2024 22:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1734475108; x=1737067109; bh=bSIZ7dXoD1rWmgCn7XvqK3h+wFGYLWH4KD5
	tC/qtZFo=; b=AuPRoLiJTYmWL1q+fFCsUjEzte0+XTkBxPNWRvzO1Q1Yu90jAbf
	mbNcpGN98VrRhWPNxc8BZEluUvFxgeLJ+5X/xfShvhPvSIhq0MDVGt54jsJ4K/Qo
	bCPybfjHEfIcGj7XvDzm9O//8zs2eUFnYa/cLMGja7FwENx5NngClk9t471sw/wT
	RAKrnt6+vnbKxR97VOe0d6H4LequppIsWz5Yx3q01aCAI935NxWFs8vSis1wLjnB
	HFWiTdgzNVQ00ddYQFK8dRU0mayal7msp6ma/SiEG4UGT8fYk10sApDBbR6Hny6U
	sgbBhhCLTkwOd8j3fiBGjtGZ0Msbqp9qEow==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sF_2yC4LHtu3; Tue, 17 Dec 2024 22:38:28 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YCWtW4RJLzlff02;
	Tue, 17 Dec 2024 22:38:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/3] Three blk_mq_submit_bio() patches
Date: Tue, 17 Dec 2024 14:38:06 -0800
Message-ID: <20241217223809.683035-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

This patch series includes:
 - One patch with a micro-optimization for blk_mq_submit_bio().
 - Two patches that improve blk_mq_submit_bio() readability by moving err=
or
   handling code into blk_mq_submit_bio().

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v1 of this patch series:
 - Addressed Christoph's comments on patch 2/3.
 - Added patch 3/3 to this series.

Bart Van Assche (3):
  block: Optimize blk_mq_submit_bio() for the cache hit scenario
  blk-mq: Move more error handling into blk_mq_submit_bio()
  blk-zoned: Move more error handling into blk_mq_submit_bio()

 block/blk-mq.c         | 36 +++++++++++++++--------
 block/blk-zoned.c      | 67 +++++++++++++++++++-----------------------
 include/linux/blkdev.h | 13 ++++++--
 3 files changed, 66 insertions(+), 50 deletions(-)

