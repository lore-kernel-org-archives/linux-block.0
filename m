Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A8171B4
	for <linux-block@vger.kernel.org>; Thu,  8 Feb 2024 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384725; cv=none; b=SILlF5xE+o1XJ0a4w/cm2YKLLzRbjoE+Vkzvu8yKfXE0QLWkBDqjWT04Xk4k8cXpDvKHdenw0fJicdmCNQqbbbzoMLyCNI74jfnriZoZLXx12Emqfzp0IL+GxQA8JDqGZOFaHzeCfoVBpe2YDQ+SSqJcNKZv3A258UnE1wV6h/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384725; c=relaxed/simple;
	bh=krq/hS9/1j9KLRxH0FYt963iK2ab66gutwWA8nIZph0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y6/0mmvFYqPiOWfMHLzjiNRJiWCpthz6q2Gbt9OxyCMYTqkYk7s7Oszh1TlVrQn7+1yS5aKqgN+40aOSAhCGSn4kyNyMKrzIeJ5Z3dnXOkXTf1/qAfK+ne2RjROwrprWlhUT4/Xcx+e2sDkcVoI5Fo+Pdy3lKhcOwHGNz1DY5Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4189VjUp048928;
	Thu, 8 Feb 2024 17:31:45 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TVsF36KYhz2K4gjP;
	Thu,  8 Feb 2024 17:31:35 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 8 Feb 2024 17:31:43 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
        Ingo
 Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent
 Guittot <vincent.guittot@linaro.org>,
        Yu Zhao <yuzhao@google.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH 1/3] sched: fix compiling error on kernel/sched/sched.h
Date: Thu, 8 Feb 2024 17:31:34 +0800
Message-ID: <20240208093136.178797-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 4189VjUp048928

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Below compiling error reported. fix it.

block/../kernel/sched/sched.h: In function ‘update_current_exec_runtime’:
block/../kernel/sched/sched.h:3287:2: error: implicit declaration of function ‘account_group_exec_runtime’; did you mean ‘sched_group_rt_runtime’? [-Werror=implicit-function-declaration]
  account_group_exec_runtime(curr, delta_exec);

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 kernel/sched/sched.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 04846272409c..b0cffc9c0f0d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -20,6 +20,7 @@
 #include <linux/sched/task_flags.h>
 #include <linux/sched/task.h>
 #include <linux/sched/topology.h>
+#include <linux/sched/cputime.h>
 
 #include <linux/atomic.h>
 #include <linux/bitmap.h>
-- 
2.25.1

