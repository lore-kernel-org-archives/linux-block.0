Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEF52E62CC;
	Mon,  5 May 2025 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483757; cv=none; b=sCO2/W6WfvjFtHFHuxv8anXNQK6C34idySxbB+UBJ2B60ZSZHN/j1P+p2Bo/VJGMUceO/oCWTpfwZiYyaAbs2lKzrrsxaEB2qpuHG5QqNxD8EEVv+nGJGlNFo2cnWwEBbSluVkJfKcvjOnihJO27gBjpEWeCl1SIj78Pp13+ZMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483757; c=relaxed/simple;
	bh=JUqtbR/yscXAD1scuNnJkYoMVnOPkshvLf3LIPKm+Po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tt5u8SQ8eVb9//20+iuycmV+8sM9btfjYyAZTGHPk6mkR49Mf2iVHBmD3GQ2lF1TBS7ItNJ3GtfAP0pAq7Qc00FjxAxgrnJM9pXeOh5fBW1GQuOWza15v9ppvav4PPLrTxWs8vO0zguibnSik+NSBYn+UAuUuGOjyC02QHlakyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmt80Am2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmt80Am2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94637C4CEE4;
	Mon,  5 May 2025 22:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483757;
	bh=JUqtbR/yscXAD1scuNnJkYoMVnOPkshvLf3LIPKm+Po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jmt80Am2pmc0JyYibMtDvkM05GZB3R7fMdOaJ44w0Cf4jZ1WnzUwC01//VMroz0O4
	 pv6mGbEvqS5kYwaKbhLpHIBGYwlXGVFe85gZ/i1wyMJUsNvR5OD5xEjoS6IndGWj4k
	 Z+6H0PcafzUAlygSYBVEJwzeZ2ypVf4PswXES0rlWPZezx5DwNskjO8Pglp/AAZGab
	 yBQXnomcy99p6VjpoEPVWFCpeKnU9Z1l5s9AAEx3N8ze2Pq3ZzQNVT5gbGk6GNR4gu
	 z1Ok37Hd3qv5oW0YQsTStCb5s8Yd2hR57Ox4KTI8oJImupcYoE5Tft2kT4PZnlcWqL
	 x+EmfN6k5QoQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Coly Li <colyli@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 202/642] badblocks: Fix a nonsense WARN_ON() which checks whether a u64 variable < 0
Date: Mon,  5 May 2025 18:06:58 -0400
Message-Id: <20250505221419.2672473-202-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Coly Li <colyli@kernel.org>

[ Upstream commit 7e76336e14de9a2b67af96012ddd46c5676cf340 ]

In _badblocks_check(), there are lines of code like this,
1246         sectors -= len;
[snipped]
1251         WARN_ON(sectors < 0);

The WARN_ON() at line 1257 doesn't make sense because sectors is
unsigned long long type and never to be <0.

Fix it by checking directly checking whether sectors is less than len.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Coly Li <colyli@kernel.org>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20250309160556.42854-1-colyli@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/badblocks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index dc147c0179612..23acdf7c6f363 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -1246,14 +1246,15 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
 	len = sectors;
 
 update_sectors:
+	/* This situation should never happen */
+	WARN_ON(sectors < len);
+
 	s += len;
 	sectors -= len;
 
 	if (sectors > 0)
 		goto re_check;
 
-	WARN_ON(sectors < 0);
-
 	if (unacked_badblocks > 0)
 		rv = -1;
 	else if (acked_badblocks > 0)
-- 
2.39.5

