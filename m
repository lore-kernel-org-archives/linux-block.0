Received: from outbound.baidu.com (mx16.baidu.com [111.202.115.101])
	by smtp.subspace.kernel.org (Postfix) with SMTP id C830C36212C;
	Wed, 30 Sep 2026 03:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790740208; cv=none; b=nyLOv6jL+6EuZMvnMCmp+ZXQxlXmxckAyFBsw5hGm58jvr62T3xbvJ9OoKavdM57y1AT7uFIZeRIxIaHUqhHTx5YxkJZhXdZSy3xK4hCBcJBtB3f/j7OB9IR59hh84YA6QBGJzLiyiEaeYiHcok0q+AyPHFbL2+q+uF2q1EYQqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790740208; c=relaxed/simple;
	bh=Ic8nqWQeCEBR/NN+vIdgf9HuTys7Ex96tdp1kivxrIc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kg2sYhfkrWij6i5G9pb/cqogZM9zdLnUlM4sITIxwmy2+mULx8MIOgi+AHAo7yYA8moivDvAsINxcsrV7kEx7AbpgODZSFqrae4wgCDEWzk5mhXRFqfQiKjrZqyU2e1KJeru9XkzC5N1C7FqmNBMNrPT6CLCoh9G6MtILc9IfYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=b5BH2Hn9; arc=none smtp.client-ip=111.202.115.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="b5BH2Hn9"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>, Geliang Tang
	<geliang@kernel.org>, Xiao Ni <xni@redhat.com>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] badblocks: actually round to block boundaries in set/clear/check
Date: Wed, 30 Sep 2026 11:49:41 +0800
Message-ID: <20260930034941.1814-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc5.internal.baidu.com (172.31.50.49) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1790740190;
	bh=/33CsaBKM/LGw8D9fyhF4Ou5EfH0WoXT3K9BKseATzc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=b5BH2Hn91Wse1eo3fAaEhpfffAAJWksKYSq55K74HHrnuV2IbS5ezlCflKPfe9DDc
	 G9kfiWsN/O0bmkxYcAoQbBsAg4HiinHNHz738esREYU3D789EwuplhbXy8XLrjYAJX
	 O0BrHNtkX4aqjMq06cL54MG27wZLu6bqTgjtESZwIs+453wt9+vL2/I5P9+8hLXnDM
	 KxwegkgCY1olj4BsIEXgEcmhk8vTQQRpM8Vp3nWJG/HPAbPGrqjnWrng8x36S+VY2Z
	 w2Ob7YXXJMZmwy5xijrhph6sB2zsvNCiaOXYjphuRZwyHS4yVnPRIXaFKNqW4r8KWD
	 hfpyBnLDLK7KA==

From: Li RongQing <lirongqing@baidu.com>

_badblocks_set(), _badblocks_clear() and badblocks_check() intend to
round the start/end of a range to the bb->shift block boundary before
operating on the bad-blocks table. They call rounddown()/roundup() as
bare statements:

	rounddown(s, 1 << bb->shift);
	roundup(next, 1 << bb->shift);
	sectors = next - s;

But rounddown()/roundup() (include/linux/math.h) are value-returning
statement-expression macros; they do not modify their argument in
place. The results were discarded, so s and next/target were never
rounded and "sectors = next - s" collapsed back to the original
length. The whole "if (bb->shift)" block was a no-op, and ranges on
devices with bb->shift > 0 were stored/queried at raw sector
granularity instead of being block-aligned -- exactly the "think a
block is not bad when it is" hazard the _badblocks_clear() comment
warns about.

Assign the rounded values back so the alignment takes effect.

Fixes: 3ea3354cb9f0 ("badblocks: improve badblocks_check() for multiple ranges handling")
Fixes: db448eb68629 ("badblocks: improve badblocks_clear() for multiple ranges handling")
Fixes: 1726c7746783 ("badblocks: improve badblocks_set() for multiple ranges handling")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 block/badblocks.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index ece64e7..eafdb6a 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -857,8 +857,8 @@ static bool _badblocks_set(struct badblocks *bb, sector_t s, sector_t sectors,
 		/* round the start down, and the end up */
 		sector_t next = s + sectors;
 
-		rounddown(s, 1 << bb->shift);
-		roundup(next, 1 << bb->shift);
+		s = rounddown(s, 1 << bb->shift);
+		next = roundup(next, 1 << bb->shift);
 		sectors = next - s;
 	}
 
@@ -1071,8 +1071,8 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
 		 * isn't than to think a block is not bad when it is.
 		 */
 		target = s + sectors;
-		roundup(s, 1 << bb->shift);
-		rounddown(target, 1 << bb->shift);
+		s = roundup(s, 1 << bb->shift);
+		target = rounddown(target, 1 << bb->shift);
 		sectors = target - s;
 	}
 
@@ -1307,8 +1307,8 @@ int badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
 		/* round the start down, and the end up */
 		sector_t target = s + sectors;
 
-		rounddown(s, 1 << bb->shift);
-		roundup(target, 1 << bb->shift);
+		s = rounddown(s, 1 << bb->shift);
+		target = roundup(target, 1 << bb->shift);
 		sectors = target - s;
 	}
 
-- 
2.9.4

