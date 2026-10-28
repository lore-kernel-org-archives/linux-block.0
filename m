Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217468;
	b=O1nsysnTmjH6H+UTbulqFeGE5REzEQxXaLJTVgeADI2/RbudmJKqikyzTARJZNZ0k+UP
	 F+rG4j60+Ge6JQE3pNa3qBErXNKkhpiDRCilIn9lWif0F61MO+c5AaKPUDou76K2JDSIN
	 aRNDL9bCqoIaZJYzefig8MwaCvijCQQ5KU8GuJocuT3DogcY/I+dDYCD9jio8xNL30hUe
	 1ZLr1ZYBeS2vyLdtReVQMyGjGEOXQiVLXh5YCJ+Lqx6JbNm50Wd1CBZBLR1NDEcVKYxcS
	 jQVz55cd+LBuqrekUwOsOMSD7QtBURjtRWzEY+Psvq1lZz5gCzv4VHzBoFAj2OyW/MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=jSKBNBV9XJtnDZlpb8sFmkGj4ydQ7QQvommJYpzcW3w=;
	b=XaaQgveMhKRFj8oCEk2v3FSIPrZGvAKXy59nWP0MO3/dbqfFO4kjrQUv8j7FgMRvcmHu
	 cMIwBXAzkKCSPuh+H2eHGei358ltzLxLCoBOO3YqjonTXULeSUwCYOnYqZ51ZZrWRq6cZ
	 FHtCiYCLki1VSRRIE49fearMKVJ1US3TFmaclp/VTUO4xfzE4pscXo5drJaZMcYZbh7Qi
	 +iCM2Zq5VrsYspaCfuSfxJflaF9LEZypoXWxfk+4hgVmPvHIus/AKbXzRjztNm8lholYx
	 J5YUELXCaTj+uvZMkoXQeByMPkuK6atk71utzFVdJfDTnPgZmFwI8py247NJpATjQzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=L0xxlOCh;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE62606A31A
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 19:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EE62606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=L0xxlOCh
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jFJ7H530lz1XM30h;
	Wed, 28 Oct 2026 19:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793217463; x=1795809464; bh=jSKBN
	BV9XJtnDZlpb8sFmkGj4ydQ7QQvommJYpzcW3w=; b=L0xxlOChV80biMYmrJkm/
	mU1pTNCDuKrPuR2awRJSyCEsjqCKEFy7Az3nBkE+0FK8WZo88u2xrS7lMr7Pa1gr
	9+GXPUwdN2IxG7kxwdORV2GX/2eruAKxyu/p8KBpPUWWei6LA0fQ0Hk4OKjWQg9f
	rAv6uty3CUs1wiCDHdnpzlXmU9WYQ9nhZASk9JGEnrMrSAD7q+jgya4Ou0w9fy3O
	aV1uXiiRq/pvKoktPNUvHOI7wdMgxrnYjLSQpOPghLr0cPsYJb1SaTqO/Bmdg67v
	0ZVDZMPL0hyQOtA5GRB5oyzkHH3RHDTj/Hs4W8VWiuDsCYucI2CqpLHk007J+/ah
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qeS8-vGjBoYs; Wed, 28 Oct 2026 19:57:43 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jFJ7B6L4Dz1XM30j;
	Wed, 28 Oct 2026 19:57:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <mason@kernel.org>
Cc: Justin Sanders <justin@coraid.com>,
	linux-block@vger.kernel.org,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 41/98] zram: check a bio's range against the device size
Date: Wed, 28 Oct 2026 12:57:17 -0700
Message-ID: <20261028195731.1591331-5-bvanassche@acm.org>
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
> +/*
> + * bio_check_eod() counts whole sectors: it does not look at a bio tha=
t is
> + * shorter than a sector, nor at a tail that is shorter than one. zram=
 takes
> + * such a piece to the slot of its sector, so round the size up. An em=
pty bio
> + * has to start inside the device as well: the loops for reads and wri=
tes run
> + * once before their test.
> + */
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

1. It explicitly allows an empty REQ_OP_READ or REQ_OP_WRITE bio
   (bi_size =3D=3D 0) as long as start < nr_sectors. Both zram_bio_read()
   and zram_bio_write() use a do { ... } while (iter.bi_size) loop whose
   first statement is bio_iter_iovec(bio, iter), which immediately
   dereferences NULL bio->bi_io_vec on an empty bio.

2. It allows sub-4K / unaligned bios as long as they fall within
   nr_sectors. However, ZRAM_LOGICAL_BLOCK_SIZE is 4096, and on
   PAGE_SIZE =3D=3D 4096 kernels is_partial_io() is hardcoded to return
   false:
   - zram_bvec_read() calls zram_read_page(zram, bvec->bv_page, index,
     bio), ignoring bv_offset and bv_len and overwriting all 4096 bytes
     of bv_page.
   - zram_bvec_write() calls zram_write_page(zram, bvec->bv_page,
     index), clobbering the rest of the 4 KiB zram slot and compressing
     up to 4095 bytes of adjacent kernel page memory into the slot where
     a subsequent read will return it.

Shouldn't this reinstate valid_io_request()'s ZRAM_LOGICAL_BLOCK_SIZE
alignment checks on bi_sector and bi_size (as well as rejecting
bi_size =3D=3D 0)?
