Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B135042A598
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864012; cv=none; b=mtMxrTABVydx8sXVRofjPQIfblKEnJ6zRsl6nuDjiE1bpidDXfo7dgISDcxpLKRYcvl0MyvrjtwBiZbz2G4QNJ5ijvKpNHiIq609qum0MsKTbZOnlL98wLmpTUt7zyhsPZkqiYBD0DZnIiHEQG44Qb4A2FOsycdHqn2aiNCK0Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864012; c=relaxed/simple;
	bh=MsJS7V6fpUg2zBKi42tVc5Ptl7uOMehQJ8c0G3rEClk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQXp3OEpRRg76bCfj5qCgV4v3f5qp0QywLXcTNNN8RCwTpjUgPUIIHm79Zljfa3B/FWGd5pMFRj6RN8BbgTjHnDC7+RjhaB2P66own2ysFBIfK/foKM2hBp53J6cGobs/izukNcsKss5QIPUSWIzgpi6hiDCd31OsVY91j1C4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EkrDFRFG; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EkrDFRFG"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a097cc08d5so6824635ad.0
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 01:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863996; x=1768468796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFGr8sSgizfUuX519DO/CGZxfXJRTiuzDWpoBuOhO+w=;
        b=EkrDFRFGn9vhCHGVI3o/5hs+jr8LHW4Lh/ZlqsU+vYvXaMHQM4/I2s1V491oX9chQz
         c7OT7DSmMA5FxEsON3BXFgp2/PED63gp2R9f1A8StaBRen3VXMPOMvWE2DQkRk/XllL/
         LJaGgPo32q4/83kM8KWxyy6PlFRfvTsFtiFIDRyOJTiG/gtgvp01eNzdQXp2mn9hokpO
         ePocZKvn5l774pVIAeEW+q+TF9QI2ts9vibcAmyPxG2M7nKFOXalhHxNO63yV6zz6oKx
         ZmCgP6jYlnBfRs+RqQN0dMao1cfj3Ns4MlfVhHWdLThC77rC8TCbe+B3Jq7T33H7RsDn
         g9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863996; x=1768468796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jFGr8sSgizfUuX519DO/CGZxfXJRTiuzDWpoBuOhO+w=;
        b=ZVef7RrgiTuUyXHW/RpZ1de4HpCBqKrkL7NMg6SAJ/a4D7bn0ewzlIOFGcZ+CpukB0
         UhLtPE7aHoJvrBghMIRJ7/QtQbDg/Gq2m+dvGpawr3QzE4VmdCqX7+iXKe5AkVBaGjFX
         yTE8glImn85o/+hlt8UQAOlrWyOJ2DutYm3frhCnYXZZlnOsFxwGt80XCeU4zFqRui5P
         y9dp14oWPyO3vgefn4/dOYBDma5/A+KPNmRtP7pGpM1mVQDpQLXcbzMVfXoW5EvfiVl/
         fMZjw0tr1CGfwbR2n8n+kaNmxJQ1U8VTWJG8NxTYKACCEbUyFJoV45d58NqQnOaaRCF0
         QVkQ==
X-Gm-Message-State: AOJu0YyeLzsFrBegB6H7c2PzQqiQ10vzltv09D1fIzF7KSJVlwW0uuZA
	+yMmuHav6B0dHV53ildnGahe889xrx1ipfs/Dnsx7NT2RWkjqIxl2yVrsxISF6hx+dYGMk1yIxD
	WkhQutsdXBzGBS2l1lnP5CXahV6r6yc1NNj60
X-Gm-Gg: AY/fxX4xXQ7lYLkRomjSWoR++seCprgZKeodnApemm2zvYDJdPcT+98NUVaGd27Ug5p
	8iWBZnztwMjs+fFoZ+2xyC0KNPk1hsnSpYMwDvQjvxTP5V9FJ5QCteF1Fk3QfmSKYlzsaBpLzur
	PNsVigkCz7iobTvW7AfZiR6odGq6rmFOyruyZt6k/h5959ill3awdgX3Tfm7/g7HDWELlORTueO
	dgfVKoePmr8+FYmdupbAqbmipf5kW+cdNV0YfuCsXFi2K2kZir4jo+udXsRil1O3RuJubbRrmLt
	yN+ij85ijPzjgZtExGy5JVYOTRa4JQmM3V5Fp+PyM9EIQUjWKSNjV/fXFqiCiTjM4HvlYiLLC6O
	x8+FfjyCt339Su0qbYFS/rT0hWsQnsfKUDIyPGdjZnA==
X-Google-Smtp-Source: AGHT+IGbE42kNiN9VAF9w3CyUfpY7emMMXpuu2bSY/RAho9b530kNluhzICcqsPKlkiWwq+LyOI3a5W7H8Xc
X-Received: by 2002:a17:902:f78b:b0:298:9a1:88e8 with SMTP id d9443c01a7336-2a3ee4b33a5mr39639025ad.5.1767863996530;
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3caea08sm8405455ad.32.2026.01.08.01.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D97BE342258;
	Thu,  8 Jan 2026 02:19:55 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D4409E42F2C; Thu,  8 Jan 2026 02:19:55 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 06/19] ublk: split out ublk_user_copy() helper
Date: Thu,  8 Jan 2026 02:19:34 -0700
Message-ID: <20260108091948.1099139-7-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 22e82bbf50ce..225372cca404 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2700,42 +2700,36 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
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

