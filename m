Return-Path: <SRS0=nGPF=IF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5FCC433E0
	for <linux-block@archiver.kernel.org>; Sun,  7 Mar 2021 16:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C53650F5
	for <linux-block@archiver.kernel.org>; Sun,  7 Mar 2021 16:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhCGQcT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Mar 2021 11:32:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231314AbhCGQb5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 7 Mar 2021 11:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615134716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PPe10iwzwa523FVfuqtQzm9VfBe1rdxjWcoaqBNWp8k=;
        b=PJ1t/tRqQq5j/D2tpSMtpb5NkXZaHpNIxbFzWCL/nOHgxGg0jGDvbyIf9L4tdb46r1AV0k
        pCqxS6od4oNIbtr9Tf5i17le7YzsweqVwv9VSyfF26epQaJPja1G4baOIupypa4OTSj4Fi
        02brrme48VZhrDl1JyW3lNAYSbpXkRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-BxZq2wfQMROK_U-7qPJZuA-1; Sun, 07 Mar 2021 11:31:54 -0500
X-MC-Unique: BxZq2wfQMROK_U-7qPJZuA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 624D1192D789;
        Sun,  7 Mar 2021 16:31:53 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 081276064B;
        Sun,  7 Mar 2021 16:31:51 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@fb.com
Cc:     linux-block@vger.kernel.org, bvanassche@acm.org
Subject: [PATCH blktests v2] tests/srp/rc, tests/nvmeof-mp/rc: add fio check to group_requires
Date:   Mon,  8 Mar 2021 00:31:42 +0800
Message-Id: <20210307163142.6918-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Most of the srp and nvmeof-mp tests need fio, we need add fio
check before running the tests

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
v2: update to based on Bart's patch
[PATCH blktests v2] rdma: Use rdma link instead of
/sys/class/infiniband/*/parent
---
 tests/nvmeof-mp/rc | 2 +-
 tests/srp/rc       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index 0a12825..dcb2e3c 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -42,7 +42,7 @@ and multipathing has been enabled in the nvme_core kernel module"
 	)
 	_have_modules "${required_modules[@]}" || return
 
-	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof rdma; do
+	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof rdma fio; do
 		_have_program "$p" || return
 	done
 
diff --git a/tests/srp/rc b/tests/srp/rc
index 2986bfd..586f007 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -60,7 +60,7 @@ group_requires() {
 	_have_modules "${required_modules[@]}" || return
 
 	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof rdma \
-		 sg_reset; do
+		 sg_reset fio; do
 		_have_program "$p" || return
 	done
 
-- 
2.21.0

