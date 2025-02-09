Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDBF13D28F
	for <linux-block@vger.kernel.org>; Sun,  9 Feb 2025 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739103660; cv=none; b=kghYj8zftdORYsX7cyMyG9J/86tT81iKkHYZ3kwIhqZRGc+jIZgBOMXXNs8kwo9eNqHKUIfchRvocEdP0x99+q1Z/faQMCGSKd6PHAGTlfjffKUoGLhIMJHKeZFLZTo6J/H4M1ZXrsSWQQkgQUJH1M/EbLmihHX2ohtoUR8eaJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739103660; c=relaxed/simple;
	bh=dBg8COqF2SHroiNCvuaMwQBfqsgHjb/D3BNhFEyCRb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uge4GjOoIqZoMclFlC37KxREEnqiK0eHni966OiUB+cQ3KUPrCm2ifDrj6XEQ1qvMscbuyPbc/d/T/q9fKWtmmkvFO+jTI/UDJmllUB8LleYa6ZbNbOEMBpqrYgIR37nbC91dFRNx43Fu81eJ56Id5uiJDbiBdTSJg0/28v4mXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXlQnytA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXlQnytA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739103657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OrXMtZg1zccV/cptNpgua1EfDQYmiSU3xBUUWia+8+E=;
	b=NXlQnytAonMUKi6qEFNuI68oc3s13omtd+mLXmP6p5ZYLSXnCqUybMTczKh1Slq4OM/KnY
	NeCt/Vb/BXomtkQRWIy0gwAIrw0Yg+XhT7yagH0KZh5tNx3Sh4ImeSO0DwThls9Gz70gRI
	QS499gUcpCanEojrTiCLwqs/kLGRsAQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-p7oOYfJ8Psu0f1UCfaLXlA-1; Sun,
 09 Feb 2025 07:20:53 -0500
X-MC-Unique: p7oOYfJ8Psu0f1UCfaLXlA-1
X-Mimecast-MFC-AGG-ID: p7oOYfJ8Psu0f1UCfaLXlA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1EEA1955DD0;
	Sun,  9 Feb 2025 12:20:51 +0000 (UTC)
Received: from localhost (unknown [10.72.116.41])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35F8F30001AB;
	Sun,  9 Feb 2025 12:20:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/7] block: remove all debugfs dir & don't grab debugfs_mutex
Date: Sun,  9 Feb 2025 20:20:24 +0800
Message-ID: <20250209122035.1327325-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi,

The 1st 6 patch removes all kinds of debugfs dir entries of block layer,
instead always retrieves them debugfs, so avoid to maintain block
internal debugfs state.

The 7 patch removes debugfs_mutex for adding/removing debugfs entry
because we needn't the protection any more, then one lockdep warning
can be fixed.


Ming Lei (7):
  block: remove hctx->debugfs_dir
  block: remove hctx->sched_debugfs_dir
  block: remove q->sched_debugfs_dir
  block: remove q->rqos_debugfs_dir
  block: remove rqos->debugfs_dir
  block: remove q->debugfs_dir
  block: don't grab q->debugfs_mutex

 block/blk-mq-debugfs.c  | 179 +++++++++++++++++++++++++++++-----------
 block/blk-mq-sched.c    |   8 --
 block/blk-rq-qos.c      |   7 +-
 block/blk-rq-qos.h      |   3 -
 block/blk-sysfs.c       |  13 +--
 include/linux/blk-mq.h  |  10 ---
 include/linux/blkdev.h  |   3 -
 kernel/trace/blktrace.c |  27 +++++-
 8 files changed, 158 insertions(+), 92 deletions(-)

-- 
2.47.0

