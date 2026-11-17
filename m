Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921114;
	b=2SAhae4R56Cno0jDQKI+24f8ECyvH74HjyL0oP0cy7ViMiOKm12FjuQZBsmmsvAmv+fL
	 hR4YIIPCrSF4650+KuqdC8wBhfK/YpeVUqkrMzBdZIcSXvGLZv9PBqc8iy2biiwkLEwYs
	 5RI639MzTBbSkTovnRkysw1CI6AdPSzO2WCBOxj6b41vRRmcJDBohUL8oaedzuRKMIdtT
	 +eEwkVpudjJJZFdvM8EygukHO7esehu7bzgo4agRVwFFIITcrYZ0VPAbnIglaCKMJu3wB
	 cNMaOfnTDPxxcTJMbHBqJbg8DPcRV7kp5revSE/E75ofnO9z3FZKLwIiLemQk2XDKMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921114;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=uYjgRnG7F/qHd9d76sHl73jFLXyEHd1QSP4s60O6uMc=;
	b=eoOmJCrd+eRzl1JaYywW4NxTZ/psKE7dezkNc8QPRSGovjLIQIs9ZVITe952ZF8xpr7H
	 0mEY5fzhTGRDq+vy1o2BX6s3iz3bYa0wFo10lTYLQq51dlc6zkR6IsZ+re01a89R//UOh
	 YRflEGc9NUNa2dSnWLEwxZyXStsDLYoIO2gELWMXShiLoSX4t+pECLqnJhHpXjfYPdC/u
	 puMjIqQmOMqKHjfzfe4+1GrxYIRedvto1EJvmYQ/K+Zx02UiLEYxVc6h5XkEWFMQicRAJ
	 JeBHz4sHbGN42G70woJE80YwpKJtOIflMoPCvBmtqhWA/MS7aRDDjPW7pDr7jbZhYFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mHHNNtor;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAE6606A31C;
	Tue, 17 Nov 2026 13:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CAE6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mHHNNtor
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=uY
	jgRnG7F/qHd9d76sHl73jFLXyEHd1QSP4s60O6uMc=; b=mHHNNtorD+IfNmIrbo
	pFlisDLlF5Er8yc0d140iV1fGOa0MDvWRPiObuy4uqFrC9Cm2ovMEzzDYUBpGI+y
	APDip7qsAJaWuNz7V5BTPdjDsUo4AwpsZFBFcndaJcaUF0X45Qp+eszR/fKNT26U
	s1qszpxxoywy4G7k9EW2Z2P5k=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3F51yUvxqV94CGg--.35035S2;
	Tue, 17 Nov 2026 21:11:16 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: roger@xenproject.org,
	axboe@kernel.dk,
	jeremy.fitzhardinge@citrix.com,
	konrad.wilk@oracle.com
Cc: xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] xen/blkback: Fix memory leak in xen_blkif_init()
Date: Tue, 17 Nov 2026 21:11:14 +0800
Message-Id: <20261117131114.1393829-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD3F51yUvxqV94CGg--.35035S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw1Duw4rGFyUAry5Ww15Jwb_yoWfAFb_Wr
	48Ars7Xrs3uw1DCa4DCFn7Ary293y8Zr4Ik3WSq3s3tayxWr12q3yqgrn5Crs3ua17C345
	JFyUXr1ayr10kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRubyCUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7hSL+Wr8UnQNXwAA3q

If xen_blkif_xenbus_init() fails, xen_blkif_init() returns without
destroying the slab cache created by xen_blkif_interface_init().

Call xen_blkif_interface_fini() on this error path.

Fixes: 8770b2683f9f ("Fix compile warnings: ignoring return value of 'xenbus_register_backend' ..")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/block/xen-blkback/blkback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 88526e349ce1..6c25da65e46e 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1553,7 +1553,7 @@ static int __init xen_blkif_init(void)
 
 	rc = xen_blkif_xenbus_init();
 	if (rc)
-		goto failed_init;
+		xen_blkif_interface_fini();
 
  failed_init:
 	return rc;
-- 
2.25.1

