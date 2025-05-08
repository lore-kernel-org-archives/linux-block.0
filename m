Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75562397A4
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746694701; cv=none; b=GZV1P+x1g491qCPwWSn4jyjDN94dFMsbf13/s/q8zSXQC34Ue+szN2VK9vvajHWaVRJBRy8MUVT1ryBzvD7G/BWKoLv/r/z+zoo0vtp8JE7Wi+o16A8dm0hFtbcgV0/tmnGP6pW7cU8mP9uaJiBdMuxl5DaWibbFgQ0Bc7SJcm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746694701; c=relaxed/simple;
	bh=hA04ymrVMQ05ZQJAIS5E9WLyrYpOaHFPU2MpTMQYTxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UfxfvZsCq9YJjksdnoOIIdIfYCOSl+dQ1IB1FFV06CRG7HRkj6vSm9AzKxnyJ+hz08sq/9GiXnu5PX2b1emvHRbgyRAHiDXuHZ41tRjYSORGLCfHXUCFMVdtps2fM0bUixlOnahqYnjzE6+jYeEk0zv9T4LEwKJmLkZEZjER+C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EUUZVzdA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUUZVzdA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746694697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ahJSZBZ7dWT1WLVTbKGHNzCkr/5WJ258Guqd5U5N7pA=;
	b=EUUZVzdA8dgx4WtQD6y+TFOvgW/nkiBGJ3JjKtUjRPHOT0B4J59ro1bU0Q+83BK5RX0rcE
	cMRM0emNztam7oIglOj2d2NCttK3Jco9/NeRGKKK5HaLqjHyiwr52uZDfNdtQqxB6Sdeet
	6WDuBEkK3VVWOLz0h7APSz09RTeq0gQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-TzSgHMLxN1CwwXvL4ApiWQ-1; Thu,
 08 May 2025 04:58:16 -0400
X-MC-Unique: TzSgHMLxN1CwwXvL4ApiWQ-1
X-Mimecast-MFC-AGG-ID: TzSgHMLxN1CwwXvL4ApiWQ_1746694694
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8EA419560AF;
	Thu,  8 May 2025 08:58:13 +0000 (UTC)
Received: from localhost (unknown [10.72.116.149])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2E7519560AD;
	Thu,  8 May 2025 08:58:12 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] block: two fixes on recent elevator change
Date: Thu,  8 May 2025 16:58:03 +0800
Message-ID: <20250508085807.3175112-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello Jens,

The 1st patch fixes one hang in del_gendisk().

The 2nd patch fixes one race in case that add_disk() fails.

Thanks,
Ming


Ming Lei (2):
  block: don't quiesce queue for calling elevator_set_none()
  block: move removing elevator after deleting disk->queue_kobj

 block/blk-sysfs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

-- 
2.47.0

