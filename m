Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795169896;
	b=kKHSpPNhwMAEnby8d25iU7GtI1KMyw9kBJsV2GtL2POeV39fT3KZaRIXavjty3BSc7bQ
	 7jVmPFwYEGAHEFvEvRdL4SK/hoOMt/PQ0GlPKrMJjY/MUQzDa9XQTq/gPBzn+thAPfKWB
	 EI5ELMPwJ7C5XhwpR1dTkeqjMy1Bu1RaqvK4TBc38xxuhqhvJINZybfxzmNa5XwBJn9Oc
	 VuPH/5UaCj8y8PJc8tozUYBa4+5Tfz5b8qrcnChpvA9cp6icmSAHHegIGQJrOhUvzQkkJ
	 ton/HbR7sseDNeXe9EQaGts3zrb0UvE5Exe1FhYWw7KNbL6evxgWDuZ9MWbFiXNW9MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795169896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0840EDq5sPqsJHKgUXXcqS6nB05CdxuLpexyxuNzBmU=;
	b=DGDeIte4koZ8BEWeUlkJzBkTXlXsoHqRO9viAQ7HTZCbHWFBHlVod1tzltOfEpKCCmVB
	 DD7xH2AlB5xdwqXdF1BJVl2vQ/uDucar0YAq4V7DLzjPd6YaO+c8WY+fmUqfbjeXN2QCE
	 9CEFnPKxS8m5YySEoyjfVC/Upw4qk7eG1FEvCsjqjSzzb2FPcv3Wp7JrAidkBZn2flEyZ
	 jLwLZyaGFRW0jow9caMHZz9ggCs3wUfKXJyuhD2F76bnxdH1rKTXMzJ0GRhHyj2tIB+/t
	 6ioHBidjXg7tiA8y3TsIucsaw/URsWgePMR2NHxtTfWQrDG6snABo4pMSZ+KsddO0wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0UWDzhBg;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA8F606A330
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 10:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAA8F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0UWDzhBg
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36f936424f2so179097eec.1
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 02:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795169895; x=1795774695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0840EDq5sPqsJHKgUXXcqS6nB05CdxuLpexyxuNzBmU=;
        b=0UWDzhBgiZt5U/3N4EeZci/JkWF9eKwGJXsAHn33Vkruk3qem1UHqvfcGP6nWBvInq
         BdCARVy8qG6wx2oPff/jAo/jp2sEbNZLdW+aiXFbEcQvb+2WEqXLeca3fkfqaEXKAl5n
         lrgbH9EcwYkxXzc9HMRgG7npL0l+MYg5mlUyrqhOj3eUmlzNEcy7ln+bAP6DfG+rwxQU
         dsO1QW0R8k0RfLSX8CSqHIqkiai9v1pDGS9vIm2NPVZof7kmQaUntowQ99KIIV3Dqesi
         diGgYheEaF+iqiezAvbSE5xWM5zNHf3jCQGh4t/IW7lxv6XFNtuqqnqqO9UlxRCX7oQl
         s24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795169895; x=1795774695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0840EDq5sPqsJHKgUXXcqS6nB05CdxuLpexyxuNzBmU=;
        b=cWogO/Th1AOGlV6ofLu3M0jYHfp7S11rR1s49ldCe2N/Il2UodttOCOUn2bUsOukWD
         LLcw+b7XtJXTUYqLO7z+DxxuFqzggbPdhbP8SEQXQw0qqTVj7suhWu1VL93SFXIO5R1C
         hjRW0h7BUBmnxm3XJ5yAAoqPobx8DrEzRyqt1qavV+S63iIZXalS4NAEHOw0v429/y95
         +crhVwfmbaEYM8CINL4Fj2pOkTYKabgwVMcD+JX/8dexftvCkV6anzjs95aPsPLQ2BFp
         pFZr45ZG8R3XdWX7LuJC5rbH97tXj/0U0o45DHQOqrGCmLfvosTZugaQRDTU1C05MMow
         sHTQ==
X-Forwarded-Encrypted: i=1; AL+hErEO3HBV+UbxQUfdk78iLog1G8kYq4NDStmmRrWtkIm7sasLvt/ssgLGOGnoTn2RD7vr315w0QSGrddj1w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8UOLjQulV5eXyV77fu9yIJvdHYeVu1W38MvZ6cqKLhwOkdiney
	EeylHqjN1pu9WVepSfrjtLRfcoA3uKCQ187oMa8exLrfd1D+lVNQQGvf
X-Gm-Gg: AYBFou2TY4BpNdGcv8m0wfMIZlAY5+KlSau5H3EVXmX1XxKwXVhsklptrUyepmlTos4
	XmsETpnJTLxWh2ojeDmB+eJq9XbFWaQF3j7lTODZ2vAa1t9DaQ3sDUI7n60/qmjTWhivCW+orvC
	p/lSs8k7cm6NWPzxSAzKwmdRFI+dMA7pseKwjvQjDIOsFusa4EWHyQ9CF4mBlCDL2ORqOThmVjV
	JOULS9J2yqGxctNovva+4iTnxT2ZRXnH4jaF+0IJkwVDb/dR1mPUVB+XzsMefsbPZaG+EaWFd6R
	ARG5zT6pafSHiPMmuZ0FqPqUNV3ZOp99hh5bBWlxeuv2jetc0bbGzPnKrI7d/jdBgjCu7H/IZGi
	tNYib3eeVkI8mzYIa4QuULNeHVkeR0RpbdXF35cPPBZuN6uQPhgihrGSjfGRqmofVlO+DhQec1G
	cf0FIvxJgfOLTGUejAxtzsNeIbAm6gvWvKXNr8qQ4R2SbovAb2cpzQxVTW9b7tEfXe8dDYQk0R7
	aFzHpK0UvFUGrUHDZGmeXHgSSJv5owTrkfg36nDLM641o5AYRTL1Fu2kvkx9Q+YEU+PAVFyQU8k
	O2pqIFpUkBIp3elF5pvQ2mFXgcXhGWylTudE8HHOkNMIu0kz1dALH0UG4nEJYZv3TKZasy+VvR6
	/X+a6qS5gjJVbQlQNIgKHEeXYzHY5A8UlPQmP2Q==
X-Received: by 2002:a05:701b:2901:b0:143:3c9f:10a6 with SMTP id a92af1059eb24-1b5567b315cmr2415345c88.4.1795169894971;
        Fri, 20 Nov 2026 02:18:14 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm5905170c88.15.2026.11.20.02.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:18:14 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: axboe@kernel.dk
Cc: hch@infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	mtsai@redhat.com,
	stable@vger.kernel.org,
	dennylin0707@gmail.com,
	hch@lst.de
Subject: [PATCH v4] block: fix discard alignment for non-power-of-two granularities
Date: Fri, 20 Nov 2026 10:17:58 +0000
Message-ID: <20261120101758.45513-1-dennylin0707@gmail.com>
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

bio_discard_limit() uses round_up() and round_down(), which require a
power-of-two alignment. However, discard_granularity need not be a power
of two. For example, dm-thin supports data block sizes that are arbitrary
multiples of 64 KiB and advertises the block size as its granularity.

With a 192 KiB granularity, discarding one complete block at offset
384 KiB is split into 128 KiB and 64 KiB bios. Neither covers a complete
thin block, so dm-thin ignores both and the mapping remains allocated.

Use div_u64_rem() to find the starting sector's remainder without
modifying the sector. Round the maximum bio size down with rounddown()
and subtract the remainder so that the next bio starts on a granularity
boundary. This handles non-power-of-two granularities and avoids a small
initial bio when a large discard starts at an unaligned sector.

When discard is unsupported or disabled, discard_granularity can be zero.
Return BIO_MAX_SECTORS in that case so the existing bio submission checks
can handle unsupported discard requests without dividing by zero.

Fixes: 9b15d109a6b2 ("block: improve discard bio alignment in __blkdev_issue_discard()")
Reported-by: Ming-Hung Tsai <mtsai@redhat.com>
Link: https://lore.kernel.org/r/CALjSBEvjbiGDVewuapWKhGDtaxZwcn4=22raUiBEOyj22rY7-g@mail.gmail.com
Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v4:
- Add Christoph Hellwig's Reviewed-by.

v3: https://lore.kernel.org/r/20261103185909.71843-1-dennylin0707@gmail.com

Changes in v3:
- Use div_u64_rem() instead of sector_div(), as suggested by Christoph
  Hellwig, so the input sector is not modified.
- Subtract the starting-sector remainder from the rounded maximum size
  instead of emitting a short initial bio, following Christoph's proposal.
- Include <linux/math64.h> explicitly and retain v2's zero-granularity guard.

Changes in v2:
- Handle zero discard_granularity before dividing. Leave unsupported
  discard handling to the bio submission path.

v2: https://lore.kernel.org/r/20261026195131.46699-1-dennylin0707@gmail.com

 block/blk-lib.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 688bc67cbf7..e98aa483707 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -3,6 +3,7 @@
  * Functions related to generic helpers functions
  */
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
@@ -13,26 +14,25 @@
 static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
 {
 	unsigned int discard_granularity = bdev_discard_granularity(bdev);
-	sector_t granularity_aligned_sector;
+	u32 unaligned_sectors;
+
+	if (!discard_granularity)
+		return BIO_MAX_SECTORS;
 
 	if (bdev_is_partition(bdev))
 		sector += bdev->bd_start_sect;
 
-	granularity_aligned_sector =
-		round_up(sector, discard_granularity >> SECTOR_SHIFT);
-
-	/*
-	 * Make sure subsequent bios start aligned to the discard granularity if
-	 * it needs to be split.
-	 */
-	if (granularity_aligned_sector != sector)
-		return granularity_aligned_sector - sector;
-
 	/*
-	 * Align the bio size to the discard granularity to make splitting the bio
-	 * at discard granularity boundaries easier in the driver if needed.
+	 * Align the bio size to the discard granularity to make splitting the
+	 * bio at discard granularity boundaries easier in the driver if needed.
+	 *
+	 * If the current sector is not aligned, shorten the range so that the
+	 * next one is aligned.
 	 */
-	return round_down(BIO_MAX_SIZE, discard_granularity) >> SECTOR_SHIFT;
+	div_u64_rem(sector, discard_granularity >> SECTOR_SHIFT,
+		    &unaligned_sectors);
+	return (rounddown(BIO_MAX_SIZE, discard_granularity) >> SECTOR_SHIFT) -
+		unaligned_sectors;
 }
 
 struct bio *blk_alloc_discard_bio(struct block_device *bdev,

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.50.1 (Apple Git-155)

