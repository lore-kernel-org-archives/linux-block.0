Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8271F2DCF58
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 01:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776391069; cv=none; b=qwh5tDpnppWUT88tOKJ4+GMmos82bjSaf0HkdkdhrqRNI3rMrT/IyeAC3tGhos+0CDOkRVJmUesiMEAtlW0K/izQcSXgBroZUSabT9Dl7aIu51m1kXTioMReo3/1iDA+KTkwPozChdR02xmkMQp/Xz4hqpB0TQybmR+rHnWx85E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776391069; c=relaxed/simple;
	bh=fhgMAHy09LsI1L6bahd3pmbOSSyNApfMWjie8uHGN74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqoSbU6kqKESIC/NiJWUBFnAbBjeYazRp3NSfyoM5slK2TS9jNXDUMV9D78t3/9fr//odiT1B0m1lh8Q85hbHiBt+w+Eb4HAzvx1qUX+ZE0x9AVXJqdQSoGCBTRpZUB4xTQTfkB6DkKHb0WyWVB5A1CuvQKzo6OIF7y+S1eIV8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WcXV0ODh; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WcXV0ODh"
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-8d5e1ca50ddso5144285a.3
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 18:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776391061; x=1776995861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNTSjciFlX9Rr/279QUaN+sXA97OE3S8NKaAWj6D0d0=;
        b=WcXV0ODhPgZRhhFcuKI/SlGxMpU9IB9Qat1jFXkv3DIO4HdS/16t6whB1jhXzXQdJ4
         gP8Bn2lZqv7KO0XYceQPW+TRMlVLKjV7yPj/oi3npgktWRjn8Ore6pxWltWu+eQVwbgK
         6rpFIf7/a7/C+F+Thaguc9F1Jbp/MgwNbtkyGZyZ1fy8ttgzwvUOy0D6BPOR+0uowNUp
         /kA3AGSZFtX51JQir926dqj4X3O+Cb4x+W8NiU/lfYe9XIu8Uax52ye4Lo8NNLVj8kt5
         SRt+dcmT0lB0HrLYSWHHTUSdHkcp39LRKPT01jtYQ8R+reI3jp51/djtc2UEbRwTgx7u
         UqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776391061; x=1776995861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MNTSjciFlX9Rr/279QUaN+sXA97OE3S8NKaAWj6D0d0=;
        b=Dyq2icA2wzJ4XFAoTlJ5iCjG5krtqo8rHd5QEiSMxM93AbLEV3UO4EMQy5YPaGGR1o
         fB/nbJByIljwoWv/R4vu/uTcJbG1YB/5wtGJrVgJSXSVPKZpL8WlvFtBVUQvYQX3phJw
         15tS0vMMepZd1e8RX1ZrPebYw5Pj3H4v8nrVuEF0j1F0HnPTyv21Jp0ENnge7+NyrBgO
         ODMN1d5j4MZTVK85gVTJ3pJBEfaFx5JhNhd2ccblGwjrBpo/S0qxS5HvSEIy903I/sEz
         g+QDaCnXaQ4tAUmD75LHuymemloawv03LtDI3CsENqyJsXAkw/IyGPu94waMEcZeKBeF
         UXwQ==
X-Forwarded-Encrypted: i=1; AFNElJ89EuafBb0WswEpDfv667n2gR7aFe0+fY9eNc+upssl4kOek4DbDHcRnjYXRL1CXu5PBXmSFNQF4VZQpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+SA1zet9UBlrBC4niy/ksdblCw/zkh+Q/csqaknC0W6j4NPJO
	mpJbUwTgVQ4e1QQ8RtCJOWH//UrEwUjEtO3HlJPD58fBTWtqg1XvS9AZ+7YIz1nSZhAAiLhj/y3
	0L3lbTUim4hL9JZuwtNj8vjxEvsYL6v4p1YJl76jCcxPeVBr3euh5
X-Gm-Gg: AeBDiev6BNCqN+NuM/7jcjLxtQ+XMG7s+pVRaTQoSH71eM8H+o2BbPwjiNJHGrrgSPd
	SsE+ljeSRRbvja94a5/pmb7HnqxGduflpmbogkVwr2x/DMxFf6w0IcLuv90vkzujWYqOqLQh9aE
	Wm7yI53inY7fPqn+X4Wr8sODo+8E3KAQtn8y2kUngI8qzu8bZYkFRi/cV2PUVF2oH+X9Xg5U2bJ
	KCE7ASXEzXN+eqpY9cbrxTjhqJVx0lkZQBGLFVTvwrDuViBjKQILMpSvGPCUMSgJkxkBzaIrBaQ
	nZrxs3pVSGhTsHQ5GFSQRsQnELCvLTRtjVCHB98SPNauERSUJM8NoGRu/+wrpbALsNcEwIN2gY7
	jE4AXr0vV7x2JAMZiBynmNzunVHRITj5p9u+zPA7135ZW2yQyLw==
X-Received: by 2002:a05:622a:44a:b0:509:15aa:cf03 with SMTP id d75a77b69052e-50e36c0afcdmr8556161cf.4.1776391060999;
        Thu, 16 Apr 2026 18:57:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50e394581ccsm55631cf.26.2026.04.16.18.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 18:57:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 446ED340C58;
	Thu, 16 Apr 2026 19:57:40 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3FEBEE406BE; Thu, 16 Apr 2026 19:57:40 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 4/6] bio-integrity-fs: use integrity interval instead of sector as seed
Date: Thu, 16 Apr 2026 19:57:30 -0600
Message-ID: <20260417015732.2692434-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260417015732.2692434-1-csander@purestorage.com>
References: <20260417015732.2692434-1-csander@purestorage.com>
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
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity-fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
index 0daa42d9ead7..0ad1c5ab64e9 100644
--- a/block/bio-integrity-fs.c
+++ b/block/bio-integrity-fs.c
@@ -65,11 +65,11 @@ int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
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

