Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB283D6B
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733473346; cv=none; b=dzvt9FUXFdwO8Xe4+iBRVETrBdKvMyAoOh4XQo1n3AgitNVw+BaYBYwUiWA3v+t4sc8D8/jfcr7jjwpqwI6/sW8Xi4atid8KEhEkCqNteRMlG/87ucJk9FlZZ4O4DYEYDZ5jf0+BcGeCU2Fg1oyv7TzkxYURvLAryeHKsDIJ7yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733473346; c=relaxed/simple;
	bh=chfrWPNhjCYEY/1wKgYFnd6s1+WEvWcV4wzpdv3YHHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YymXwtvxsbkAGZysnDZp5cob2YgcJhRcVAvDD+SeXzIJZU04ugW03KjvhWQtTP7JOm62lua/8Q99PWUXTZhCH8irnjHzIa3tvmqVIAwfb5GMHaOBLm2s5kClRUkNHOKPmLTeZg2cfTfauPAG//2O4eNpdSfkA5ik7i2bXeax4Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2xDEKNd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2xDEKNd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733473342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vuyCU7EtxGgas7DGnrbNBeYIf2l05Yuz7JMMYqlULN4=;
	b=f2xDEKNdDuZ8/A6jKBgXuLD6EuG1k3CSRtH0hlihNhazQAWapHeH1yZUc1LmpBMnVe/Nxw
	3UxspHPEK+5Te9vCcGgtIWfi5nBVNXJzdYtyAZxvUqAFbla6r7GMBqnkszxtzOCMUn/MWu
	7tiycm9vQHiU8OUBcaS/WQYN5eUwOYM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-e4RTg2f0N2KKm_HuxR-Cfg-1; Fri,
 06 Dec 2024 03:22:20 -0500
X-MC-Unique: e4RTg2f0N2KKm_HuxR-Cfg-1
X-Mimecast-MFC-AGG-ID: e4RTg2f0N2KKm_HuxR-Cfg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F71B195608C;
	Fri,  6 Dec 2024 08:22:19 +0000 (UTC)
Received: from localhost (unknown [10.72.112.88])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0FE7219560A0;
	Fri,  6 Dec 2024 08:22:17 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] blk-mq: fix lockdep warning between sysfs_lock and cpuhotplug lock
Date: Fri,  6 Dec 2024 16:21:54 +0800
Message-ID: <20241206082202.949142-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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

