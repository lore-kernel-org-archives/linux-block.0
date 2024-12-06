Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB0A1FC106
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483790; cv=none; b=QmdGAAivUfRqG6nedvCrEVaSV9Jf39+imP9PioePS2Xb3GkafnT8Huw3VgvWmQWR8jo6Am2Va9zqBlfC8EgllmXuv94FXcDhc8G1ZQh6H2pj/pehGoiL8J09YThdISxbBHjpVfGz3wodes14Sr/8xgCZee2XvrHKHsoo0nuDDR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483790; c=relaxed/simple;
	bh=chfrWPNhjCYEY/1wKgYFnd6s1+WEvWcV4wzpdv3YHHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZE3JJTDPaobU/XLeKXKY7fXcXpBCYYgjY6JRQTOKOpynxOAS3KWMHYM4k5wuyVfRCdknY+psEUjADRYONtfGykbtK/8Y/HIKl1uX+G68aPPKSgThq4ATaLNit3ZVovY7qMHB0mEeE0qzQudWrG9Zx0AlctsuGOyTI6fPMAnepxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMhraK+Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMhraK+Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733483787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vuyCU7EtxGgas7DGnrbNBeYIf2l05Yuz7JMMYqlULN4=;
	b=QMhraK+YPsFpdSyfsBTyF0l1orknwLkkeiurSgzh4dbRmbLAy4XMHIz+v5iwo9YQmx4EoG
	poQ+nWCh2PvdY/C68ragweOLms0lcj1DeB2bpvMGAw7oU1sX/KPZBTGeqdjutHNalr6tlA
	JrCKS2eaeOmRN8bRgsXyw3AjiGCRWKQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-6F_bbXZDNI2eYrOTF3RFEA-1; Fri,
 06 Dec 2024 06:16:24 -0500
X-MC-Unique: 6F_bbXZDNI2eYrOTF3RFEA-1
X-Mimecast-MFC-AGG-ID: 6F_bbXZDNI2eYrOTF3RFEA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B612E1955DD5;
	Fri,  6 Dec 2024 11:16:23 +0000 (UTC)
Received: from localhost (unknown [10.72.112.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8345B19560A2;
	Fri,  6 Dec 2024 11:16:22 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH RESEND 0/2] blk-mq: fix lockdep warning between sysfs_lock and cpu hotplug lock
Date: Fri,  6 Dec 2024 19:16:05 +0800
Message-ID: <20241206111611.978870-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello,

The 1st patch is one prep patch.

The 2nd one fixes lockdep warning triggered by dependency between
q->sysfs_lock and cpuhotplug_lock.


Ming Lei (2):
  blk-mq: register cpuhp callback after hctx is added to xarray table
  blk-mq: move cpuhp callback registering out of q->sysfs_lock

 block/blk-mq.c | 108 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 14 deletions(-)

-- 
2.47.0

