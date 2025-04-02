Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7ED2F4A
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 04:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743568780; cv=none; b=DA/1/4RNm/E9LrDyiB0sT8jce0rRAWFkkoMVEeblz0faKHYuaPK+5RLdFYbZyF6tZgsJkiKBwsNyzVrkYim15X+HPvzlbWRTONCcoO6oCOgnj+u775xS7tVCWvGISueNSbH8AW8y4IzPBO9l6YC80/y/Kvyy6nU/AKE9+OD8Qnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743568780; c=relaxed/simple;
	bh=5b/dSxXg2FDqdArJq9lKtTejNUJoDvpoiCQrOpdawTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VbldmIzZAVyCSrmNw9Llc2nyWrwa8tOdDD2vM2hNtEZelSWOChLSvJY98ZFxAf42HJWOxOA2kooNhLcPn2pJsqL5qMp5x9v6qRTPRun1u6Uj+brWweijEK0WXP7vJAC6pq21W26QukC3zen0S/Adjm8hmOFRYBtz+zOmepvz3+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sm/V045+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sm/V045+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743568777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bExnF53BT7kz2tmEJk1b9kee2pgr3DmGXHAwiH87Ee8=;
	b=Sm/V045+ou4fLDGlBO+s8EEF0dxdSowoSgDsl2tgMrzZulIbZQ2uH044yM2tMZc1nd2us8
	GhLBa3kctZg2WnYhPzmbYl9cleksHOwD1XG9cgmeYYA1ERjqgbx3gqNGSbTddsXNGvsrdK
	3lJJL+AVozseFZ3al20hSOdrHH0nH1A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-gJ_7MX_fPT2Yr55Qvgpw2g-1; Wed,
 02 Apr 2025 00:39:32 -0400
X-MC-Unique: gJ_7MX_fPT2Yr55Qvgpw2g-1
X-Mimecast-MFC-AGG-ID: gJ_7MX_fPT2Yr55Qvgpw2g_1743568771
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A01B1956048;
	Wed,  2 Apr 2025 04:39:30 +0000 (UTC)
Received: from localhost (unknown [10.72.120.17])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B03EE180174E;
	Wed,  2 Apr 2025 04:39:28 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] block: fix lock dependency between freeze and elevator lock
Date: Wed,  2 Apr 2025 12:38:46 +0800
Message-ID: <20250402043851.946498-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello Jens,

This patchset adds two pair of block internal APIs for addressing recent
lockdep report between freeze and elevator lock.

Thanks,
Ming


Ming Lei (3):
  block: add blk_mq_enter_no_io() and blk_mq_exit_no_io()
  block: don't call freeze queue in elevator_switch() and
    elevator_disable()
  block: use blk_mq_no_io() for avoiding lock dependency

 block/blk-core.c       |  6 ++++--
 block/blk-mq.c         | 25 ++++++++++++++++++-------
 block/blk-mq.h         | 19 +++++++++++++++++++
 block/blk-sysfs.c      |  8 ++++----
 block/blk.h            |  5 +++--
 block/elevator.c       | 11 ++---------
 include/linux/blkdev.h |  8 ++++++++
 7 files changed, 58 insertions(+), 24 deletions(-)

-- 
2.47.0

