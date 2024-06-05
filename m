Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEAC23D7
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 01:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717549734; cv=none; b=BKBp6QfN2wBEvbeAYqNhwDRKeu8hc8NAziwBS64bnLCQ+J3fEgRe58lctbidCcBy9voZUARb+bvi7rgCg9B1CUYnEo/b6SRDiItPe/5CQ/r6nULRMkNS+DlMhpQGr3/StMyz2YYOcs6PVZWKCKAYsyHh+YWQPoT2oQW67G1W4do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717549734; c=relaxed/simple;
	bh=pAwDng9jaN/ivvyaEvHADKkiItBliQnC1sVfuc7lUnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQE6Rm20p6V+FQyq/Pim4xKNi3XJMGldsli9cNwOO0TyXrTQd/1hF9Jqj4ZeOQwP956MtlBMvQEo8BVh4H75PQLpalr/BkD8hzhxpXSl9EQ4RBZ8ZoqxgHdTRbyOCq9nSaJ15qpg8rzOR+SmzMsOs9pvrM7mYt2TUUZSC8+vy9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fgykn/6E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fgykn/6E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717549731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HUC6XxFMvpdzhz+KouEfqqhKMNga1XMhn+QfxGt7fAA=;
	b=Fgykn/6E5+KXJkPQIgJtql9AeeTlZ6zbdU2lTZV/lW9DZd/WDoqNG4uw0Ht86s+g2ps38/
	lz+Rog4JbSGxkf8oxjTfXpNtqW7MaBxMwgi3kgUvYV6DpeGUYRKwHyvUUe/hg5u05U53Ye
	WM8VYJC8S0kdl/uL/7OdeFBlI6Sa0iA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-xCnV36CNOzCVwRqzAQckGQ-1; Tue,
 04 Jun 2024 21:08:47 -0400
X-MC-Unique: xCnV36CNOzCVwRqzAQckGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 015DE29ABA03;
	Wed,  5 Jun 2024 01:08:46 +0000 (UTC)
Received: from vm-10-0-76-146.hosted.upshift.rdu2.redhat.com (vm-10-0-76-146.hosted.upshift.rdu2.redhat.com [10.0.76.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BF308111DD10;
	Wed,  5 Jun 2024 01:08:45 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	yukuai1@huaweicloud.com
Subject: [PATCH V2 blktests] block: add regression test for null-blk concurrently power/submit_queues test
Date: Tue,  4 Jun 2024 21:05:42 -0400
Message-ID: <20240605010542.216971-1-yi.zhang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

null-blk currently power/submit_queues operations which will lead kernel
null-ptr-dereference[1], add one regression test for it and the fix has
been merged to v6.10-rc1 by [2].
[1]
https://lore.kernel.org/linux-block/CAHj4cs9LgsHLnjg8z06LQ3Pr5cax-+Ps+xT7AP7TPnEjStuwZA@mail.gmail.com/
https://lore.kernel.org/linux-block/20240523153934.1937851-1-yukuai1@huaweicloud.com/
[2]
commit a2db328b0839 ("null_blk: fix null-ptr-dereference while configuring 'power' and 'submit_queues'")

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/block/038     | 61 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/038.out |  2 ++
 2 files changed, 63 insertions(+)
 create mode 100755 tests/block/038
 create mode 100644 tests/block/038.out

diff --git a/tests/block/038 b/tests/block/038
new file mode 100755
index 0000000..fe3c7cd
--- /dev/null
+++ b/tests/block/038
@@ -0,0 +1,61 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Yi Zhang <yi.zhang@redhat.com>
+#
+# Regression test for commit a2db328b0839 ("null_blk: fix null-ptr-dereference
+# while configuring 'power' and 'submit_queues'").
+
+. tests/block/rc
+. common/null_blk
+
+DESCRIPTION="Test null-blk concurrent power/submit_queues operations"
+QUICK=1
+
+requires() {
+	_have_module null_blk
+	_have_module_param null_blk nr_devices
+	_have_module_param null_blk submit_queues
+}
+
+null_blk_power_loop() {
+	local nullb="$1"
+	for ((i = 1; i <= 200; i++)); do
+		echo 1 > "/sys/kernel/config/nullb/${nullb}/power"
+		echo 0 > "/sys/kernel/config/nullb/${nullb}/power"
+	done
+}
+
+null_blk_submit_queues_loop() {
+	local nullb="$1"
+	for ((i = 1; i <= 200; i++)); do
+		echo 1 > "/sys/kernel/config/nullb/${nullb}/submit_queues"
+		echo 4 > "/sys/kernel/config/nullb/${nullb}/submit_queues"
+	done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local nullb_params=(
+		nr_devices=0
+	)
+	if ! _init_null_blk "${nullb_params[@]}"; then
+		echo "Loading null_blk failed"
+		return 1
+	fi
+
+	if ! _configure_null_blk nullb0; then
+		echo "Configuring null_blk nullb0 failed"
+		return 1
+	fi
+
+	# fire off two null-blk power/submit_queues concurrently and wait
+	# for them to complete...
+	null_blk_power_loop nullb0 &
+	null_blk_submit_queues_loop nullb0 &
+	wait
+
+	_exit_null_blk
+
+	echo "Test complete"
+}
diff --git a/tests/block/038.out b/tests/block/038.out
new file mode 100644
index 0000000..aebde64
--- /dev/null
+++ b/tests/block/038.out
@@ -0,0 +1,2 @@
+Running block/038
+Test complete
-- 
2.45.1

