Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F634572F
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468270; cv=none; b=OtflYIKXCaSzIb4BBncN6h3DZozt2Iy8hSW7ntj5zyzz9OoggH211ft4X0Nu4Vc7NUvY1GmA4+8zdXGPCsKjjkZ9IFX8fbdlJdqdCo2PN0MITVHxyvEt2MKICOL1LVE4t2lr29NiFKT8shwx/1qr67RMiZqp7hOHkoqKRGZRq9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468270; c=relaxed/simple;
	bh=Wb5xGoZ1T2F3DF8GEa9yyPEBNP3REChrTE8oQ+6c+uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u23yp2SxGuSVHlAwJey4FEG9cm83B0ORRu2drf4TeNkJTnTkZAD9cTJhw2z3PLlDvLisxJd5Q5VH0gnZDlj5M2egI8W7bIsFd2OHOHvAtitaIdzqr09fxInwwluRxsWwaf26wzm3+9PRAllgh1yKXVlEVXg0i3QQjOzjAS5Fwc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Et/GJrLu; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Et/GJrLu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768468269; x=1800004269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wb5xGoZ1T2F3DF8GEa9yyPEBNP3REChrTE8oQ+6c+uE=;
  b=Et/GJrLuOxhaf6gviT8+6CO7nnCv++uFslQqDkaOlucgST+bszkmEO1S
   ubiCZMMKjIBKx1hG17G2c60rqcCXHUmYqFaqWyP5xCGrKfDM8sF404XJe
   s91soObKNeIhWsEU/wIyR86yfv3eqsPCozrsL1gkRdTpaXHMsDTT8RYrH
   ka5NnR7tY5q88U8ioVjQKQ8uoiDmc8TdPaOemOGIodDOCN7OtnwWiEXKx
   ZLdHpW3pjxkeBFMQ56urdkn9qdTIaI+dPC5hzMSNe9/jLb+YXOe/a7kYX
   IfYiWav7RLKNeFMwmwz1i3jCDrbm4JjxdmIxuu+cIyh2djjjzjZ/+LA+Q
   g==;
X-CSE-ConnectionGUID: ICv941AzQVusUbUZX97+vw==
X-CSE-MsgGUID: MCTmB3E7SPCPd4Ak8Jak7A==
X-IronPort-AV: E=Sophos;i="6.21,226,1763395200"; 
   d="scan'208";a="138836187"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2026 17:11:08 +0800
IronPort-SDR: 6968af2d_UBEgJ8iNSv6+hL83jEoFRbQi3xA7x+mAXN4Fl10LzOFaIDi
 oQuMMqXsARNlLd28Sya6cJJUzeyWgV51zq7AMkw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jan 2026 01:11:09 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Jan 2026 01:11:08 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: mcgrof@kernel.org,
	sw.prabhu6@gmail.com,
	bvanassche@acm.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v7 3/3] check: check reference count for modprobe --remove --wait success case
Date: Thu, 15 Jan 2026 18:11:01 +0900
Message-ID: <20260115091101.70464-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115091101.70464-1-shinichiro.kawasaki@wdc.com>
References: <20260115091101.70464-1-shinichiro.kawasaki@wdc.com>
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
index a8b7611..43a22e8 100755
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

