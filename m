Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFBE81720
	for <linux-block@vger.kernel.org>; Sat,  8 Mar 2025 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741450522; cv=none; b=LPKxmx0APNRUx1xgQJsYIZaRdVBumvhBZ6VPBONTXAA1wRPyxMoqXmx5Bd4S3sNRKNsXSRJE6UUWBBo1tscJJZQTVv7FCJt6bSaqauYm82xztKnAkOGqtQHrIXjqu8UiXRWldB5/cbRxhTFUqDSi/h23tpxs1CcxxHNn13iHdHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741450522; c=relaxed/simple;
	bh=Hc8g2ZjsMlDhYCo0fkMCIVNtcu5TlwF1WciVJkhCncY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cTpzc+otXw1k26pVJ10Zpzfd7e+UcVCxMsS3hj4//uXbqcRDuYpnqH3Z+n5o6dxiIQiSTk4Bks+I/XUaBeioLCV0Z8lRK3qd2YgzG4BwvkFqvFJbtzlNnM1VNU6DZgqhaybyatDSAW/RMF5WraDLvoPCROC7xlvBUoIb2Rk7ON8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvTwnd46; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvTwnd46"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741450518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YqYo6QQfSCrqXOS95daGWu+yL68RsAPabrvKTrwWBLc=;
	b=RvTwnd46fzInzMfWjWjlBud8boWwlQhioz6hkCHcbW9q1lI5eqt+DaIrOeK8GVzSuJy0r7
	j9qayUz12GVTCWfsXXDOCPVooH8hIR56DPLfUxF7ws7OD/RWy0Tmm7eV7SI8ZUdMzc1JHZ
	e/+2eEJeWxHJnPAluPQVtjbPjb6vXGA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-y7jJYkNPNqy7XXvY9ezeFQ-1; Sat,
 08 Mar 2025 11:15:17 -0500
X-MC-Unique: y7jJYkNPNqy7XXvY9ezeFQ-1
X-Mimecast-MFC-AGG-ID: y7jJYkNPNqy7XXvY9ezeFQ_1741450516
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D18A31800258;
	Sat,  8 Mar 2025 16:15:15 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8565619560AB;
	Sat,  8 Mar 2025 16:15:13 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/5] loop: improve loop aio perf by IOCB_NOWAIT
Date: Sun,  9 Mar 2025 00:14:50 +0800
Message-ID: <20250308161504.1639157-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hello Jens,

This patchset improves loop aio perf by using IOCB_NOWAIT for avoiding to queue aio
command to workqueue context, meantime refactor lo_rw_aio() a bit.

The last patch adds MQ support, which improves perf a bit in case of multiple
IO jobs.

In my test VM, loop disk perf becomes very close to perf of the backing block
device(nvme/mq virtio-scsi).

Thanks,
Ming


Ming Lei (5):
  loop: remove 'rw' parameter from lo_rw_aio()
  loop: cleanup lo_rw_aio()
  loop: add helper loop_queue_work_prep
  loop: try to handle loop aio command via NOWAIT IO first
  loop: add module parameter of 'nr_hw_queues'

 drivers/block/loop.c | 225 ++++++++++++++++++++++++++++++-------------
 1 file changed, 156 insertions(+), 69 deletions(-)

-- 
2.47.0

