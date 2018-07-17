Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35454 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731580AbeGQOEK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jul 2018 10:04:10 -0400
From: Hannes Reinecke <hare@suse.de>
To: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 1/2] blktests: enable ANA support
Date: Tue, 17 Jul 2018 15:31:17 +0200
Message-Id: <20180717133118.39026-2-hare@suse.de>
In-Reply-To: <20180717133118.39026-1-hare@suse.de>
References: <20180717133118.39026-1-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Update nvme functions to support ANA.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 tests/nvme/rc | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index fb5dbdf..116661d 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -27,7 +27,7 @@ group_device_requires() {
 	_test_dev_is_nvme
 }
 
-NVMET_CFS="/sys/kernel/config/nvmet/"
+NVMET_CFS="/sys/kernel/config/nvmet"
 
 _test_dev_is_nvme() {
 	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
@@ -49,6 +49,7 @@ _create_nvmet_port() {
 
 	mkdir "${NVMET_CFS}/ports/${port}"
 	echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"
+	echo "${port}" > "${NVMET_CFS}/ports/${port}/addr_traddr"
 
 	echo "${port}"
 }
@@ -58,6 +59,39 @@ _remove_nvmet_port() {
 	rmdir "${NVMET_CFS}/ports/${port}"
 }
 
+_create_nvmet_anagroup() {
+	local port="$1"
+	local port_cfs="${NVMET_CFS}/ports/${port}"
+	local grpid
+
+	for ((grpid = 1; ; grpid++)); do
+		if [[ ! -e "${port_cfs}/ana_groups/${grpid}" ]]; then
+			break
+		fi
+	done
+
+	mkdir "${port_cfs}/ana_groups/${grpid}"
+
+	echo "${grpid}"
+}
+
+_remove_nvmet_anagroup() {
+	local port="$1"
+	local grpid="$2"
+	local ana_cfs="${NVMET_CFS}/ports/${port}/ana_groups/${grpid}"
+
+	rmdir "${ana_cfs}"
+}
+
+_set_nvmet_anagroup_state() {
+	local port="$1"
+	local grpid="$2"
+	local state="$3"
+	local ana_cfs="${NVMET_CFS}/ports/${port}/ana_groups/${grpid}"
+
+	echo "${state}" > "${ana_cfs}/ana_state"
+}
+
 _create_nvmet_ns() {
 	local nvmet_subsystem="$1"
 	local nsid="$2"
@@ -65,14 +99,22 @@ _create_nvmet_ns() {
 	local uuid="00000000-0000-0000-0000-000000000000"
 	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 	local ns_path="${subsys_path}/namespaces/${nsid}"
+	local ana_grpid
 
-	if [[ $# -eq 4 ]]; then
+	if [[ $# -ge 4 ]]; then
 		uuid="$4"
 	fi
 
+	if [[ $# -eq 5 ]]; then
+		ana_grpid="$5"
+	fi
+
 	mkdir "${ns_path}"
 	printf "%s" "${blkdev}" > "${ns_path}/device_path"
 	printf "%s" "${uuid}" > "${ns_path}/device_uuid"
+	if [ -n "${ana_grpid}" ] ; then
+		printf "%s" "${ana_grpid}" > "${ns_path}/ana_grpid"
+	fi
 	printf 1 > "${ns_path}/enable"
 }
 
@@ -80,11 +122,12 @@ _create_nvmet_subsystem() {
 	local nvmet_subsystem="$1"
 	local blkdev="$2"
 	local uuid=$3
+	local ana_grpid=$4
 	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
 	mkdir -p "${cfs_path}"
 	echo 1 > "${cfs_path}/attr_allow_any_host"
-	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
+	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}" "${ana_grpid}"
 }
 
 _remove_nvmet_ns() {
-- 
2.12.3
