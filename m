Received: from mail-dl1-f97.google.com (mail-dl1-f97.google.com [74.125.82.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86D3D5677
	for <linux-block@vger.kernel.org>; Fri,  3 Apr 2026 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245285; cv=none; b=if8bfFpxsGV7wlodWlwGaIERQPT8ZG2p2pukAW6NSEEp8zOEo6Oc44xAYRDYnHCXRfTSjqt/XuzGd/5wyGdAhIuHv/UetskeQ2eGnE0wM/xSeLnq304vWznCDexn6U0hmxulmXfHXhDdHNMiXHggskHgI/JxQgOiTrIutIZI8mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245285; c=relaxed/simple;
	bh=6guigZtakqC5pvuDbptKgaqm6++svhWNI/4P7FQdOpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWQFptotzAoYFcjQ0rNXchjaZZ9lFZmZJD22lKmYpQwzQA6xqtcVsS2x0FGKa8Sjd0W7cr8d3irRe2aWR0WOoTNjku2jL40UMm7cqwcCYBx5VAyd0yHvhIjb47XidyCBOQyzMM0+SVdB8BamgdzQsTecZ2vAO9HmiZ212ERCBn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=W3GRVnJA; arc=none smtp.client-ip=74.125.82.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="W3GRVnJA"
Received: by mail-dl1-f97.google.com with SMTP id a92af1059eb24-124b07e5fe4so74021c88.3
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2026 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775245282; x=1775850082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5n7eMwAf8ARSdCe/bC94DhqCdtLVwx2F31J3F2H4e4=;
        b=W3GRVnJAV+88NGTdK1YaoDuXShp6cW/1gloZhDOSAJUahZ0CQw/tcrbUXrHuR+n4//
         VBo7wwIemJ9vuXs0lhr+pZxRDYk8iOsd3wBTk/Jrfs0nc5msQLeUrxlmNjr3N6Y65Rb/
         ONqXfOtsCDm+22UfgtjyQIVrnnwOUHyeW/TLokpgSTsujHpkUQpgfjnSn1B+AiYWerm+
         D8vaXTwvlHyzL5Sz+6VjF3PVP3hlrdj9PReH7KTuCuHQbq3BxyvbnYK2pJaZeab4FfpY
         RRM0ZCnedorRkquh7Y18SaZh3DqHfyy15c7H1dxrFa56GCntKjCmNheZ3Rh0LhUJTHoJ
         waqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775245282; x=1775850082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L5n7eMwAf8ARSdCe/bC94DhqCdtLVwx2F31J3F2H4e4=;
        b=a21APYR5cyUrAzz4hPvay/9sQHvZL3DP9fsQWF/jSJp4oHhfFj4Ftw/aWhb8eJJ4BL
         k3xEzWPtb5AVu8SkqP+GLHKAvkuDulqUvu3XMGSA4kq8CbOWYjKewgXTbSgWQhoyM+L6
         DnMxGa42SC6+Kqn1E9TFDZMJe8R1vgVaTnUOXOM1JxU/qAf4ERmw3B10a1fTMgy6fHRT
         8BzE5zDYliDBuiC+Au+/wFyWUXC26QrRxjp1SWcVplLvMa0fxf0Gnq9UVFzfheqbq5eg
         zdFQRzqn/hI3cMdheEgLvE9CpVQo1HyA7TT+hFyb/AZqMAOLQ8qQZZz3/wmK75Fz/UaS
         99RA==
X-Gm-Message-State: AOJu0Yxyfl9xSdvy/gDN3A4tFSIF3Zsl+vd+x3p8JzxL+6bijYo0lSnB
	KkF4Ci56cbXJvrcbM7XB+lDH2Pi8pwQifdd3v19SqS4pkSrYAyN9vPh/oRcgfj54Jqyi/tj/pKN
	Z5bpoGUHydKv/iROYPdvCuO3K/j9cnhWAuQLB
X-Gm-Gg: AeBDieurg/NTnY7I6xXTZC6OLFqm7q2xWs8twXE8XVN7WlBewCjZDLfMwSThueoLxpp
	ltyqWhPODjRaPuzna88F03UtRfTKJQuEx4wx2j77XLAaQ3ZgdOeoKDLG6evtrdIFSaaUflUq8rG
	rM7VghjbW4EPulENdBMXEXKgSQ/ayL8UXDUsHN55689xUAdFT52ZiEB+M15pKOiwcTV2nsNvazA
	AT1hKaBtbrI3PBE+iPQqVAoRZjes/02vGGN7KyJbbO3F4xbV58LOsR+3RbrLOP/ppH3EiCY0Zjd
	FdZZN3JN6WrlZ92W4F/uSu5XqplK3q+YJuEhFyJmOaPwr38dEtbeWxmbEgdpT5RRdseOmyAaKO0
	atNcLcbBcQRBLO01T3D0QALuDRkqj9gO3THHN+48nptfxLFQP1djfQA==
X-Received: by 2002:a05:7300:4347:b0:2c0:c961:4b98 with SMTP id 5a478bee46e88-2cbfc85e0eemr888275eec.7.1775245281557;
        Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2ca7b9037b5sm474222eec.17.2026.04.03.12.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id ABDFF34071E;
	Fri,  3 Apr 2026 13:41:20 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A21A2E41AC2; Fri,  3 Apr 2026 13:41:20 -0600 (MDT)
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
Subject: [PATCH 1/6] blk-integrity: take sector_t in bio_integrity_intervals()
Date: Fri,  3 Apr 2026 13:41:04 -0600
Message-ID: <20260403194109.2255933-2-csander@purestorage.com>
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

To allow bio_integrity_intervals() to convert an absolute sector_t to an
absolute integrity interval, change its argument type to sector_t and
its return type to u64.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/blk-integrity.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index b1b530613c34..2e366f03a3d8 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -64,21 +64,21 @@ queue_max_integrity_segments(const struct request_queue *q)
 {
 	return q->limits.max_integrity_segments;
 }
 
 /**
- * bio_integrity_intervals - Return number of integrity intervals for a bio
+ * bio_integrity_intervals - Convert sectors to integrity intervals
  * @bi:		blk_integrity profile for device
- * @sectors:	Size of the bio in 512-byte sectors
+ * @sectors:	Number of 512-byte sectors
  *
  * Description: The block layer calculates everything in 512 byte
  * sectors but integrity metadata is done in terms of the data integrity
  * interval size of the storage device.  Convert the block layer sectors
  * to the appropriate number of integrity intervals.
  */
-static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
-						   unsigned int sectors)
+static inline u64 bio_integrity_intervals(struct blk_integrity *bi,
+					  sector_t sectors)
 {
 	return sectors >> (bi->interval_exp - 9);
 }
 
 static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
@@ -151,12 +151,12 @@ static inline unsigned short
 queue_max_integrity_segments(const struct request_queue *q)
 {
 	return 0;
 }
 
-static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
-						   unsigned int sectors)
+static inline u64 bio_integrity_intervals(struct blk_integrity *bi,
+					  sector_t sectors)
 {
 	return 0;
 }
 
 static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
-- 
2.45.2

