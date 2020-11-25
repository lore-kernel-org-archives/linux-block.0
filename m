Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32241C64E7A
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 15:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D982720857
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 15:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJIJNox7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbgKYPuB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 10:50:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730318AbgKYPuA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 10:50:00 -0500
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3441205CB;
        Wed, 25 Nov 2020 15:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606319400;
        bh=JCpD8H8ozq3VPH/TBxrRgs/DodaTZAmPqn1BHclw1pA=;
        h=From:To:Cc:Subject:Date:From;
        b=rJIJNox7ghX4zhSWH7Sm66lhL+NCOW94Mfd8z67b8btlC3ONNVm40O75RxBFPWaBq
         uetJDndVYaSkZ6pUSa/qKXRXKACt8EmLFXs2Q/2FK/glUxjUiR9MlgreXcSpi3O2aw
         sk6uZm3oN6D3BfiLcX0h+aasoQGU9sUR9e3kPmP8=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] common/rc: confirm pcie hotplug capabilities
Date:   Wed, 25 Nov 2020 07:49:52 -0800
Message-Id: <20201125154952.2871261-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It turns out some PCIe slots report hotplug surprise but are not hotplug
capable. Despite the contridiction, the spec seems to allow that.

The linux pciehp driver needs hotplug capable to bind to the slot, and
the block/019 test requires hotplug surprise to handle the unannounced
link-down. Verify both bits in the slot capabilities register are set.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 0d7a3cd..d396fb5 100644
--- a/common/rc
+++ b/common/rc
@@ -269,7 +269,7 @@ _require_test_dev_in_hotplug_slot() {
 
 	local slt_cap
 	slt_cap="$(setpci -s "${parent}" CAP_EXP+14.w)"
-	if [[ $((0x${slt_cap} & 0x20)) -eq 0 ]]; then
+	if [[ $((0x${slt_cap} & 0x60)) -ne 0x60 ]]; then
 		SKIP_REASON="$TEST_DEV is not in a hot pluggable slot"
 		return 1
 	fi
-- 
2.24.1

