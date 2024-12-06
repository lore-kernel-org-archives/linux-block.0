Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F363C3D6B
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733473358; cv=none; b=j+/E++knAm8VTGxvn0vxa6+xuj0+VqcwEtHm6SDMhkcb6yUYTvN085+xN3OiqaUy54A29AqrJcL7E7X+O8DDjfFKxhgNZI9ULz3K1Req6F3B6PGIlxrmm/XRZQ7wPuJk4lGZdRmJI/lSl9o9sA0xP7V2+rPB8ae8AwvMK0TpZuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733473358; c=relaxed/simple;
	bh=VNKNJoGkdz1yaf0nphsOXHR/yZOoF2vQFHJ2k0acUl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQv8E7IpoPA11lcVKUjiwBOYaxfGatQ+DOyEv//cVAzfJFt0U5UQnmTSod6PvOAJB9NmGh3Hs9hHLr/ehQ8WigqMzm5lQwEp8w6mLUWKfHH0VHyHbusMaG5roFZf7fYNKy+yjwWelhYQVUuO8P+hNUy8PLJ1hyrxrFQHcXGSExI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1tWogiT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1tWogiT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733473355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJw8wxdcIFES9kNcqwwN/2XAC26sN+/VWduD8r/2YVw=;
	b=d1tWogiTlkq7Vd0GdNWuzNF8Xfs9YiXu+vOEiK7dnC0ZaHKFSauoMpFtDCXTzNJSOyi0QF
	ieQdC/+NK/1WivabOuGdAGKrZzPLycu/4YquvFg/evJnZL+DZ5TTX6kPRj1qEmBCOAjiCg
	8ozgBn3h503lHrJmCcyGm6hmrekXwAo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-NbeStgl4NcWdgbZd-z5MFw-1; Fri,
 06 Dec 2024 03:22:34 -0500
X-MC-Unique: NbeStgl4NcWdgbZd-z5MFw-1
X-Mimecast-MFC-AGG-ID: NbeStgl4NcWdgbZd-z5MFw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E08A19560B3;
	Fri,  6 Dec 2024 08:22:33 +0000 (UTC)
Received: from localhost (unknown [10.72.112.88])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35EE71955F3E;
	Fri,  6 Dec 2024 08:22:31 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/3] ubd_drv: fix return value for COMMIT* command
Date: Fri,  6 Dec 2024 16:21:57 +0800
Message-ID: <20241206082202.949142-4-ming.lei@redhat.com>
In-Reply-To: <20241206082202.949142-1-ming.lei@redhat.com>
References: <20241206082202.949142-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fixes: 6261abf48a88 ("ubd_drv: abort io command if queue is aborted")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ubd_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ubd_drv.c b/drivers/block/ubd_drv.c
index b7a59dc2229d..3b3723d78084 100644
--- a/drivers/block/ubd_drv.c
+++ b/drivers/block/ubd_drv.c
@@ -769,7 +769,7 @@ static int ubd_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 			goto out;
 		}
 		if (cmd_op == UBD_IO_COMMIT_REQ) {
-			ret = ubq->aborted;
+			ret = UBD_IO_RES_ABORT;
 			goto out;
 		}
 		break;
-- 
2.31.1

