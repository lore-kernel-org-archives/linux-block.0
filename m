Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8123D10A26
	for <linux-block@vger.kernel.org>; Sat,  4 May 2024 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714810503; cv=none; b=n3/6I3a+ZBwELGIDayPOhMt7C0J1nMIph527ZmOy2BlLVkdBShJIV+SnPopIYuZrUJe2kw5huxGm+Gvn22hTTCnMQwV9tu6MW1OVQGvHVOEdq1vNmQIeYEJzY7qd/73WFQ0Qegl3MXK5IzpZrMlFgnF3ki04mGlm5920A8+hGlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714810503; c=relaxed/simple;
	bh=G793cZjy30aPyEIQAxowL1pADYTgaWu/BBcCwUB0WJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwMu6uH6GsORXYzEkcZjz8b/caukjZsCVAKc0L1PyppFL/J3EwUP7bXpdGsibxwod5PSFQJRLO/dMUVgTmRSOrXWkqjRkYx70Ro6koumVENzPL0vcdbVU3OaM8sbls4hM9GGvOD3eUEM/j4C3Pz5cjj7L83tQxNHGAqKMWVy4ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e+HxsF0U; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e+HxsF0U"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810502; x=1746346502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G793cZjy30aPyEIQAxowL1pADYTgaWu/BBcCwUB0WJM=;
  b=e+HxsF0UXHzaW/NeXjxjicfA89ETWbfG2Snvte6O6UzYMz8PFjLms7CY
   qvwRxkIZdJHbQTs/dWuKTmoxotO3yep9Zphy/bDLvhA/MdtWOWCg1VKQX
   lBmid6V0+EMrBChlE+BxsPr2c2NAi88vLdicBkFsbbcvPBm1xsLK+j/eJ
   yiW5mjAqEuXhrY8F+Cx9NSeJdCrSo6BnVKZ5iFFkSEpqTmD9E0LNX5ZDv
   YebdXHVpGKDLn7ZAqNNnNZM4fua1a348iP0jswRXep+zb8PcXgbgW0v4P
   pWqrjUNM5DsKBtddVV1yobygjDDr0EmeMIyEJvyHr8ZqRqco9sCJ9nvHC
   g==;
X-CSE-ConnectionGUID: Do0WTMLlStOPhOO1/JGnDg==
X-CSE-MsgGUID: gVbwaIzIQ6y6Ya0zbklNsQ==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540312"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:14:58 +0800
IronPort-SDR: c9fiiWfgNWJ41pvMQkirPq0nTVbJeFrcd3oax4iov2UJkFcE5ej3+BkLRgE09qf9ViJarX29vZ
 WUwIA3/GXIwd7U5dMFA3VOD48VwXhCG6MFvSGLnT9n2Ru8WkrFLI2+YrhOF5YfETKFmDuXkZ2W
 DGdc5Z6KuzCKHfAAVrhFWzxa5AKo47M/OtqKJf8aAGSuPyaVuRg9HRbKpeAfcaW7caRDOOU6uu
 7J1XlIv7Dj1SIIfcBy8fWjRPmtcPmpHZCX2Pc01R1ED9xxzjBLe8eolHJrQ4PaZZ8C5w1NdsFw
 HzE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:22:56 -0700
IronPort-SDR: P7GfbLtTu24m7gpnxSapn/L5po3BYbCYSeE/0Q5th/LckOpYOa66mmwL5kmQpgDyiAKhZ6g1+M
 nxFAOTB5Ei4sWWOYRNuYT4Tf8VfCHgGvdm+cyTypf03jenrARpu7qjLYNn58oZchjeEiO+Ra3+
 BvcvUzE1Di8jWCMfGLh40zSwUmwF/0iDWuvKqmeNgXNxk2pOrxv5Ga3O2v2jw+ieNYObcNW3Ff
 hA8ZFXU8tXVWregtVOPfqafUdbBa8fEJ5m4c9f/17vy7XmGViXC6uQOQqOindnzil9HDdjGo8W
 BnE=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:14:58 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 07/17] common/rc: introduce _check_conflict_and_set_default()
Date: Sat,  4 May 2024 17:14:38 +0900
Message-ID: <20240504081448.1107562-8-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
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

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/common/rc b/common/rc
index fa61cc6..6a9a26c 100644
--- a/common/rc
+++ b/common/rc
@@ -515,3 +515,30 @@ _set_combined_conditions()
 	done
 	COND_DESC="$_cond_desc"
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

