Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A22253B68
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 13:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031768; cv=none; b=UmiFEj3ZqotFD+SJUF97pSgg5FC73R19rDapcdv2jhlJsJyTDAdArQrSAEOr2Shfwk1eUS8ZbLGPg/JaQb6QZ0mAnJFvxUDGpOOHpocDt8njVB4PsLOdunAZbT2s2aG48NP5kC6XloAp4oINSoIXIgKPB6l/GLQ85bP1xnI63Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031768; c=relaxed/simple;
	bh=nDmYjwxh5V3mInfuCX5bh4Gu2+57PpNnp8sSS3hI/ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHvD0oq5+7MAqVGpAqRWuna+PT3bqrQ4ID4Ww+Fo187KKnyL59G24u7CPa+KHUmr5xOdyhSzHWLlCmbI43GzYUW7Joc89/s4gAHhWQ9sO6WtHFKarHKeEvjlQiYRNvWG85JJaHZzsA987mQCavcrgjBTQN9/8Sz4VR6DafN10uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RpAc4krh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpAc4krh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744031765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZybHChfSn8OEdssHH6oh4NRjJ67Elkx3onrOIGCzIBo=;
	b=RpAc4krhnh1pY2AVOv4K50va3Rc95spZM8NbiQ8eaNdLr3BfMRtTOBqyqtHG/LkNnSDI3i
	AN8qrgKCopOMqSbblRLKxaq2zNhC1lC1dTtcXsJILPPruC1zIe413pnwlpQleRmp1rIJN+
	oiXmDSuA72kKdLUqgMW7nECJYGoMPgI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-wHpgKby1MqCtYY6j6-wbnw-1; Mon,
 07 Apr 2025 09:16:02 -0400
X-MC-Unique: wHpgKby1MqCtYY6j6-wbnw-1
X-Mimecast-MFC-AGG-ID: wHpgKby1MqCtYY6j6-wbnw_1744031761
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91EAB19560B0;
	Mon,  7 Apr 2025 13:16:01 +0000 (UTC)
Received: from localhost (unknown [10.72.120.16])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B0601809B67;
	Mon,  7 Apr 2025 13:15:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 03/13] selftests: ublk: add io_uring uapi header
Date: Mon,  7 Apr 2025 21:15:14 +0800
Message-ID: <20250407131526.1927073-4-ming.lei@redhat.com>
In-Reply-To: <20250407131526.1927073-1-ming.lei@redhat.com>
References: <20250407131526.1927073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add io_uring UAPI header so that ublk can work with latest uapi
definition.

Fix the following build failure:

stripe.c: In function ‘stripe_to_uring_op’:
stripe.c:120:29: error: ‘IORING_OP_READV_FIXED’ undeclared (first use in this function); did you mean ‘IORING_OP_READ_FIXED’?
  120 |                 return zc ? IORING_OP_READV_FIXED : IORING_OP_READV;
      |                             ^~~~~~~~~~~~~~~~~~~~~
      |                             IORING_OP_READ_FIXED

Fixes: 57ed58c13256 ("selftests: ublk: enable zero copy for stripe target")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 760ff8ffb810..d87d6c376283 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -20,6 +20,7 @@
 #include <sys/wait.h>
 #include <sys/eventfd.h>
 #include <sys/uio.h>
+#include <linux/io_uring.h>
 #include <liburing.h>
 #include <linux/ublk_cmd.h>
 #include "ublk_dep.h"
-- 
2.47.0

