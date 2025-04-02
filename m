Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA73236453
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577757; cv=none; b=SN8LlSp7sqkOiVBMEVzsk2UvBehuZSULg+TgQ4VmCUvf7Z9Qkdihotf9Rzl74x6U5fj1Jo+TRk5nuzKHNsHQnQ+qLRn7A28xrQRdg2F9l01e2RcUx64L3FzSMf6eIYOzouaGl3wtxojA2aYSuDJeDdem3VmD7omDlI1Xw+Men4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577757; c=relaxed/simple;
	bh=tftTrXPbJbZQ11TozRGfTpfYSu/Q0A0MVEOzzzAL7/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSvqUatdoEXSaqrBZn7wXWSwhnvo+G6lJvCadUlsklns0UGWkJi46Nv1IRL/HOzJNXda4gi2f2i+fCAWsFkRZyK/nbkWmJlNmiIFaiAWBCOfmILlIXllxKFEOTTtavjLGM0L8M6GpTXLsZcoTJwQMUfmKhCnipqJsiJVEaam89c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=leiXIYHn; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="leiXIYHn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577755; x=1775113755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tftTrXPbJbZQ11TozRGfTpfYSu/Q0A0MVEOzzzAL7/E=;
  b=leiXIYHnBSpxzdUkF++aH3A1fBWD89uqtwg112HNsrmlAmOMiRtAxIIe
   7Lpv1+4+25CSvo61R7wcQ/TMLbkELfeQZEb6vcXsuypSZH9kYHlJMkOIJ
   U33h5fm3svMyBR8fgzS6gGBUS3VLo+nLU7D9a1n++jBc8w6pxsRaEVadY
   iIAemsC+PVrqYkMDk/loK+DDbfgQmj0SVCDwBpZFbot13u9m48EhedxY/
   S4944q1ArAxgCA7yqc7tiKZFOfmFMYoEN3OQRCBxCpla+HBZiHwgzit+m
   o7B66iQ6FZaaK4EGNPw/7JqnHOaAgFOokHI3XYVYzWtRCttLiHdrXlNRV
   w==;
X-CSE-ConnectionGUID: /oitlINYQP+Rln4lV4yXPw==
X-CSE-MsgGUID: eDK68Kc5Rd6MZDqFY6uSzw==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="71367698"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:15 +0800
IronPort-SDR: 67ecd4a4_9VZTIf5hSx/o4mO1Ppvy0Y+gc0FAVT73ODCxsk2hqVzmk9U
 WO265ICGq7oH5cZ31jELNWBwFgaY/WicTd4WX3g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:40 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:15 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 06/10] common/nvme: add '--tls' argument to _nvme_connect_subsys()
Date: Wed,  2 Apr 2025 16:09:02 +0900
Message-ID: <20250402070906.393160-7-shinichiro.kawasaki@wdc.com>
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

To start TLS-encrypted connections.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/nvme b/common/nvme
index 3761329..9327dff 100644
--- a/common/nvme
+++ b/common/nvme
@@ -274,6 +274,7 @@ _nvme_connect_subsys() {
 	local no_wait=false
 	local hdr_digest=false
 	local data_digest=false
+	local tls=false
 	local port
 	local i
 	local -a ARGS
@@ -340,6 +341,10 @@ _nvme_connect_subsys() {
 				data_digest=true
 				shift 1
 				;;
+			--tls)
+				tls=true
+				shift 1
+				;;
 			*)
 				echo "WARNING: unknown argument: $1"
 				shift
@@ -397,6 +402,9 @@ _nvme_connect_subsys() {
 	if [[ ${data_digest} = true ]]; then
 		ARGS+=(--data-digest)
 	fi
+	if [[ ${tls} = true ]]; then
+		ARGS+=(--tls)
+	fi
 	ARGS+=(-o json)
 	connect=$(nvme connect "${ARGS[@]}" 2> /dev/null)
 
-- 
2.49.0

