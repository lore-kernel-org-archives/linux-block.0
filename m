Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE12254B19
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949718; cv=none; b=tJoGZuKHeHih43hAR2nFZddHBnQ92ThHu6zAHxR8IRq5+bzAzW4UX9dzMO1yYzevvSEecG5UArhHe6Vi4SC/XQtyXPM6KLhY6GsJdg70CpWZi/nDqGhT891KDF5p5Xf025f9W2/5rcdmXCj1qSN5Iy6T49a8j4uXHRG9vazJNbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949718; c=relaxed/simple;
	bh=pFLON0C1oQtjJn2qiXI7MdgjCCHKt6ZzUS2gWW7cigc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTlfNLPgxDvy1wLLtuAgkNYFcbXps/lGiJ1GYEDYF2AUspcr16DZR1/tmikXTWbinzUxVHqt7rxFzqoXqICgmmxbrr1QXHvVVCJf/zSpOwBFHUT3OIQclUHd0Q+NR++Oq8DA8tlrYdAB/XDomm1JTlSo0Ya5HSOVWmbVhffxtEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=buAMOgLO; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="buAMOgLO"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-29f08b909aeso12049505ad.2
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 21:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949713; x=1766554513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nnWCsd7c+dSY8wBQngk2tPTTYvptZXaImBTrn5efMQ=;
        b=buAMOgLOoVGXYmYAYaKLYDeO9Am+GPjYU9O9hSlbEHV3PP0WTn4AaRHjqTDzyN1Yf2
         80TQP5nXMWsig84mlOzwIZB6tvRn1WHVrVLw56IiaS0xrfu5+rdyZrOZw0l2jhZ4gtck
         N1dk53bZ1WXyHMJT0z+rc1jvuPy6XvrbhzVYJessQjoxt3a0ecpFnnvLX/fgzCNs+6oN
         gvrV0lQkPu713+2Bp7DesvEw1RNnrsXF2NQjB3inar8u2L/KN0QsuBXBcxTaJahEZbqR
         L+GWUkZLopEU9AEUW16CPvgVUMxPCVAs0jzWlTuMJGqc11zEzuEWdAm+dwIN6sIWzsPc
         V0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949713; x=1766554513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7nnWCsd7c+dSY8wBQngk2tPTTYvptZXaImBTrn5efMQ=;
        b=FVTL9UM9/Rmn5qQQehfJrrnpOEkXPv+7FJMEmIZJitfp7MldCweJM/hWmPe1P6SSRd
         g9OI/xNB739/owdUZKPe1sEIans1YQDP7GTmloc/n4mpUhXTQKZdL++PgYUos/YxHJhq
         t+QR/Y1Uim6DA9GP6QMym4ls7c+MW8bVmLkvfjTbz7yQY8FJt5kN7xfDP94x34O++RWC
         m78OG6l0FCHTvjKkzlgSXeICIQj4RJlIXvIAwjgrfWEL4n+tdp4JaO3YMccGkK/UrWOW
         xhVuqg1YFXvEMA3sKCKbVOMyrAL+Un1XFUlk7Jlv07pYStbDsW/cHOxI1NFCX4DDUTXM
         OFEA==
X-Gm-Message-State: AOJu0YzlsqaqMhmyGOLAnTtcEjKMEGYGEb3uJrcCipmg4wcyn2R3ThFq
	hxCPqbmEoe5JKPOIgH20Bbe8ZrpgBuVcJmOovsRASZKY4Y2mHlM0aWdYfCG/lkLcBR6v+/AYeXd
	lgHM2/5xAkVxvFgvCJq7Sju+P3bQIOHYYtZI0z237QoosfA6vKb2e
X-Gm-Gg: AY/fxX6Paa++DnOPfFE6KuLDdWPMrmdg0h+QrkwOFuHk6Mt5aoz2tBw6bFgepTk0JPA
	1yWIBjXHknPN6em/WIPw9MwDSdZfozODxZSI0eKjF6FQT2UTOH4dpL9QfW9TzmYkUOvPB5VDvTu
	Ty0nAQEZqEAdAmWSTVVmqxlr9bL9oKhvHGUAzPGhyt26ft2g/6kSnGwhTLTJAM/YMGipb60dnMp
	wNKCGnmxkQrNqYN71sgC3KWl/hOZZeo4Pnel7DivlVcr3PHE+BkqQVeAQ6cIEsJV6WrElZg05L8
	ICwXKQIdb5uwgYczUu+DuN2OAeJ+NzatYYAwO5QX36tXUmXpNG7Oex88rmGYCAqm+F83MVRItBL
	UzqmiIlS/DjHuFVv5Jr1G+xTnXCU=
X-Google-Smtp-Source: AGHT+IHMdHsws7Dly3g8BQupcQIOtlAn+95WYWkTsv2m0JLOGAKnlJx71g9i0zbiAmgrrLQ8YLltVLenV8LJ
X-Received: by 2002:a05:7300:fc0f:b0:2a4:3592:8623 with SMTP id 5a478bee46e88-2ac30187911mr4942568eec.1.1765949712815;
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-11f2e151243sm3230590c88.0.2025.12.16.21.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5FBA534225B;
	Tue, 16 Dec 2025 22:35:12 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5DB2BE41A08; Tue, 16 Dec 2025 22:35:12 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 09/20] ublk: split out ublk_user_copy() helper
Date: Tue, 16 Dec 2025 22:34:43 -0700
Message-ID: <20251217053455.281509-10-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_ch_read_iter() and ublk_ch_write_iter() are nearly identical except
for the iter direction. Split out a helper function ublk_user_copy() to
reduce the code duplication as these functions are about to get larger.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0499add560b5..e39ed8a0f0ae 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2657,42 +2657,36 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
 fail:
 	ublk_put_req_ref(*io, req);
 	return ERR_PTR(-EACCES);
 }
 
-static ssize_t ublk_ch_read_iter(struct kiocb *iocb, struct iov_iter *to)
+static ssize_t
+ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 {
 	struct request *req;
 	struct ublk_io *io;
 	size_t buf_off;
 	size_t ret;
 
-	req = ublk_check_and_get_req(iocb, to, &buf_off, ITER_DEST, &io);
+	req = ublk_check_and_get_req(iocb, iter, &buf_off, dir, &io);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	ret = ublk_copy_user_pages(req, buf_off, to, ITER_DEST);
+	ret = ublk_copy_user_pages(req, buf_off, iter, dir);
 	ublk_put_req_ref(io, req);
 
 	return ret;
 }
 
-static ssize_t ublk_ch_write_iter(struct kiocb *iocb, struct iov_iter *from)
+static ssize_t ublk_ch_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct request *req;
-	struct ublk_io *io;
-	size_t buf_off;
-	size_t ret;
-
-	req = ublk_check_and_get_req(iocb, from, &buf_off, ITER_SOURCE, &io);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	ret = ublk_copy_user_pages(req, buf_off, from, ITER_SOURCE);
-	ublk_put_req_ref(io, req);
+	return ublk_user_copy(iocb, to, ITER_DEST);
+}
 
-	return ret;
+static ssize_t ublk_ch_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	return ublk_user_copy(iocb, from, ITER_SOURCE);
 }
 
 static const struct file_operations ublk_ch_fops = {
 	.owner = THIS_MODULE,
 	.open = ublk_ch_open,
-- 
2.45.2

