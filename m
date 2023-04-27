Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDDCC7618E
	for <linux-block@archiver.kernel.org>; Thu, 27 Apr 2023 02:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbjD0CnW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Apr 2023 22:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjD0CnV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Apr 2023 22:43:21 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E6B26BC
        for <linux-block@vger.kernel.org>; Wed, 26 Apr 2023 19:43:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q6KmL5SvTz4f3ybS
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 10:43:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLNC4UlkQGzvIA--.1778S4;
        Thu, 27 Apr 2023 10:43:16 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     shinichiro@fastmail.com, snitzer@kernel.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH blktests v2] tests/dm: add a regression test
Date:   Thu, 27 Apr 2023 10:41:26 +0800
Message-Id: <20230427024126.1417646-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLNC4UlkQGzvIA--.1778S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1Uuw4kXw1DCF4ktw45Awb_yoW8AryUp3
        yUur1Ykrs2y3W7tFy3W3W7Xa4rAws7uF4UCr17Ww18Ary3Jw1UK3W7Kry7AryfXFZYqan3
        ZasYqa1rur48J3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Verify that reload a dm with maps to itself will fail.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 tests/dm/001     | 29 +++++++++++++++++++++++++++++
 tests/dm/001.out |  2 ++
 tests/dm/rc      | 13 +++++++++++++
 3 files changed, 44 insertions(+)
 create mode 100644 tests/dm/001
 create mode 100644 tests/dm/001.out
 create mode 100644 tests/dm/rc

diff --git a/tests/dm/001 b/tests/dm/001
new file mode 100644
index 0000000..6deab1f
--- /dev/null
+++ b/tests/dm/001
@@ -0,0 +1,29 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Yu Kuai
+#
+# Regression test for commit 077a4033541f ("block: don't allow a disk link
+# holder to itself")
+
+. tests/dm/rc
+
+DESCRIPTION="reload a dm with maps to itself"
+QUICK=1
+
+requires() {
+	_have_kver 6 2
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	dmsetup create test --table "0 8192 linear ${TEST_DEV} 0"
+	dmsetup suspend test
+	dmsetup reload test --table "0 8192 linear /dev/mapper/test 0" &> /dev/null
+	if [ $? -eq 0 ]; then
+		echo "reload a dm with maps to itself succeed."
+	fi
+	dmsetup remove test
+
+	echo "Test complete"
+}
diff --git a/tests/dm/001.out b/tests/dm/001.out
new file mode 100644
index 0000000..4bd2c08
--- /dev/null
+++ b/tests/dm/001.out
@@ -0,0 +1,2 @@
+Running dm/001
+Test complete
diff --git a/tests/dm/rc b/tests/dm/rc
new file mode 100644
index 0000000..0486db0
--- /dev/null
+++ b/tests/dm/rc
@@ -0,0 +1,13 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Yu Kuai
+#
+# Tests for device-mapper
+
+. common/rc
+
+group_requires() {
+	_have_root
+	_have_program dmsetup
+	_have_driver dm-mod
+}
-- 
2.39.2

