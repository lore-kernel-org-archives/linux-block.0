Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17B419CC29
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 04:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749702018; cv=none; b=gzXQfg1ANu7NEdJfiozlvFksw2teygy9Y3xRTsUf1tWXN7MFQz1uHo1H9qi9y38rF/JiAiNdoUTRLh+NyCGMdVUwkv5OfTvwMUK9bavdNIuBdC3Us+WL0EKuaY2fshO9k4deAdWkj76Bzk5hU2VhCw6NF3n6G3IB0wWYSg5DhSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749702018; c=relaxed/simple;
	bh=4aux1w/aPnQWv4VD7FDwSYpij2u36Ixwz3P2BB9KbyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFL4sz7jHk/rbzlE6buTkWosYCyEDm3tD8Z8UpcBvUhhnjeMGRdB6QLdSZE8uQXdGHe6Y6Q9r3Kl6zG9TdS6kb5bSZJbRuq/YHo0bYiClN35x20Dv/kCc17h3i2WZpFwxyHW70fjdSSgSyv4tzw4pjGTTNOSC0P+vE3RQ8squZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQGw2VZa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQGw2VZa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749702015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=75kV+E8mEqe5XswcuY9XhWUGrFOSmMwSVqmuasygtEs=;
	b=eQGw2VZaH4Pice1pAEtOVooHnpHr0Gh400g6Ad/rEv8lreRmxvITFxnu4SPD6HRN7m2LUv
	eKGzk56fgb6Lm0PhsRNlOC363WxWFH9x3ZSS6+aAm5MpY6vQZsbRDbBzgScHmkXWLyuJC/
	ukFslGL26t+2hgEg3JrdTFxC749mq1U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-Olhz6VO5N8GD6cOG5CqvLA-1; Thu,
 12 Jun 2025 00:20:14 -0400
X-MC-Unique: Olhz6VO5N8GD6cOG5CqvLA-1
X-Mimecast-MFC-AGG-ID: Olhz6VO5N8GD6cOG5CqvLA_1749702013
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25E501809C84;
	Thu, 12 Jun 2025 04:20:13 +0000 (UTC)
Received: from localhost (unknown [10.72.116.109])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D9A9180045B;
	Thu, 12 Jun 2025 04:20:10 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] ublk: doc: fix "ERROR: Unexpected indentation. [docutils]"
Date: Thu, 12 Jun 2025 12:19:52 +0800
Message-ID: <20250612041952.157670-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix the following 'make htmldocs' build warning:

Documentation/block/ublk.rst:414: ERROR: Unexpected indentation. [docutils]

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 Documentation/block/ublk.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index abec524a04ed..08da8d51adcb 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -411,8 +411,8 @@ If auto buffer registration fails:
    - The uring_cmd is completed
    - ``UBLK_IO_F_NEED_REG_BUF`` is set in ``ublksrv_io_desc.op_flags``
    - The ublk server must manually deal with the failure, such as, register
-     the buffer manually, or using user copy feature for retrieving the data
-     for handling ublk IO
+   the buffer manually, or using user copy feature for retrieving the data
+   for handling ublk IO
 
 2. If fallback is not enabled:
    - The ublk I/O request fails silently
-- 
2.47.1

