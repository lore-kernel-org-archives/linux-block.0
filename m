Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A23481B1
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718155; cv=none; b=dZirYLwd93hn6uMzj94qbUQLAFSXrkahvcNTxjhNzkUj64i3LqZD+efz4V0rA3bI7fe7BY7QgyoCbODUK5pXeYDbx8pjWUc0olRbRO9f/7CG28Bh2DOOK5LAyjBmKn5wPtxYFXCmAwIFIuQPogQmqmCHMkXiw2HsS2N1rI3qwqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718155; c=relaxed/simple;
	bh=xkpH8lLTG9c3p1Ro1+SoWKPP5IKBS7+x5hs5r63cxJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H8A5KmbiftGeJ/FgQ0Vgi8FpacE1cKOAYBq7z+UXXdUa79Y0nufdvrKSGukogarrEUZ118vHX1QOS1Nh5092BxAt5+pL9pZaKzBz51zgKwS07u5lz6UwUdFq84xDFXIDN3nrqCuPoAmkIu+NT0TsO3ht4UhBaciH+wkJfhHy/H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=M6ZvaRsA; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="M6ZvaRsA"
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-2884e7fadb8so218099fac.2
        for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 14:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1729718152; x=1730322952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QWnXrhO7H2hLUx4TRf77CLBlysOiI1jydW7RM0rQhME=;
        b=M6ZvaRsAhBs6poDCWVJyN3Y/o7sg2+UoGJugjLZWyS9DNnHsLpDEUySq+y5XmNLsNn
         lbcFr1DmDlgR/mseDUKdtwRv+iE/uPzzdawIIeDLRPzWvAwWNwe7dPteyH5QNl7PwVNX
         jt/km5Dkr8GWI1rxNyqWvM5RDTkIZHEt5NjoQBOkJ0GdoC9V6RwqzYiFtxBZx+Y8+O3y
         MfEynE2yMQsPsLo6eP62sLt9AH8FBlDHkn4L2/4CzB1FqAa5kmZD4t7qN/nwHoLWkw6U
         CXM6HffUilyjbWVtCLqSeovOlMvdQd27JsEYjkOkrt5mvCcrEIj3YuvbJqIW2fWa/yUh
         9aNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729718152; x=1730322952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWnXrhO7H2hLUx4TRf77CLBlysOiI1jydW7RM0rQhME=;
        b=ridzZciaoBD/uchz7E65+y0BOJ2tSVE03BrPmNLBfNB6o6m31+wb4FJELGD2vxNYsj
         HdZWj5mE/aEg3urv14lkSLLHPQKAZXdxbrlG3GRPwWgOG9D00hoseCh8oAYGXxqbcpqu
         6ak7q1I6XpDG/WNo2BUD+3saiRBMBU+UJSbGun0gmrsgo3UGs/s/TczHTHUvF3MYHAY4
         lckmg3RPhfYMTuboo9CSGwYi648KVg/VyUq57E8r0iwmN2JIf9lL/jSdSpIZUa9+kOXV
         QJ+Qd2LEfa4UAB1jPHIX2H9sUPwuO+KL37JJeB9cLo0rhaV6hhKDWAcBiFDRU+wOiaAo
         J81A==
X-Forwarded-Encrypted: i=1; AJvYcCWLKBUDCNuF2N8bEucU1KurCixszbgR3jZtsye3rWtOa2EwkA39/YskFYBJk5jjzKJuh2IeOsEDRWpf7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwerVYmgUCwZKOqnmDA+E5UGc+TRj6JZP4MeX/TqN//DaFVZUUP
	3h3qU7C6E/fhbgSdUkQ9ImQNoMq3HA8qCd+EadJp57VJ8STtNhSLEmr2+5LFWGmBNSlxNwWewe6
	x7sw9AHXIcL4jNwTU/PMk5SOioEIqRw8p1LeLgNbvBw5VvAno
X-Google-Smtp-Source: AGHT+IED6zp0Am/YixQ0vvtVvueXLlVmAkcXvq+lCwAkJwApc+22gSEPafj6KkGKD/+2e61wHQaGQBVbd6bL
X-Received: by 2002:a05:6870:9626:b0:277:eac5:c344 with SMTP id 586e51a60fabf-28ccb816848mr4656976fac.19.1729718151930;
        Wed, 23 Oct 2024 14:15:51 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-28c7941edf7sm331173fac.38.2024.10.23.14.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 14:15:51 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E1BEB3400E6;
	Wed, 23 Oct 2024 15:15:49 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id CD110E4134A; Wed, 23 Oct 2024 15:15:49 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Christoph Hellwig <hch@lst.de>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	Xinyu Zhang <xizhang@purestorage.com>
Subject: [PATCH] block: fix sanity checks in blk_rq_map_user_bvec
Date: Wed, 23 Oct 2024 15:15:19 -0600
Message-Id: <20241023211519.4177873-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xinyu Zhang <xizhang@purestorage.com>

blk_rq_map_user_bvec contains a check bytes + bv->bv_len > nr_iter which
causes unnecessary failures in NVMe passthrough I/O, reproducible as
follows:

- register a 2 page, page-aligned buffer against a ring
- use that buffer to do a 1 page io_uring NVMe passthrough read

The second (i = 1) iteration of the loop in blk_rq_map_user_bvec will
then have nr_iter == 1 page, bytes == 1 page, bv->bv_len == 1 page, so
the check bytes + bv->bv_len > nr_iter will succeed, causing the I/O to
fail. This failure is unnecessary, as when the check succeeds, it means
we've checked the entire buffer that will be used by the request - i.e.
blk_rq_map_user_bvec should complete successfully. Therefore, terminate
the loop early and return successfully when the check bytes + bv->bv_len
> nr_iter succeeds.

While we're at it, also remove the check that all segments in the bvec
are single-page. While this seems to be true for all users of the
function, it doesn't appear to be required anywhere downstream.

Signed-off-by: Xinyu Zhang <xizhang@purestorage.com>
Co-developed-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 block/blk-map.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 0e1167b23934..6ef2ec1f7d78 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -600,9 +600,7 @@ static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
 		if (nsegs >= nr_segs || bytes > UINT_MAX - bv->bv_len)
 			goto put_bio;
 		if (bytes + bv->bv_len > nr_iter)
-			goto put_bio;
-		if (bv->bv_offset + bv->bv_len > PAGE_SIZE)
-			goto put_bio;
+			break;
 
 		nsegs++;
 		bytes += bv->bv_len;

base-commit: d165768847839f8d1ae5f8081ecc018a190d50e8
-- 
2.34.1

