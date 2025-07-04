Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12E82FC00C;
	Fri,  4 Jul 2025 07:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615718; cv=none; b=DnbiO0Qekwib/l27fygs8KM+lPBNs2/YHwEvJa6wTNmibjZ3/vt5NMfLSnKDLbn1EMW8xCf7daoRNx62ijIqBgRxGJSGhdWjUeiU0wNTOWgt/NJosy3OLFYo9eTi7M24CN6RCFv0wf/EB1SO7tzrHxWRvXKf35S/oGczFEjBlIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615718; c=relaxed/simple;
	bh=BB3rhAsySMZ6PI5adPReuYJsqbTYSmLkgXXONyBiWNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hmVSk+lOnKxeWbB2whf8EYa4L0Okc6L78nq3RwnjT9lZGszukhXzEeGOtb6fDX9kOBZn+hHxqaHBwibwtgjjoIIhXZtJqyDzIbc3033py5oabb+1pJsjvmUChFDGVjbxuM2mdzrtFkd2cQjZMebaVu+5WEiuDzxchZnr9lZzBfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bx3uzdZK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bx3uzdZK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615717; x=1783151717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BB3rhAsySMZ6PI5adPReuYJsqbTYSmLkgXXONyBiWNQ=;
  b=Bx3uzdZKL1qSdVIXvUCcDbfiwZ4LTFacw8Z43uGNX1DGa/XS1qtCV/6u
   V4n/qkEKV4ttWH7o84s+wtp3yUSBPOtfs6dpqhZDRKtJ21G8rdP4E/o6h
   qeT3ZMnls9Ur0z/kjTdRoDijnhf1NtHljVwhtY7trrrUaPBCYGQZ98e+l
   cJLVYg4zaYTaBuReDkQLJqDfOsRtgBTeJ7JOXRREaRAz6e1bk/T6gXnyk
   glZ6yEX6ecBIW3iGgPm7rKZedaqQNd+Vg+0OjVerljpWpm13ttviS1JDB
   X6gONKaH5NuZdYIK/5XZm0lU5OWzrFre6v2Rtx1SuSTNXe8fsj6rGzLXS
   A==;
X-CSE-ConnectionGUID: X/ljuuA1TvGv4h2RFwld4Q==
X-CSE-MsgGUID: khq9JthbTY2eSyiCVshPog==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64194371"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="64194371"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:55:05 -0700
X-CSE-ConnectionGUID: k4jNQM5LRgW24dmJhqpysg==
X-CSE-MsgGUID: 4+8QGBjSTfKjJk3ao15Olg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158616721"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:55:03 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id C686E44419;
	Fri,  4 Jul 2025 10:55:01 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 77/80] block: pm: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:55:01 +0300
Message-Id: <20250704075501.3223068-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
The cover letter of the set can be found here
<URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.

In brief, this patch depends on PM runtime patches adding marking the last
busy timestamp in autosuspend related functions. The patches are here, on
rc2:

        git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
                pm-runtime-6.17-rc1

 block/blk-pm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-pm.c b/block/blk-pm.c
index 8d3e052f91da..d6eab3193a20 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -181,7 +181,6 @@ void blk_post_runtime_resume(struct request_queue *q)
 	spin_lock_irq(&q->queue_lock);
 	old_status = q->rpm_status;
 	q->rpm_status = RPM_ACTIVE;
-	pm_runtime_mark_last_busy(q->dev);
 	pm_request_autosuspend(q->dev);
 	spin_unlock_irq(&q->queue_lock);
 
-- 
2.39.5

