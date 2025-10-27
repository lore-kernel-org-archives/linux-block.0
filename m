Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41692E2EEE
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565807; cv=none; b=aLs35woF2Ao5UGxLrSX8YZH5mMPFieKdvHGaTu2pPQDgb2FxX8nxk+z9Mvwm3/6ywIz2Rwl3hnGx+4/ZGQ7f9RoFNtTXKsZS0r0IMcbprg2n8bemFiV2szzC71BI5oVIUuGo9bVun9BP+RqI6OLHv3oQRWqgfS8x9FmVVSl3u3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565807; c=relaxed/simple;
	bh=EpQFjOwrkQfFu+Gt5XgCG8kbcgC2F3qk3D60ME1Kdjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJ9CqbDu7gKcavBR43tEr1C7cq1mLWOvuRwtnjHYlEVargpSOKGaCGwRnceLmQun0lSD2OHVunTjCuAuA41qPc9/0azGDt5Xv26XkStccHEbJifmgO3GUhS+ORyj3uPyThn974zA89VLc9prm7t+RK+8K7GVVDsZKugIR1g7iJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqTooQ8P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqTooQ8P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761565804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=24JsHF8n5WksK4AdXGMZfE0/VOPpcNEqtsJ2mClL4E4=;
	b=fqTooQ8PXv42XBVycECcznMkk2bHCqII6hc2tQfl5FZe0utQoJFkOt5il+qfTahorucQQ0
	GQTYmsMAl15j9cUgV/d4CoQkRlh16iKHN9q/2SC51AWmxDK9Z/R0blxyJmZh4E6PW8akYW
	/L1edPc5CbSx91jmYHxxLgHCXawR19g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-vmjkSKgqPQ2Kh8ahCz9yCQ-1; Mon,
 27 Oct 2025 07:50:01 -0400
X-MC-Unique: vmjkSKgqPQ2Kh8ahCz9yCQ-1
X-Mimecast-MFC-AGG-ID: vmjkSKgqPQ2Kh8ahCz9yCQ_1761565800
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D505E1800654;
	Mon, 27 Oct 2025 11:49:59 +0000 (UTC)
Received: from localhost (unknown [10.72.120.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E87A180044F;
	Mon, 27 Oct 2025 11:49:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/4] ublk: NUMA-aware memory allocation
Date: Mon, 27 Oct 2025 19:49:44 +0800
Message-ID: <20251027114950.129414-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Jens,

The 1st two patches implement ublk driver NUMA aware memory allocation.

The last two patches implement it for ublk selftest utility.

`taskset -c 0-31 ~/git/fio/t/io_uring -p0 -n16 -r 40 /dev/ublkb0` shows
5%~10% IOPS improvement on one AMD zen4 dual socket machine when creating
ublk/null with 16 queues and AUTO_BUF_REG(zero copy).


Ming Lei (4):
  ublk: reorder tag_set initialization before queue allocation
  ublk: implement NUMA-aware memory allocation
  selftests: ublk: set CPU affinity before thread initialization
  selftests: ublk: make ublk_thread thread-local variable

 drivers/block/ublk_drv.c             | 60 +++++++++++++++++-------
 tools/testing/selftests/ublk/kublk.c | 70 +++++++++++++++++-----------
 tools/testing/selftests/ublk/kublk.h |  9 ++--
 3 files changed, 89 insertions(+), 50 deletions(-)

-- 
2.47.0

