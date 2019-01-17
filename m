Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F388CC43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 12:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C1220657
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 12:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfAQM7S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:59:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:40184 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725928AbfAQM7S (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 07:59:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 14CE4AE47;
        Thu, 17 Jan 2019 12:59:17 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Anthony Iliopoulos <ailiopoulos@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH blktests 1/2] nvme: enable buffered_io for file-backed namespaces
Date:   Thu, 17 Jan 2019 13:59:05 +0100
Message-Id: <20190117125906.15479-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All file-based NVMe over Fabrics tests fail in my test environment as I'm
running these tests form within an initramfs. It turns out the file backing
store of the NVMe target defaults to using direct I/O which is not
available on tmpfs for obvious reasons.

If the backing store of an nvme target is file-based enable the use of
buffered I/O.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 tests/nvme/rc | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index eff1dd992460..ec92e41396be 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -48,7 +48,7 @@ _remove_nvmet_port() {
 _create_nvmet_ns() {
 	local nvmet_subsystem="$1"
 	local nsid="$2"
-	local blkdev="$3"
+	local backstore="$3"
 	local uuid="00000000-0000-0000-0000-000000000000"
 	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 	local ns_path="${subsys_path}/namespaces/${nsid}"
@@ -58,8 +58,11 @@ _create_nvmet_ns() {
 	fi
 
 	mkdir "${ns_path}"
-	printf "%s" "${blkdev}" > "${ns_path}/device_path"
+	printf "%s" "${backstore}" > "${ns_path}/device_path"
 	printf "%s" "${uuid}" > "${ns_path}/device_uuid"
+	if [[ -f ${backstore} ]]; then
+		printf 1 > "${ns_path}/buffered_io"
+	fi
 	printf 1 > "${ns_path}/enable"
 }
 
-- 
2.16.4

