Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894735;
	b=Pdt0SI24hjO65GytlkcINTwF2pvsLBVqwV7DvNkgPC4okgDWGqGiGj9iGoXfBaNEAMrC
	 DGt/phCW1reinhzDVs4pLNOo9qXVPAEUT5aAhvhYWD+lPuyjCHUzZ4uKef8l0WwGJHr8P
	 9m7NC1EM5NTyhiYNpUtLhnYcrm3FsqF1J9x45aqARQW/9lHCwi2+swpzLySp2LuS1SN0R
	 2yGemVA0lCSp7LXVL+vVrbNht7A4OsCQ3+hebVGfIQlOPeYHSOpg/wmxvAmOpK/XFHY/g
	 H4fgOhAKj4Z+SZu/1mJtP4e/o76p1PlBg8giA9pguJm3tTzxHADgPrytyJYCqht2wkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=W+dUZI0Q28ikrVhP8r1OLTtsR33EU3YB9h6P4MYpUiA=;
	b=lYWfMWEZb7we0TE+dLy8XGGsALcFTzeMDhRh9C/HFUijQbPDRJPz1babuvQx/xrLTdu1
	 3V2ZVoziFMZQzQfFP0NthDXhoE7sg20FSLQhdiu0K2717m3d0Ip5hVNv76PtOTCeMuNEp
	 A3mwkknDPkKEk7oQXXVdD7bJ4ltPikj//v66GIguhrFbDEX/WSdDKxPXgEFm6CmwBFxH5
	 KyCVDR6C3GVMV0Kbs+vXMzyhYXT20/+WbNrrABLsM+YwoEWkpdgjHrDyqKwVK3rfEnN2S
	 bqjAOUaK+wqYBc0mD95B3TVct1nlV44ba5XbAex/eU3LcdOvjpkissexSFoVxFjUbuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hLIjZwFt;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF00606A327
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 02:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FF00606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hLIjZwFt
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-156cbe59622so1271726c88.0
        for <linux-block@vger.kernel.org>; Sat, 24 Oct 2026 19:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792894735; x=1793499535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W+dUZI0Q28ikrVhP8r1OLTtsR33EU3YB9h6P4MYpUiA=;
        b=hLIjZwFtx8Ocq0I8UgCZUYCgBRzE884+HJ4PzXQ/5piFtAtizIYfax0BxklWOg3jIW
         pweYn3GT/EMQ3ESrZbEb0mrlNWpsnlz47lgoWcayFSypUxCRNg41bopM9RAexrHcMdc/
         s+DircLyUoOPED3IBFHWxSVTd7NAxmMgW5iPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894735; x=1793499535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W+dUZI0Q28ikrVhP8r1OLTtsR33EU3YB9h6P4MYpUiA=;
        b=FmF+cb6Gng5K05YdwKvukfYcdZshlxVmZN1rR0n9hxcSrhuvmDsl2GCU6/StzuYTIV
         Jjwr7tHS4oHqw8Rf6fGGbo6ouwcGOnWcsXY5ASr5r4W6ffiN5pRvYWCScxa324MBJ6e8
         vOeWHWCRG0Ik5MCBbQQ9IQEaiddGVlnF35q+8ghMYMBpSqdsUr/wTig0z+5pRoumkH2A
         MQ6PI+6OnoKmNoUwBTTBGmCZ5xm0ARukAryy+dzzL1JzsjsYFO2SJoyVQ42wLdyPCqnh
         49Pawefu9HAZmtvBzjQXq1d8enS5JxrLxhbWmC/AD5czi2p6wVzN/0LiZXcF7g5WZcte
         3Fgg==
X-Forwarded-Encrypted: i=1; AKwUvBzYstwrXPXPejPzsdA2aeL7o50Rg6pAGpE7Q8+FD8BL+XDFiLAe4vBehBuShE7kva4tF+vhnTqOYlNh3A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+Tq3hAM5k+acG8Z1efOYZHluPdhj3L4gx86nqdPz+so4MsTqZ
	22FE+5WcSWjI9+xbqbRSc7oEPfatsU3x6WA6tqbuHjQqzkitD8RRYH6bQ8Cb4CsDyg==
X-Gm-Gg: AYBFou1S4mbkOqCnuEUjVTQyokoufk8JSYgFO7DEXAoLF+hDTQO5oeEQ/OXEECaBMxl
	JdRZ2nrkSDSplELKEMAVrj8M687pZ7Ode6/E7DYYiQN3b1cmOvPvdGIYJOkghxqRlqNgBsz8gi5
	wYTF/8TeseybrApTd/ozlzXKF3Ev6iOZ7LZAmANnskCRWzo8aqIGXlTPtbJp388ZeE/jkmb7oK8
	AulL3dizx6ML46j4RmdD/QQK3URhMyE4hmCLg0l941TV420rD7DDBUYUvAwSv44Q3ied9oyArMG
	CHNGH86FojpKH5gVmX/5YXYDkpprrO/d1+PUVbX+thwAQQl1wnsltuyqlBsOH4P1kCLWDrIGRcX
	PM5V5RcjS0+8SB84q7WPfbUncA+/FDGxTn5liHqJM23SbNRhqBvHb867k/fVabjQ/+zbRs8SlaG
	fSqP72lgA7Non6MWubfVse0gV/flqsW4IPdDt7OFZMGExyRtmhox0MRon9gk9G12Q3aTWmHUdvl
	vX5srP5pb0j0vNtWtaL06GWEA89UJ+EOwBuurD2xJ1q4E+X0QG0kQASyPcaoevg3m7x+DAAAKlK
	K0bBmQxA+rQ2v8LNYu3ps1kWF6RxQZ48Q8LSzYUI4HWa
X-Received: by 2002:a05:7023:a85:b0:153:3c50:ab85 with SMTP id a92af1059eb24-19934a952c6mr5391501c88.12.1792894734487;
        Sat, 24 Oct 2026 19:18:54 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:9f87:66fc:8c85:11bb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm10387242c88.8.2026.10.24.19.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:18:54 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Barry Song <baohua@kernel.org>,
	Bo Zhang <zhangbo0325@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v7 04/15] zram: move mark_slot_accessed() under existing slot lock sections
Date: Sun, 25 Oct 2026 11:18:20 +0900
Message-ID: <20261025021839.1542805-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
In-Reply-To: <20261025021839.1542805-1-senozhatsky@chromium.org>
References: <20261025021839.1542805-1-senozhatsky@chromium.org>
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

zram_bio_read() and zram_bio_write() take slot lock just to
mark_slot_accessed(), right after zram_read_page() and
zram_write_page() have already taken and released it.  Move
mark_slot_accessed() into those existing slot lock read/write
sections.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0e1aa0da11aa..2affac25db5d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2188,6 +2188,7 @@ static int zram_read_page(struct zram *zram, struct page *page,
 	int ret;
 
 	slot_lock(zram, index);
+	mark_slot_accessed(zram, index);
 	if (!test_slot_flag(zram, index, ZRAM_WB)) {
 		/* Slot should be locked through out the function call */
 		ret = read_from_zspool(zram, page, index);
@@ -2244,6 +2245,7 @@ static int write_same_filled_page(struct zram *zram, unsigned long fill,
 	slot_free(zram, index);
 	set_slot_flag(zram, index, ZRAM_SAME);
 	set_slot_handle(zram, index, fill);
+	mark_slot_accessed(zram, index);
 	slot_unlock(zram, index);
 
 	atomic64_inc(&zram->stats.same_pages);
@@ -2283,6 +2285,7 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	set_slot_flag(zram, index, ZRAM_HUGE);
 	set_slot_handle(zram, index, handle);
 	set_slot_size(zram, index, PAGE_SIZE);
+	mark_slot_accessed(zram, index);
 	slot_unlock(zram, index);
 
 	atomic64_add(PAGE_SIZE, &zram->stats.compr_data_size);
@@ -2348,6 +2351,7 @@ static int zram_write_page(struct zram *zram, struct page *page,
 	slot_free(zram, index);
 	set_slot_handle(zram, index, handle);
 	set_slot_size(zram, index, comp_len);
+	mark_slot_accessed(zram, index);
 	slot_unlock(zram, index);
 
 	/* Update stats */
@@ -2756,10 +2760,6 @@ static void zram_bio_read(struct zram *zram, struct bio *bio)
 		}
 		flush_dcache_page(bv.bv_page);
 
-		slot_lock(zram, index);
-		mark_slot_accessed(zram, index);
-		slot_unlock(zram, index);
-
 		bio_advance_iter_single(bio, &iter, bv.bv_len);
 	} while (iter.bi_size);
 
@@ -2786,10 +2786,6 @@ static void zram_bio_write(struct zram *zram, struct bio *bio)
 			break;
 		}
 
-		slot_lock(zram, index);
-		mark_slot_accessed(zram, index);
-		slot_unlock(zram, index);
-
 		bio_advance_iter_single(bio, &iter, bv.bv_len);
 	} while (iter.bi_size);
 
-- 
2.56.0.257.gf7497c7d27-goog

