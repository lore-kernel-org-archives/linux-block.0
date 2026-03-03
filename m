Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7AD2848BB
	for <linux-block@vger.kernel.org>; Tue,  3 Mar 2026 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522733; cv=none; b=cAtDRYxakJCLCoHqYZYdydCUVwKmdhXMOLs9E/E3LizQwea8yundfrLK0e0IU31Dbz1H110qZeZS0ruUvfw9RlesHnfDZnrjTh/Xh/dqEk5j/7SO2rhYEMx4n/N+BRt3rvAhm9wmnuSBpbmP1rFEbppGo9CmKw4J7CYwkkkWVt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522733; c=relaxed/simple;
	bh=olr5Xba5ljFhinjZ+51c5ZvprnFM445ahKA4H2gc8wU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C5LpWcpuyCCO+Ed3YCVzMlY/e36F36Yx/2ogLc5UP+s8B+Nw0yd7Fe9Zvx6KsmcGxz/GZJrcoHh6262ittqXMdVRjHenHyUUUVgiydhmG3oH/ITp5KlTcjxHPwlCBW6fey7dHEYFVtDaz7nzGxHRuzwj/TrJEG+U9PrN1M9eUjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=chhKCd0K; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="chhKCd0K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Hy
	jirS+K3VQFj4XF47nk2NDEe29GmdKOSzj81ZIpGzU=; b=chhKCd0K8gLCFWUgXp
	IBus3SUbWNzMxDCnCvabO+IjnA4gFXkGpxo0V6/BE3bupLPpbNgRUApZt5YapALS
	KNKGXrin2yyQw0tbLAUnhveWp7Eei0FZKpjyUOkaVdnoNY+lTzki/qa3u+94sxB8
	tIsYs5+R757yWR1+gwLgkMWTI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCHMIzfjKZpBYJ1Ng--.15418S2;
	Tue, 03 Mar 2026 15:25:20 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: axboe@kernel.dk
Cc: tom.leiming@gmail.com,
	linux-block@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH] block: fix page leak in bio_copy_kern when bio_add_page fails
Date: Tue,  3 Mar 2026 15:25:17 +0800
Message-Id: <20260303072517.571437-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHMIzfjKZpBYJ1Ng--.15418S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF45Aw1DKF1DZF15uF47CFg_yoW3JFb_GF
	1jvF1kWFn8C3W8A3W5Ca13Cr10y3WDury09ayvqrZIqF95JFsF93WfZr9FyFW3G3yxu34U
	t3y7XF13uwnYvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8UDG5UUUUU==
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwgBf72mmjOCqVAAA3v

When bio_add_page() fails in bio_copy_kern(), the allocated page
is not freed before breaking the loop, leading to a memory leak.

Fixes: 42d2683a2704 ("block: simplify bio_map_kern")
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>

diff --git a/block/blk-map.c b/block/blk-map.c
index 53bdd100aa4b..ed0ff4e77833 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -398,8 +398,10 @@ static struct bio *bio_copy_kern(struct request *rq, void *data, unsigned int le
 		if (op_is_write(op))
 			memcpy(page_address(page), p, bytes);
 
-		if (bio_add_page(bio, page, bytes, 0) < bytes)
+		if (bio_add_page(bio, page, bytes, 0) < bytes) {
+			__free_page(page);
 			break;
+		}
 
 		len -= bytes;
 		p += bytes;
-- 
2.25.1

