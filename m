Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3031A04F
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763545172; cv=none; b=SOUBg7Y4i047F4azaCrVZJtGYDYOU0epc6FO8DEFAejROzh4J0V8uLDl71/KxdFSrUOT0+p2Xkfrk17NsIoE3XK1AbyN3DTEtK2oJX+o5/HPwvzpHjq6UCs9ASW/22/jRNMtFQBbfzv27l6SpG82htr3GX+Oy7DQHHEtkt6u50Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763545172; c=relaxed/simple;
	bh=cAS8lCtPGNRFvrZQDrTc7RJpXnTFg4KcJPnAozu5ikU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQ9cXggOSYNFJz1/fyYZJCHuFCHhwfdb0rX8h27QM+fGNWnm2oNDhBptxo0NaymNHMkZ/tDNFbljEhEITpQv2qKVB6nFxKq81m24JDTomKA3sJzkTajPBZiMCBhJQTpFdzTMlbXju0GzyuJPpXCVYYXs05lnHphpqbF9YrS5SXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9UF+1im; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9UF+1im"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763545169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RMLjuVDerl17Qc3cdWKDeKkxWcGgFF26t/CKy2Xmky8=;
	b=C9UF+1imirpShqtZf6vHNinNEJfLiCn3QNb2Su5Yt3SjstI1YxushaZGJA2geqUhh4GjM0
	hzNinKFBOwszDyS1CzfydIRg86EViuV0ikn23D0/GI/puh1zgoC5rjTuAVadBmjRSG0l1L
	2TmpiVrHoRdbZRHcEnoDVarY8KvmDPk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93--eSX4E1SNyS3FzY5Rb2npA-1; Wed,
 19 Nov 2025 04:39:21 -0500
X-MC-Unique: -eSX4E1SNyS3FzY5Rb2npA-1
X-Mimecast-MFC-AGG-ID: -eSX4E1SNyS3FzY5Rb2npA_1763545161
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC5E9180122B;
	Wed, 19 Nov 2025 09:39:20 +0000 (UTC)
Received: from localhost (unknown [10.72.116.74])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BBC6E300ABB0;
	Wed, 19 Nov 2025 09:39:18 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] loop: nowait aio bug fixes
Date: Wed, 19 Nov 2025 17:38:50 +0800
Message-ID: <20251119093855.3405421-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Jens,

The 1st two patches fix error handling code paths for nowait aio.

The last patch fixes IO hang issue because of writeback throttle.

Ming Lei (3):
  loop: move kiocb_start_write to aio prep phase
  loop: fix error handling in aio functions
  loop: disable writeback throttling and fix nowait support

 drivers/block/loop.c   | 28 +++++++++++++++++++---------
 include/linux/blkdev.h |  2 ++
 2 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.47.0

