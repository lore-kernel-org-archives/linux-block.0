Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0FF2F872
	for <linux-block@vger.kernel.org>; Thu, 25 Dec 2025 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766664573; cv=none; b=Hlewh/pZHaFWoNZg8FuLoJUWDpX29gUq77VIaNfKJyxN7X76viFEA93DKvUTQ2JpDYNLMEhFxy55k7QkVfPUZysu22V7C5IuGYzuCc0J2Agn+ZOMjtFotop8HeYNOUJ9esc6BIgUrra8Z8kFo/luZB4H6n+IEZ03PZEIz0Gxddk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766664573; c=relaxed/simple;
	bh=aJUiKN2sKT9VZdOay/C75W9xspOjRMkPALTTdgS+rG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhC3i1qanjKgPYz7WnDZB5C5G4mLDdcwiwudHyOtY/RYyvmjlCkyyR7BEgUxmdlKSI1oK9xUk9qhjdrtyd/cYwrI1ot/NXymP5rdPuETMMR3+nhDtfS97xow/N+C1kTLoIaa8akJykc9F28T0VSZnTc5aDGIjYTIegME9MLzw/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LElXaoaj; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LElXaoaj"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1766664572; x=1798200572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aJUiKN2sKT9VZdOay/C75W9xspOjRMkPALTTdgS+rG0=;
  b=LElXaoajQE0s69e2uA73ZF1LK97wRDuuscEmwhUPFxBRETqZrusIX2ic
   r3qwycnZ7Ypu9sztp/+cAr/PLPD5VaXNOAWBcjE8qVucCBliRqkpsI1Mq
   xDCjPgZ5smORUVRrZUxzrKbcGlVCnZqOvKEYwN1ISS0tKC37iIQWIduXh
   tKkXQK66pyPWNWBOkVsy8S+vrn9xN7FW5EnNE+Z3fOJuXNnRvUv7Iffkj
   sE/Bzz8+hVYEEUYHQcwwYxkdPQe4IwDgzyZ1/YzpASwR4VlFRKTHHvlVi
   L9VvAXOHxJNAbMCsctPRKKyK3XWyst3jbHwPK7z0xAm630cUvN5T8raYB
   Q==;
X-CSE-ConnectionGUID: /bv/aj3+RAiwZ9dhfBUvDg==
X-CSE-MsgGUID: xky7SRPCTP6ivHyVjh2q8Q==
X-IronPort-AV: E=Sophos;i="6.21,176,1763395200"; 
   d="scan'208";a="138971440"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Dec 2025 20:09:28 +0800
IronPort-SDR: 694d2978_HaCB06hAXaxWxz39ZCToMO/OFCJU4KGGT47gw6Yupfay4Ie
 XPL+nrXCkruawUwQPdKER3OncRukWrJeSaM1xWw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Dec 2025 04:09:28 -0800
WDCIronportException: Internal
Received: from 5cg217421y.ad.shared (HELO shinmob.wdc.com) ([10.224.105.42])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Dec 2025 04:09:27 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: mcgrof@kernel.org,
	sw.prabhu6@gmail.com,
	bvanassche@acm.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v5 3/4] check: reimplement _unload_modules() with _patient_rmmod()
Date: Thu, 25 Dec 2025 21:09:18 +0900
Message-ID: <20251225120919.1575005-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251225120919.1575005-1-shinichiro.kawasaki@wdc.com>
References: <20251225120919.1575005-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous patches dropped most of the calls to the helper function
_unload_module(). The last left caller is _unload_modules(). Reimplement
it to call _patient_rmmod() instead. Then remove _unload_module().

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/check b/check
index 6a156b3..cd247a0 100755
--- a/check
+++ b/check
@@ -581,25 +581,14 @@ _patient_rmmod()
 	return $mod_ret
 }
 
-# Arguments: module to unload ($1) and retry count ($2).
-_unload_module() {
-	local i m=$1 rc=${2:-1} reason
-
-	[ ! -e "/sys/module/$m" ] && return 0
-	for ((i=rc;i>0;i--)); do
-		reason=$(modprobe -r "$m" 2>&1)
-		[ ! -e "/sys/module/$m" ] && return 0
-		sleep .1
-	done
-	echo "${reason}" >&2
-	return 1
-}
-
 _unload_modules() {
-	local i
+	local i reason
 
 	for ((i=${#MODULES_TO_UNLOAD[@]}; i > 0; i--)); do
-		_unload_module "${MODULES_TO_UNLOAD[i-1]}" 10
+		if ! reason=$(_patient_rmmod "${MODULES_TO_UNLOAD[i-1]}" \
+					     2>&1); then
+			echo "${reason}" >&2
+		fi
 	done
 
 	unset MODULES_TO_UNLOAD
-- 
2.52.0

