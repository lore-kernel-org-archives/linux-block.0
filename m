Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B9126C1E
	for <linux-block@vger.kernel.org>; Sat, 12 Apr 2025 02:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744425063; cv=none; b=rbWX98LZh2Xo/fArfs4hptj1xci9JpcVJVURVFPPEYeUY/ETlAsQTw57/aV4K0K0VetvcKcnju46ic6iethETekI0xyppQKYI8U/tMEbBd4xfbbp2ZIQVS9QIGMhVI7cJ7D724TeWBaL38wDCplmwyH/ILmWx59pUwLWNBNGHv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744425063; c=relaxed/simple;
	bh=B68eBHNooc9O8uGfi3U/t/hTYx2r2rfTRtJzNIx20k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAWr2IVDA+/7n/Mv1zeuIeUu3li7baAfcnUp+Tf5P2W4BMSwIMuLOyE2J9me5bq3xLy4axe8Fu30ttIp85JAsgWMO8ak/BkXREtyEP++WS/nFa57f08Z7cPi1t2YvZ4E9XBAGFGSFChAT3TwDXLyhuWI17a9kN0/F/NWmfiyEfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hmmVlEgd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmmVlEgd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744425060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aBjn9r7rMdXJqp4u+2vR8o5oSefXfzFWPaONd12pXXA=;
	b=hmmVlEgdjyX+JEGKudbsFIi1WQviulFOvJHboo1yGP2qOC5kqKq1EUmXIYtkNBawVdu5RB
	YgPUnlyH0N5c0uhBfSRWtkjcOnSfVWf0o+TAyBKGrGWBdRp7QPkj+ewbaK9aX8ET3cPp+J
	JGzoTR2wqxeLwhev+wmDM9Cp2SsLbt8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-dOmDa1i2M8yLtuw8qoKKqQ-1; Fri,
 11 Apr 2025 22:30:56 -0400
X-MC-Unique: dOmDa1i2M8yLtuw8qoKKqQ-1
X-Mimecast-MFC-AGG-ID: dOmDa1i2M8yLtuw8qoKKqQ_1744425055
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04A191800EC5;
	Sat, 12 Apr 2025 02:30:55 +0000 (UTC)
Received: from localhost (unknown [10.72.116.41])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DFF6E180886A;
	Sat, 12 Apr 2025 02:30:53 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH V2 02/13] selftests: ublk: add io_uring uapi header
Date: Sat, 12 Apr 2025 10:30:18 +0800
Message-ID: <20250412023035.2649275-3-ming.lei@redhat.com>
In-Reply-To: <20250412023035.2649275-1-ming.lei@redhat.com>
References: <20250412023035.2649275-1-ming.lei@redhat.com>
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

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Fixes: 57ed58c13256 ("selftests: ublk: enable zero copy for stripe target")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 73294f6e3e49..eccf12360a14 100644
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

