Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE484235C1D
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577761; cv=none; b=HEnt20PRSj+adZuta1bANf1GKZcs3cIzYGITaQkTnHOj4P+V6q1qcvyUsZROS+/TiDvSoOXpfGg9xisBP40B+I6nCd39tVOBrX/XQ4MmKHv4XOiNNxOlEohDVUDyqpHGWYKXcfiwLJ7OuTg3JiBXbNuwiCHUHZ9TOGmR4UQHv3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577761; c=relaxed/simple;
	bh=NxBN7WHC+BPZl+big/3dpOEyGx/GAd3rlYitT6IXIRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMQvoGnfASlfmSphJMqvQ/GqUOU5styWsm5uCjH2zx0+CajaeEyfSYkTU8DJY+FkwN1q8hbNxJ5lMdFHr1ELM75ok4B9NnE42zohBFSNrZ3WR6OhbwE7kC0eFzg/4xYj548xLdvoEeAi0LEFmPDXh4c/Mx+B0agO3Vxarfd3/+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QCxRsNqD; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QCxRsNqD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577759; x=1775113759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NxBN7WHC+BPZl+big/3dpOEyGx/GAd3rlYitT6IXIRI=;
  b=QCxRsNqDtvmnrgGEYCNBQMPQjRfkzX540FiIL/yRrTH+z/8m9SLi9QzY
   AhbSHUbLTxGC36b9SPBH5o1hbVVU2Pzy9icq5nwSHBZ0O7KTJqSfb6/mn
   wl9SGsx6PHNr3DMsEjZqBVbNU8id+8heOUNq1ac+2bU3IEp9x4/sjbIIx
   UrNgQHDF3hzn/7fmdp7Zc5rpgdBp+ys+9TclqM2AE3NORAfZdnGZ7m1rY
   nZmFYfZNtPfQ+NOSK0IKdUy/UCt4RXY5FZNmZw6nrx+XHiljKpV3hGolN
   ohloF+Ouj3MLAUTzrImQdrYtp6jIvQgldgoHbv86FqSQZNvGK9bZG3mzc
   A==;
X-CSE-ConnectionGUID: BH8Q4FxzS26jHuf2C+fkPg==
X-CSE-MsgGUID: tpOi42W6RRygjF2KMYMCEQ==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="71367744"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:17 +0800
IronPort-SDR: 67ecd4a6_kdy0gFuBXWJFjT2MA68jSeSCqKkYMjbRuxMFXKvwb2RdjoX
 asEn5JpW/lBZ69fWe6f0DMXhGK6dn/sPv5aqYgw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:43 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:18 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 08/10] common/nvme: handle option '--concat' for _nvme_connect_subsys
Date: Wed,  2 Apr 2025 16:09:04 +0900
Message-ID: <20250402070906.393160-9-shinichiro.kawasaki@wdc.com>
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

To start secure concatenation the option '--concat' has to be passed
to the 'nvme connect' command.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/nvme b/common/nvme
index 47bcdc9..402db18 100644
--- a/common/nvme
+++ b/common/nvme
@@ -275,6 +275,7 @@ _nvme_connect_subsys() {
 	local hdr_digest=false
 	local data_digest=false
 	local tls=false
+	local concat=false
 	local port
 	local i
 	local -a ARGS
@@ -345,6 +346,10 @@ _nvme_connect_subsys() {
 				tls=true
 				shift 1
 				;;
+			--concat)
+				concat=true
+				shift 1
+				;;
 			*)
 				echo "WARNING: unknown argument: $1"
 				shift
@@ -405,6 +410,9 @@ _nvme_connect_subsys() {
 	if [[ ${tls} = true ]]; then
 		ARGS+=(--tls)
 	fi
+	if [[ ${concat} = true ]]; then
+		ARGS+=(--concat)
+	fi
 	ARGS+=(-o json)
 	connect=$(nvme connect "${ARGS[@]}" 2> /dev/null)
 
-- 
2.49.0

