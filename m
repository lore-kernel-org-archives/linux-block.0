Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2563D6474
	for <linux-block@vger.kernel.org>; Fri,  3 Apr 2026 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245286; cv=none; b=GP6YzKJuGCLfNVldyH/IY4IL2KVk6VteVDARj7Tj5BQ1vSdKETs5t0qHNRJ62sQ5VMe+ZqbME3HMLpKphwP31cN+hGf/gV+vAqPU7711+2rLYAGx1MZF8xVJI4Me8AO9ZNPVvzLw2xkyc/rsyrw+/MzLvuGlg3aerd6n4HtkQXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245286; c=relaxed/simple;
	bh=YYGrwQRz4CUpiS0HafIif2tS+tWh36dIqKCheejEgg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fv2SaAlNHjGhNcbHV2gNcEd2JAblXpn4Sh9LkuXEJQXNvgGFRRiMYtNSbFed2tNQwPqLcHDaHFlb0VovHYvZn0LBbw8daTJt82+0gtIxPts4l7ilb5Z7KLDJ1uEo91/6owvCEdMtIlcrL+gMS7nBViAUVsXZ1ni78hUmdXsk8Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=edYt1hND; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="edYt1hND"
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-7d7cc688861so357273a34.3
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2026 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775245282; x=1775850082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otX1Hqc0T9DvgqLYhcqiRNaRpAdPxblh5+E7UixGoPQ=;
        b=edYt1hNDxW0OYL+t0VGIvgcz9lgtpWhSdGkrNqD6MAGIbJlLEV2Zkj96at8Pq8uzJS
         OGWTPrIO+MmuobdFI++4h7RrDnFKtAW20d++l1nyyGwywqipRDIkeektWcyC4PA+X69L
         TUHYXuqomlQWPDRYYgZ3XoOYG/cHQLxZ1WcLgTpMglKqI2raIdmHSMVptMWq8dH7WBoC
         ZrI+G/isek5bv0yB1pbwzgMMbNx2qdteumh9lnEYBouU/V5WdhH75JXJ06XHAeZD8GiL
         5xeJwt/x0CbzM6xV60SrbfuhammflPrR2wU/TQDon4Dy1g5Ws9pBTSDZyTxtGTr7wRuK
         8f/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775245282; x=1775850082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=otX1Hqc0T9DvgqLYhcqiRNaRpAdPxblh5+E7UixGoPQ=;
        b=XHRjQFjR9lRiQOM7en7V0owCugqXAhJOTCLNtOedSPFiDWDavkAExInjnxWIFCdtWJ
         aQ0fGxrxitZBQdmznKG4scAnA3TRqaG4mvkalFP3a2ee5jsVQMc9AnBAYaMc8r3O2Cc7
         FwZlOvgjTV7tRMFf2IspZ3nYydV56hNMCQ+Jt9HX5AVa8sBhCWQg5l2xLRTdWESZcE6o
         Cme+u6UEWUn/iYrg9KUwzNqbZuutXDtWAQVgIC+CPSHjoOMHkPQuJicOlvvKSPsHsElr
         nZR1AzHxDAJ/QEaPvyBQiQNFvFPAq4l1QEHaZmynXiAPkLQE7yqyjdjq64llxj19ArId
         vPEg==
X-Gm-Message-State: AOJu0YypJsYcphnIh2Taa1NTpLIR80xR0br1YU9yjdTh4lu6sW/0FaLY
	R5aEU4cLu/eZ01Au7A1EbhE4MpqBizb615oyUc1VgRCC0u+2H2YnkOdqtkBzYGI3v+Yxv/ixEOl
	5bsa8bqfgShBW15M8yT/urzyaV0+4/WhkhzT0
X-Gm-Gg: ATEYQzylZ35wiDwpl2AMrz3cTI+z2PHFGomhX8zOWcDGtzeKBS45Jp549YiqLA7sfZf
	9HVCIc5GqGsyB+eBpEXMv86xz2C67FZ7Rmq0LVZWbbMCOlJfi7RJgOis8jNhmpGgKMYEa23n+nt
	y805N+X0Rw6nG9/rRkHpfq1f4KVGjmSBYKy8QcgEfHOaeRfFjLeYNXjXU8Ez2V0xvuv4PXXfUB7
	3HP5xCjZYMF8BGl8vLXp+mUfuWg78gb2nxwFI1jOo5Y8hCSBERNaFU7y67EQDo6YOD2SeenCvmx
	gKhiImawsbYjdT+M75dzY0Jj1d9Ba+otcXF0aP5JGubnqCDKhU3Aocg3b8dmmms2OXclSmh97xq
	BaqX7e4PszcP6PdyX5lh7H5095O8vlomxXdOlGNnD7WwRKKnCS0G5yA==
X-Received: by 2002:a05:6830:25cc:b0:7d7:ce56:b93 with SMTP id 46e09a7af769-7dbb72f247cmr1794595a34.1.1775245281603;
        Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7dba72d7182sm505129a34.7.2026.04.03.12.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 31F7C3422E1;
	Fri,  3 Apr 2026 13:41:21 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 27E8FE41AC2; Fri,  3 Apr 2026 13:41:21 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 4/6] bio-integrity-fs: use integrity interval instead of sector as seed
Date: Fri,  3 Apr 2026 13:41:07 -0600
Message-ID: <20260403194109.2255933-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260403194109.2255933-1-csander@purestorage.com>
References: <20260403194109.2255933-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bip_iter.bi_sector is meant to be in units of integrity intervals rather
than 512-byte sectors. bio_integrity_verify() doesn't actually use it
currently (it uses the passed in struct bvec_iter's bi_sector instead).
But let's set it to the expected value for consistency.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/bio-integrity-fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
index 389372803b38..5d1b0e33fc5f 100644
--- a/block/bio-integrity-fs.c
+++ b/block/bio-integrity-fs.c
@@ -62,11 +62,11 @@ int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
 	 *
 	 * This is for use in the submitter after the driver is done with the
 	 * bio.  Requires the submitter to remember the sector and the size.
 	 */
 	memset(&bip->bip_iter, 0, sizeof(bip->bip_iter));
-	bip->bip_iter.bi_sector = sector;
+	bip->bip_iter.bi_sector = bio_integrity_intervals(bi, sector);
 	bip->bip_iter.bi_size = bio_integrity_bytes(bi, size >> SECTOR_SHIFT);
 	return blk_status_to_errno(bio_integrity_verify(bio, &data_iter));
 }
 
 static int __init fs_bio_integrity_init(void)
-- 
2.45.2

