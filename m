Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889D627B347
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159770; cv=none; b=lrjLZVcHT0w+IN8iJZW4dtupFShi8FHxvq46nI0k0SS/8xasunODM5L6EkN3LmuG1JAdX/XL2sA9x8p8HzVthFVKRw1mC7LP92riuLoY+KswQdx+GooWKD6RhpsLlem6QbEEXwbfsZq/sk8DfSlqeemFgxAuKXEwSHWoPtx5QL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159770; c=relaxed/simple;
	bh=y4LJMW5Ormti/udlkPPSfebRPZ5dxh39OvLodCUfR9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nc5KrhUhmdci3ufPosVpwZ8STD6bG8tsMgb0AU8o9wBZAMCJ3hYKliHNSobMT6k7pwUNCv8kiRtMlNSwWa+Bbs0K9IgtNceWTtoKViYZEN5x2j/J3iSsDRE4PNx9++p+sX17n7Hqy0uyfNAL4hlVVQa8/uTJ5PnrAEtaE7ntH/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJec4gh3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJec4gh3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769159768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=al9selboXDfNBKkXOf0Z7nkQv25RcQAEyvrKZo4eedA=;
	b=dJec4gh3hYVXsaolPUERE/n11xRYSMnJ/jfb0zw+u92e85tpJQYDF7bHhYz5PH3V+H8yb2
	q/d1idUMl2Sxeol//i/fYW0FrULGr1mbvV5WTPtDMAhwDaE8f4VWo3jdB8pO+crQjplz/H
	O0hbr8WTbKug7URrZcaFr/73Ie5sM1I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-8VD-ILqfN9ibhOCEbMUP9g-1; Fri,
 23 Jan 2026 04:16:04 -0500
X-MC-Unique: 8VD-ILqfN9ibhOCEbMUP9g-1
X-Mimecast-MFC-AGG-ID: 8VD-ILqfN9ibhOCEbMUP9g_1769159763
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5DDE19775AE;
	Fri, 23 Jan 2026 09:16:03 +0000 (UTC)
Received: from localhost (unknown [10.72.116.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AD97C18004D8;
	Fri, 23 Jan 2026 09:16:02 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/3] selftests: ublk: fix test name
Date: Fri, 23 Jan 2026 17:15:44 +0800
Message-ID: <20260123091547.2164984-4-ming.lei@redhat.com>
In-Reply-To: <20260123091547.2164984-1-ming.lei@redhat.com>
References: <20260123091547.2164984-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix the two added test name.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_stress_08.sh | 2 +-
 tools/testing/selftests/ublk/test_stress_09.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_stress_08.sh b/tools/testing/selftests/ublk/test_stress_08.sh
index 190db0b4f2ad..9abb50ee3d00 100755
--- a/tools/testing/selftests/ublk/test_stress_08.sh
+++ b/tools/testing/selftests/ublk/test_stress_08.sh
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
-TID="stress_06"
+TID="stress_08"
 ERR_CODE=0
 
 ublk_io_and_remove()
diff --git a/tools/testing/selftests/ublk/test_stress_09.sh b/tools/testing/selftests/ublk/test_stress_09.sh
index 1b6bdb31da03..87b92b0a2410 100755
--- a/tools/testing/selftests/ublk/test_stress_09.sh
+++ b/tools/testing/selftests/ublk/test_stress_09.sh
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
-TID="stress_07"
+TID="stress_09"
 ERR_CODE=0
 
 ublk_io_and_kill_daemon()
-- 
2.47.0

