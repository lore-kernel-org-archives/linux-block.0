Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A6BC3F2D1
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 11:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3304D20848
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 11:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgCELxB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:53:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:51168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgCELxB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Mar 2020 06:53:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 50CCFAFA0;
        Thu,  5 Mar 2020 11:52:59 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 1/3] nvme: enable ANA support
Date:   Thu,  5 Mar 2020 12:52:37 +0100
Message-Id: <20200305115239.29794-2-hare@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200305115239.29794-1-hare@suse.de>
References: <20200305115239.29794-1-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add ANA support functions and update _create_nvmet_ns() to
accept an additional ANA grpid parameter.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 tests/nvme/rc | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 40f0413..72e33c1 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -14,7 +14,7 @@ group_device_requires() {
 	_test_dev_is_nvme
 }
 
-NVMET_CFS="/sys/kernel/config/nvmet/"
+NVMET_CFS="/sys/kernel/config/nvmet"
 
 _test_dev_is_nvme() {
 	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
@@ -90,6 +90,7 @@ _create_nvmet_port() {
 
 	mkdir "${NVMET_CFS}/ports/${port}"
 	echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"
+	echo "${port}" > "${NVMET_CFS}/ports/${port}/addr_traddr"
 
 	echo "${port}"
 }
@@ -99,6 +100,62 @@ _remove_nvmet_port() {
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
+_display_ana_state() {
+	local nvmet_subsystem="$1"
+	local grpid state cntlid
+
+	for nvme in /sys/class/nvme/* ; do
+		[ -f ${nvme}/subsysnqn ] || continue
+		subsys="$(cat "${nvme}/subsysnqn")"
+		if [ "${subsys}" != "${nvmet_subsystem}" ] ; then
+			continue
+		fi
+		cntlid="$(cat "${nvme}/cntlid")"
+		for c in ${nvme}/nvme* ; do
+			if [ ! -d ${c} ] ; then
+				echo "${cntlid}: ANA disabled"
+				continue
+			fi
+			grpid="$(cat "${c}/ana_grpid")"
+			state="$(cat "${c}/ana_state")"
+			echo "${cntlid}: grpid ${grpid} state ${state}"
+		done
+	done
+}
+
 _create_nvmet_ns() {
 	local nvmet_subsystem="$1"
 	local nsid="$2"
@@ -106,14 +163,22 @@ _create_nvmet_ns() {
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
 
@@ -121,11 +186,12 @@ _create_nvmet_subsystem() {
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
2.13.7

