Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559681CEE92
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336153; cv=none; b=nKwYxS4Gq6ku/Liqy5Q1bUxzoy03CIKe7adgJN+16qq1y0TS6XnK0/v5CADQHBl/toMqVvr7GchEFnc0yJ4Gko5tOixLHQxzXxIjt+tTyZI0nJO6sKxWulEiGHqBedHOIbZKGCuNcP2orqoW+6OXVMFsISMLUo+Bv68sZDWfWA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336153; c=relaxed/simple;
	bh=pwrd8Q03HVkykmjjSG4vjYLnXWZ2SGzi1cDTf5C8yqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S2Sv0oVd23JpyFElWSA83m0FB/U8Gk2PVw5RrYRR5EoimxOp6dHlFwJbfDPn7WfqjixZ5Sp0BCkqFqAtjzeRoGma6JiGmj108EdkVq8YbMC1mD12BZXf742Dz5HNL7I0fDLTKehBbErAb6vcoDShg6E191iotIAfoSwSAlfIbJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ri8RCbh2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ri8RCbh2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734336150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ykUsM2mqfg1uRkcMceXMX4JKCXxP5FM+iKTDIIbMIqM=;
	b=Ri8RCbh2R2AJHuz7QFfaot2vefq9a91vGSTNB9azZpaqtGTdK/kRHzzTwdxTfQ0Jhc/onD
	HytAR+6e7qmomnMpUBxmXWEiCcx6FN8FSsQml505bouYVULeDGhY56JWKkxqtOSARfUt24
	Te6IH/Las8n5F2iHx0gaszBEIqufYPc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-eMHgVRXENBSgmWGA2ap1fw-1; Mon,
 16 Dec 2024 03:02:26 -0500
X-MC-Unique: eMHgVRXENBSgmWGA2ap1fw-1
X-Mimecast-MFC-AGG-ID: eMHgVRXENBSgmWGA2ap1fw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AAF61955F34;
	Mon, 16 Dec 2024 08:02:24 +0000 (UTC)
Received: from localhost (unknown [10.72.116.154])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3415719560AD;
	Mon, 16 Dec 2024 08:02:22 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] block: fix deadlock caused by atomic limits update
Date: Mon, 16 Dec 2024 16:02:02 +0800
Message-ID: <20241216080206.2850773-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hello,

The 1st patch fixes deadlock caused by atomic limits update.

The 2nd patch removes queue_limits_cancel_update() which becomes nop
now.


Ming Lei (2):
  block: avoid to hold q->limits_lock across APIs for atomic update
    queue limits
  block: remove queue_limits_cancel_update()

 block/blk-settings.c     |  2 +-
 drivers/md/md.c          |  1 -
 drivers/md/raid0.c       |  4 +---
 drivers/md/raid1.c       |  4 +---
 drivers/md/raid10.c      |  4 +---
 drivers/scsi/scsi_scan.c |  1 -
 include/linux/blkdev.h   | 20 ++++++--------------
 7 files changed, 10 insertions(+), 26 deletions(-)

-- 
2.47.0

