Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D7B188CAE
	for <linux-block@vger.kernel.org>; Thu,  3 Apr 2025 02:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743648751; cv=none; b=SKOXivHN/OgSFbYebdEWIQSgw2s3zSPdpWdzz+YgUBJcz9XQsm16Dwq0++59fIlKjsfPtQf+gDvlb5nAWErqRKHmSG4bPgDsVshgvyqXj8B+8TT9NoM2J+D5z55AXFXrD+WmScwZqwsTxaZQvJRZdtNabYKfZKlk75V9iitfcgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743648751; c=relaxed/simple;
	bh=nEAnro+eEVqVmU63zJQg9ITj/rdIM+3EWdbnDoCVOMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sx1qItl74fpgqQ3e3Kms2/WgRNw18pErCPCPUqNs9K7TQt/OtOiDe04/kjsmNGqxANARCt55geR/3vuKmdNFxJZ8prOKOXE5legw0AOlUwsVXNyYPOSz0g9UpXTBhjhIYkAzMNTKeUGxEAa59CR768gsldbOvTJkuiijP1MfITQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TPkmtqum; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPkmtqum"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743648748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oxXTz2C2pciJQvZM95P7Q/XVcCp3yzNA3kazYuD2ogc=;
	b=TPkmtqumgT83+hMIdncBzCiH4/ys/ImIRsxRHNurqIG5R7lzxPuaRkIUm+sr6LF71lO447
	R/MoJpc9oEs1BjdhdMU7N7Jh82BiAHZOZHIO+BAgwZMI/D4CrQQRJ9VHC8n/noqnbkgeEM
	VsHj9azvdLW2Kk1Dif9qmSQK8v2nEY0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-llx_-Ey3Pmuut6eocYV38A-1; Wed,
 02 Apr 2025 22:52:25 -0400
X-MC-Unique: llx_-Ey3Pmuut6eocYV38A-1
X-Mimecast-MFC-AGG-ID: llx_-Ey3Pmuut6eocYV38A_1743648744
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 686E3180034D;
	Thu,  3 Apr 2025 02:52:23 +0000 (UTC)
Received: from localhost (unknown [10.72.120.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0603F3001D0E;
	Thu,  3 Apr 2025 02:52:21 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/3] block: fix lock dependency between freeze and elevator lock
Date: Thu,  3 Apr 2025 10:52:07 +0800
Message-ID: <20250403025214.1274650-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello Jens,

This patchset adds two pair of block internal APIs for addressing recent
lockdep report between freeze and elevator lock.

Thanks,
Ming

V2:
	- modeling lockdep for blk_mq_enter_no_io() and blk_mq_exit_no_io() (Nilay)
	- fixes no_io check
	- improve commit log
	- add reviewed-by


Ming Lei (3):
  block: add blk_mq_enter_no_io() and blk_mq_exit_no_io()
  block: don't call freeze queue in elevator_switch() and
    elevator_disable()
  block: use blk_mq_no_io() for avoiding lock dependency

 block/blk-core.c       |  6 ++++--
 block/blk-mq.c         | 34 +++++++++++++++++++++++++++-------
 block/blk-mq.h         | 19 +++++++++++++++++++
 block/blk-sysfs.c      |  8 ++++----
 block/blk.h            |  5 +++--
 block/elevator.c       | 11 ++---------
 include/linux/blkdev.h |  8 ++++++++
 7 files changed, 67 insertions(+), 24 deletions(-)

-- 
2.47.0

