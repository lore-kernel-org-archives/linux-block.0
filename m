Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452047;
	b=c5zlwXP6mf7HHWEHqomprzuUP/4jPUviXh1mxStXrKCkI9ZHHDslW9VRjrIaBSAUwu68
	 PwmxXlx0vUOOecDp2+HQN8DbHnxPJOa28gQPN9uBOz7wWgkh07ZziXp5UHggVBJzD79Ig
	 IOrpcCixrmQmLVceVzLM6Ff4x7kgPRObAo/HdL3Puj+QHY9sEunipk6GRv6hjqhf5H58d
	 cAu+0iKMI6jr1BQBpLTTuKIsrvYu1M2oy4yBEE9dhWLUotRkLCQ7WBzcAwpbPkfHBIFK+
	 5iGOPmSMOJyh8YUnf8WDmlZbpnH3aa9Lhwte3jvMjyMZhDnNdWkD0VGTkiUFtPutA8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P5/ZiEeoOQolEtqZd6duqT2B+ydqubbd46Mv2EwUK7A=;
	b=i7uKDRTV0McEcevZ+5cOhY8hsteL0SrCp+tf3OOWbeegj1iqzbkm73QKZJ+hzPPH+b7c
	 aLy0gqAt2Zn97f+R/iQSvgyLVY5V5ZtMPe6sjagUkP51OCsvzJ99VcKgcffq4TqL+5jkq
	 hNSQUxnx8+vTQzQozEfKykwnzFEUSYvYKl8PbRdAIbGpm1U8PvEX6CCOM65fFwozBXyuu
	 5Qc4bA8VUXAQ2dmb+opRUxo0x43UXJzWAymwZRYL1JuA74AcKFx6+CqPk4pMW2rn5m1SQ
	 x1HurdFY2hWQbditrT0lVjGxyZ4Anln9mIQMMahw4BVFqP8G2+9hy4Rrh4P3Wu/XdTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vbpMdQoi;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4B5606A31A
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 16:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF4B5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vbpMdQoi
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a2af4c8d00so5967960c88.0
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 08:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795452046; x=1796056846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P5/ZiEeoOQolEtqZd6duqT2B+ydqubbd46Mv2EwUK7A=;
        b=vbpMdQoiG9qBH8Tl6U7EVOleFGxsrHTy0mVYXW6H+MRhrHrfwiAVBAdwZayZumctqK
         TjAfKEAnfrjr4j6oEW/cEYCOBj1+AV19XLVfz2mSeSpyi0+JFw8DFQVJXbtbFtagdP0E
         baE/uVWY9vzZstUi/ZpsJ07RzWunWb//7HKrxuNGitcvwHrLPXNwaPmXzMWgE05nLAQl
         sS5QwQMzgs4+UdkcXzbn4Mt8ueUsE5U3xufdoU+dhEZlXnDT4P/6Pgpg9X3SJxrhdr0E
         djNugvM++2GRtA2GnhQMsxjY3VIrtZO8oloUIyWEZKFD/GXznbLz5MwpfhzUqzgwVZ/R
         a8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795452046; x=1796056846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P5/ZiEeoOQolEtqZd6duqT2B+ydqubbd46Mv2EwUK7A=;
        b=noGWklX7QZ6hiGTLPc9q+pQhuDdBZJiCJowKxM/o5yHLtaNYbbTorVaBg8SJSjJqdi
         Nk0coCl1RaSeYUOe/1YmlPNwDCWT1InAtZGRQcq9QoFkStMTXKdL5yw0GiXR3DaM2za9
         2OU3TwlVZkh1w/Ykr1I6k7gCxCxNjNN8Ls/sQ0dUFnxnkP8pmh4aNKUI07J5fO06zuoo
         oKvJJS7nLIYDOSdt6MS5MFTi8njiLH0sorVbRihxjpi412tRdhotAb4aeRwzggSpKniU
         f89LtLFn9xcJNeFa2aoLUMmWqjrA/602NGADRR4bYKxarcUAtJx/DhJ6vdVt95yX4qFK
         SH8w==
X-Forwarded-Encrypted: i=1; AL+hErEfRRqrnPwAfAtgPjXZeK5I6LXI/F1OOYTqZnfOWeFdEitT6FqcEMXRmRKCBs4l0qClJaPfgfzhcY6QEA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8nYe4ZWmL9DMD1c5gBBmWPeHw4ZZTk1azVqCTAtuNR3JdDkSMl
	6r+rDr3ObAD/UcsFKeVBv5f+pYqAZXr8igcGTgyv1eaX4R+Q4EccXm0f
X-Gm-Gg: AZFdTZeBHksWH7l+nA1NGGYRgwkcWxlsO6TH5DaagaBJTkMORpfgbdo1EDFrURkqYIR
	Yw1QfKQguV5joFpvPgDNvXAsnyyAY/gICRf1YC2SWu+jNR0HF00UihR3nHfwLEIHqcS3kQ8ziSg
	DvrJMHmWynfrpB2SXhxXFXlqbRpHsDli0Wvlt4HnLT3EU4UxEdx2AiZjv8Js3znthB6ip1TnRow
	gmZlz1fj71sM88CT7eFscmjLOOLQrzl47JXaW59fgDMh88I73UNRzJ3Ty+INfSNm83MJ0uNY6f3
	KT4jclbHH0OUNLon2eBx1U0sqKHwFb7T6HXgvw+Eiv+7IVCzuB7fXWiZ4+Bigo+839gym3dO6HA
	bKIAcIowivd+kXbHtP4KwZBy1VslegfPnbXyaUlgeSpGZ+2X+KNo3GZEE09deqCTTr7ttHw8u1c
	WM1aeV1L4j33R8t2rPqTJ1IpAvO1/DsJrs1qliEyCLpaY4CXTpaT4cXzfQjirogKto+xKLpNfZ6
	lPrOQvqA6UEviuWgc5o3FYvoEIQ5txWyoH6MtJ9UGzHJMhaUN71lxHJIRzRPf5SbzYQOdlejnJv
	SMOHVZ9SjWuPnoTvir5pgBcWFzgvm5JhpgO2BY+nwGQPhm5Foa5OUFOTuUhHruWuXXg5FvVYb/5
	LWzoIm1um
X-Received: by 2002:a05:701a:844e:20b0:1b5:6c13:c76c with SMTP id a92af1059eb24-1b56c13c7a8mr6689110c88.15.1795452045824;
        Mon, 23 Nov 2026 08:40:45 -0800 (PST)
Received: from lounas.tail428e48.ts.net ([157.131.129.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556847fdasm33225486c88.13.2026.11.23.08.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:40:45 -0800 (PST)
From: Louis Thiery <thiery.louis@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	bmarzins@redhat.com
Cc: ming.lei@redhat.com,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Louis Thiery <thiery.louis@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dm: clear REQ_DM_POLL_LIST on embedded clone bio
Date: Mon, 23 Nov 2026 16:40:21 +0000
Message-ID: <20261123164021.463361-1-thiery.louis@gmail.com>
X-Mailer: git-send-email 2.43.0
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

When a polled bio is split across a target boundary (for example a
dm-striped chunk boundary), dm_split_and_process_bio() re-submits the
trimmed remainder of the original bio and then calls dm_queue_poll_io(),
which sets REQ_DM_POLL_LIST (aliased to REQ_DRV) on the original bio.

When the remainder subsequently enters dm_split_and_process_bio(),
alloc_io() clones it into the embedded io->tio.clone, inheriting
REQ_DM_POLL_LIST. alloc_tio() only clears REQ_DM_POLL_LIST in its else
branch for non-embedded clones, leaving REQ_DRV set on the embedded
clone that polled normal I/O uses.

The leaked REQ_DRV flag is misinterpreted by lower layers. On NVMe
(where REQ_NVME_MPATH is also defined as REQ_DRV), nvme_start_request()
calls nvme_mpath_start_request(). For a single-path namespace where
ns->head->disk is NULL (with CONFIG_NVME_MULTIPATH=y), dereferencing
disk->queue triggers a kernel NULL pointer dereference:

  BUG: kernel NULL pointer dereference, address: 0000000000000050
  RIP: 0010:nvme_mpath_start_request+0x28/0xc0
  Call Trace:
   nvme_prep_rq+0x5e0/0xa90
   nvme_queue_rq+0x40/0x1a0
   __blk_mq_issue_directly+0x45/0xb0
   blk_mq_try_issue_directly+0x85/0x100
   blk_mq_submit_bio+0x6c9/0x710
   submit_bio_noacct_nocheck+0x127/0x330
   blkdev_direct_IO+0x230/0x680

On stacked DM devices, a lower DM layer also sees REQ_DM_POLL_LIST
already set on the incoming clone and treats its bi_private as a dm_io
poll list head.

Move the REQ_DM_POLL_LIST clear out of the else branch in alloc_tio() so
it applies to both embedded and non-embedded clones.

Fixes: b99fdcdc3636 ("dm: support bio polling")
Cc: stable@vger.kernel.org
Signed-off-by: Louis Thiery <thiery.louis@gmail.com>
---
 drivers/md/dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 1881d8611..79972f17f 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -628,13 +628,13 @@ static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
 		if (!clone)
 			return NULL;
 
-		/* REQ_DM_POLL_LIST shouldn't be inherited */
-		clone->bi_opf &= ~REQ_DM_POLL_LIST;
-
 		tio = clone_to_tio(clone);
 		tio->flags = 0; /* also clears DM_TIO_INSIDE_DM_IO */
 	}
 
+	/* REQ_DM_POLL_LIST shouldn't be inherited */
+	clone->bi_opf &= ~REQ_DM_POLL_LIST;
+
 	tio->magic = DM_TIO_MAGIC;
 	tio->io = ci->io;
 	tio->ti = ti;
-- 
2.43.0

