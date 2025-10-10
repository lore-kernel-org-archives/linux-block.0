Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E9422F16E;
	Fri, 10 Oct 2025 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760063303; cv=none; b=fY6XFwO2b3ykHdJMoNdy2yzbsKaugKk2gc4SMjyraX1wpHF1weWh+OhKipRoBHUmP6Qp18MD1mny6jFXGI3OQdNoEGN1BgZbepJjJF8iie/xMyff97A3VnvA8fjf9hrSPN2ZNglOVucvw7EkDHaSV1b9tgVoClyQ95Hfzn+mKXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760063303; c=relaxed/simple;
	bh=LMSQiR7cO+DiIh19yzFcgQbHO5h0AHO8veD+ASqXLoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYBy1EujRo0ToREdvAPPvC0ZEF762KkTAOjS2VdecE6k0ZLFnyX13BkEKJVdiyBBVqOBdAr8Qe4VTavL/BJmmJVmbMsObJb0GaDyfA8OZ5GqC1AD2YbGxJodNsACiDFRD1gvUod2TZ8++HwOkCSiB5Ws9HkqMoDnje1ZdM/sdMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFIQ6Vp7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFIQ6Vp7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E7FC4CEE7;
	Fri, 10 Oct 2025 02:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760063303;
	bh=LMSQiR7cO+DiIh19yzFcgQbHO5h0AHO8veD+ASqXLoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oFIQ6Vp7+XFz2ytP5BVrOISQqm/zQl5woURl81iYlt/gNlPMXIwlgLVwWorOqQ6Z5
	 jiXmESqvSuMZJTYlq0bFsns+qEkUty7PV8CpeZI+h1ZZtIctnTXqnYjuUw/O14lZMv
	 oB2h+9j4IQZ0SDFdPCxkxn9nBDUIVT3jCbra98Vifqgj7Igw4pfO/T+TzGzoTPmjKI
	 hurdQ05sJXcGHgWSx9WkM4p8Jm/IezIE7x4nVPJP8jWURDqOBshay9Petztj50QMoA
	 4XzQaqgTpdSTX8s2a/vDaxNL/TJKyDQ7prFno8EdSOICL92gqhAaxPfsGNLt2mQWHM
	 keSTuCw5bTxkw==
From: Yu Kuai <yukuai@kernel.org>
To: axboe@kernel.dk,
	bvanassche@acm.org,
	nilay@linux.ibm.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v3 1/7] block: convert nr_requests to unsigned int
Date: Fri, 10 Oct 2025 10:28:03 +0800
Message-ID: <20251010022812.2985286-2-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010022812.2985286-1-yukuai@kernel.org>
References: <20251010022812.2985286-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

This value represents the number of requests for elevator tags, or drivers
tags if elevator is none. The max value for elevator tags is 2048, and
in drivers at most 16 bits is used for tag.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 066e5309bd45..02c006fb94c5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -541,7 +541,7 @@ struct request_queue {
 	/*
 	 * queue settings
 	 */
-	unsigned long		nr_requests;	/* Max # of requests */
+	unsigned int		nr_requests;	/* Max # of requests */
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct blk_crypto_profile *crypto_profile;
-- 
2.51.0

