Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40209 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeDXQRP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Apr 2018 12:17:15 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH blktests 2/3] nvme: add uuid parameter to _create_nvmet_subsystem
Date: Tue, 24 Apr 2018 10:12:50 -0600
Message-Id: <20180424161251.6502-2-jthumshirn@suse.de>
In-Reply-To: <20180424161251.6502-1-jthumshirn@suse.de>
References: <20180424161251.6502-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add an optional UUID parameter to _create_nvmet_subsystem().

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 common/nvme | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/nvme b/common/nvme
index 506612f27297..c54b1eb8cee2 100644
--- a/common/nvme
+++ b/common/nvme
@@ -46,13 +46,19 @@ _remove_nvmet_port() {
 _create_nvmet_subsystem() {
 	local nvmet_subsystem="$1"
 	local blkdev="$2"
+	local uuid="00000000-0000-0000-0000-000000000000"
 	local nvmet_cfs="/sys/kernel/config/nvmet/"
 	local cfs_path="${nvmet_cfs}/subsystems/${nvmet_subsystem}"
 
+	if [[ $# -eq 3 ]]; then
+	    uuid="$3"
+	fi
+
 	mkdir -p "${cfs_path}"
 	echo 1 > "${cfs_path}/attr_allow_any_host"
 	mkdir "${cfs_path}/namespaces/1"
 	printf "%s" "$blkdev" > "${cfs_path}/namespaces/1/device_path"
+	printf "%s" "$uuid" > "${cfs_path}/namespaces/1/device_uuid"
 	printf 1 > "${cfs_path}/namespaces/1/enable"
 }
 
-- 
2.16.3
