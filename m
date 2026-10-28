Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205909;
	b=39WNQIWIOiJFgF+xNzvFEbpErxgrAorbO4GPs1T9tBMkse4jW0TExXPzWOqZcFJVUBsH
	 tEaT4+MLy819lAYhVoWF3eEpQCF2E34IMD8QylNTFOHvx4BlLxCs2j6bU7VdHpj734Mfs
	 tlS1I8e0VhRvmn3AYtzUU5B/vHi3aW7nprNhHkwauR30vHrE7pvUMfNcTSUsoeypsvEVx
	 5BhXofPDiyDnbjJ2c3ZFsd8+/nnEmkNzaq5hve86x5uRTrVDATZoXjPWAN1hb2NO3ZlJv
	 YNafrWfioN+WXEZrwOyxKFiwjO6YneYqhNw+iB7BOYp5nhdX/M1PwDfbmMjPykWOTAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mBPwb555vsYf0SXuFzf/sZJzuMUF3x+ADiqBNF86O8k=;
	b=KlfOwfTIKB3VHzuAChdYqV8H8ykwIl6x4iYe0NTUljPI1c2GWtgqziBR1XmkAJdPHMrf
	 q97bRRNkr3qQzEUsUfB19iqIl05+cN6sTq0NVBMolG0K2GZOflmQlLQbheRUKajHTo/qd
	 OxwQw1bG5WT9exdXjsScJi+8u0Ci1SE1cd+hVcT5iVk6JDzuuva2xt+b0Ltq5sctqeZxf
	 JadoHoaqWcEh2JW3hVh5abyp9o1QtktUqYuAVrpvewE9klfbwx84nVDXdwd11/ltTqs7x
	 C7UZwImV8HBEfyPL+Q+DpCSM2FynjyKrTxeG4Gk8KHezq6SYIWuNP8MhX3OcSpUR2EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ATdEsx3h;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5748D606A325
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5748D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ATdEsx3h
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-8446af403b5so751719a34.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205908; x=1793810708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mBPwb555vsYf0SXuFzf/sZJzuMUF3x+ADiqBNF86O8k=;
        b=ATdEsx3he9eqADyLCPqB6UUKRnqT3aFbcNSZBRl8hMK7sSzFo/1ccNGe9Ptl4BJcUF
         40gwy+xZ4oGcP6lD3cggooKdZBFSnw0X3Bvmqb791UJxrv06KlEHGiYVqNgZMmXpJA2S
         ioRTl3SwW5FFbm7RL1l6BI+YAKACYIPRQ0n1qa+cmIf4GgNfWS2KiOx6YoiNT59mgPsR
         JmxGkWEwqCp/4RBZCdF1UMvkplP0XI892mM7FQwZPdqAp0CZWB205IR17eol+MD3aZ2d
         MBj8IoGJhe/1vHYL5S902vRQ5L92xnRPwzZJPiB+EfWXqWUEI8lg2PLQR4QdSeL0ULZU
         Y66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205908; x=1793810708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mBPwb555vsYf0SXuFzf/sZJzuMUF3x+ADiqBNF86O8k=;
        b=kOoUUmFZBWLPGR7TUVMNWQ5E4pzAKm1AL0u4CcuC8+WxF4tqMFI5GeeJqMJJV+X9lp
         yv6DZof3Flon8/bzqOk7TD0BPvozhLZ8uZt8fR8r7cJZet+C9ACwC+Lv9DnfesOoX63z
         OVO27ejUnEGbucx+cSC1Jx+2BJ/nOTGZfN1erF1+JZymxMBev2oyi8zhTZTHClULydf5
         DrVK1yfzgRkbWCWxsZ+ZsxIeuicygZ8t2x599uuyIkixAD+rUzHcsW0IjkpUYOQfNQ1Z
         mPlGYUsO5SsFP5z+1tiXlNkOJKNzkN6XLkNICgr5FQi9l/hoG+wr9GRFacjlBlUooaDQ
         boXg==
X-Gm-Message-State: AFq9FYJrTDdl3koAn6xpH5W1uoamMdK4BkoXPd2qYfGBzHxyJuZnEjck
	ov5cU7EQCFa32y6vLhfqLZ8vbhfOZokomGkBWB1qosowZi/Kd3rHay6QgQomv6UIdBUdh0jZdRf
	+caBt7+s=
X-Gm-Gg: AYBFou05QsKmesRdf9cOyGciGQYfy5S1SncUbdz7QvZ2Cdmmjhx1PTHAxf3GnfKygG1
	/1londi/iHWelqntmdg7WhL3GrkKwwpv7M3BwwxJHWbln1Cc7CiVP48n/AU96XYHcDwOqcDrMBm
	HI3W1k4RHNdbXj6N9rIpxF/aLc6jLi/d1JNvEYHbyv+srh5qSc7a2IP4XgCktPGmWoS++xX1nR3
	pptCB0Tq0U38AAkJO89w9C9oMz+Ht/rDIsRHMwot0vYobYDQBhOo6ZIy1g+JJQFZL/jmzzXzAYY
	a0IiADWm8GQnUTJeNw5dPGV/mleJBtNWVYyXukm9aY0YVkKk+5UBz+ZAkojaYwcbrV231d81FNM
	rOdayU9p60kBpGKjIct+eZSWYDumToQGHutPWqUUV+U8EWcpdenXSz2F5/uXJsx2ELv15An1cJX
	sJBcsfw6edtIbTGLLyZiUL5LA7JE/eHUZeoksVaDYDxDuOkWwf3IvN2n8vL9WFyFTW/imP2yv4Q
	kyqD5aIlg2Pj8ctsGwHg68Ju42Avz3DFYn6sS8uBLR/oaKksMKm9qE4hEFAy0wSbhPyXIqwm54Y
	hOx29ynJrKRyE2d44Cx/8BgW8OaFE0oVPG5tm6hSeKr0s1mARqaXriw2xHFmHUjKXlS/1bu5jQ=
	=
X-Received: by 2002:a05:6830:44a3:b0:843:b6f8:de3f with SMTP id 46e09a7af769-85ab7c048d4mr2812512a34.18.1793205908301;
        Wed, 28 Oct 2026 09:45:08 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 41/98] zram: check a bio's range against the device size
Date: Wed, 28 Oct 2026 10:41:44 -0600
Message-ID: <20261028164415.1262013-42-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
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

From: Chris Mason <mason@kernel.org>

bio_check_eod() counts whole sectors, so a bio shorter than a sector, or
one whose tail is shorter than a sector, passes it even at or past the
end of the device. zram takes such a piece to the slot of its sector and
reads, locks and modifies an entry outside the table, or dereferences a
NULL table on a device without a size. valid_io_request() refused these
until commit 9fe95babc742 removed it, and any in-kernel builder of bios
that takes size and sector from a peer can feed them in.

Check the range at the top of zram_submit_bio(), with the size rounded
up to sectors, and fail with an IO error like bio_check_eod() does.

Fixes: 9fe95babc742 ("zram: remove valid_io_request")
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/zram/zram_drv.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 024402438bd1..2555057a48b5 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2794,6 +2794,23 @@ static void zram_bio_write(struct zram *zram, struct bio *bio)
 	bio_endio(bio);
 }
 
+/*
+ * bio_check_eod() counts whole sectors: it does not look at a bio that is
+ * shorter than a sector, nor at a tail that is shorter than one. zram takes
+ * such a piece to the slot of its sector, so round the size up. An empty bio
+ * has to start inside the device as well: the loops for reads and writes run
+ * once before their test.
+ */
+static bool zram_bio_in_range(struct zram *zram, struct bio *bio)
+{
+	sector_t nr_sectors = get_capacity(zram->disk);
+	sector_t start = bio->bi_iter.bi_sector;
+	sector_t len = ((sector_t)bio->bi_iter.bi_size + SECTOR_SIZE - 1) >>
+			SECTOR_SHIFT;
+
+	return start < nr_sectors && len <= nr_sectors - start;
+}
+
 /*
  * Handler function for all zram I/O requests.
  */
@@ -2801,6 +2818,11 @@ static void zram_submit_bio(struct bio *bio)
 {
 	struct zram *zram = bio->bi_bdev->bd_disk->private_data;
 
+	if (unlikely(!zram_bio_in_range(zram, bio))) {
+		bio_io_error(bio);
+		return;
+	}
+
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
 		zram_bio_read(zram, bio);
-- 
2.56.0

