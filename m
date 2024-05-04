Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF6610A0A
	for <linux-block@vger.kernel.org>; Sat,  4 May 2024 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714810503; cv=none; b=nfntMaGZXGoJS+00HCRUiz3gJK/mp843TRzBe+LT3KGmPRHmK8KHfcXE4EZcEgFBB2jYdyV2cW/q7y/zUEJOUxLYQgAPUCubcnqs54FIIojEHmKUlUXml+JFUkDzQs6Y050cjJ4YepDyKI13M7ghp7DKCtHG/vsLsoAH5/cPFXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714810503; c=relaxed/simple;
	bh=+K+jDy7e3gF1AgCoCIbrLB/6EUv1Sobcxjxoms8/AuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMH9vcvDrQJgRQp1GMUttRmBK0l1Y02n6jjXijAZxEghhaC+fzCmi38nq0Vx0DQg/eiWOCqXKSLIkSDyrpaYwdlxB6meVwA8kY0ntLm/++q70t5Lajt7HcIxbhB+BqwDGLz68S8sVRX0R5HDr1xLhm0160tqLodjmKEbIaWwTHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UyrZb12v; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UyrZb12v"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810501; x=1746346501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+K+jDy7e3gF1AgCoCIbrLB/6EUv1Sobcxjxoms8/AuA=;
  b=UyrZb12v1g1iOEc6sPY8k/QJYGJwWRNvxE1XJX5wAMpVihcUQNvdG6G3
   DN7niH6fhW8qvnr3TEZT6Dckz4nMoz0qD+8uQQZJDX++aCZdqJ8+ianWd
   Y46xlAHTIcF7mWTl5FsDbp/jSfUV3VrorihlsU7raxidQbl5W++Ey5Ake
   M+OAcVlvsPhhLHqzSobhd2IVfDZioC0HHhG86QYi0vpE9W9mPEPGQoAoG
   XZAz7s/SQQggu8fCIK1vOdFv7h1tgEd4l+NX4QFUso1lmhw//m7g5m0J+
   9xN/VWTaphXM8DupDIoIAdISUV/WL4JecJl+Gl0H2Hfjld2xTp1hlSnL7
   Q==;
X-CSE-ConnectionGUID: i9aDZioJSIud8eop/eGogA==
X-CSE-MsgGUID: 5ToEw/cMTbqVCzZS91SZUw==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540305"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:14:56 +0800
IronPort-SDR: oIrIXPEcMw71dONEQwYZvLUgg4TNQuLhzXHzlP3Zdu2SQqey3NThJL7ttegMY6q9Wf/TWaTWjZ
 A+5SCOJ6PmUWQNw9HnJkPLDwGbA6CYrUl8/H1KQuBL+7VnTJTiKSltGIk199vhVWr33z24T91z
 +Rg04z3wyGeBjSW9myy8/GqI35na8Ck4QkKt4mhNd+8KiBwtxbbfFA7Cnnao2R7MqgxGkpeKn4
 UmoHYWkc3e+JpLsi0GlBb00a+EGb923NSI/0/PlHW1v5uwcdTS9WnCuKTG1788J4gZDh9hJKGF
 Olk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:22:54 -0700
IronPort-SDR: kFkhNGbrLKQFZuFDITcNasFNoVHPWDonHevw2gVnSHOpEl4rxwW2c8WZMnAP/cZRsW6ik3SEIG
 a5E0zCEoxWCmLjRZD/e24ofIWt6ZCkoPxTmJubX3yQuHEm7tRJtVSviGLekURPg6bmOQptUrYv
 jNC8ghZZdePVBGpdp8pksXjFUm/ozUBNa6OsQs/T/OnAgCVo3Zph9qQZ2l2olDh/EGxy1zIDeq
 Dny6HOzR/byvJA6j6xjWckXXT3KbNkSZiZcQOHFfpCI/fO7sVzE8vgqXz+f6tnr88n2bPCJgkZ
 Bmc=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:14:55 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 05/17] common/rc: introduce _set_combined_conditions
Date: Sat,  4 May 2024 17:14:36 +0900
Message-ID: <20240504081448.1107562-6-shinichiro.kawasaki@wdc.com>
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

When the test case has the "set_conditions" hook, blktests repeats the
test case multiple times. This allows repeating the test changing one
condition parameter. However, it is often desired to run the test for
multiple condition parameters. For example, some test cases in the nvme
test group are required to run for different "transport types" as well
as different "backend block device types". In this case, it is required
to iterate over all combinations of the two condition parameters
"transport types" and "backend block device types".

To cover such iteration for the multiple condition parameters, introduce
the helper function _set_combined_conditions. It takes multiple
_set_conditions hooks as its arguments, combines them and works as the
set_conditions() hook. When the hook x iterates x1 and x2, and the other
hook y iterates y1 and y2, the function iterates (x1, y1), (x2, y1),
(x1, y2) and (x2, y2). In other words, it iterates over the Cartesian
product of the given condition sets.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/common/rc b/common/rc
index c3680f5..fa61cc6 100644
--- a/common/rc
+++ b/common/rc
@@ -470,3 +470,48 @@ convert_to_mb()
 		echo "$((res * 1024))"
 	fi
 }
+
+# Combine multiple _set_conditions() hooks to iterate all combinations of them.
+# When one hook x has conditions x1 and x2, and the other hook y has y1 and y2,
+# iterate (x1, y1), (x2, y1), (x1, y2) and (x2, y2). In other words, it iterates
+# the Cartesian product of the given condiition sets.
+_set_combined_conditions()
+{
+	local -i index
+	local -a hooks
+	local -a nr_conds
+	local total_nr_conds=1
+	local i nr_cond _cond_desc
+	local -a last_arg
+
+	last_arg=("${@: -1}")
+	if [[ ${last_arg[*]} =~ ^[0-9]+$ ]]; then
+		index=$((${last_arg[*]}))
+	fi
+	read -r -a hooks <<< "${@/$index}"
+
+	nr_hooks=${#hooks[@]}
+
+	# Check how many conditions each hook has. Multiply them all to get
+	# the total number of the combined conditions.
+	for ((i = 0; i < nr_hooks; i++)); do
+		nr_cond=$(eval "${hooks[i]}")
+		nr_conds+=("$nr_cond")
+		total_nr_conds=$((total_nr_conds * nr_cond))
+	done
+
+	if [[ -z $index ]]; then
+		echo $((total_nr_conds))
+		return
+	fi
+
+	# Calculate the index of the each hook and call them. Concatenate the
+	# COND_DESC of the all hooks return.
+	for ((i = 0; i < nr_hooks; i++)); do
+		eval "${hooks[i]}" $((index % nr_conds[i]))
+		index=$((index / nr_conds[i]))
+		[[ -n $_cond_desc ]] && _cond_desc="${_cond_desc} "
+		_cond_desc="${_cond_desc}${COND_DESC}"
+	done
+	COND_DESC="$_cond_desc"
+}
-- 
2.44.0

