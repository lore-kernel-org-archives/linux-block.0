Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E67520CCF8
	for <linux-block@vger.kernel.org>; Thu, 27 Mar 2025 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743069122; cv=none; b=f22Alx7bTDQiMm4QcYFSo2Wmouk7Rq/c/Rw4tRk+2bB2xG85n/TYJ27EtWaVB8WjM5OqRuFgsyHN0CXCg5LeJ45puMCQ93UcSDUqDcUzZPSh8thAF9K17KQwEv4kyisivjZlj92Fkfv7l9fIEzxK5PiTfXygNtaOkj77WEYEOAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743069122; c=relaxed/simple;
	bh=0gVbJ4yfrdbTLkjJhJD/NhvJtnLQL9RzM64rYkFmhKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7PtvCdKGOJZggskyBMjGZ8m3IjfY4l+0NQZA9BdlNhsEsfVdhflLoMJrz9SWFrVRGYxChu6DWd3ms8amTLfmaeLA1foFzidKotXhi8TVW2hFxvrefLg3FS1xkhn8ylNC1icRYIYiffJlFsQtPiTbzTWHKNDgkHuyWl3RexAFwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipeP6iCP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipeP6iCP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743069120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0XgesrxVmpVy0CmTOILBOJPM/uTpemNtgab0cjaHEXA=;
	b=ipeP6iCPb/z8nmV/wir0cBNHbe+qAF9aBp34znFCfbLfXj7Tw0JsTWbFwoJraSLLZ78i+x
	PXEn0e22Vy5Nyik5z/AOmPFK0M2F7OwzAJkT2fkKr1Ik7gg5K8eaoNODrYc+ZXbrBAqNzj
	1pJKjzwoidJH9xw7m3nDx3MpRF7dEVw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-pwCSZxEsPHqejuI_EYA4fQ-1; Thu,
 27 Mar 2025 05:51:58 -0400
X-MC-Unique: pwCSZxEsPHqejuI_EYA4fQ-1
X-Mimecast-MFC-AGG-ID: pwCSZxEsPHqejuI_EYA4fQ_1743069117
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B2F41809CA3;
	Thu, 27 Mar 2025 09:51:57 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA8E030001A1;
	Thu, 27 Mar 2025 09:51:55 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 05/11] ublk: call io_uring_cmd_to_pdu to get uring_cmd pdu
Date: Thu, 27 Mar 2025 17:51:14 +0800
Message-ID: <20250327095123.179113-6-ming.lei@redhat.com>
In-Reply-To: <20250327095123.179113-1-ming.lei@redhat.com>
References: <20250327095123.179113-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Call io_uring_cmd_to_pdu() to get uring_cmd pdu, and one big benefit
is the automatic pdu size build check.

Suggested-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 200504dd67a9..1e11816d0b90 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1040,7 +1040,7 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
 		struct io_uring_cmd *ioucmd)
 {
-	return (struct ublk_uring_cmd_pdu *)&ioucmd->pdu;
+	return io_uring_cmd_to_pdu(ioucmd, struct ublk_uring_cmd_pdu);
 }
 
 static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
-- 
2.47.0

