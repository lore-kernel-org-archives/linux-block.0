Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net [178.154.239.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA371BF22
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="IpX3Paob"
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward203b.mail.yandex.net (Yandex) with ESMTPS id D6AE965C09
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 17:35:49 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:30a4:0:640:6426:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTP id 262F7608F3;
	Tue, 16 Jan 2024 17:35:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id eZpm1CDOk0U0-iNNfpDju;
	Tue, 16 Jan 2024 17:35:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1705415741; bh=hUqXt3iq3wr6WKTOdpFPRwCLgcCq56h8Q0+juNfIfao=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=IpX3PaobfaqOdmANcCrmCjzXYPdCzAZfQEBaVUlJO1HGtJgOSRWHvohes9Wa3RHpT
	 jTAQ0U8/fkwNpzTBp2OtCbfJ0+xpxGw9/YvWQc9egSaUCJ9EgUweMOsNF0jIpwIAMO
	 5rQgtDH/WyFEwLEBnx5y8rsDvYNpP0O98XL1YgA0=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] block: bio-integrity: fix kcalloc() arguments order
Date: Tue, 16 Jan 2024 17:34:31 +0300
Message-ID: <20240116143437.89060-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling with gcc version 14.0.1 20240116 (experimental)
and W=1, I've noticed the following warning:

block/bio-integrity.c: In function 'bio_integrity_map_user':
block/bio-integrity.c:339:38: warning: 'kcalloc' sizes specified with 'sizeof'
in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
  339 |                 bvec = kcalloc(sizeof(*bvec), nr_vecs, GFP_KERNEL);
      |                                      ^
block/bio-integrity.c:339:38: note: earlier argument should specify number of
elements, later size of each element

Since 'n' and 'size' arguments of 'kcalloc()' are multiplied to
calculate the final size, their actual order doesn't affect the
result and so this is not a bug. But it's still worth to fix it.

Fixes: 492c5d455969 ("block: bio-integrity: directly map user buffers")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 block/bio-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index feef615e2c9c..c9a16fba58b9 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -336,7 +336,7 @@ int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t bytes,
 	if (nr_vecs > BIO_MAX_VECS)
 		return -E2BIG;
 	if (nr_vecs > UIO_FASTIOV) {
-		bvec = kcalloc(sizeof(*bvec), nr_vecs, GFP_KERNEL);
+		bvec = kcalloc(nr_vecs, sizeof(*bvec), GFP_KERNEL);
 		if (!bvec)
 			return -ENOMEM;
 		pages = NULL;
-- 
2.43.0

