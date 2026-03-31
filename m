Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3926A1B5
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941356; cv=none; b=r1zHMGoaQXdRlRS99ZtLNpQSeqX8QmqMFfrn4cBesGjnJS/jy0rmQldQFnGktm4SwJI05Pm7AhjJ2TTLsQqrp9bf3OKi7+eQ/VVQSQe22EglpLXTIZenhk4Dn0VIDFZORKUhMVP+C9LD28eukEj7UIuML+9taW7yicN1Hfy2bxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941356; c=relaxed/simple;
	bh=vZnqaOKBg5QBXcBcccl4gk4m60ewFLzqNDe1PJUoPe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h/UYVNVcgqH3VHK1gmC7I8eUgjASXgBqH3lDSElSNBCUW/BEejM5648pYEAtjcztN82qGN/6ge4dLC4zwNLfJ8lC8wl/ABKaNv3iHdskR0yUo3/5Jcps3XR+ET/GdZN1nigw9jydu9g08Fmg1LpL0fh9lsCalwNeKyeD19Vkz9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WypDN9AX; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WypDN9AX"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35c238f1063so2651434a91.1
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 00:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774941355; x=1775546155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hBZW9JjlCCiEdLUd24hKtYoeuSUNPJmQ9yAz6YgyHRY=;
        b=WypDN9AXdPut59ImC3rqdckrJyJ3Ygu9bm46qkVxjl+mOXLnWCeQhXvqbpNWDzox+E
         ndiduC2NcQTmTmU4eu2D2Ep/7ggwYYv/RtbAS4lWFAxRbHnhMiYG9q/z98prLajSdywT
         X/1hq4Z9lnpIBWuOyoXlqDQjWfLz2r/wbDPuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774941355; x=1775546155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBZW9JjlCCiEdLUd24hKtYoeuSUNPJmQ9yAz6YgyHRY=;
        b=ObzgFAumSeJhNoVcz6936vFL/pN2Du+kqPQnv7daELg9PcxoiiOwbc1x9m/eY/2ej6
         GGv2A6zY01gAfBZSYksLQ6KyBw70hFN6PBDy3eHgJqc1pQDDyH5hw41qCk85NAiOMG6u
         eUv/ZwAfU/Pa2oTyPWVi3jNzz7MFt8wh8oItnIO8A5s0Q2sevZdmgVI4zJcUJ+XQnQ3g
         yne2L+v4HC5L4XcHJluv+oPKJoASujDqPgAOeu4DLYJCodoO/wn5MiDuX8KrhXcrA0PW
         wLzMs+cmATdz36S7ehMW/+oaRJLsCiItIDPoNqTP01DXeHkYVLXklYYjtyrKcxQiHYfw
         zK+g==
X-Forwarded-Encrypted: i=1; AJvYcCVNW26L4wLQOahbmUQKVDBrsVKr5HpSHptSgIgOAA9Nh7Cv8Sv2kyvtXyTqNlpuOX7dAOJE4vid2jPPbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh46BzMvyJJZ70CBxoH3UWj7SySfjzFuP0NrGs1O2rybZt6rQY
	AlvZpBjmLxa8Ad8tCQz6H3dPPIqWB7GLUjjSLYU3PYxq+h7mRd5rWzdQwQ8D6Ruuxw==
X-Gm-Gg: ATEYQzzBp5PYBJFOwDqxOhaV2ZRGNfdxKmq+3DDcL3QoTxcFMiv0RVOzVpXx2Ka1uC0
	6aZzNpTfFADX+tVwAYfnENn8hWKvzNGXtTGqVM32UuSN7vBBxa8edD6b8GVSLC5ST0iCWI/iOhE
	CBLl71DNY8toZ41gVnnLfjAQNWjoZviibs4k8/BY/EZHLJgicBsqQ0EC+5poOcdF/OadMx9GrYB
	AyWbcsdK4A4MjTcoc9liSF0yHzx13RdkjhhS9JbLF1Wd1wT/b6x+Z8+qDqNeE49qCBxy1FOAiD4
	K05p/aPFBkJoJDQ+pOOhIzjLCSesLbyT0s2eO7cR+G0gHOodPcxs7D/H/wMXP9F3A+5KUTq1hd+
	y71zLbBwqUrRXPZTj8vI59ORbQKWUDNcoQq1YlY9Vu8xBsfOkOoaeUnax8B/en6KSEf+4JpSAif
	CDgbyIRB5KhQ5KyKfd6PcgpMcCvIINJdDKiPXq4tWnCSSju3l8bMZUJ/HwyQY41OywU/kTWgIZx
	KrgklWLd6NwFg==
X-Received: by 2002:a17:90b:3c8a:b0:35b:952c:43b9 with SMTP id 98e67ed59e1d1-35c2ff8b257mr13908581a91.10.1774941354917;
        Tue, 31 Mar 2026 00:15:54 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:90ef:61f3:1679:56f5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbba1daf5sm331975a91.14.2026.03.31.00.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:15:54 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Qu Wenruo <wqu@suse.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] zram: do not forget to endio for partial discard requests
Date: Tue, 31 Mar 2026 16:15:06 +0900
Message-ID: <20260331071537.706139-1-senozhatsky@chromium.org>
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
Cc: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index dcea703a6766..b0637423953b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2683,8 +2683,10 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
 	 * skipping this logical block is appropriate here.
 	 */
 	if (offset) {
-		if (n <= (PAGE_SIZE - offset))
+		if (n <= (PAGE_SIZE - offset)) {
+			bio_endio(bio);
 			return;
+		}
 
 		n -= (PAGE_SIZE - offset);
 		index++;
-- 
2.53.0.1018.g2bb0e51243-goog

