Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91591A8412
	for <linux-block@vger.kernel.org>; Thu, 12 Dec 2024 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039018; cv=none; b=qoS8KF4RD2XC1fAP8pemmYD7ZaEi5eeTDZgik1jK5IfF/IS25CT6K9rGFzhlFivbdtgECYod9qUbI71aT42IvkJ2SIqXja8H6XccpFqO7GPKURyhyvCM6M3rbeLn36yIFFpCH16sHedWaw8ZqgUNZdjeDnx8kMf50BWJJTLRHVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039018; c=relaxed/simple;
	bh=bihH33pekKwsJyDmBMS/2pq2MW6UX7wlYVOUmVq4VNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJzkutH1VyQbk3KXAB9MpjfLYWenft6bLHnABJzSPVLljh0ANmg8m8krK+L19hGBvRrGIsQqi8Xc54DNDT2JFNkpTTKf8dppCCzZ4HeKEL40WAbYc01z7dx/QiUil0dMw8SMdPjKAddY6c2SfoIiToynjn6sFw2TbOzkUaW3z30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=J6m46zPC; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="J6m46zPC"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Y8Qc23g9Dz6ClGyn;
	Thu, 12 Dec 2024 21:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1734039008; x=1736631009; bh=XD8Z3lQfNvBc1mRVucLdgm0n63nmv1lFAqw
	y/B3oIww=; b=J6m46zPC5QyR1Ddcm7kc5Q84xv0bqYk3AtPiGgyXKLpzzjM019P
	kAlXvlDbQcshb//p7SQfwP/oWpQ/rXhOmv8/K0NieYI3MpoeVylLOhkOpKcbMOi/
	RbPfCQOPile9PWikQIhbO3xPmjeucV2/xJoh5Z7iZ+Z9osqBnfZtv5cU/di0+HAQ
	kJwUJBNsDfXW7rMDuNJhCNrPPwbN+Bx5T/OkDlLgTtLaInT7R5np2TlipRhOUzAw
	ONnvq92WtA3noR4UO4m+lc7wUfk5gIbUqiKYW8DDy/NmR5CKY0xIrWBhKKhLXuuK
	E7vXV/YBI0pIJAxaDRpUeF5pOVrWihv2ekA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id xLQqpubrqOPC; Thu, 12 Dec 2024 21:30:08 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Y8Qbz03hdz6ClL8x;
	Thu, 12 Dec 2024 21:30:06 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] Three small block layer patches
Date: Thu, 12 Dec 2024 13:29:38 -0800
Message-ID: <20241212212941.1268662-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

This series includes two code cleanup patches and one bug fix.

Please consider the three patches in this series for inclusion in the ups=
tream
kernel.

Thanks,

Bart.

Bart Van Assche (3):
  mq-deadline: Remove a local variable
  blk-mq: Clean up blk_mq_requeue_work()
  block: Fix queue_iostats_passthrough_show()

 block/blk-mq.c      | 10 ++++------
 block/blk-sysfs.c   |  2 +-
 block/mq-deadline.c |  5 +----
 3 files changed, 6 insertions(+), 11 deletions(-)

