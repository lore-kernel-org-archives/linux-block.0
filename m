Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE71326E715
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765270934; cv=none; b=VrDGaw+5o5fxJcRmlnLajerWNf61ntMP31V/1kzWvFt953lxt4e6acSMH6AsmDJ4yuKkH/3cw9MayJPGBO/OXlHZnIs3uE9m8/s4wBZF2l79lRNYtwECRPV7coeP4s26U6VVvoAFIL0L+d2VLxtWQBjohfDtW8cTaEVTYoxuTbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765270934; c=relaxed/simple;
	bh=54Xh/j2WhG2Ei4a1qEnIpkmDGonn8ZggrBoCMAcXO3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tqQuTMZxQpONgxfGPR6QD92ptkP3Ygo0dJ73qLvzeXsHUtRhKIZ0+4XPeSQBduyBJzj+3jrM7NFuXKzTqQsWpxKBrMJnCzy/Le/ia8dB5zWHwX5g6eon4ZUUVcWPMv2mwHfAyprHI/iz2EKnGqu+rXFiVM+Hw5PhjeqpolxPVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpJxwryK; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpJxwryK"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-349ff18445aso1541658a91.3
        for <linux-block@vger.kernel.org>; Tue, 09 Dec 2025 01:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765270932; x=1765875732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/7vzy1FUoDsUfjpWUzueUpIzsuHBaOImPA4L+Mj+ZI=;
        b=EpJxwryK9g1Feixo5HHg0A7IWUjHhSJZm9ujaEBQ9sWhRetOzFD3gsyryoOuyYVUBJ
         19Rx37MWHMc/F+ASQSz0osshuiVFw8yVyYJRhaNqSTphkLEfR0DmMrC0q6ACdLYGpRHP
         k0yKYhmmAoAgYzAmVppILLEScbdCuZZyhUYeRQiEpb5KVxVYpi0H9xXddfTGa6sfcSST
         FdWWUcc6l0AwwalAkqJ/DCpJvEDPQ0SEw9BYRn4EJKnThghmHaotEaw3MdTvV7mhx7vY
         8Gxvz0EE08zYWCKUQFmw07iIiPoJNq+Ozq+4xhqxM43CfFRz62SwrzFM6U6hv9a3lOjn
         QdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765270932; x=1765875732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i/7vzy1FUoDsUfjpWUzueUpIzsuHBaOImPA4L+Mj+ZI=;
        b=SdhMFrup0/cBkP/NeX2Sp387d/CBr4mmWuzvNVO/mgOVh4KBX5CBqjFSCklHLUTvcW
         5LLqdq3zSCJDreZcU+4yHS2fGeqa82XFiEdUckWehsBkP/O9kSVJjHz8Jc4di1Kwxbv8
         S3Cu4eyFa3foQCMUnJ1C8pAhva+sWlk5gbMWF6HjsOEzB5LxP9dPT09w4NzTvKmUJPC5
         lCfCPqyDT8dyk/j0BY2tlfnMSpiU34bVACvVMz9ocFw8QC5EMC4mMA3ZrpzfmhAeS6+p
         1M1P6D79AtkrT1LUah1CbcTI3hzhRt0dEN44u7Y9k+25cMoZDlkay+T0YkGMoQhCDAEn
         rggg==
X-Gm-Message-State: AOJu0YyaxMNpHgjcQQ1Vk9jCDlkDadqVeu+uEWGEyc9MEp42sJNqERx9
	uw4jw5wKfBzEpNeGZkhphYO7rBEDJ4CkvBFB0HOOOdca2fyzjkG8onnI
X-Gm-Gg: ASbGnct82Bp9h1LbMhbS48drsriDNF16z0gu1bCeEEysFt+kvP665zG2oZJycvqE7M7
	hc9RyV1ZCbfmgWC6QWsPSa/jg8CrlPqbLo5nb39ahWfnTAJvG4n6WfNhz613sitbpdTR6D9Vnn/
	3zVgM0xwFDrvi3IdkT/ze4dJ5hS+Xc/HkPTcjgqD3E4e4PU5ZLzh3B1E5nH6c4cEybntQ9tsYt+
	SFtcnw2jxJDohnonDrXVIPB+lejjONya8wrHZBu4r7ymYJ/XKLZt3tzTwN/WU1W+r/mWVn1OPQs
	q4tsfewORsPYhpTt5Xl8ys0NNOa0kggCaghCFeQ50ABsUl7ul0heFft+m3rwi05P284XgP/y6tI
	L55QWFhJoZWV0D2PRj0bc4/ey+fGDWucC9tQcuCK+RtRJX2Dn8xpQyAYbjNfhPboDRJxV1UBfFu
	LqmVrsgVdNDCZkqvbi9AmC+epmSPm9ZQ7jdq/4
X-Google-Smtp-Source: AGHT+IEWOR2FgI2CN9m4o4aayuOxDe2oGxmpJeGBPF7NkEyhYo7Qnk9E6QoJf+0EWwAzSeLh/XP9Fw==
X-Received: by 2002:a05:7022:170d:b0:11b:9386:8258 with SMTP id a92af1059eb24-11e032d86demr4398847c88.45.1765270932150;
        Tue, 09 Dec 2025 01:02:12 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7576932sm69700982c88.4.2025.12.09.01.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 01:02:11 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	agruenba@redhat.com,
	ming.lei@redhat.com,
	hsiangkao@linux.alibaba.com,
	csander@purestorage.com,
	colyli@fnnas.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 1/2] bcache: fix improper use of bi_end_io
Date: Tue,  9 Dec 2025 17:01:56 +0800
Message-Id: <20251209090157.3755068-2-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251209090157.3755068-1-zhangshida@kylinos.cn>
References: <20251209090157.3755068-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Don't call bio->bi_end_io() directly. Use the bio_endio() helper
function instead, which handles completion more safely and uniformly.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/md/bcache/request.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index af345dc6fde..82fdea7dea7 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1104,7 +1104,7 @@ static void detached_dev_end_io(struct bio *bio)
 	}
 
 	kfree(ddip);
-	bio->bi_end_io(bio);
+	bio_endio(bio);
 }
 
 static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
@@ -1121,7 +1121,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
 	ddip = kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
 	if (!ddip) {
 		bio->bi_status = BLK_STS_RESOURCE;
-		bio->bi_end_io(bio);
+		bio_endio(bio);
 		return;
 	}
 
@@ -1136,7 +1136,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
 
 	if ((bio_op(bio) == REQ_OP_DISCARD) &&
 	    !bdev_max_discard_sectors(dc->bdev))
-		bio->bi_end_io(bio);
+		detached_dev_end_io(bio);
 	else
 		submit_bio_noacct(bio);
 }
-- 
2.34.1

