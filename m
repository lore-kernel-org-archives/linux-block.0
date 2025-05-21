Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD49D186A
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 00:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747786019; cv=none; b=tHCAqmTvvgEFGDs94UJ6pMMSvruklIZ+LDwgExCxtgINTCEI1zyKdy5vADcVbMAaRvj/HmlSfeRivoeB+ktRdlvbqCtTZHIXetANuOxCUbB8SQPhB1wqgI2ltSD58+oqBr7zPqBbZDFSMjyu1P8gbaBNifsa4QYN033y/rblM9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747786019; c=relaxed/simple;
	bh=fC0TnXuzr2UBrS/te2rNhxKQZXVh8jbAUqQoecnZZWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sSP7PuQZlfqOWPjEzQK6i94jwWL9bCnOuu4tMYhjlsLXdKYaAOUQaDhSVHEvYicdpq+tZF51kHMRiy9mHg6V9YRbXATxP3tYoAzJnLPwroJ3VhklvI6NMOeo9lvv/tURnVss2UFB4j7cg3wklQPDNuiBE5WlBn7cpu27A9w6bnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vZfwER0w; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vZfwER0w"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4b2BYP7132zlvq4d;
	Wed, 21 May 2025 00:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1747786008; x=1750378009; bh=s5F7NYbJkLg+DszS7H93Tif47P7Hc4x2XQe
	lK7FzKag=; b=vZfwER0w+nVjYHGqn0Uu+zrZAePk421IuAiofLIU2ttZik45biS
	gRU+tzlaIBvs3DaE6M3Ph+BpjUEWJcm0q7o0xNZdQbMf3mkvScrC0q2OydJrN9bf
	JUL8LETH7bPbKFUr+fVdKcB/ScQwM8GPaAyw5fyanKeYrNSQoHxo8d3X2viM55KA
	MO+dG1sxGYEsYBfv+rI/iYs5IisLczH2RI1qsXJOgZbqjHog/1S19142yn5mYUje
	pBdz3CKaV2aS9taP83Ms+Uk39VSFVnAfts4Fi6DLpbsDRJueHl1wWe3xmPSnOCmH
	SJ9Bn0ICkysDuXJnGyVQ3x+uRnCYCMBAFyQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3daTQrfbmjHz; Wed, 21 May 2025 00:06:48 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4b2BYJ6mb7zlvnM2;
	Wed, 21 May 2025 00:06:43 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] Hold the zoned write plug lock less long
Date: Tue, 20 May 2025 17:06:23 -0700
Message-ID: <20250521000626.1314859-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

The zone write plug lock is taken in the submission and in the completion=
 path.
Hence, it is important that this lock is held no longer than needed. This=
 patch
series reduces how long the zone write plug lock is held. Please consider=
 this
patch series for the next merge window.

Thanks,

Bart.

Bart Van Assche (3):
  blk-zoned: Move locking into disk_zone_wplug_set_wp_offset()
  blk-zoned: Move locking into disk_zone_wplug_abort()
  blk-zoned: Do not lock zwplug->lock recursively

 block/blk-zoned.c | 56 +++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

