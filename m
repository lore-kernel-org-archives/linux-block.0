Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9CD31AA93
	for <linux-block@vger.kernel.org>; Thu, 25 Dec 2025 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766664573; cv=none; b=jTEHHPQ3pQHqwEg99KJMu+zFhjY8xXCjTDPgbcYC6O45riJAo/6pUUohbXem9/W9YPOFjgVqR5GcN3qCjAq4cggyq4an026feEX+iBQ6r1TonOqhcrMDy7e9fcPk0PFQus2KJOc/XnN/oKBPEBfdCeJAs7bqM4efHb3u0JloPBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766664573; c=relaxed/simple;
	bh=DQ4PaB6minKlvrTeTWzBZ/zP4Ap08uHF4f9TR3b4L1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+TBWej01LE94Rabi6stjVf/pS7ViKD5VuTiyo7Ej7h8HLkhSBz3Dus+AC+nYFOc9ZEzg2lQMSVnzJFpG7/VMgkhXf69YSUwL5a6wmyadibT2irMhu/ssB/8UDCNi0pcAS8/GeUOOYmmMxo99gPYlwNF4qzkupiKGmRKR/1gr2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qrxCjpwh; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qrxCjpwh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1766664572; x=1798200572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DQ4PaB6minKlvrTeTWzBZ/zP4Ap08uHF4f9TR3b4L1Q=;
  b=qrxCjpwhlCVikOcr6YYYyFGus0Aw5GfSbjhigorFnRnDOK67bEO+59pX
   cHsW3kftUuH4WrdDRbZ1DnbW8wwVNZJUwH+goC1jAUP88sb6+eW5Yp4y9
   hVfb1TrEvVei11s8YGV0Ug9XN1lliD89M82wTkoq88EuVTYEUEoGj7gU0
   UotMKsyPkC/lW6zgeROmvyOCQ0PuLhh/OnvfVyx+WwlpvmU5GxYosLupl
   wY3xWUvxCxu6fcfvVU8Swr04He9eg5FT9+nyLjY8twuv7xvEvlBQAAVn4
   3lrM8b2eI5nJEQxsX+cJ1P51tQuDLsHdP6R+l8F7zhvaCnUCw7tlyhy6h
   g==;
X-CSE-ConnectionGUID: Vm2i6CGNROO374kCjz9Wsw==
X-CSE-MsgGUID: ANdQXQOsRPu1E9PzdxHDvg==
X-IronPort-AV: E=Sophos;i="6.21,176,1763395200"; 
   d="scan'208";a="138971441"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Dec 2025 20:09:30 +0800
IronPort-SDR: 694d297a_XahCSpl9qOilxZIUiQL/W5AA1q2tx0ACeDaYpvsIuv/Zhbv
 6DRAlzJxHMOgFdLACFJiDXRGe58W/h3IFSnsZRA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Dec 2025 04:09:30 -0800
WDCIronportException: Internal
Received: from 5cg217421y.ad.shared (HELO shinmob.wdc.com) ([10.224.105.42])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Dec 2025 04:09:29 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: mcgrof@kernel.org,
	sw.prabhu6@gmail.com,
	bvanassche@acm.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v5 4/4] check: check reference count for modprobe --remove --wait success case
Date: Thu, 25 Dec 2025 21:09:19 +0900
Message-ID: <20251225120919.1575005-5-shinichiro.kawasaki@wdc.com>
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

The commit "check,common/*: replace module removal with patient module
removal" introduced the new helper function _patient_rmmod() which calls
modprobe command with --wait option to do patient module removal.
However, the modprobe command can return a zero exit status even when
the module removal fails. In such cases, the failure remains unreported
and hidden. This behavior was observed during the execution of blktests
srp test group using rdma_rxe driver on a kernel affected by the
rdma_rxe module unload failure bug, which was addressed by the recent
patch [1].

To address this problem, check the reference count of the target module
after calling the modprobe command in _patient_rmmod(). If the module's
reference count indicates a removal failure, print an error message to
stderr. While at it, change the print target stream from stdout to
stderr for other error messages in _patient_rmmod() to ensure the
messages are printed on failure.

[1] https://lore.kernel.org/linux-rdma/20251219140408.2300163-1-metze@samba.org/

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/check b/check
index cd247a0..b554cd0 100755
--- a/check
+++ b/check
@@ -530,7 +530,10 @@ _patient_rmmod()
 		modprobe --remove --wait="${timeout_ms}" "$module"
 		mod_ret=$?
 		if [[ $mod_ret -ne 0 ]]; then
-			echo "kmod patient module removal for $module timed out waiting for refcnt to become 0 using timeout of $max_tries_max returned $mod_ret"
+			echo "kmod patient module removal for $module timed out waiting for refcnt to become 0 using timeout of $max_tries_max returned $mod_ret" >&2
+		elif ! _patient_rmmod_check_refcnt "$module_sys"; then
+			echo "modprobe with --wait option succeeded but still $module has references" >&2
+			mod_ret=1
 		fi
 		return $mod_ret
 	fi
@@ -544,7 +547,7 @@ _patient_rmmod()
 	done
 
 	if [[ $refcnt_is_zero -ne 1 ]]; then
-		echo "custom patient module removal for $module timed out waiting for refcnt to become 0 using timeout of $max_tries_max"
+		echo "custom patient module removal for $module timed out waiting for refcnt to become 0 using timeout of $max_tries_max" 2>&1
 		return 1
 	fi
 
@@ -575,7 +578,7 @@ _patient_rmmod()
 	done
 
 	if [[ $mod_ret -ne 0 ]]; then
-		echo "custom patient module removal for $module timed out trying to remove using timeout of $max_tries_max last try returned $mod_ret"
+		echo "custom patient module removal for $module timed out trying to remove using timeout of $max_tries_max last try returned $mod_ret" 2>&1
 	fi
 
 	return $mod_ret
-- 
2.52.0

