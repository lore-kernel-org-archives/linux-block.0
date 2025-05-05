Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E4E277815;
	Mon,  5 May 2025 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485104; cv=none; b=KgFwCoB/gGNyeca2nxW4qto8vvrLrrdupGYsZE/rbZI+w7pWpXUMk7lbgHRQ0VN4SpCBMgxmahC1Qv6wRThRAw02eqFscXrfQXIR/p7mL0uPS9m0tQ4ZJ+Y4Z52ZCO5TOrbDuT7jxy3X5RDkC83QeWaf0FbZh0kZJn6Dj0sTOFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485104; c=relaxed/simple;
	bh=OGEmbQrUFdVZHyv53Gw+XrgRi5QoqkjyJgMiANsk2VM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kovgte84Gy/71bkB75cgfqbCdkdZ5V4TZk+NXaf34CNJ3yNh/V80WYEArTKTzoX/U2PSZwZwMW3hPCPStqwhmL0wzN2r/uAMQFUyWoI9TVX0V+Ve3M55ozGof5YW9fkbP0yfDZOyramIojQ8gQhLPFN8HqgGOBEZmzJWSpRs2TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKMAxRLm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKMAxRLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD11C4CEE4;
	Mon,  5 May 2025 22:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485104;
	bh=OGEmbQrUFdVZHyv53Gw+XrgRi5QoqkjyJgMiANsk2VM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iKMAxRLmRFST8T1BZQbJA/nnc4z/QUyEEkOLD6x7NK+b3SR+XCYcR2nuNLjFR2RUb
	 hw+K8Wn/iLwP4mE2WBNvWGCOmYTmpgYI1nqXLP7RAUnKIsf5DxrBv9hee72kb+h4dy
	 2/RNoHV3LPwBUDTLgSNEazbuwBU0xKdXCA8kFOv6s7dkJQ/q8ZiiSm5tZmz8ZDXZOm
	 C3MXYfOudk50CAK7hVDJvSVXezSyYDmaFLT7U0ayVAxlRrq4lU+mYwG/8rRvYaHQMG
	 PltmyXxmQd9GRhVincba4GbG5o8N30s+bk5pkGfPoKnIr1urvVium04eo04WK8wWKF
	 NJmU9X48jCTWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Coly Li <colyli@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 163/486] badblocks: Fix a nonsense WARN_ON() which checks whether a u64 variable < 0
Date: Mon,  5 May 2025 18:33:59 -0400
Message-Id: <20250505223922.2682012-163-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index db4ec8b9b2a8c..a9709771a1015 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -1349,14 +1349,15 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
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

