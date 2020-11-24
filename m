Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526FBC64E69
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 01:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B1D20758
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 01:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3YG0if+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgKXBFG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Nov 2020 20:05:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728149AbgKXBFF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 20:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606179905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2hH9HMbD7m3D18dSNHVZjKe3HFdYJgzZXEL8KtrsMA=;
        b=P3YG0if+o2cfsmfalVqR3ZwU5PD9QJVm9x26R/4BRnlDR7nuHCLCUShdL/hWczvV6uogE3
        m4rxmZml4NN5QwTbf1LNseMJpSEvVOpNhQW3dkm55C6qHi1pggC86yENeHXQPDPRVxP2A5
        wxp9nFcrsa6dkcs0dWgoj4RBh1eQwOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-LKpQkwyrP52Wrb6FHFDnSg-1; Mon, 23 Nov 2020 20:05:03 -0500
X-MC-Unique: LKpQkwyrP52Wrb6FHFDnSg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E9A980EDAD;
        Tue, 24 Nov 2020 01:05:01 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8927E1346D;
        Tue, 24 Nov 2020 01:04:59 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@osandov.com, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
Subject: [PATCH blktests 4/5] common/rc: _have_iproute2 fix for "ip -V" change
Date:   Tue, 24 Nov 2020 09:04:26 +0800
Message-Id: <20201124010427.18595-5-yi.zhang@redhat.com>
In-Reply-To: <20201124010427.18595-1-yi.zhang@redhat.com>
References: <20201124010427.18595-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With bellow commit, the version will be updated base on the tag
fbef6555 replace SNAPSHOT with auto-generated version string

To reproduce it:
$ ./check srp/015
common/rc: line 98: [: ip utility, iproute2-5.9.0: integer expression expected

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 0d7a3cd..37eb873 100644
--- a/common/rc
+++ b/common/rc
@@ -95,7 +95,7 @@ _have_iproute2() {
 		SKIP_REASON="ip utility not found"
 		return 1
 	fi
-	if [ "$snapshot" -lt "$1" ]; then
+	if [[ "$snapshot" =~ ^[0-9]+$ && "$snapshot" -lt "$1" ]]; then
 		SKIP_REASON="ip utility too old"
 		return 1
 	fi
-- 
2.21.0

