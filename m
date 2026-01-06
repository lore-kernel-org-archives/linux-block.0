Received: from mail-dl1-f98.google.com (mail-dl1-f98.google.com [74.125.82.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D842877CD
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767730148; cv=none; b=kAJxsuy+TlNxQUlJ33KDVa2PDzoiFpTg9NPL97UT2RpnIU7NVM+HZkmyCTiZED/857zgVgv6DEA5P/ZkwRwwNmQsvAUOSjXvfrWsoYojAgdLp74XX08b1/19W1S62xxICkprxugc0bOMuxoH1r7kmlrlkfBHlzlQMU224VXYu7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767730148; c=relaxed/simple;
	bh=2lcupd++x1Moic9b4VtfjeROaCYx184irW5v+3n9oZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uqgPGs3TiDvzGNAH0DnZNitASdqF85j7IA1W30UUmYyOfyIkQ/PDNzXLjh+3HgWMtGBkUjQ4YxObZFcpnXlFjMYS5gczTmkFPUP2/xdM+69AXA7bvKa04v6pDR+Vuye2Hoo5v+jkVw0BYzt0mJhQNHDgy/YzQUv8VqOb5YVwOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Z+5XAxL5; arc=none smtp.client-ip=74.125.82.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Z+5XAxL5"
Received: by mail-dl1-f98.google.com with SMTP id a92af1059eb24-12055b489e0so69627c88.3
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 12:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767730143; x=1768334943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9SVubMuE0j+whBvLRvVXzI07Qv1rcUX3f0Z8uKGqRo8=;
        b=Z+5XAxL5sWOHYTafACtosf6u3Ks82Cj5f/vki3cJ1UZIDKSdTi3stXResJh0GJjS1m
         svk7uqZhUhT74w1JcJG2y5a1QhPYX4TlqNdoYDuMZjuZuiCIXoVtf5uYp/K1/5fm3qEB
         zVwH8zmWIRGKrcGPFu9YpyVWRIAoVNj1rPGuJ3l5/y1cmqlZTc/GLtCBgRN9cQxrqrNM
         l228hU0+DMqqab7MoveLtjqWGN6ds0c3b7T4qPWKmXHie0nAhxpw4yRllBVUtQLj0eaY
         AoeiWuu5xdavRhrIgSURbYQzCBIb4qWtL48RHA46tPyfRglg/pDuEMeJgV22GT2mSM/+
         8FBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767730143; x=1768334943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SVubMuE0j+whBvLRvVXzI07Qv1rcUX3f0Z8uKGqRo8=;
        b=TMwabeEnA2aCSm4d7giPSiw/xjmFTXIyxnA0RkDqyvjXd6PytP6G8zNoc+bolDx3ov
         31GBnBxYQgRZ57ubPRgJH6O/g37rucjKg0vwCEgyJnee5skMzGw/kVPqA9PEofA6TOr4
         wXfqGXATppHHXtQrMXMZpoTTx96Q0rVGZz/y00+SttB69R5z8FwTA9KtpzgUBeSqXJQZ
         +ZcrGn6GF8jya9KZK6ZNsUZLdR9jbZPjjqxgqYHpw7Dt9ZLWAItkPX3Y42/3hyx6hqgw
         fSLDxpYWaQXPHjNgHWRiSdl5Rh59+8leojE9MUJVMsf5zPj/rmAAc7vpN7QvC/XtCaxm
         jnZA==
X-Forwarded-Encrypted: i=1; AJvYcCUlIeR5E4HmxJ6A+VPU6hLOww4LC+PGoxXJGLShLNy2pkpjuNs+iPkZdvtsoyN284qW1SM0XiUhpNFYVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr4IDhHKV9G/rikQOUzEd+95CMm3YUPyq06Q4KjB1iVhzuiY7a
	LrIStevwQSGyB49OM9qtdQvyZ6qww8rlmr1XOoi+tKtuQDMtA6/yQSV/V24r3URa2BRMPWVaw5r
	3JAWrc4whXQlaE+qnMdvqA9WNmtp617RXL1Pj
X-Gm-Gg: AY/fxX6ingH+tjQi6aiDycBOVJBMRELVi5AmPkOO8I5pyabH346B3gWe+3rcxtqfgjl
	dip2fR0iU978rgeG5vT1R76mc0yQ6F2fLggydg4u2ZeUqwqmNbgkj8fSkPjTIR8go+dPJVvAawF
	s1guScBgGz0Uo3A9pap8XOejFUzmc6sL0lvvTCKtmpkr7FZw+R1XG4Egrz1gKo0N9OfIjSi1N3T
	o/By6QwwZOaRJZRMCAk//mJa0saNz75pl8CGlDwxb4ktwU6tQPTeTANUycSU5iWNnfykw1TU31m
	1bsm6NF1EgfQbhZDI3od4Vip/v8s9IF3vuZSTl7AzGisMBWu4r7rG5+HnORA6f6Wx1l+RfV7Co6
	5ATyZkJGXk4z9neXiZjhrCk3n0BzBhB6+A0WpRN6t6Q==
X-Google-Smtp-Source: AGHT+IFri0XimIVAtss9i1TtFqdSkejhFF4tr/n0oIMn5U5OJKjupAAzB2VPtvCr3RLCcxKJXYiQU/BaDhXS
X-Received: by 2002:a05:7301:fa0f:b0:2a4:3592:cf8b with SMTP id 5a478bee46e88-2b17d23fd01mr77426eec.2.1767730143226;
        Tue, 06 Jan 2026 12:09:03 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2b1706acf81sm358000eec.6.2026.01.06.12.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 12:09:03 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B94EB3401FD;
	Tue,  6 Jan 2026 13:09:02 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id AA8DDE422C2; Tue,  6 Jan 2026 13:09:02 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	Ming Lei <ming.lei@redhat.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: don't merge bios with different app_tags
Date: Tue,  6 Jan 2026 13:08:37 -0700
Message-ID: <20260106200838.152055-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme_set_app_tag() uses the app_tag value from the bio_integrity_payload
of the struct request's first bio. This assumes all the request's bios
have the same app_tag. However, it is possible for bios with different
app_tag values to be merged into a single request.
Add a check in blk_integrity_merge_{bio,rq}() to prevent the merging of
bios/requests with different app_tag values if BIP_CHECK_APPTAG is set.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 3d8b5a22d404 ("block: add support to pass user meta buffer")
---
 block/blk-integrity.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 9b27963680dc..964eebbee14d 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -138,18 +138,25 @@ int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
 EXPORT_SYMBOL_GPL(blk_rq_integrity_map_user);
 
 bool blk_integrity_merge_rq(struct request_queue *q, struct request *req,
 			    struct request *next)
 {
+	struct bio_integrity_payload *bip, *bip_next;
+
 	if (blk_integrity_rq(req) == 0 && blk_integrity_rq(next) == 0)
 		return true;
 
 	if (blk_integrity_rq(req) == 0 || blk_integrity_rq(next) == 0)
 		return false;
 
-	if (bio_integrity(req->bio)->bip_flags !=
-	    bio_integrity(next->bio)->bip_flags)
+	bip = bio_integrity(req->bio);
+	bip_next = bio_integrity(next->bio);
+	if (bip->bip_flags != bip_next->bip_flags)
+		return false;
+
+	if (bip->bip_flags & BIP_CHECK_APPTAG &&
+	    bip->app_tag != bip_next->app_tag)
 		return false;
 
 	if (req->nr_integrity_segments + next->nr_integrity_segments >
 	    q->limits.max_integrity_segments)
 		return false;
@@ -161,19 +168,25 @@ bool blk_integrity_merge_rq(struct request_queue *q, struct request *req,
 }
 
 bool blk_integrity_merge_bio(struct request_queue *q, struct request *req,
 			     struct bio *bio)
 {
+	struct bio_integrity_payload *bip, *bip_bio = bio_integrity(bio);
 	int nr_integrity_segs;
 
-	if (blk_integrity_rq(req) == 0 && bio_integrity(bio) == NULL)
+	if (blk_integrity_rq(req) == 0 && bip_bio == NULL)
 		return true;
 
-	if (blk_integrity_rq(req) == 0 || bio_integrity(bio) == NULL)
+	if (blk_integrity_rq(req) == 0 || bip_bio == NULL)
+		return false;
+
+	bip = bio_integrity(req->bio);
+	if (bip->bip_flags != bip_bio->bip_flags)
 		return false;
 
-	if (bio_integrity(req->bio)->bip_flags != bio_integrity(bio)->bip_flags)
+	if (bip->bip_flags & BIP_CHECK_APPTAG &&
+	    bip->app_tag != bip_bio->app_tag)
 		return false;
 
 	nr_integrity_segs = blk_rq_count_integrity_sg(q, bio);
 	if (req->nr_integrity_segments + nr_integrity_segs >
 	    q->limits.max_integrity_segments)
-- 
2.45.2

