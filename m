Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F96C4B5AE
	for <linux-block@vger.kernel.org>; Tue,  3 Jun 2025 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748976478; cv=none; b=eCr29ZfeuZNxVcEglGczf2i7CN9lcqxCZMbmZNpcmUbQUxBArlXP9Saoz+iardrDuR0K1gTTYfUGS7a4pW0lmZR/JNBT4j2JLRw7RQKBI8B/0jKtzDLg5bssaEa74v0mQDkWjpvdTjlOsb1dNmYO/6q0HgBQ/4yWC+j8wvJ+Zg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748976478; c=relaxed/simple;
	bh=T1nJCLcmWXLOe6y4Ii4bdG1cnEHziBxfcWmNxILh2TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mhmooaytysXlVN8iFjsoALXGvsCDwsJAwVZB/ECcwWXlu9ve5evDTB0H5yDsX3aqy8cT7CB1xJ9jgDnw8w+Eb+ghi3fNouq5d5feMjHyeQwT4GfQcGV+K3oy4zEBwjWUw+yuL3INmxKVqiDQg0K4zg7F5RqHGfb85Qte+Lcuaro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EDNGC76R; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EDNGC76R"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-736c8cee603so657566b3a.1
        for <linux-block@vger.kernel.org>; Tue, 03 Jun 2025 11:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748976474; x=1749581274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wleOKjFHw+cNcX4TN+jBCmGoOfaK4yhpbI0lui86FvI=;
        b=EDNGC76ROYG8mb6RidcHTxSwVsFWN9RJoPQGZQ7mu+uNEO+69BVw/5g9qRPeTAIwu5
         E4D5HJk9bUe5bz3UN0RNxjwsIMVSXB6yckQVl4X0qTrKU0AOrI2Fo9nmxLszlvGqoRLD
         eBBOSwyAnW95vkrtUjnNSx8YmWNrLWFm5YhMt5BKw2AYgt4pfDxiW1FlxmWH0HA4wB95
         +2eHfFBxeLgLf2JeZzmbN9N2lEfjQSYsTTbajALdqFJF8WY6yxz6V8bjqKtcRRX0Ca6g
         8U7jL3eS4bI1De7oh4KwZ5oSWkCpp/sNjQrKALuIFcOOp1St9NK6Xm3WXM4u5jB+WvDf
         21bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748976474; x=1749581274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wleOKjFHw+cNcX4TN+jBCmGoOfaK4yhpbI0lui86FvI=;
        b=ozidfyNz6nTi4L+xx8/9Sz9wA7D5VPiUkd6TLI1JbsjRsG+7Y7ESD8JD5UN/y8ldaR
         HR0cMikepdwlS+LdJI4Qaw9M9Eb27gpyjEUzsgsDTr3B68voIobos1PsNwTlV/s50eva
         8QDiqX+24e1QCp0PVmsrnJEmWPJbRreV/cSfSB9MMbtmirecOr+Y1HZKnifpw1EcFR45
         y3O4sLBU9nWniHbhd4rZt8FErIQaFub7HMnR0AjBLgk4TGQliKWgIdVRFcwfgEWH6RB+
         YJmxqgeEcr/Z3c6I17fAFU4aem97w2KsfKkNvFcQ/S0XxCJqSoKUpid7nHQm2t25oJqM
         W0rw==
X-Forwarded-Encrypted: i=1; AJvYcCXkbZVTDIFienTHZ6HJJaTNQMxhxyy3/AqrXIym5RvD7taJZcKpTeH/QdT4VdJzlTgWfu0nEWP9g4/Jqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6PNO5JRAKlAyqzKZk41NQD73I0b9UnaAPvxR7j5eczbMWISvf
	i2e+v2aS+QHCmMmVJwDZ3gKRePauwA46WQ45IUAKLh6RRWN4OLxy5MLNhVgR23KYGcfclXGU7Zh
	+zIsrjmqdjKVyyG7AVcp36eaxb8LPQQG6o2bW
X-Gm-Gg: ASbGncuMDKmt/7d/Ghka3iLSN95QRIoHLqr4q3j47aIBMCQPrlcCkiKDWF3k4ptU/qI
	fCzRJC6njNKPlZRUqzwzcmP2rjOHTLXf4YZ+KocMFK1ClZzDwJtzyGLqpKRb/ICguX+u9OYeedD
	90tAGtGt0Pnb48Db3dVBWFgVaI0j0dYHj2KHJL9L1uSGQQlS2kjnzKkigAtyrehj3282g3sifvc
	zoUwn0+qGJCr4PCpPzbsPgsOcaGkjj97s9Wz2aZ23REfRbosNaohZ++kjyjFMLziEjTEXj08Ok9
	/JxUENgEgpIFB2QJvN1pvpZDVudxYYoxoX4vOx4ad2OA
X-Google-Smtp-Source: AGHT+IF9o/kLaE/7tSmOjOj70ylD0L4dQmAqwISZaTT54uQrF1uMJGXZ/22CdVWSxkBTXdol5aFUQ6VoHoKD
X-Received: by 2002:a05:6a00:1815:b0:736:4d90:f9c0 with SMTP id d2e1a72fcca58-7480b20132dmr118819b3a.1.1748976474360;
        Tue, 03 Jun 2025 11:47:54 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-747afe98193sm743791b3a.1.2025.06.03.11.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 11:47:54 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7EAF834027F;
	Tue,  3 Jun 2025 12:47:53 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7B4C8E41D2E; Tue,  3 Jun 2025 12:47:53 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: flip iter directions in blk_rq_integrity_map_user()
Date: Tue,  3 Jun 2025 12:47:51 -0600
Message-ID: <20250603184752.1185676-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_rq_integrity_map_user() creates the ubuf iter with ITER_DEST for
write-direction operations and ITER_SOURCE for read-direction ones.
This is backwards; writes use the user buffer as a source for metadata
and reads use it as a destination. Switch to the rq_data_dir() helper,
which maps writes to ITER_SOURCE (WRITE) and reads to ITER_DEST(READ).

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: fe8f4ca7107e ("block: modify bio_integrity_map_user to accept iov_iter as argument")
---
 block/blk-integrity.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index a1678f0a9f81..e4e2567061f9 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -115,17 +115,12 @@ EXPORT_SYMBOL(blk_rq_map_integrity_sg);
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 			      ssize_t bytes)
 {
 	int ret;
 	struct iov_iter iter;
-	unsigned int direction;
 
-	if (op_is_write(req_op(rq)))
-		direction = ITER_DEST;
-	else
-		direction = ITER_SOURCE;
-	iov_iter_ubuf(&iter, direction, ubuf, bytes);
+	iov_iter_ubuf(&iter, rq_data_dir(rq), ubuf, bytes);
 	ret = bio_integrity_map_user(rq->bio, &iter);
 	if (ret)
 		return ret;
 
 	rq->nr_integrity_segments = blk_rq_count_integrity_sg(rq->q, rq->bio);
-- 
2.45.2

