Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D360223645F
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577758; cv=none; b=aIPyJI6tA8gdBObHxRTJ7C7g3RijiqefqLyMMRYi6GZyOBI2WsEkoHqvCkVfhihIkfEtdLSEdL+0SuttL0q14frK042kZ7Nu2eiQLbqdXNgZvkLmhnYO6I9LqxQIwOL9EFvJwczgaFymm/v6hUYp7glJgWCrrrL7LdtiJl434wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577758; c=relaxed/simple;
	bh=TINAFm3X74n/MGQFIZO+LLmFc58R1cN4e58MBJh5UUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8Kv90ttuGD2l8k2CNReQWy7EDITUNtIBlkLeZMhiceoEKR1nyf99FNW8r5WdbTWbSbl0LFpJnEdeGMy+BaBUkjfdoz+Ztci7gh9OvcO3gkI5daxGYePetQWlOhwsgQhVe28+axFVmPlSLYASCzRkNtB3tPK0B698FfyjQWPauk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hFrraZd3; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hFrraZd3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577756; x=1775113756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TINAFm3X74n/MGQFIZO+LLmFc58R1cN4e58MBJh5UUA=;
  b=hFrraZd3vGoKT4+tF5OPTjGQ+QJFRD63VoEKSnLY/tJhDRwX1P0kijGb
   Dr2ujk5qva3eovNE8sVHR7+9oMlRvIxIIiNmFMW0vjcCaCmaqdRoMdAs2
   ssDn61y16p2lUf1OFn0bhWgxmgq7kkP/VwvXFWQZpaZE1YLCPXQ29pOJ2
   5gx09ML8jBDhhKaWV3jWCxRTOAAWaV8TFwNz2yGmjEhJingsN7Sn0sgsi
   6vOpx/kRdsXioN5Vs1J4hxZJ2xl0oYyL05zaZjBRgc6Fcn8eKD32zAXhR
   XanTUjUlLM9ZVXA3V+JxknL4VuMbrgIg2H2Z4CUdEAyvhCujzeF4+12S7
   g==;
X-CSE-ConnectionGUID: ZZulwOWeS4i1XALdhi7Uxg==
X-CSE-MsgGUID: xRrIWvQuRvuT+QZz4xRCRw==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="71367724"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:16 +0800
IronPort-SDR: 67ecd4a5_t93MXZFKER6HQSjMHfT4Z3FBI8FYzkFCYm7VY35+o8huhbw
 NjAIBdZH9+XrKR4UwP67itHp8fhIm7Tz0d56ZVA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:41 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:16 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 07/10] common/nvme: TLS target support
Date: Wed,  2 Apr 2025 16:09:03 +0900
Message-ID: <20250402070906.393160-8-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
References: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@suse.de>

Add --tls option to _create_nvmet_subsystem and allow to specify
the tls requirements in _create_nvmet_port.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/common/nvme b/common/nvme
index 9327dff..47bcdc9 100644
--- a/common/nvme
+++ b/common/nvme
@@ -477,6 +477,7 @@ _fc_host_traddr() {
 }
 
 _create_nvmet_port() {
+	local tls="${1:-none}"
 	local trtype="${nvme_trtype}"
 	local traddr="${def_traddr}"
 	local adrfam="${def_adrfam}"
@@ -513,7 +514,13 @@ _create_nvmet_port() {
 	   [[ "${adrfam}" != "loop" ]] ; then
 		echo "${trsvcid}" > "${portcfs}/addr_trsvcid"
 	fi
-
+	if [[ "${trtype}" == "tcp" ]] && \
+		   [[ "${tls}" != "none" ]]; then
+		echo "tls1.3" > "${portcfs}/addr_tsas"
+		if [[ "${tls}" != "required" ]]; then
+			echo "not required" > "${portcfs}/addr_treq"
+		fi
+	fi
 	echo "${port}"
 }
 
@@ -878,6 +885,7 @@ _nvmet_target_setup() {
 	local port p
 	local resv_enable=""
 	local num_ports=1
+	local tls="none"
 	local -a ARGS
 
 	while [[ $# -gt 0 ]]; do
@@ -910,6 +918,14 @@ _nvmet_target_setup() {
 				num_ports="$2"
 				shift 2
 				;;
+			--tls)
+				tls="not-required"
+				shift 1
+				;;
+			--force-tls)
+				tls="required"
+				shift 1
+				;;
 			*)
 				echo "WARNING: unknown argument: $1"
 				shift
@@ -956,7 +972,7 @@ _nvmet_target_setup() {
 
 	p=0
 	while (( p < num_ports )); do
-		port="$(_create_nvmet_port)"
+		port="$(_create_nvmet_port ${tls})"
 		_add_nvmet_subsys_to_port "${port}" "${subsysnqn}"
 		p=$(( p + 1 ))
 	done
-- 
2.49.0

