Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131FA189F33;
	Thu,  8 Aug 2024 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111988; cv=none; b=SlHOkkdZPGM4/6yKnJ5yzllVZNBmAvdQrRA/p5JbYopnAgnWbAsME0AxcxNMcV7IS7uXbiDBT/Ct8jzjSIFeoNRxCLKAk+i69G3J/jATU28yGIu/7mgK7743JxqUJeo8BC2EdSK1dX+F7VzPui+jnH3ec03fQnEdYAjcfplOQ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111988; c=relaxed/simple;
	bh=ouPA6ZrahlF54R4HPTBRnYcpfrAsj1xJHWagR7bwEPg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=VAZJRUpyvW1PfRM7il8/yvwNnySGHIURmPNthGrOJb/HnLDYFj/zoHpm88xpN9/CQ3PejWS1jO7tjex8TAPc6TgLRC0V7WbChsJv2qStPJzb4hT3ArHexHfEWZgJmcDZXbJ3uJdCz566OQnfzLcQlP2jEtjs0jp20ly80pBVQJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SSh4DpBT; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SSh4DpBT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723111974; bh=mfUonZG/C+QDJMq8H/BlxiTC4EXPl9wK66ybZn66nho=;
	h=From:To:Cc:Subject:Date;
	b=SSh4DpBTmvsAan2sf0kQ2JglXirYEBMGu2GtOSde8tiwpNh0W/xnuf04q7/Q15+PA
	 cFtVV52iyWdB6TeWLSHpiLmQbNE9YU80L5EftPm26ImFChTF92STWAb30fmKfV8ofL
	 CMV2MdzUGTk7AIUdU5KOJfSZtAZe2BQzo3wa0suY=
Received: from localhost.localdomain ([123.150.8.42])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id DB32546F; Thu, 08 Aug 2024 17:54:51 +0800
X-QQ-mid: xmsmtpt1723110891tvw1l3xep
Message-ID: <tencent_9A3345EA79C1EE9DC4464BB576C6A602A105@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+zW6xu5i8c99xvDD8u1RYFkfUoGob7cHiYe6CLAgMVTwiC/6ImLo
	 VdVTh+YuWZ4RkoxTjANVW6Ab40A7jqAqZamUnu6TYQ3Y0QUQF4Vn8P2VZu1hN9n387G0zesJrFbi
	 qpS8D8feVAT/4FzJlHEpN0ujM6K0XGdbexhcXgFB30ia5DspdKRO+ht55TTtMaCE6SqXolB6bgfg
	 37THZsAj2xT8bShU/tCsAl5xpF9P4WLUUWol6K3JEwKNLvt5jJ2XAdcFiv8AOUX5Iysdf9SRz6VP
	 XiARAib8dRY7KdJgvf2La39ixs8+LZhgzbleWi/UWjQFcg01TGqOdj6at8YiGzCwe5EiGtvKi9dN
	 iYznpCqIJi+loBHl3GN10j0E0cErrYVap18rclMlrZKvbJnMxKrEOkaFA+x8/lc+jwAIQE9LiSD1
	 fyRqdTy+MoCQ7qsrLB/Oru/JPQsWeBN6aL8AYEWMgF4CuVjBYpmq6e57PnRIjck57h1O9G1ThFc8
	 1T379W1Bi6IZp82x2yAnwxVHpbsDkwWbXXTjeaij3tz1camucB8XGWaWwXTJK5hBiFDuDKoKW+uP
	 3RUl6oB5iLJVoxZwIeNOjNuuH/b9CGwJP1I40nsl8GT0vv/Xu4MAjFer8ROxX5r5/GCEVmOMmJ8X
	 AfP6UCLyNFnURYcMERFuOXh7kiQO5quqgJ33GDAwhE5p7z75ZecWOSHuz/HC+jB2aw8zvw/IdFWF
	 a6KylLu2v5UG2lbsjvM8u2cWxZPCiQ2eT/kkY+n3yviALvDrsHSybA8f2Pv4kI03yWKxinmsdsJB
	 haPqu0ty/nNIVT8g8GtZGYQJqYI5UEBpQsHej09ckj5qCiAHhAS/AueHvbQml3KLZnV6ER5XqD7c
	 YwG+5NMdg61G8CvrFyzUEhShK21m5MDDbE2Sy1cH3uDkoIbfsx/7q8NASdnh13Gg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: 824731276@qq.com
To: axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	baiguo@kylinos.cn
Subject: [PATCH] block:added printing when bio->bi_status fails
Date: Thu,  8 Aug 2024 17:54:48 +0800
X-OQ-MSGID: <20240808095448.360239-1-824731276@qq.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: baiguo <baiguo@kylinos.cn>

    When ftrace is not enabled and bio is not OK,
    the system cannot actively record which disk is abnormal.
    Add a message record to bio_endio.

Signed-off-by: baiguo <baiguo@kylinos.cn>
---
 block/bio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index c4053d496..fb07589c8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1617,6 +1617,11 @@ void bio_endio(struct bio *bio)
 		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
 	}
 
+	if (bio->bi_status && bio->bi_bdev)
+		printk(KERN_ERR "bio: %s status is %d, disk[%d:%d]\n",\
+				__func__, bio->bi_status, bio->bi_bdev->bd_disk->major,\
+				bio->bi_bdev->bd_disk->first_minor);
+
 	/*
 	 * Need to have a real endio function for chained bios, otherwise
 	 * various corner cases will break (like stacking block devices that
-- 
2.33.0

