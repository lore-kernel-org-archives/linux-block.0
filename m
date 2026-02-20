Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230073451B2
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771593843; cv=none; b=swE4R0cIZj/+BsH6KmpEfp1+DwRhbTA7+5ezOHydrY5tpBJa4udJYVNKrzF6jNAF2UlWON9xjAvcp+4vU2xmgeA0s7VKv0Nekr/zHDKn3lcYzQbq2752W5exFTbtIHqmvz4SMHjgaOTOjhYI87wrL2zGS1eQX3/c7xymbgLb81w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771593843; c=relaxed/simple;
	bh=gr3qQNhHBsd/JeVh68bkT3kVZVx3jEyONfak5DgdsUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThU86qsMdS4xWywfUyaO7L7vBWEEwLRcwpd4ypA87KnwbmFuPmFKGeEp+nzmJI3cVAM5dq9Df3BZJrdndYoyz/BFczmloONpF2nxsX5Klt7v+LflPr+Ox3TG1U7IJi0jbvFBxrD+a/o8K9oDO8YObqgeddjKwjc6nohl62Tbc60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KGcK3G13; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KGcK3G13"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771593841; x=1803129841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gr3qQNhHBsd/JeVh68bkT3kVZVx3jEyONfak5DgdsUc=;
  b=KGcK3G13Y8iIyjCao57UcyjgS1q1qLnODxoQJsKM1cwu7CNV/iTPCWeS
   RjWVsgYZXg0F2ffNlXKn0EGdCHAgVHTMOmq1JzDzD0nw1rheKCd4X2uIa
   LFmSkfeUC9KIRE+dFbXEqVCHm4f/psX9NJXjEJnVLwvjdXKrNUFoyye1i
   oOVAqTOVoWVUW8scxyckhOmcTtV/HpZRjkBTN+YKn0T3PUp+AzhTz60VW
   j6gkjt3VtIZutnTDlNaF/fmBQ6j7WO8dur/SAZA1NnnMn4eBfWqclOZGC
   FKpqjqqOZ4oWvN5hQsO835DuuR5Ahk3dMiplJ9cgCoeb6+Nm5rr/CHp32
   w==;
X-CSE-ConnectionGUID: hFjzwNfxTmiZbAlBpktKDg==
X-CSE-MsgGUID: Eq2HaFGQTQ2tWao9EDHzLA==
X-IronPort-AV: E=Sophos;i="6.21,302,1763395200"; 
   d="scan'208";a="141089915"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2026 21:23:56 +0800
IronPort-SDR: 6998606c_crq9l2S8rD6wXxZGRGl29cnowdDZUUHms/fHscgTw2ZuZmi
 7e9BrFdN20wY4eAdsY4GOh8LYOAy8OhyIk04AlA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Feb 2026 05:23:56 -0800
WDCIronportException: Internal
Received: from wdap-y8axpm7exs.ad.shared (HELO shinmob.wdc.com) ([10.224.99.2])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Feb 2026 05:23:56 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 2/2] zbd/002: do not check write pointers of conventional zones
Date: Fri, 20 Feb 2026 22:23:51 +0900
Message-ID: <20260220132351.273758-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220132351.273758-1-shinichiro.kawasaki@wdc.com>
References: <20260220132351.273758-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the recent change in util-linux [1], the 'blkzone report' command
no longer reports numeric values for write pointers when the write
pointers are invalid. Instead, now it reports the sting 'N/A'. The test
case zbd/002 assumed that 'blkzone report' command would return valid
write pointer values for conventional zones. The test case worked before
the blkzone change, but now the test fails because of the wrong
assumption.

To avoid the failure, do not check write pointer values when the zone
type is conventional.

Link: [1] https://github.com/util-linux/util-linux/commit/b032247f48d8b6a13bf8541eb663c779e448f568
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/002 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/zbd/002 b/tests/zbd/002
index 39c2ad5..cd9609d 100755
--- a/tests/zbd/002
+++ b/tests/zbd/002
@@ -80,7 +80,8 @@ _check_blkzone_report() {
 		fi
 
 		# Check write pointer
-		if ((cond != ZONE_COND_READ_ONLY &&
+		if ((zone_type != ZONE_TYPE_CONVENTIONAL &&
+		     cond != ZONE_COND_READ_ONLY &&
 		     cond != ZONE_COND_FULL &&
 		     cond != ZONE_COND_OFFLINE &&
 		     (wptr < 0 || wptr > len) )); then
-- 
2.53.0

