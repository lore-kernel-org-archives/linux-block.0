Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BFCC4332F
	for <linux-block@archiver.kernel.org>; Fri, 30 Dec 2022 06:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiL3GeJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Dec 2022 01:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiL3GeI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Dec 2022 01:34:08 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE1BFCD6
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 22:34:07 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NjwT21MpKz4f3tpl
        for <linux-block@vger.kernel.org>; Fri, 30 Dec 2022 14:33:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP1 (Coremail) with SMTP id cCh0CgCHpzFXhq5jVoXlAg--.55000S4;
        Fri, 30 Dec 2022 14:34:00 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com,
        hch@infradead.org
Cc:     yukuai3@huawei.com, yangerkun@huawei.com, yi.zhang@huawei.com
Subject: [PATCH blktests] dm: add a regression test
Date:   Fri, 30 Dec 2022 14:54:24 +0800
Message-Id: <20221230065424.19998-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCHpzFXhq5jVoXlAg--.55000S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWrZF4rGw13GF1kWr4fGrg_yoW8AF17p3
        yj9FyYkrs7CF17KFy3Ww17Xa4rAr4xuF4jyr17Ww1UArW5Jw1UKa47Kr12yryfXrZYvFs3
        Za4vqw1rCr18JaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
        daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Verify that reload a dm with itself won't crash the kernel.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 tests/dm/001     | 27 +++++++++++++++++++++++++++
 tests/dm/001.out |  4 ++++
 tests/dm/rc      | 11 +++++++++++
 3 files changed, 42 insertions(+)
 create mode 100755 tests/dm/001
 create mode 100644 tests/dm/001.out
 create mode 100644 tests/dm/rc

diff --git a/tests/dm/001 b/tests/dm/001
new file mode 100755
index 0000000..55e07f3
--- /dev/null
+++ b/tests/dm/001
@@ -0,0 +1,27 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Yu Kuai
+#
+# Regression test for commit 077a4033541f ("block: don't allow a disk link
+# holder to itself")
+
+. tests/dm/rc
+
+DESCRIPTION="reload a dm with itself"
+QUICK=1
+
+requires() {
+	_have_program dmsetup && _have_driver dm-mod
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	dmsetup create test --table "0 8192 linear ${TEST_DEV} 0"
+	dmsetup suspend test
+	dmsetup reload test --table "0 8192 linear /dev/mapper/test 0"
+	dmsetup resume test
+	dmsetup remove test
+
+	echo "Test complete"
+}
diff --git a/tests/dm/001.out b/tests/dm/001.out
new file mode 100644
index 0000000..23cf1f0
--- /dev/null
+++ b/tests/dm/001.out
@@ -0,0 +1,4 @@
+Running dm/001
+device-mapper: reload ioctl on test failed: Invalid argument
+Command failed
+Test complete
diff --git a/tests/dm/rc b/tests/dm/rc
new file mode 100644
index 0000000..e1ad6c6
--- /dev/null
+++ b/tests/dm/rc
@@ -0,0 +1,11 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Yu Kuai
+#
+# TODO: provide a brief description of the group here.
+
+. common/rc
+
+group_requires() {
+	_have_root
+}
-- 
2.31.1

