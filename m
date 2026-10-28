Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231379;
	b=hbJK9qnpPAXPpflVkwgvxFcx2hjGj8n1vtNGLp7d4e+M3TKU9fg9TbKSE7I2V7OJsiUP
	 x2J+X0DBclMymJiEGtyPcXJa2dOS43OyKrGR+E2HzhsRNb/TbQs9SosfNzTx7cR/ypYY0
	 romCNlA6XVXHpF06sVo2cfaaO8cti2G0CMYcOLFBP/ljpGCVK0WFl83IUttkEMxvi8lbS
	 WBirb/p6OeVt3f+V3BOhXy2sjLxtRrze+otBGuqqSXeJgywDJeOS5CC49PghoG9CAxAp0
	 9K21KAvEENnVUQBDGeFbLY39aIbNI8M+fzeNkNBLYtqBDx3584GlBbB5Ua2CGlRbBQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=eDb63xC4bQrSLONENgbB0n5iZ1U32uPw/pGmBmuFnsU=;
	b=Cp08FoBRMipcIjISehpJOz2nIGRaHOOOckuwbPcdmsd2z5xzXmJAsXpXyS41nCg6i7Aj
	 B8wHQbUA08Jvsd878LZOs+94CdswUcmD+9h8NT0l1pf+j3cUFXUCybibBOjraDf9PY5uB
	 8IUtJqcE7DSqhEchVWGZMUWc1ofGt71tfCvB4VUd9j0q5mdzSA101DTmrSXAgjrUju4n/
	 ErdW7BaFR/rSdIDAUYuDMBeeJRiNfILo0sJPAPMF4dGtrK+S6fuktCBxBAoiaHgyzn05F
	 gE8RBPwaKp6xerjDvnk63KkQ1+9L4jGSD9XxuxdufK5j+ZMmWEMBPAiTSEOiU4eEMVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=4Rsb0x2j;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26270606A31A
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 23:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26270606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=4Rsb0x2j
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jFPGp5NvDzlfvpd;
	Wed, 28 Oct 2026 23:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793231374; x=1795823375; bh=eDb63
	xC4bQrSLONENgbB0n5iZ1U32uPw/pGmBmuFnsU=; b=4Rsb0x2jLGsxkdyUVYB9a
	CTsZXikoant0brjRoBBIPKEF6GSGiBPKYIomFVynOkJ0LqOfOSqUOrQjx3B/0Lxi
	Cf+MN71NN/AJ9gJVe/ZNJTNeWLeEJX+ZLxk6CloBBoVv0KpkiGulrOnusQvFxS3A
	r8M9ApGCDP3vwJJfvfiE0ebdGGRHCxMKdwCCUGHG8cw8M2TpEAIDlAVxwA/Le5C3
	SG9+S2NizlU6eE4GiGEgDRRrG9ZeUvzPySQQiGZXby5em+45mNG36TKw5G7YOm0k
	BpTlmFvp8kVPm1LjV7ef5sJ780K2Nu4P4D3t/jymatvvbofX4bSP4E1z/wD16AJO
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id iaDiYGG9g3nl; Wed, 28 Oct 2026 23:49:34 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jFPGg5T9Dzlfvpy;
	Wed, 28 Oct 2026 23:49:31 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <mason@kernel.org>
Cc: Justin Sanders <justin@coraid.com>,
	linux-block@vger.kernel.org,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 41/98] zram: check a bio's range against the device size
Date: Wed, 28 Oct 2026 16:49:10 -0700
Message-ID: <20261028234917.3067347-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
In-Reply-To: <20261028164415.1262013-42-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-42-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/28/26 09:41, Jens Axboe wrote:
> +static bool zram_bio_in_range(struct zram *zram, struct bio *bio)
> +{
> +	sector_t nr_sectors =3D get_capacity(zram->disk);
> +	sector_t start =3D bio->bi_iter.bi_sector;
> +	sector_t len =3D ((sector_t)bio->bi_iter.bi_size + SECTOR_SIZE - 1) >=
>
> +			SECTOR_SHIFT;
> +
> +	return start < nr_sectors && len <=3D nr_sectors - start;
> +}

There are two problems with zram_bio_in_range():

1. It allows an empty REQ_OP_READ or REQ_OP_WRITE bio (bi_size =3D=3D 0) =
as
   long as start < nr_sectors. Both zram_bio_read() and zram_bio_write()
   use a do { ... } while (iter.bi_size) loop whose first statement is
   bio_iter_iovec(bio, iter), dereferencing NULL bio->bi_io_vec on an
   empty bio. (Empty REQ_OP_FLUSH bios are already completed in
   submit_bio_noacct() because zram does not set a write cache.)

2. It allows sub-4K / unaligned bios as long as they fall within
   nr_sectors. ZRAM_LOGICAL_BLOCK_SIZE is 4096, and on PAGE_SIZE =3D=3D 4=
096
   kernels is_partial_io() is hardcoded to return false:
   - zram_bvec_read() calls zram_read_page(zram, bvec->bv_page, index,
     bio), ignoring bv_offset and bv_len and overwriting all 4096 bytes
     of bv_page.
   - zram_bvec_write() calls zram_write_page(zram, bvec->bv_page,
     index), clobbering the rest of the 4 KiB zram slot and compressing
     up to 4095 bytes of adjacent kernel page memory into the slot where
     a subsequent read can read it back.

Reinstating valid_io_request()'s ZRAM_LOGICAL_BLOCK_SIZE alignment
checks on bi_sector and bi_size alongside rejecting bi_size =3D=3D 0 and
out-of-range bios closes all of these cases.

Here is a replacement patch (checked with checkpatch.pl and
syntax-checked with Clang; not runtime-tested):

---
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
index ab064c84b092..8d4e3791b424 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2796,6 +2796,23 @@ static void zram_bio_write(struct zram *zram, stru=
ct bio *bio)
 	bio_endio(bio);
 }
=20
+static bool zram_valid_io_request(struct zram *zram, struct bio *bio)
+{
+	sector_t nr_sectors =3D get_capacity(zram->disk);
+	sector_t start =3D bio->bi_iter.bi_sector;
+	unsigned int size =3D bio->bi_iter.bi_size;
+
+	if (!size)
+		return false;
+	if (start & (ZRAM_SECTOR_PER_LOGICAL_BLOCK - 1))
+		return false;
+	if (size & (ZRAM_LOGICAL_BLOCK_SIZE - 1))
+		return false;
+
+	return start < nr_sectors &&
+	       (size >> SECTOR_SHIFT) <=3D nr_sectors - start;
+}
+
 /*
  * Handler function for all zram I/O requests.
  */
@@ -2803,6 +2820,11 @@ static void zram_submit_bio(struct bio *bio)
 {
 	struct zram *zram =3D bio->bi_bdev->bd_disk->private_data;
=20
+	if (unlikely(!zram_valid_io_request(zram, bio))) {
+		bio_io_error(bio);
+		return;
+	}
+
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
 		zram_bio_read(zram, bio);
