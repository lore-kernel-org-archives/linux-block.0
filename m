Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D527DC433DB
	for <linux-block@archiver.kernel.org>; Sun, 24 Jan 2021 05:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963AC22C9C
	for <linux-block@archiver.kernel.org>; Sun, 24 Jan 2021 05:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbhAXF2Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Jan 2021 00:28:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55238 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725803AbhAXF2Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jan 2021 00:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611466018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=085Fy3vC7BUZwVACF5KtJQeFe+7dRXAkuEeU9MPcjsE=;
        b=RmHEOmbnv2mHIsZcENq0N6mqN45BzhcVZiAaYsNaGgq0xGG1AcV1wzBT3WqoVIwfscEDD7
        nIrqntZhecSYzop0+HgHUTnDNVs0Av9BoQuis4VD566JeLm1xZUNl6fsEpSvaW8k2N+Hkt
        87PmHv0979pV1F4PNBead1eOOIlZyAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-WIE96KpVOb6OCI2orvuy3g-1; Sun, 24 Jan 2021 00:26:53 -0500
X-MC-Unique: WIE96KpVOb6OCI2orvuy3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FA37180A094;
        Sun, 24 Jan 2021 05:26:52 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F2D35B4BC;
        Sun, 24 Jan 2021 05:26:51 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@fb.com, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests] nvmeof-mp/rc: fix nvmeof-mp failure when NVME_TARGET_PASSTHRU enabled
Date:   Sun, 24 Jan 2021 13:26:44 +0800
Message-Id: <20210124052644.6925-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

$ ./check nvmeof-mp/001
nvmeof-mp/001 (Log in and log out)                           [passed]
    runtime  0.400s  ...  0.457s
rmdir: failed to remove 'subsystems/nvme-test/passthru/admin_timeout': Not a directory
rmdir: failed to remove 'subsystems/nvme-test/passthru/device_path': Not a directory
rmdir: failed to remove 'subsystems/nvme-test/passthru/enable': Not a directory
rmdir: failed to remove 'subsystems/nvme-test/passthru/io_timeout': Not a directory

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvmeof-mp/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index c77526f..ab7770f 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -265,8 +265,8 @@ stop_nvme_target() {
 			rm -f -- ports/*/subsystems/* &&
 			for d in {*/*/*/*,*/*}; do
 				[ -e "$d" ] &&
-					[ "$(basename "$(dirname "$d")")" != ana_groups ] &&
-					rmdir "$d"
+				[[ ! "$(basename "$(dirname "$d")")" =~ ana_groups|passthru ]] &&
+				rmdir "$d"
 			done
 	)
 	unload_module nvmet_rdma &&
-- 
2.21.0

