Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA06C4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 02:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiKBC6r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 22:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiKBC6q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 22:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B0822535
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 19:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667357865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hPUqyTphJbcj2xxsFqvjVhKPi20MUf82RhN84b01TZs=;
        b=KDFGFC3hiQwwuv2Pr6FGmz0tTo87O3Zs/VKN5mv7TU/pw5fvEgudlA8Bw168qvdPSrYncw
        YbpZnxgm587peYBesQ1w9dt70KlA/cQOlVlqvQDvTC2+rW4mKyQ6ZasO5ovM4j0jvvhEWO
        wI9PVu5L+L1v8jlUfrUfz1SlSxsLmwg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-tRdl9fRAOeWVVDI4hF1X0g-1; Tue, 01 Nov 2022 22:57:44 -0400
X-MC-Unique: tRdl9fRAOeWVVDI4hF1X0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F7951C068CB;
        Wed,  2 Nov 2022 02:57:44 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A34AC422A9;
        Wed,  2 Nov 2022 02:57:42 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     shinichiro.kawasaki@wdc.com
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org
Subject: [PATCH V2 blktests 2/3] common/rc: add one function to check required dev size for TEST_DEV
Date:   Wed,  2 Nov 2022 10:57:01 +0800
Message-Id: <20221102025702.1664101-3-yi.zhang@redhat.com>
In-Reply-To: <20221102025702.1664101-1-yi.zhang@redhat.com>
References: <20221102025702.1664101-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nvme/035 has minimum TEST_DEV size requirement, add a helper function
to check it

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 common/rc      | 10 ++++++++++
 tests/nvme/035 |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/common/rc b/common/rc
index e490041..7987ac3 100644
--- a/common/rc
+++ b/common/rc
@@ -324,6 +324,16 @@ _get_pci_parent_from_blkdev() {
 		tail -2 | head -1
 }
 
+_require_test_dev_size_mb() {
+	local require_sz_mb=$1
+	local test_dev_sz_mb=$(($(blockdev --getsize64 "$TEST_DEV")/1024/1024))
+
+	if (( "$test_dev_sz_mb" < "$require_sz_mb" )); then
+		SKIP_REASONS+=("${TEST_DEV} required at least ${require_sz_mb}m")
+		return 1
+	fi
+}
+
 _require_test_dev_in_hotplug_slot() {
 	local parent
 	parent="$(_get_pci_parent_from_blkdev)"
diff --git a/tests/nvme/035 b/tests/nvme/035
index ee78a75..e8581ef 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -16,6 +16,10 @@ requires() {
 	_have_fio
 }
 
+device_requires() {
+	_require_test_dev_size_mb 1024
+}
+
 test_device() {
 	local subsys="blktests-subsystem-1"
 	local ctrldev
-- 
2.34.1

