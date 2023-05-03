Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EE0C7EE22
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 08:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjECIDT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 04:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjECIDP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 04:03:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBADE74;
        Wed,  3 May 2023 01:03:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 669B9200AE;
        Wed,  3 May 2023 08:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683100993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zuH7OxLZZ6mL7lQtqpx6kEOj3SSaSSRaBrLmSYsP3ug=;
        b=SRxHYgUvOSN/luK2rX8SG+kDeTVs9HlxQ0Q56silroZmpi65o5b1Z9mA/hy6YejXCc55za
        t8XBXMTuruM6kEBn1mSXCSMFOZyewF/2Gbug6JdhZeDjGjlbWuCfrt2MzqvUjHxnDo7pQx
        1k5AUC6CzVMuf57L6AD1y6rHAVrUfG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683100993;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zuH7OxLZZ6mL7lQtqpx6kEOj3SSaSSRaBrLmSYsP3ug=;
        b=MQsYinun/4qb6UR8wykBHkBj3B7HWuhYIDDbO1gfb8OtbtSXjXKPJVdER2q9b9QvUDR5fT
        ZgYcKFCeuM1bpuCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59B0C1331F;
        Wed,  3 May 2023 08:03:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R8DkFUEVUmQ5YgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:03:13 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 06/12] Documentation: Add info on nvme_tr_type
Date:   Wed,  3 May 2023 10:02:52 +0200
Message-Id: <20230503080258.14525-7-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503080258.14525-1-dwagner@suse.de>
References: <20230503080258.14525-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Mention that the nvme tests can be parametrized.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 3550f377f487..7e827fba7ac0 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -98,6 +98,13 @@ requires that the kernel be compiled with `CONFIG_BLK_DEV_ZONED` enabled.
 RUN_ZONED_TESTS=1
 ```
 
+### NVMe test parameterizing
+
+The NVMe tests can be additionally parameterized via environment variables.
+
+- nvme_tr_type: 'loop' (default), 'tcp', 'rdma' and 'fc'
+  Run the tests with the given transport.
+
 ### Running nvme-rdma nvmeof-mp srp tests
 
 Most of these tests will use the rdma_rxe (soft-RoCE) driver by default. The siw (soft-iWARP) driver is also supported.
-- 
2.40.0

