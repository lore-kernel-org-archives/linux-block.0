Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40015 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeDXQPE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Apr 2018 12:15:04 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH blktests 1/3] nvme: fix counting available ports
Date: Tue, 24 Apr 2018 10:12:49 -0600
Message-Id: <20180424161251.6502-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 common/nvme | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/nvme b/common/nvme
index 400f66690f52..506612f27297 100644
--- a/common/nvme
+++ b/common/nvme
@@ -29,7 +29,7 @@ _create_nvmet_port() {
 	local trtype="$1"
 	local nvmet_cfs="/sys/kernel/config/nvmet/"
 
-	local port=$(($(ls "${nvmet_cfs}" | wc -l) + 1))
+	local port=$(($(ls "${nvmet_cfs}/ports" | wc -l) + 1))
 
 	mkdir "${nvmet_cfs}/ports/${port}"
 	echo "${trtype}" > "${nvmet_cfs}/ports/${port}/addr_trtype"
-- 
2.16.3
