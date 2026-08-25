Received: from mta1.migadu.com (out-28.mta1.migadu.com [95.215.58.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541723FB7DE
	for <linux-block@vger.kernel.org>; Tue, 25 Aug 2026 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662683; cv=none; b=iDXjGBNTaTvy2b1xFZ7KCvF1WQ1Vv68reAfWcr2NQ7yShRM3baNK8e55plhktnW9nCW/83FhT9EgNA+dx+yqyn7e0aABWAdf7jmNHfoTlD1gqJmjjFK2ZKurtJXaHhdkzeoKS1IK8FnUTLXN0lrMwjT6sTDrUkIiAjtI8lHQnms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662683; c=relaxed/simple;
	bh=1YPYm6TwcZfy5y0h7vMpIpqxKy7QKXtsLrVb2wLMlJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0yxfYKmdQgiafeYygQyTU5m7LgkG6AJiCMFTHKQpezd23yjbYDON8K7IYN79HMbyAD3Q+c3tDYoEg4AN1Osgp1m0Ikvaobxt5v97BQ//SvSVddLmqsmCxYyjqO/HQvXiBT32JxpFeI2xOZO972dxUgoP3Fi8N7MFK7nAy3XT90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wMjbQkAM; arc=none smtp.client-ip=95.215.58.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wMjbQkAM"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1YPYm6TwcZfy5y0h7vMpIpqxKy7QKXtsLrVb2wLMlJU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787662680; v=1; x=1788267480;
 b=wMjbQkAMc/18lGb2cSoaJmxH11xv9oJN4kKEgJCGZFJ9cgfPyQ0hxr/9hYTEzaErmc/Zafoj
 gCaXAt7HH8jGtT4V6xlqXTDMLzcdnm6kVsCb3Fdk8aIi/soP/V2/aO19z9ivn53Kq8SXI4lJUJZ
 XKziGct8Em8oJJkRgpBD5jQ8=
X-Envelope-To: linux-block@vger.kernel.org
Received: from ctao-book.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id ac232629fd2da2f1;
	Tue, 25 Aug 2026 12:58:00 +0000
X-Mizu-Trace-ID: ac232629fd2da2f1
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: axboe@kernel.dk
Cc: hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 3/3] loop: drop the unused argument of lo_req_flush()
Date: Tue, 25 Aug 2026 20:57:20 +0800
Message-ID: <20260825125720.181793-4-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825125720.181793-1-cui.tao@linux.dev>
References: <20260825125720.181793-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

lo_req_flush() never uses its request argument.  Drop it.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/block/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8ba146e76a59..e7d16e5961c0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -270,7 +270,7 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	return ret;
 }
 
-static int lo_req_flush(struct loop_device *lo, struct request *rq)
+static int lo_req_flush(struct loop_device *lo)
 {
 	int ret = vfs_fsync(lo->lo_backing_file, 0);
 	if (unlikely(ret && ret != -EINVAL))
@@ -411,7 +411,7 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 
 	switch (req_op(rq)) {
 	case REQ_OP_FLUSH:
-		return lo_req_flush(lo, rq);
+		return lo_req_flush(lo);
 	case REQ_OP_WRITE_ZEROES:
 		/*
 		 * If the caller doesn't want deallocation, call zeroout to
-- 
2.43.0

