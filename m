Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCACEB64DA
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 12:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjF1Mpt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 08:45:49 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:27924 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjF1Mnp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 08:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687956225; x=1719492225;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gfx1u99cyhBlTpKJXO9JdtXu79VGGOr+tEjCoTB3OPc=;
  b=bzrUYkJoX0/hlom0a61gCmesrHe6PbWfTW+VoCLvSOSjfXxwFW5miBiP
   LFx6ZtMIIR+Yf7it5fIHCXIkhCqO1XH/sqZ1EKAn6dz8PezilAxK6Tl0W
   z2ftdF2w6JmXXGS4yg78I92XMT0kU7rFW9r1zHZFcy5Jq5EpM9f6kJJ8M
   OvaVuhM7LngLfAmXoEHoj7xZcvYNNQkoGNwfb1oi/Mw1QCQ9g2EiTa6Jf
   LZwGMo3oDcE6O1pEYI63y8Uid0gJ/0fgvOJPPIU/wTOBaIdk420h6VLx/
   csHAFA/RXYh9XM8JwfnPOcRcKRYt3ENGPOvquVmOmDGyJoqtz0fc4Q1kw
   g==;
X-IronPort-AV: E=Sophos;i="6.01,165,1684771200"; 
   d="scan'208";a="241423570"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2023 20:43:45 +0800
IronPort-SDR: UP75lLLB8K/x3aNQPvlRrPNCwcpSMxESMHPw8HFtQRl2COZc6fumRJDiUi/MTuOUk4NeDxvnUa
 zSJwLPD6ILVHKAybHQV4AHIzlcO6ufPzg+dHrmkcdG3cSVSZvt9MNqLX2ARZM8Dj4tlV6L47Ra
 ZM9v0VKWY8XAnssAXBpRWi/R9DQSjuK8TAlnzNOUx/Y7iEcLbNgrEIZ561Hruf7ZlFLYjPuDZW
 QZdq2nhGKrFedvSWgTvyYo3YNBnPI8DHZT6i5qmQlc4za9OY+PNNQf2HSvKZBW9tGNIU+5wfG2
 u4I=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2023 04:58:03 -0700
IronPort-SDR: a2MkjIK5YvVFE28Z+bgP8TWuo8y79y5+LMH+xYFo4pB4FYWdnJ4DdMYvYKA7YTUjfQoyxZK9yH
 pfv8rOVeFl5Q4ZGyhhicHBcWZEVE76k7VYP+KUnphpEOBNJ0SODHRRU5XXEPm0eEBNeFsRDFOt
 leJaN2C7ZmEBSOSNYT4hn5Zw2QcT8VEqsuyp1mfZRVfsysymfFUgtEYT5+J3M3u2vMv41KWYY/
 Wm53qHKU3CMrNRT+XcSZp1kWlbxywFyDvjsshB5nn2yxTxmfb5l7lh7vQc9XGc1t5zpwMn6CwX
 0gA=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jun 2023 05:43:45 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/rc: specify hostnqn to hostid to nvme discover and connect
Date:   Wed, 28 Jun 2023 21:43:43 +0900
Message-Id: <20230628124343.2900339-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Max Gurtovoy <mgurtovoy@nvidia.com>

After the kernel commit ae8bd606e09b ("nvme-fabrics: prevent overriding
of existing host"), 'nvme discover' and 'nvme connect' commands fail
when pair of hostid and hostnqn is not provide. This caused failure of
many test cases in the nvme group with kernel messages "nvme_fabrics:
found same hostid XXX but different hostnqn YYY".

To avoid the failure, specify valid hostnqn and hostid to the nvme
commands always. Prepare def_hostnqn and def_hostid even when
/etc/nvme/hostnqn or /etc/nvme/hostid is not available. Using these
values, add --hostnqn and --hostid options to the nvme commands in
_nvme_discover() and _nvme_connect_subsys().

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Link: https://lore.kernel.org/linux-nvme/CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com/
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 191f3e2..1c2c2fa 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -14,8 +14,23 @@ def_remote_wwnn="0x10001100aa000001"
 def_remote_wwpn="0x20001100aa000001"
 def_local_wwnn="0x10001100aa000002"
 def_local_wwpn="0x20001100aa000002"
-def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
-def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
+
+if [ -f "/etc/nvme/hostid" ]; then
+	def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
+else
+	def_hostid="$(uuidgen)"
+fi
+if [ -z "$def_hostid" ] ; then
+	def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
+fi
+
+if [ -f "/etc/nvme/hostnqn" ]; then
+	def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
+fi
+if [ -z "$def_hostnqn" ] ; then
+	def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
+fi
+
 nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
@@ -442,12 +457,8 @@ _nvme_connect_subsys() {
 	elif [[ "${trtype}" != "loop" ]]; then
 		ARGS+=(-a "${traddr}" -s "${trsvcid}")
 	fi
-	if [[ "${hostnqn}" != "$def_hostnqn" ]]; then
-		ARGS+=(--hostnqn="${hostnqn}")
-	fi
-	if [[ "${hostid}" != "$def_hostid" ]]; then
-		ARGS+=(--hostid="${hostid}")
-	fi
+	ARGS+=(--hostnqn="${hostnqn}")
+	ARGS+=(--hostid="${hostid}")
 	if [[ -n "${hostkey}" ]]; then
 		ARGS+=(--dhchap-secret="${hostkey}")
 	fi
@@ -483,6 +494,8 @@ _nvme_discover() {
 	local trsvcid="${3:-$def_trsvcid}"
 
 	ARGS=(-t "${trtype}")
+	ARGS+=(--hostnqn="${def_hostnqn}")
+	ARGS+=(--hostid="${def_hostid}")
 	if [[ "${trtype}" = "fc" ]]; then
 		ARGS+=(-a "${traddr}" -w "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
-- 
2.40.1

