Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12E01E1E14
	for <linux-block@vger.kernel.org>; Sat,  8 Mar 2025 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741451027; cv=none; b=W7wa2HIr7b8+4xKHg2pOt6+OGDpism0OGr1TCy+u0JdhUy+sqwL0rqJuJzK8DKRuRrnOeZEaIskBNn0X/tspzHEdhddF3ZuNtDnhBeZskNl2ses4te0y5fCgzqlyt//L0v8mSZTc75rvY7AHbbcYnRW5CR4/zmgg45OxP9lJwww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741451027; c=relaxed/simple;
	bh=Hc8g2ZjsMlDhYCo0fkMCIVNtcu5TlwF1WciVJkhCncY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SsRLsfY3DawUUuaIQc+gVAW5DWPdToo3U2BUzb+eMNS/EfyW2UgCxUTcaet0OEZyCfBw7M2sZvfTyBoZYNdb+YkfblE7tXYL2+ZnVIyigyALDDowR1lAwqYqJmJhipcefKfrerK7NBSTKL/+OXqHresHW/JTJdRNGd8kCboIvW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YBOxLo3Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBOxLo3Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741451024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YqYo6QQfSCrqXOS95daGWu+yL68RsAPabrvKTrwWBLc=;
	b=YBOxLo3Yen6d8CWR3+imRh5F8LLa7s16sujXBnhKnD7PeI7VwDq5paA4+Z80YjoLDMAAlY
	2aYEG5HHlZWCpoyz5i2LuB3WEFQ9S61IVLmLDhLZvOKeNT0atBHvwlppeaQTTViCX+V879
	T05zXavAz0wCz6bf3XpkZytYFv7pqnk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-Y0oUIBG2M7y1N395klPAMA-1; Sat,
 08 Mar 2025 11:23:43 -0500
X-MC-Unique: Y0oUIBG2M7y1N395klPAMA-1
X-Mimecast-MFC-AGG-ID: Y0oUIBG2M7y1N395klPAMA_1741451022
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DD7619560BC;
	Sat,  8 Mar 2025 16:23:42 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45EC71828A8A;
	Sat,  8 Mar 2025 16:23:40 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [RESEND PATCH 0/5] loop: improve loop aio perf by IOCB_NOWAIT
Date: Sun,  9 Mar 2025 00:23:04 +0800
Message-ID: <20250308162312.1640828-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

