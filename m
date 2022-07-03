Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E4DC433EF
	for <linux-block@archiver.kernel.org>; Sun,  3 Jul 2022 18:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiGCSKb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Jul 2022 14:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGCSKa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Jul 2022 14:10:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B82F460F6
        for <linux-block@vger.kernel.org>; Sun,  3 Jul 2022 11:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656871828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ayXml23qBeBCmrzLfgRXNtHzuajrRtR37MMNQFm/CRw=;
        b=jG4Y9oNqtZugd8VRyqXIx7yksZ90Rh4JsGKT3GjnlojzhATA1tqi7Ds6ECpV5qyCR+lB1m
        pt1YboWONCXS7fFoYrKqsfSlHNSxqQPNhdTKwKCxQ3WTPRlGlyX1UXIpxrRRNuukT1TIXh
        Fa6hrMJMbXGqJ40s4irZKjnhmyFL8x0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-P8EDZk4INPuK0rJ01-lKLQ-1; Sun, 03 Jul 2022 14:10:22 -0400
X-MC-Unique: P8EDZk4INPuK0rJ01-lKLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CEC0801231;
        Sun,  3 Jul 2022 18:10:22 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B3CD40E7F28;
        Sun,  3 Jul 2022 18:10:20 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     shinichiro.kawasaki@wdc.com
Subject: [PATCH blktests] block/008: fix cpu online restore
Date:   Mon,  4 Jul 2022 02:09:57 +0800
Message-Id: <20220703180956.2922025-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The offline cpus cannot be restored during _cleanup when only _offline_cpu
executed, fix it by reset RESTORE_CPUS_ONLINE=1 during test.

Fixes: bd6b882 ("block/008: check CPU offline failure due to many IRQs")
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/block/008 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/block/008 b/tests/block/008
index 75aae65..f61f33a 100755
--- a/tests/block/008
+++ b/tests/block/008
@@ -91,6 +91,11 @@ test_device() {
 		fi
 	done
 
+	# The RESTORE_CPUS_ONLINE setting was ignored with previous
+	# err=$(_offline_cpu "${online_cpus[$idx]}" when only _offline_cpu
+	# executed, reset it here then the offline cpus can be retored
+	# shellcheck disable=SC2034
+	RESTORE_CPUS_ONLINE=1
 	FIO_PERF_FIELDS=("read iops")
 	_fio_perf_report
 
-- 
2.34.1

