Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C4D2EA168
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654863; cv=none; b=Mw0iVADuvFj+5/F6KSQ/JECgHUAEV+JadIpAc1NMq9434d8SMnYMtQOlUYS/rxivcyYipIItgCSoDxdXJgbbN+ssrWx/hJ9OnsfKSq3oVfFY0xgVWUbKh3W9TL4W4dlfHj+dkqMuQ+eMlWnHDim+EUaGcyZrTVKHXPR0gW4J4Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654863; c=relaxed/simple;
	bh=xGMfUqmMe/5qpOd6uiv6bI4L13VZ6Z85bQgixUxqk+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tNvypUdDCy+4VVoIuBb9Qd9jxtpeJEci3gIGvwo0YEeaG68Q+y+1nXMM8rECP0r/Y+Md1USOF2SJ5/NzAz7nRM7GekGLSSN+2DJPE3qiXcH5CYYAEzDHpl6i/TBzGHjI3zzPE9CC+BXMv1rYKFJLAajZ+kXtCdIvmAduimIndyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jft+95De; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jft+95De"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763654858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GyvnpClf0ScbiyvwWzWeLuX1bQILWUAX/TAXUQlHXIg=;
	b=Jft+95DegY3SsAmd23dm2B0CViSnQj0MZLexk1vYwEyxcAav6Q38tipHxIxaOWIGec2AU9
	vhBZRITpTek6VLeTQrFZR2LInMmxfc5IdEQXgojshiU0kXRVYAvOvQdFZr7gLq6/itxwcS
	HtMRV54h2cGTZcr348fSHjKLHAlK9rA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354--InDIOIlMp6_ePd5U4geXg-1; Thu,
 20 Nov 2025 11:07:35 -0500
X-MC-Unique: -InDIOIlMp6_ePd5U4geXg-1
X-Mimecast-MFC-AGG-ID: -InDIOIlMp6_ePd5U4geXg_1763654854
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A732D19560B5;
	Thu, 20 Nov 2025 16:07:34 +0000 (UTC)
Received: from localhost (unknown [10.72.116.74])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA68F30044DC;
	Thu, 20 Nov 2025 16:07:31 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/4] loop: nowait aio bug fixes
Date: Fri, 21 Nov 2025 00:07:16 +0800
Message-ID: <20251120160722.3623884-1-ming.lei@redhat.com>
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

The 3rd patch fixes IO hang issue because of rqos throttle.

The last patch improves blk_mq_flush_plug_list() to support new request
added to plug list from ->queue_rq(). 

Tests:
	- not observe regression on xfstests
	- not observe performance regression on nvme polling/irq test


V3:
	- don't disable rqos
	- add BD_LOWLEVEL_BIO_FIRST flag for loop to submit lowlevel
	bios first
	- improves blk_mq_flush_plug_list() to accept new request added
	from ->queue_rq()

V2:
	- use QUEUE_FLAG_DISABLE_WBT_DEF to disable wbt, so that
	  check of QUEUE_FLAG_QOS_ENABLED can work as expected

Ming Lei (4):
  loop: move kiocb_start_write to aio prep phase
  loop: fix error handling in aio functions
  loop: fix NOWAIT io hang by introducing BD_LOWLEVEL_BIO_FIRST
  blk-mq: fix plug list corruption when queue_rq adds new requests

 block/blk-core.c          |  3 +-
 block/blk-mq.c            | 64 +++++++++++++++++++++++++++++----------
 drivers/block/loop.c      | 27 ++++++++++++-----
 include/linux/blk_types.h |  1 +
 4 files changed, 70 insertions(+), 25 deletions(-)

-- 
2.47.0

