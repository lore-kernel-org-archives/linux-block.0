Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F15158D7E
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945609; cv=none; b=YPuXL3gHvFZIxw2hDtaMMt2uLQYYbM2LVAp7F73qkLgqBbFOiMbhEEV9uujPClwqi1pjwa1yT5Mw2N2gUZspdc/gWYS7hWmtlbVMhERsR8mEU3eybqyD+DhqgtoW3tlBdkxsTm3EfT47x6eG1g3/VqJzEuqNT/1V5XKv+zCohwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945609; c=relaxed/simple;
	bh=yHpLX1JLyja72v9Ay7upFM5xSkaMZAaYoylx1iwvVZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wgv8YYTYMTk+2A5DMRwnBvbSfKatBjATUzFGZBY4MMaAM2c/f7SDeXSEOy0BshDn6BMWNII8oLgMmp2A4yFJ7Fz/HIT5fvogarfZraO53rzLkxlcKufO/m0doRhIHL9IB7gPpVZ1E5AUOgirJapEzmQ73XJI0332CwIshkBNiKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=G86KzTZ/; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G86KzTZ/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945607; x=1745481607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yHpLX1JLyja72v9Ay7upFM5xSkaMZAaYoylx1iwvVZI=;
  b=G86KzTZ/RUEGH0WV5BLsRtowZzZWrvanOSs6qDbEZ4uIubcPR66KlKfF
   7B8E6UUPoQ0JscHXIoXZX2Pdh7N+65MKG2z7ahlwb9eNHEDDz6LVjgaTa
   GYul84HVh20ErRv3LmLb0NbjB2ujSo1dzoU7rhdB0nLoDx4RxLUvJOdMK
   LtiSdgur705s4nth9cfOu4a7X5GjDhQFjsk5D+va/FQBFCZ/MzGI9ix2m
   VOPSq3GtKpBU5GPOWwykYtEhVC9LxzSmvbDXFhxlynP91FcGW+018If86
   W1LJvjk5+pa/IWiefNVgRaCQtzjc8Y27OabK0Qqdi1fD+WFdpsD3L1DYL
   g==;
X-CSE-ConnectionGUID: DSMaZdAGSSmS8/fpf7yMOQ==
X-CSE-MsgGUID: PcOW90XSTX2IeZFsioVsdQ==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14515685"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:02 +0800
IronPort-SDR: RxPJWP7QlONYxujlJfCIlLhp163T7N5fFIouK3bdEyW2g2XnBKZJQ4+H93msPGVyd+9MTbsv4K
 R1WPtIZDZsCB7/xanzu5DO+gQz92DWzA3Tk7PW0IvQkXpI3aHNzBSu+DChjhXTRcutmz4Pmo22
 wbWsz3+qOKLaCMDWNOzI5x6IYdEmW+Hp9fWt8UnlNhxahIlkL0uNpg3OkDUG52WCJ9oAQXE21f
 oi5qwXyizgoXvl/dpDFeXO/rE/zL1clG8FruHAuOtzYuKoxXC+LrB3RvPJJs55kWsO0wXRoq0+
 ap0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:12 -0700
IronPort-SDR: YaJvLZZoTODNj7TXjVY2iiIDjM4IZettOgbKTI+aAfCtUcqs2qNw9++Tj9qq5AgC4crPWUb5x3
 /OAn7u11b7sCgVuawFR0Lw/0wupxvCQB+8eks9CUlYNXWqlbYI4yLzyBObTQmqxLm0kgVcCORV
 MAQlSvSw8ufSvp00CRwmd5vGsVWdmL+ObuEpIMa03+vH991SH2lwSpy0LPyK54nt0O5RC67Ypb
 YS4fGl8onh5a2UmAq9UHC55YtiTJlmSnoJgCWgluwfPM/ihNoMMXOkjY7ZEXZgaVX7MxDg9bPX
 MB4=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:01 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 05/15] common/rc: introduce _check_conflict_and_set_default()
Date: Wed, 24 Apr 2024 16:59:45 +0900
Message-ID: <20240424075955.3604997-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following commits are going to rename some config option parameters from
lowercase letters to uppercase. The old lowercase options will be
deprecated but still be kept usable to not cause confusions. When these
changes are made, it will be required to check that both new and old
parameters are not set at once and ensure they do not have two different
values.

To simplify the code to check the two parameters, introduce the helper
_check_conflict_and_set_default(). If the both two parameters are
set, it errors out. If the old option is set, it propagates the old
option value to the new option. Also, when neither of them is set, it
sets the default value to the new option.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/common/rc b/common/rc
index c3680f5..9ff31cf 100644
--- a/common/rc
+++ b/common/rc
@@ -470,3 +470,30 @@ convert_to_mb()
 		echo "$((res * 1024))"
 	fi
 }
+
+# Check both old and new parameters are not configured. If the old parameter is
+# set, propagate to the new parameter. If neither is set, set the default value
+# to the new parameter.
+_check_conflict_and_set_default()
+{
+	local new_name="$1"
+	local old_name="$2"
+	local default_val="$3"
+	local new_name_checked="$new_name"_checked
+
+	if [[ -n ${!new_name_checked} ]]; then
+		return
+	fi
+
+	if [[ -n ${!old_name} ]]; then
+		if [[ -n ${!new_name} ]]; then
+			echo "Both ${old_name} and ${new_name} are specified"
+			exit 1
+		fi
+		eval "${new_name}=\"${!old_name}\""
+	elif [[ -z ${!new_name} ]]; then
+		eval "${new_name}=\"${default_val}\""
+	fi
+
+	eval "${new_name_checked}=true"
+}
-- 
2.44.0

