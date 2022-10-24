Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6C7C38A2D
	for <linux-block@archiver.kernel.org>; Mon, 24 Oct 2022 06:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiJXGPi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 02:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiJXGO7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 02:14:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7276113A
        for <linux-block@vger.kernel.org>; Sun, 23 Oct 2022 23:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666592057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pantO3zHCuj/0sWwfClVRGHvq4EWW3HMQyB2NqJ2iXQ=;
        b=Lcu1AdXoxAPY5CBuIfxnVO8qrpOAvVlbeb5vMEzz4OxanQylKrT6/gXBC6H6WaUFjjDZZJ
        udD5zEh9hSUKR9iPXbhg0lMORGejcnjG/6uc0ngUDdgiIXCbK/IkTSNdN6R0JlQJTxeHoL
        aEchaqaYdFggJvMNO3kcZaHBbXguU28=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-2tP-MINfPZODaPehndilYA-1; Mon, 24 Oct 2022 02:14:13 -0400
X-MC-Unique: 2tP-MINfPZODaPehndilYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5B3A185A792;
        Mon, 24 Oct 2022 06:14:12 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19C472024CCA;
        Mon, 24 Oct 2022 06:14:10 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 2/3] common/rc: add one function to get test dev size in mb
Date:   Mon, 24 Oct 2022 14:13:18 +0800
Message-Id: <20221024061319.1133470-3-yi.zhang@redhat.com>
In-Reply-To: <20221024061319.1133470-1-yi.zhang@redhat.com>
References: <20221024061319.1133470-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 common/rc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/rc b/common/rc
index e490041..847be1b 100644
--- a/common/rc
+++ b/common/rc
@@ -324,6 +324,14 @@ _get_pci_parent_from_blkdev() {
 		tail -2 | head -1
 }
 
+_get_test_dev_size_mb() {
+	local test_dev_sz
+	test_dev_sz=$(blockdev --getsize64 "$TEST_DEV")
+
+	echo $((test_dev_sz / 1024 / 1024))
+
+}
+
 _require_test_dev_in_hotplug_slot() {
 	local parent
 	parent="$(_get_pci_parent_from_blkdev)"
-- 
2.34.1

