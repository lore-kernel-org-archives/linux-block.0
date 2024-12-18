Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E1A35963
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734516990; cv=none; b=nINnyvhz5/1yMKRqTlXl0ow3wsTwrMpqP9PCCmRw2h+Fz/tKSJtZWB6HNNVNTztsFeOZsZj8c6HaW2GxOTIvTMWA5RhU5ktIz9NQhs4l5bMiQ76oXqcn2Wt5cUXkjaqsrdsZneC0Nq4Eb1FFVeeG7/KpAjOKczM9p2eOk/r/qmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734516990; c=relaxed/simple;
	bh=3Vs0ufnbHXBLVB3vizJuw4ET7ZVJ7H7+XkM+yqsaYcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V6b9ue2JHtz1JWHX4lWtiUvaArSxgbbgrfBSe4IKB7rJ8+uYpHr9KGn3TOQlokuKqFbxiWNRiyOtHXYUFyAmZ5j6ctRW81Unzr5mRFU1P9PRMSrkoEjKK9jqqkPjnfxNDwfqVsD3hbYoQX5gcXqH6GhwRiShjtpEZCyFkReBPc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bc2uFx8V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bc2uFx8V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734516987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8zZBDvOfoGmXE4ZWOUEtqmKwy1ehR+oVPjjuwP/bo0o=;
	b=Bc2uFx8VkdscMFP8WwArVpC6UgvUUGutaEpU9nk9k0y7hRmtvbmMspfVhAjEh3DwpvC25v
	VqN+J04r1cNnNlmhHttj4Kxav592h8f8lHzHY5Jc/tjpPFsLNRDcghHM4ZqpOh9XKFdlEd
	1lD1Zljt2KvMyJKj05K79KXOyNC9Dfk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-3Xr6S8ZzOGic063-TCEi7w-1; Wed,
 18 Dec 2024 05:16:26 -0500
X-MC-Unique: 3Xr6S8ZzOGic063-TCEi7w-1
X-Mimecast-MFC-AGG-ID: 3Xr6S8ZzOGic063-TCEi7w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 489F1195609E;
	Wed, 18 Dec 2024 10:16:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0096819560A2;
	Wed, 18 Dec 2024 10:16:23 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] block: fix two regressions in v6.13 dev cycle
Date: Wed, 18 Dec 2024 18:16:13 +0800
Message-ID: <20241218101617.3275704-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello Jens,

Fixes two regressions introduced recently.

Thanks,

Ming Lei (2):
  block: Revert "block: Fix potential deadlock while freezing queue and
    acquiring sysfs_lock"
  block: avoid to reuse `hctx` not removed from cpuhp callback list

 block/blk-mq-sysfs.c | 16 ++++++++++------
 block/blk-mq.c       | 40 +++++++++++++++++++++-------------------
 block/blk-sysfs.c    |  4 ++--
 3 files changed, 33 insertions(+), 27 deletions(-)

-- 
2.47.0

