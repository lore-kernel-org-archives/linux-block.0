Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769340;
	b=ZAJSxKSLkz1m2G/d6V2ofHcu4Exht60L84KAAuhGLEDf/Yp5B/zs+wHDXs0bB3scV7m8
	 e9OfMlUv3kYCeFNY2tEildw5uFnM/RjU2lrAmF/2n65Esf07ptjaq6lZAm8BtnmnSp+nk
	 wHoi0p2rHlaKq4XAaOfwTnyrD6ehD3fqDSdmNmrP0h0i5F9AjFFCWaPyytWPyvlvXFNkN
	 PsApCPsWevbvVKY3StyOz2Da51HRzx3tloR2Cv9zhWnqr3xtWUf9FdXRvoSNLpTp6mDg6
	 EHxCCGaUpUKqLsSAy0iAa4l5QKAGkHG5yQHgdPlQnOGypwSmd5oNtEmqo1sxP+StEfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aSulb1ZKSxB82Q0DHVFpLluzjXlQ4n39cXbO7GHm4Hg=;
	b=tkLLdrmxYRvl1DQdiXRbDQd5nk63eEKi73vnM9EXMGOr76qcrC/ZQXgnZ8fFzqkKRId9
	 91e8j1RXTcUXYv/NQGLivwLhjywblexPiTmWMBu/H4rhvm54pN2J9PYjIsdNsREefCioE
	 H7QQlKWYYSAqZkxgZGbCJZp/FEHbPsjtnTDjbLhMmWZW+pq7O+8j+KsJ2vZSRlfdsI19k
	 u44Bkhf8rrbeBfsMmNrd+eWlZSQjh73YS8lowQw9cgjG8r/3I3LUgwKm3WR4r31c+Nfam
	 QcZGQPP4fdmzEXDDrSM/xjjAf59o0rscUhD1DOXIb218l22CDnmsSrgbIgRMiaWnO7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jaXo+qjx;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F21C60A2601
	for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 08:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F21C60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jaXo+qjx
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f05b465cd1so1491085ad.3
        for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 00:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769340; x=1796374140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aSulb1ZKSxB82Q0DHVFpLluzjXlQ4n39cXbO7GHm4Hg=;
        b=jaXo+qjxS4fzoJ1sRQ8Yi81AgRWhimCxet1u+2ypHmWVaS4F6bD4yNr48nufv3HKEd
         pBuvi91xlP2kgry/49Zibz3buJuD3yv+nFgstbLMZWbv6FIEqVoOgzgtfIGKMqmfyEAs
         exUFaN1Vb5eB1op9z7SruKPxs3jk4eq4fe35/q9m8jSAZqh+jhIXQIfjD55LG/5Lgzlk
         k4gzG5VzILL+/MablkEU1WzCDIm2tVf1seXgNRskbhviWLdrizUghgXqkPF5kN1xOQRh
         /x0cI0WdKXCfxTXYXH6OprpaNmImqlEly/ESj6RiS2UD918BLS2MxJ3CmRtYY4RU40SO
         7D8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769340; x=1796374140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aSulb1ZKSxB82Q0DHVFpLluzjXlQ4n39cXbO7GHm4Hg=;
        b=Ym+u+hfgH1DB8i+380BVqdRFS4FAuXJoJT97/d1sMVWFXsiygdK9PanpjIpSrhzN2w
         0hyDMZhPXfF3VTQ0ssxAU69CGGhcUhbzTwNJIatV8FRpGLieAedSvwyBDTouXTqmRbxk
         A/qozYx0zpt2k57eoi2wFSbPsKEz49iDiqb/aovCGalv11Y6AVhb+yaaS3yla86i1HIT
         t50H9RfeIEymIemR0cstrCJNOsv6sj+Me+L/kHDIpR8N8yA6gCahhcLbY5S7MaXhLe8y
         0gIey8ophlfkJqkrRx3dq5psjOKaiCBvOHKnnhnpbrjcs/8R820DIm2eNlUvc/d08ZqY
         O76A==
X-Forwarded-Encrypted: i=1; AL+hErG+ko7sD/adxhXyY5pK57JLme2kOtwArEAuvic0TrGchq0yxN7MVPDYu/EJdoXbJQRQE/Qzow8VRMnN0g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/AQTByFfeKTgEFCbtgEc/tmEHaZj/OOGli1IhAHd4o37t1mXt8
	LfoXWaCUhyoQT6m3D5x8NN1JwBJ2APus2dVB7JPJwTzcPSewl+6qp7gLkVZ8EVv6
X-Gm-Gg: AZFdTZf18D1WJOknzuBxO3YJ2WkWUkrnfDyX4wKueiFZIGj+RrhLWAs1+gpNIjayAN0
	MWuBaPISjg6o7RfkwNCCeVQzg4Pt7+OvgwJ+m7DNTLTdNneOQYgpMgJTgWXpnTTvnY2kWZXBW37
	6ATDQEg+Oi+w3wamSVtEH4CHcxOuN39FdP3PO5gA/12qsJ++2+d95mKoh7XO9Ua+beABTGne5Uz
	uVU1VU9RREwEnssZH00pHCnH4xAHrdr+Aqo/DD5K8z71EHTHrUSBmVxPkW0KZ/mGNNsT5HdjFzV
	CwyNCM2WSu3QuOSfhxplq0HOBRs4/AFAo+P+rBDmkhCvxUKHwV6mGBLze+nHl/lYqUaxLDzavqt
	GuqGWMNAKqAoGUlJNjzvD7imvwi4VFRcnmtBTblCCjhHUhA7pU7N8tnbTZe32ce9YvoMKijb15v
	7YWHHyENHDB/I8FN6MNYPJ8KVEb+Z4JH148vuMv8md9n1qV4d1Bso70QaMcUaqNTMafG9bP/VMf
	jvwMuODYuxlNk7YUzz9I9jBcXHrDi6m42uqehRyEIyZI4BPduYEHeDibR/lGbPg4cP6O1n+fjOL
	ACrNdTTDAOBhm8Q5PjUTPwPzwHlM68Ce0eMPVJQn7vlNlFuUjDa40G9/yH42Wj9DNQ==
X-Received: by 2002:a17:903:22c8:b0:2ef:e563:d2a2 with SMTP id d9443c01a7336-2f11414c317mr10473615ad.57.1795769339572;
        Fri, 27 Nov 2026 00:48:59 -0800 (PST)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d0818c1sm12289058a12.30.2026.11.27.00.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:48:59 -0800 (PST)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	jack@suse.cz,
	axboe@kernel.dk,
	tz2294@columbia.edu,
	baohua@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: [PATCH v6 1/2] f2fs: complete dropbehind write bios in task context
Date: Fri, 27 Nov 2026 16:48:44 +0800
Message-ID: <323235fbdeb5131f83569541c602ddc88f412b18.1795746008.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795746008.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com> <cover.1788795700.git.qiwenjie@xiaomi.com> <cover.1795746008.git.qiwenjie@xiaomi.com>
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

Mark dropbehind write bios BIO_COMPLETE_IN_TASK so the block layer can
defer their completion to task context before folio invalidation.

Allow normal and dropbehind folios to share IPU and OPU bios. Set the
flag after a dropbehind folio is successfully added, checking the original
page-cache folio rather than an encrypted or compressed replacement.

Exclude metadata-cache I/O, which may not have a file-data folio. Leave
the existing large-ATC completion path unchanged.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Changes since v5:

- Rebase onto dev, preserving the updated bio_len/bio_offset merge paths.
- Skip metadata-cache I/O before testing the original folio's hint.

 fs/f2fs/data.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cdc9e6e8633c..37d74afc8b26 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -624,6 +624,9 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	bio = bio_alloc_bioset(bdev, npages,
 				fio->op | fio->op_flags | f2fs_io_flags(fio),
 				GFP_NOIO, &f2fs_bioset);
+	if (!is_read_io(fio->op) && !fio->is_cache &&
+	    folio_test_dropbehind(fio->folio))
+		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
 	bio->bi_iter.bi_sector = sector;
 	F2FS_BIO(bio)->entry = NULL;
 	bio->bi_private = NULL;
@@ -1077,6 +1080,8 @@ static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
 					fio_folio->mapping->host,
 					fio_lblk, fio) &&
 			    bio_add_folio(*bio, folio, bio_len, bio_offset)) {
+				if (folio_test_dropbehind(fio->folio))
+					bio_set_flag(*bio, BIO_COMPLETE_IN_TASK);
 				ret = 0;
 				break;
 			}
@@ -1359,6 +1364,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		__submit_merged_bio(io);
 		goto alloc_new;
 	}
+	if (folio_test_dropbehind(fio->folio))
+		bio_set_flag(io->bio, BIO_COMPLETE_IN_TASK);
 
 	F2FS_BIO(io->bio)->entry_cnt++;
 
-- 
2.43.0

