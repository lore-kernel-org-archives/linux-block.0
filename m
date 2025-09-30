Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5512B140E5F;
	Tue, 30 Sep 2025 00:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759192604; cv=pass; b=mXx6OPuSJKyyOMvoRkWvc7gUlHLnBQtUh76+sFpNRORonVlHBP1GKizXzhdSfxRlo5ykb+p41sJvpDQoO7lJAV+5QH7i7SrXFm4DfVwe10IO+x6HE36pFw6Wt0jTP5qT+xtZsDcFQP3oYdsCCMWzuJ5wS5wZYqneDjxiurALaG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759192604; c=relaxed/simple;
	bh=0dmw+NX0SV+++5sYlZaNjj5lFZzOb2zEdPom2w5GJ28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXfKivLQd/f72G8PeIvKXqBwgNvx/ooZ74DKSQ7FlLHG/FfA4Ucq2/AO4MyNprIeM4MtdJi2/Ft1JNzCBaxeqJvCGLg6twVUFT/p2pVIK8FUC29RJdjnEN5H4MLCiiLWPhLF4QOEblLUthHgsaxvls1QgUByzdkndz2U4lXOewg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=O3Ji+s0t; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="O3Ji+s0t"
ARC-Seal: i=1; a=rsa-sha256; t=1759192572; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Gzzvatf2+sOjcLRAR35rfF6PyBpIAs2zctN6lNO2evh/mpIP7fD1GVTcbKuJECN9VPY3dG4T+kgi97611gXES0990c2xlbSrmT9lgscxazjJ3We7DQV7JP6U7hVS1x/mboZp4vRetKQzCYWI0C8SqBV37GMDc4ayN/vN9r9Gsl4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759192572; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hydiAdnjg/6bowrEjqyPCxKqacoOwPu3GjH+2V9IjnI=; 
	b=N072Nz1wP8msVfX2z6Vb4QI8eM7xVRQCzU+3xnOuAiKtpjL1+OszzPlYWmQQMRVJoxi1NdgnR2U2n/6gz3dL8YG2cXqFWo0lv0z8r0KXvKo/Ik2hZc/13/5Xh8/gCSOoETVkLBPpUVVkK5m+tDVjFI2hKPOv+eNnjjBxSctdPlo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759192571;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hydiAdnjg/6bowrEjqyPCxKqacoOwPu3GjH+2V9IjnI=;
	b=O3Ji+s0tXa3c2jQrZHN7aZtOznofbmue9EnDAJIFiXn9A16jwC4x8w+bzihQDdwq
	/QlgieInSYZMTKQMDYqtT4GTl5vJPUpPQ2him4WI4mKmWeGSLHY4e8APRLTjMWlIKCL
	fbA53BHKKcsPHj9oMc6d43EdZVsdDry9A8LBBq4U=
Received: by mx.zohomail.com with SMTPS id 1759192569234211.8709219622018;
	Mon, 29 Sep 2025 17:36:09 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: Jens Axboe <axboe@kernel.dk>,
	Lizhi Xu <lizhi.xu@windriver.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	"Markus Elfring" <Markus.Elfring@web.de>,
	"Yang Erkun" <yangerkun@huawei.com>,
	"Ming Lei" <ming.lei@redhat.com>,
	"Yu Kuai" <yukuai1@huaweicloud.com>
Subject: [PATCH v2] loop: fix backing file reference leak on validation error
Date: Tue, 30 Sep 2025 08:35:59 +0800
Message-ID: <20250930003559.708798-1-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

loop_change_fd() and loop_configure() call loop_check_backing_file()
to validate the new backing file. If validation fails, the reference
acquired by fget() was not dropped, leaking a file reference.

Fix this by calling fput(file) before returning the error.

Cc: stable@vger.kernel.org
Cc: "Markus Elfring"<Markus.Elfring@web.de>
CC: "Yang Erkun" <yangerkun@huawei.com>
Cc: "Ming Lei"<ming.lei@redhat.com>
Cc: "Yu Kuai"<yukuai1@huaweicloud.com>
Fixes: f5c84eff634b ("loop: Add sanity check for read/write_iter")
Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Yang Erkun <yangerkun@huawei.com>
---
changelog:
v2: add review by, Fixes and cc stable tags.

 drivers/block/loop.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 053a086d547e..94ec7f747f36 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -551,8 +551,10 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 		return -EBADF;
 
 	error = loop_check_backing_file(file);
-	if (error)
+	if (error) {
+		fput(file);
 		return error;
+	}
 
 	/* suppress uevents while reconfiguring the device */
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
@@ -993,8 +995,10 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 		return -EBADF;
 
 	error = loop_check_backing_file(file);
-	if (error)
+	if (error) {
+		fput(file);
 		return error;
+	}
 
 	is_loop = is_loop_device(file);
 
-- 
2.51.0

