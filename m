Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD973A5E64
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671438; cv=none; b=cVJFxwoQWLcXwJFlykuVNJfkiuV12ikWF2Vc/lArLaR6hMteu5rorn6YKQwlNPeJ19bocsSbuggtLlqc+MPlfLZfVrZFwqtRvjUrlwd/xiJtzLtXp+PKBx8Vers+rOvjcy2ljIlH1jJCJs8mDCH39HgUl1YGsQMnqgHFjzOMrHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671438; c=relaxed/simple;
	bh=MvF3M6B4bgSEwdbZRi+/u+Jgq9n0e8gkZV1gAxVfGFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqukiKZjggQFQXbdNbNgfsKniRukJNJP2loAbD/fanJEnTOklT9NBo0obaCa2ky3GejbUnQAHKjag2i7YTkwpD6eEjrV3z2xEvBbuh8yC81fHcV1RwGF+OUsWtPq5fld7XsVtuhzNa9Ygfms6XphUPO0Zujtm4WVa1KVk9h2puA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qLKkXe7y; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qLKkXe7y"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1778671437; x=1810207437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MvF3M6B4bgSEwdbZRi+/u+Jgq9n0e8gkZV1gAxVfGFE=;
  b=qLKkXe7yonlk4yMf98Cm3Zwk7UFnYcwt+9iYBQI7nfwu8eY+6OhTMwfR
   BuasTqnxcRBSvWGFazy9g2MGViSUJ4S4JUjAs0VwSeQbMYotBcjfCh00L
   iWKPqwrPRqyEQZWgfZhKdkOnIM+7TLEnvf5sbXAczi2Igu/BvQNeMvT79
   wrVe5/3zLwzNYu5UYaKOqC8Qr641G9KtiCfsUh/ZDrTd98vwMfabFc3UC
   VpYHf7RzzFSd84nQO7SiEGJqRhOKdPVWcPSMnIX337UC7Sv4mel8PxanO
   zj3vpeECX8C/+YO0Ee0xw3b9qlSG7tnpXUO5ULRUbRWV891iRRu041tjO
   w==;
X-CSE-ConnectionGUID: O7Z8g9MtRKOtMpiRDh8ojw==
X-CSE-MsgGUID: hDlWj5ivRHSav+zKnffKZg==
X-IronPort-AV: E=Sophos;i="6.23,232,1770566400"; 
   d="scan'208";a="145918711"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2026 19:23:55 +0800
X-CSE-ConnectionGUID: 1KfwNTWjSmunBSqc7kFIqg==
X-CSE-MsgGUID: Oopn3ZJfQt6C06SlW3UHWw==
IronPort-SDR: 6a045f33_NhY3x24x3hhuhyfEpfhgD8Nizt9dUpwqrEURs7VCH/dwHU2
 GKPmw6+J8BbdfPrVHwxeLiLzcbRy6AvaMhzuazg==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 May 2026 04:23:30 -0700
X-CSE-ConnectionGUID: sr31dchjQFOrl0h8f0sdeA==
X-CSE-MsgGUID: C5PZWmjnTq2ZQ3Cyy7/2WA==
WDCIronportException: Internal
Received: from wdap-o209afpuln.ad.shared (HELO shinmob.iptvf.jp) ([10.224.105.138])
  by uls-op-esai2-o.wdc.com with ESMTP; 13 May 2026 04:23:30 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/3] common/rc: add _echo() function to trace sysfs attribute writes
Date: Wed, 13 May 2026 20:23:25 +0900
Message-ID: <20260513112326.584256-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513112326.584256-1-shinichiro.kawasaki@wdc.com>
References: <20260513112326.584256-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many test cases write to sysfs attributes, and these writes are
important for understanding test behavior. However, bash's xtrace
feature does not record the target file in commands like `echo X > Y`;
it only records `echo X`.

To capture the write target, introduce `_echo()`, which writes its first
argument to the file specified by its second argument. This allows
xtrace to record the complete operation (e.g., `_echo X Y` instead of
just `echo X`).

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/rc b/common/rc
index d2c1d74..0941678 100644
--- a/common/rc
+++ b/common/rc
@@ -780,3 +780,9 @@ _min() {
 	done
 	echo "$ret"
 }
+
+# Echo a value to a file. This wrapper is used to trace sysfs attribute writes
+# when the --cmd-trace option is enabled.
+_echo() {
+	echo "$1" > "$2"
+}
-- 
2.54.0

