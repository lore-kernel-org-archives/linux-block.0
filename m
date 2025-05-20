Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6179024394B
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749268; cv=none; b=rYGPBpY7npZyliWbHpStghFJ9/AtuMOcxfAnBt66/UXM46Xbe0ltbrq6JSVFuCj7i4aV4prFZ7R2758I8jf+aE8hnnviltip6SCwdJa0OjN7M/zaAIw+UE8P49/oHQs2DwUJrUtAe4POJoz7L7Znd5cMbVkIGhBdTQZuY99gR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749268; c=relaxed/simple;
	bh=UL/KYkiXAreMozg4LwVFjNtKo3wh/yz0+daQDMEHZAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itJDILRtVEE/SzW5f6298suVQ7Upo6UaupY2aJFNoSljeEUc3lSab8aQmUadvb02pz0qvbTgmv9K0VBy6n5jAO+MBZ6NoDn14YaH07j0fUOYLWY55h1wwmm0Hhy/HrM9kzjHjBf1qhyo5CPMLsF0svhGV6qdxLtpWNDCe58igCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vCxVQDpE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vCxVQDpE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=IpGsYvqAvbp9861ZDsWaDXTX4WcjuQJkzsbDIg3/wjE=; b=vCxVQDpEE17sJeVw7wPCYJ8kNp
	1o/ExfeTCUM6/CBe+1isnp7HhNbK8xeyVEElX3xlfs6tx0nL+KTxUag88zHOs+48OxEcnILjg1X/2
	gwNme1tVj590SgVRvANlkCQODarB+hEu+f7AUbNWHGn9Z8LjK/APx/+b9RU1XSp+EjnFcAtHd0xEW
	VdgLAo7Hla7fJIfbivvkQtD21mlipcwBz6IjhY7pgC1OkmLguGgPpKHywOee6rlra2pe7u78CS60h
	GiD5lZrdflGMrgCX4CMmM8SaS37t3Gl0ZW8YjNmKKuAIbD3+7SpeAiv0BJLXGaSxEUL6SM22cGArr
	M8zMNZdA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHNQG-0000000D4xw-3tbf;
	Tue, 20 May 2025 13:54:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: mail@eworm.de,
	lizhi.xu@windriver.com,
	linux-block@vger.kernel.org
Subject: [PATCH] loop: don't require ->write_iter for writable files in loop_configure
Date: Tue, 20 May 2025 15:54:20 +0200
Message-ID: <20250520135420.1177312-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Block devices can be opened read-write even if they can't be written to
for historic reasons.  Remove the check requiring file->f_op->write_iter
when the block devices was opened in loop_configure. The call to
loop_check_backing_file just below ensures the ->write_iter is present
for backing files opened for writing, which is the only check that is
actually needed.

Fixes: f5c84eff634b ("loop: Add sanity check for read/write_iter")
Reported-by: Christian Hesse <mail@eworm.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b8ba7de08753..e2b1f377f585 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -979,9 +979,6 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	if (!file)
 		return -EBADF;
 
-	if ((mode & BLK_OPEN_WRITE) && !file->f_op->write_iter)
-		return -EINVAL;
-
 	error = loop_check_backing_file(file);
 	if (error)
 		return error;
-- 
2.47.2

