Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ADF13AA5D
	for <linux-block@vger.kernel.org>; Fri,  4 Apr 2025 00:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725953; cv=none; b=QMn1yBeemSz3MLeCBNDvvfd2+AEPraR0mEly51Rc2ocOGHyvejiERmBelugYR/O7zSORW42WLVneqs985cfsoBQNlrKz41yEloWDdCAfFXcReU6Py3dHedCm9u1sNzKTzIEch9Z7nRC310Bg5bdMC/bzNL3XdQ0qVbAKaibl4nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725953; c=relaxed/simple;
	bh=z6dMu/eEgVqVTUgW1qqZ4loC5dlfaiXYKiHF1yu7jg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ERZmLUuG7TQDa9vCO1QX9lzLcHumlSd1PpuKkz5tl3UpGjs7AWJgoXlGozN/5KBS/KNpH3wjUOf6aEhmBQjFuFz84HG4KgK1CULENsqS6AZRYhJ8jgCQ941ViD+DYlqp7NcQgJY/UUsZx4H3n241Z/H5ShJ/ZDXlY9jZATxjtM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XVwWoDr2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVwWoDr2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743725950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RVql1DCeypI6m34kdlGpk7A3gYaBbC6Y8RcuEDcjufs=;
	b=XVwWoDr2WblsxHlw8Sl7lNDj6oMRijsw5/wsRUMifgJIhjKeu/kKMs8AKLnFQqK+Z5YBYC
	vqu3RiUm6zFsQzVvvv1Yrqy2DWiOAmsszX5ms9FGCRT/DOV2WUZhxFbE2eSDJsq+n7MJDF
	qzOP/bPz61+CNF9vkOnvr1f8aTnLtZQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-ZxaI2P1MPkCmeyagtBCVrw-1; Thu,
 03 Apr 2025 20:19:07 -0400
X-MC-Unique: ZxaI2P1MPkCmeyagtBCVrw-1
X-Mimecast-MFC-AGG-ID: ZxaI2P1MPkCmeyagtBCVrw_1743725946
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 814C21800258;
	Fri,  4 Apr 2025 00:19:05 +0000 (UTC)
Received: from localhost (unknown [10.72.120.26])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42DFD1955BC2;
	Fri,  4 Apr 2025 00:19:03 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH] selftests: ublk: fix test_stripe_04
Date: Fri,  4 Apr 2025 08:18:49 +0800
Message-ID: <20250404001849.1443064-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Commit 57ed58c13256 ("selftests: ublk: enable zero copy for stripe target")
added test entry of test_stripe_04, but forgot to add the test script.

So fix the test by adding the script file.

Reported-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 .../testing/selftests/ublk/test_stripe_04.sh  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100755 tools/testing/selftests/ublk/test_stripe_04.sh

diff --git a/tools/testing/selftests/ublk/test_stripe_04.sh b/tools/testing/selftests/ublk/test_stripe_04.sh
new file mode 100755
index 000000000000..1f2b642381d1
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stripe_04.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="stripe_04"
+ERR_CODE=0
+
+_prep_test "stripe" "mkfs & mount & umount on zero copy"
+
+backfile_0=$(_create_backfile 256M)
+backfile_1=$(_create_backfile 256M)
+dev_id=$(_add_ublk_dev -t stripe -z -q 2 "$backfile_0" "$backfile_1")
+_check_add_dev $TID $? "$backfile_0" "$backfile_1"
+
+_mkfs_mount_test /dev/ublkb"${dev_id}"
+ERR_CODE=$?
+
+_cleanup_test "stripe"
+
+_remove_backfile "$backfile_0"
+_remove_backfile "$backfile_1"
+
+_show_result $TID $ERR_CODE
-- 
2.47.1

