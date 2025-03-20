Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E341D1D6188
	for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 01:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742434702; cv=none; b=BkAT0poEAJ19CUf0xLqEJvfsrS1L03xTecHk3i1SmFXkJiNYds51ixbJaOMnw7IkYrBVNvHKiZHRNuW4hj8IS/lpJErh7IvcoKBwAeqwaouImLLIsg47MkPFUhlfklM/fP48C9GUSBvi3hkBhBJICNM6g26gMt+XA0r30lCAtN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742434702; c=relaxed/simple;
	bh=lK3Yjf94mHImISjDknCmk6n2QoQ4fiJ2vCSeSLPlBnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBVikF3trBMd4DeOgnzc1bB7/4IE4MtIW6lBgDm50KK6X0QVcwbT5xzzyWWsyYdERDcDoruokOcglUAx5DkLDUukZ/mtomDaEYsSSec3p1e5Dm2Enor6kTkSNmYQU7K9ZxLupgw3R8UZu4rbcPGOmq7gSIpA/Il9RAAo843+9/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dmfioqmK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmfioqmK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742434699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55q+DkLDP4WVpSk85IxOVe1rdMCQ1VopH8gWNIvcGUM=;
	b=dmfioqmKxuJ+lBw2UYNKLpAv+tzi2V8xdr1NjeZ1aOT0baM2wRn9LJ3APFdeSdoQKQzf96
	GFaKZCoODnyDWJSHwf6xyp+fYEJOAyimTfL/WuDUw7bWlT7PumHQ+OFRLCarq+AoYIB6aB
	kX/Gexn73gXZRmRUrMqEa4v5aF5uHJ8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-Mt2hd6M2OoqRwohKxi7I1w-1; Wed,
 19 Mar 2025 21:38:18 -0400
X-MC-Unique: Mt2hd6M2OoqRwohKxi7I1w-1
X-Mimecast-MFC-AGG-ID: Mt2hd6M2OoqRwohKxi7I1w_1742434697
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 222C01800EC5;
	Thu, 20 Mar 2025 01:38:17 +0000 (UTC)
Received: from localhost (unknown [10.72.120.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD15C1828A98;
	Thu, 20 Mar 2025 01:38:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/3] selftests: ublk: add one dependency header
Date: Thu, 20 Mar 2025 09:37:33 +0800
Message-ID: <20250320013743.4167489-2-ming.lei@redhat.com>
In-Reply-To: <20250320013743.4167489-1-ming.lei@redhat.com>
References: <20250320013743.4167489-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add one dependency helper which can include new uapi definition which
isn't synced from kernel.

This way also helps a lot for downstream test deployment.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.h    |  1 +
 tools/testing/selftests/ublk/ublk_dep.h | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 tools/testing/selftests/ublk/ublk_dep.h

diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 26d9aa9c5ca2..3ff9ac5104a7 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -21,6 +21,7 @@
 #include <sys/eventfd.h>
 #include <liburing.h>
 #include <linux/ublk_cmd.h>
+#include "ublk_dep.h"
 
 #define __maybe_unused __attribute__((unused))
 #define MAX_BACK_FILES   4
diff --git a/tools/testing/selftests/ublk/ublk_dep.h b/tools/testing/selftests/ublk/ublk_dep.h
new file mode 100644
index 000000000000..f68fa7eac939
--- /dev/null
+++ b/tools/testing/selftests/ublk/ublk_dep.h
@@ -0,0 +1,18 @@
+#ifndef UBLK_DEP_H
+#define UBLK_DEP_H
+
+#ifndef UBLK_U_IO_REGISTER_IO_BUF
+#define	UBLK_U_IO_REGISTER_IO_BUF	\
+	_IOWR('u', 0x23, struct ublksrv_io_cmd)
+#define	UBLK_U_IO_UNREGISTER_IO_BUF	\
+	_IOWR('u', 0x24, struct ublksrv_io_cmd)
+#endif
+
+#ifndef UBLK_F_USER_RECOVERY_FAIL_IO
+#define UBLK_F_USER_RECOVERY_FAIL_IO (1ULL << 9)
+#endif
+
+#ifndef UBLK_F_ZONED
+#define UBLK_F_ZONED (1ULL << 8)
+#endif
+#endif
-- 
2.47.0

