Return-Path: <SRS0=+JuZ=IE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF5BC433DB
	for <linux-block@archiver.kernel.org>; Sat,  6 Mar 2021 07:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0672E65005
	for <linux-block@archiver.kernel.org>; Sat,  6 Mar 2021 07:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhCFHUt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Mar 2021 02:20:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229581AbhCFHUL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 6 Mar 2021 02:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615015211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gIwX05qwpVmbv4adGNleOZnpjdRy4N9gkWX/TR/tUx4=;
        b=jFtFNgqT1bcBJM+/9NFskdqli1ZBW70/kn5/cMn/Jyh7buhbCaPz0+IIhE1UYiBKOoGcDD
        5BX5jHZXuErb9cTbdCHmZxfD3ZRaIIsrxVwX18kW/JMM1pPwJ6HFWK4yRi7DVbO3O4ceFg
        wnF9iNpHE2rjld3nsV7H0ChBbLbZu5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-WYC3geDNOb-T_IEmtszpgg-1; Sat, 06 Mar 2021 02:20:07 -0500
X-MC-Unique: WYC3geDNOb-T_IEmtszpgg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 881FB801814;
        Sat,  6 Mar 2021 07:20:05 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 331F761D2E;
        Sat,  6 Mar 2021 07:20:03 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@fb.com
Cc:     linux-block@vger.kernel.org, bvanassche@acm.org
Subject: [PATCH blktests] tests/srp/rc, tests/nvmeof-mp/rc: add fio check to group_requires
Date:   Sat,  6 Mar 2021 15:19:43 +0800
Message-Id: <20210306071943.31194-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Most of the srp and nvmeof-mp tests need fio, we need add fio
check before running the tests

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvmeof-mp/rc | 2 +-
 tests/srp/rc       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index ab7770f..4348b16 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -42,7 +42,7 @@ and multipathing has been enabled in the nvme_core kernel module"
 	)
 	_have_modules "${required_modules[@]}" || return
 
-	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof; do
+	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof fio; do
 		_have_program "$p" || return
 	done
 
diff --git a/tests/srp/rc b/tests/srp/rc
index 700cd71..2daf199 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -59,7 +59,7 @@ group_requires() {
 	)
 	_have_modules "${required_modules[@]}" || return
 
-	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof sg_reset; do
+	for p in mkfs.ext4 mkfs.xfs multipath multipathd pidof sg_reset fio; do
 		_have_program "$p" || return
 	done
 
-- 
2.21.0

