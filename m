Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEAD40DFC1
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942675; cv=none; b=YswZxw+TWULwN8xee1UCzgsklByLJNc4/DzdP/5iAZqWNVOUIwzwpH2ciWNyWgqvceMecKQPWyfMrKM2FbPQ+10gZBeiQtR3299gKHX+L1GbMdOI9IG2yLy6tPnaO8J3pPnFUYWpJ+ENnFH6rMy5dSNwffr0rFSOhjL7EdXmJWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942675; c=relaxed/simple;
	bh=qozmCTyu5c3kxrtUp3C8lzwt5tW3H/XV91k4RrhW7F4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AaTuMt6tYM1M6ZyGtu6dDi4s2Xd7oI68oXpzpAwx9c1t2M8EE9wzvKl2YDOANZTNSmaoOhT2DpdCktDpCfEnOm5vgaQwuPYr1/GWW4rd373Nh7q+KWIEqWOt+GSUowE/NJXpB0TlNgvXnQHkEmDRhUcZWZkNG+n3TN/wHBGYXOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WPDCNXst; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WPDCNXst"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ad21f437eeso35692695ad.0
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 00:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774942674; x=1775547474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qge3MorNS1YgycDNr3wmwHALhVcOGjEeMYPPOcQMBh8=;
        b=WPDCNXstYWtN5qbA4QeOWuCS7fDAkP+D9FPnjaIJ0PjnXW+B/ipZGc9pKvgJ39UH8G
         tytyRD3tUazCU4FLwCF31TBvpz5JbSTmpwW6cyMMX2C15LtIb8vrNy99RzR43/ixS5Qe
         RN0DeCa/qmwMqDvGOGeNDHOnc2kR3QAtwYMjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774942674; x=1775547474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qge3MorNS1YgycDNr3wmwHALhVcOGjEeMYPPOcQMBh8=;
        b=RLfmTBAMe770ZfhREpM8ss8IYa1Ie6EXvSPzwZ8O2SLLVnr75oeitAJV6QkUaOeZ8Y
         jEmGDB/ht4DbhjPoFRorQjtRXemGD4Kvz4pNoZdmQRMWShHf1y9cVPXhsPG9F+rzirPM
         onwKCZzW0yd/tuBw5JkraURYtPomIgX6oq6/f17fPFZWvRs7GE/Q3IUStnr8xkK/SeCv
         QNnkF+iDm1DN/Rj5Ry77aceT0GVHEDyJQw5h8K6Phr+pIGmqX+kPS3bKvxWBXF7Wf1iR
         TxgDU6Z1P0W4ITeI92qdpnmmlWhUrF5NwlSk/bF1NAcggE0PFpim1e9O2bikXLWgVHxs
         V/Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVLjg30I/128EMOKgysSbCp6eF8+jnILO05qnLzvBZ2cC/tGiTiprH8/1ok/PDpLzhIRSjd9Yx+oMw3DQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8AbopZQo1xZ6MLF0cAyiIxPJOhqYSRyd0PTn0MyVazD4LgL2Z
	BGIqTWpuY4x70PUtMuBZq+ETzDrURfrwQvspgZ+NmdOgQSp+tNZyKcJ95753mSCq6w==
X-Gm-Gg: ATEYQzztFcSeruIsBmfYUHXz9dNKukR+eOZ8oS8yFT3JsCEFvILx/MxU2U5PdS2qaxl
	u6COWAZgULcF0lReJo16Z1V0zSkdrT5UMAnwkrHf/Ifg9m783nqCLrtELfvjMUORLfTk3zJv9JF
	TJwQAVDTWihoneqpRsxcWN2aR3syLzhXGrprowk7JdEWYhYM2TBkcCnagYWdgRrOFv1fgA9dJ6N
	qlma5TJjkVAFwUjaFxxMFw1w6Ix+LnKb6kq2h/qOF5kHIGYm6iQfOAkWeLpTRQHzS1r9iTtiSOP
	FK0tk6M2xwQuKpmKV99RWLnxTFkcR5vyKbtbrWm0aL9G5MtTzZKOD9q2JuF1QFHfabT3FPd9D1R
	nFhZ4Z0Sd4ZXQSDEBpLYL6wxcWwyfKi2RRqLwPp+BwlVndenx6a3W33doaFTqlLSh2/FXR64juF
	V89Nijf7/MCnb55FjTQgBvCD/Ka2e06LalG9dr3pL5pDr3WjQUl1y96gA87GuiJI1QkCgjsX+yS
	DuABUt4orbHrA==
X-Received: by 2002:a17:903:32c2:b0:2aa:e47d:e3b with SMTP id d9443c01a7336-2b25ed654ecmr25933655ad.0.1774942673664;
        Tue, 31 Mar 2026 00:37:53 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:90ef:61f3:1679:56f5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76916bd67dsm7848596a12.3.2026.03.31.00.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:37:53 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Qu Wenruo <wqu@suse.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] zram: do not forget to endio for partial discard requests
Date: Tue, 31 Mar 2026 16:35:34 +0900
Message-ID: <20260331073737.774503-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported by Qu Wenruo, the following

 getconf PAGESIZE
 65536
 blkdiscard -p 4k /dev/zram0

takes literally forever to complete.  zram doesn't support
partial discards and just returns immediately w/o doing any
discard work in such cases.  The problem is that we forget
to endio on our way out, so blkdiscard sleeps forever in
submit_bio_wait().  Fix this by adding a missing bio_endio()
call.

Fixes: 0120dd6e4e202 ("zram: make zram_bio_discard more self-contained")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reported-by: Qu Wenruo <wqu@suse.com>
Closes: https://lore.kernel.org/linux-block/92361cd3-fb8b-482e-bc89-15ff1acb9a59@suse.com
Test-by: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
---

v1->v2:
- use goto end_bio (Christoph)

 drivers/block/zram/zram_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index dcea703a6766..aca67d7144e4 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2684,7 +2684,7 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
 	 */
 	if (offset) {
 		if (n <= (PAGE_SIZE - offset))
-			return;
+			goto end_bio;
 
 		n -= (PAGE_SIZE - offset);
 		index++;
@@ -2699,6 +2699,7 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
 		n -= PAGE_SIZE;
 	}
 
+end_bio:
 	bio_endio(bio);
 }
 
-- 
2.53.0.1018.g2bb0e51243-goog

