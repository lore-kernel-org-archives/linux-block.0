Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FE94B1E56
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624836; cv=none; b=Fu6kq0yzQx+HbqGq6djD6u+FX4pAm0hsAViswdjkrgHzBw/pwDXmDGkqRXrQypthpu8dyQYuy4W0p5y94Sw675TMSzTRnn1gYfg72f9o++Ra5912U+ap70Y0WF++kZ+9Pn/RDDfk8xsgex9LYQEsIjkChD4gu+F9qPAhtyJXfco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624836; c=relaxed/simple;
	bh=Cp/xpKP1zSXJzZfP0M6Z3idmz7YwXz/bXsUgVQHVcGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MJEy96Jk4mUCg5tDm5Dw4HEYUkjtA4e+6UA/1bUDO09cIcOkW2vkp+lQW5Z92rlII5gG/IUPwjFe9sB4/balNwNmcLHH5Nw5fQjk1O3pHEc0I9SgfCMUTzenowXKwO9xXHpgQ9PrvgPq0foMHZF0X+/gQWZ+9dwhAepOmB8GUyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NdhdbHRZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdhdbHRZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746624833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XWD5E5KE7JyByou7WHY3u6FKpUjE9u7eC7vxTQNrmsQ=;
	b=NdhdbHRZbw0dgERzcMFeAh5cAsOfl9MtDsXMBIyjUfzU7IqDH/coF2rWnPIZKLQhGl+yqn
	5LeFi0spnEwkNZNgISKPrCk/63sGAaaBiUyWP/mNKqBrSF5scyOwBR5apXMQtJ2wgjcGUm
	rF7riSm+1wa8fZig/UPe999wvu1M7Nw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-sMMpZfq5PV-99YJAZXPWTw-1; Wed,
 07 May 2025 09:33:48 -0400
X-MC-Unique: sMMpZfq5PV-99YJAZXPWTw-1
X-Mimecast-MFC-AGG-ID: sMMpZfq5PV-99YJAZXPWTw_1746624825
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF366195609D;
	Wed,  7 May 2025 13:33:44 +0000 (UTC)
Received: from localhost (unknown [10.72.116.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69C861800368;
	Wed,  7 May 2025 13:33:42 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH for-6.16] fs: aio: initialize .ki_write_stream of read-write request
Date: Wed,  7 May 2025 21:33:28 +0800
Message-ID: <20250507133328.3040255-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

AIO needs to initialize .ki_write_stream explicitly for read/write request,
otherwise random .ki_write_stream is used, and cause -EINVAL returned for
aio write randomly.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>
Fixes: c27683da6406 ("block: expose write streams for block device nodes")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/aio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/aio.c b/fs/aio.c
index 7b976b564cfc..793b7b15ec4b 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1511,6 +1511,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb, int rw_type)
 {
 	int ret;
 
+	req->ki_write_stream = 0;
 	req->ki_complete = aio_complete_rw;
 	req->private = NULL;
 	req->ki_pos = iocb->aio_offset;
-- 
2.47.1

