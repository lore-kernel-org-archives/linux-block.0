Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EBF22E3E9
	for <linux-block@vger.kernel.org>; Mon, 16 Feb 2026 23:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771286151; cv=pass; b=ZS0UWyGGz70+L3q3BmhJ3Qwz2nqC/D0bd2SxgjRubR7KA0xXuRhC68SW2pVfa9vMHqHl2EUbsS6MzoPy/PwwrasUBHSpT4g8ty4JsKMWv6evTbGiuWuQ+M/dOGl9iLixq1XOqjeFZKhCB0y29SA042/OF2aJzYysCdr8V4xXS0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771286151; c=relaxed/simple;
	bh=XlrX/qq2eH6XEzpyo3kwRmOiV2AOVdwXS/CHoGVbbPo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PxdSBTiTx8zpzWstmdfAMVy5nrQFy5aHKO50zoA0GgJc3fJ8P+qHEGZUVgAMsGQNPLVhkSHnpSvd6tg9NLt/f7onMO0W2Ie8mk6YbY6fq9YlAoniOJExOf2GhwqVEGGMq4YXbUpk5amMfUXxy840Xv5jOl+gG9kDHuWwfa7kENY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeufaBjG; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeufaBjG"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59e60925251so4183981e87.3
        for <linux-block@vger.kernel.org>; Mon, 16 Feb 2026 15:55:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771286148; cv=none;
        d=google.com; s=arc-20240605;
        b=aGwGDUHoSesa/ryB67HQODBwizkJDpBO/BzYKtfoAEkH/1SBO6Vo6pJDmPQO2TR7gG
         cnnZ9taa7ceqJoaLvEiDunGaXsZbRTOPp85hu2Z2Qi8OMEEJynTEFr2/LADtXBSK9w+g
         LQuXYyk92A99lVQTSOir2kkcyCfohBfwSOQrjoaiA17ccPo9uRdppipRBzyZgIlnRyQI
         /850TPC8ovk875gqu4F7vb27rkYOyMuxtyY/RiTLuR5JQdDZDXZ3cog4jzyxfDDhkf42
         eT+GldjcEL45//7blo3axknLZakQ8WW4RVAvt5/5BD49NeVWgwMi8D+g8thrwWM9bpn9
         vX7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=06jmf6t92SQPtbMpj6uIcq6qG1h2woFgzQJzzPTqLmU=;
        fh=mLLgPi4CETxr/tgg1Jt6ep4vUjVYrAVpX/SOWH2q9zE=;
        b=XhUXu5AsFreQ5JALK/R/fONnk9oXIzYBkFkBS2fh7bZhOxorr2nFUYj8CRwGJp03A/
         LXj/mjp7IKEDVHLJ3KRadEHH54lJm9OIGyHxpsC+HWj0rt7YTCmq5wlIwUmEG/dk4DJV
         M1LwTB7RZjaTiMpkm+UGBxaH+DTzm4wrh8fubNYcc+saca/uxuFMDRx7raAKPt93/dZ4
         YVYgA2M4xsWgbFUnXrpi2wvZCpf+qWQ3MzH93nVLrqf+67mx5QK2C4sshoqwjeF9h+LT
         AsdKYQYevQy/eO+CUUa9Qtx6iqrS9Bt3JvZ0TOB0JGWyfdSGpeT5sy/Nrqjs/m7XPPVP
         AURQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771286148; x=1771890948; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=06jmf6t92SQPtbMpj6uIcq6qG1h2woFgzQJzzPTqLmU=;
        b=ZeufaBjGm3FI08C7LgIjBvKz7nPdJIFY/NBWS8IZentCKXytUvlh5fjIVY/KVQX1Xi
         SXbGSLJOkZgfhM5L4M0wr9hrFurJFsuzqKYtMfIKvYHxf4j8yKv4H8BDY0L/lHRwDyoy
         1/kEDt02KTwxUVGpfP35YXQYu7q4a+tF5C+3NES7X8U/oizGT9cPTrZ+Bl2RZm5dB7SR
         EEvihV352s/gaamVVyTei8NTumDRL2NQ2UVgMwK6D/SyyAVg2/h9Wxomx1rR39dBZogi
         MjiMzSQ8rhfFxwxjI5FcCQqR6V05myJxHIyN2UOpwIePs1/ft/O6Jze2wix9b0VQkI4E
         X21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771286148; x=1771890948;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06jmf6t92SQPtbMpj6uIcq6qG1h2woFgzQJzzPTqLmU=;
        b=pDlcGKcyeYq79Ai8zKBjh+Z0QsQBbAK9UlqZtXXIA3vkFFu6s7tCr9J7aQQerXNSmn
         wbqNjFzeIMcsjqWNfQuupvZPzioAZgonkJJbZMPbS7PuYxldKrFxa/R3zQkQHxLMDaxo
         xXZIq+qFzYi28uXXueENmHiZz/3H2rGtyTVKXlQzF6npTf2lgdH0eXsr2FatewZkKhpm
         iEUHaU9lvfQdsnQsdoOIl36bnMdnrfHAWUmU2bleqHpd0sTQ7TTUThCePvOFIz5YD5zC
         ODhbJdWrZtQvrsQ2qFw0D7gpaRq7Zp3Wv/npTD8ezVceeW4FvTOEAPo1Bw34yDUYGh5x
         JTNw==
X-Gm-Message-State: AOJu0YxZe3Q6dZXDOTilJIgTZ8y+Eee95TRPKvfrDacQRhy+9Z8BLURF
	inqDwAh5fDozTmWXwpV3gg8rEjquKmshgrhCR0Bw3YteVyoYqPlbM+UBx3601u+olUb99mXrvUC
	bTKpiuZNqCBkazQudfLdNQbMh5EkdJiO8T0JWumc=
X-Gm-Gg: AZuq6aL2yvRrJWqpsGP02WqXhb6dBN4QerYcMsdo1yH/VSNf2fb0splphkJzfH/LdxB
	hnaCKsS3NLyVIfVHGbwr68I70oA06zopg/fqY5422p2r9XSu1tIlG7C+DHzMyN7GLb+1+2gUO0E
	tNYKp/Cu2XEx3W3jDXVhIHMknULPlfg8mYkgKht12Jr2vKHWOElvxIeSymZpIJeu41dE6CODMo+
	YwIitHd4r4LJ5imbQdYCeDsKtYMvPPtap/flCCQYOm4hNfKP2/4YfZmwOcqKeo9mJePUJlyo6w/
	5GgYNC/HBf/g4pulFN4QqdAarOJBv3kAFZW9uc2Fiqoxm9nE4GTcFc90KkaTVv9IDqMbQiPvEQ=
	=
X-Received: by 2002:a05:6512:1255:b0:59d:f274:c50 with SMTP id
 2adb3069b0e04-59f69c0f268mr3801084e87.6.1771286147910; Mon, 16 Feb 2026
 15:55:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Adnan Jakati <adnanjackady@gmail.com>
Date: Mon, 16 Feb 2026 18:55:36 -0500
X-Gm-Features: AaiRm50qk8rHmlBUD-O6W_2UbPkNmZsU0fRC5Z3U9u7IZlabww9LoRVpgbDjP0Q
Message-ID: <CALH9e+L1NvS+Dke1sRwNGBYuyA=rG_UqMZS90eUMOEd0nuFv_A@mail.gmail.com>
Subject: [PATCH] block: add missing bounds check in disk_zone_set_cond()
To: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

disk_zone_set_cond() accesses zones_cond[zno] without verifying that zno
is within the bounds of the zones_cond array. By contrast,
bdev_zone_is_seq() does perform this check:

    if (zones_cond && zno < disk->nr_zones)

If disk->nr_zones is reduced during device revalidation (e.g., after a
zone configuration change) between bio submission and bio completion, the
zno derived from bio->bi_iter.bi_sector in callers such as
blk_zone_reset_bio_endio() and blk_zone_finish_bio_endio() can exceed
the bounds of the reallocated zones_cond array, resulting in an
out-of-bounds write.

Add a bounds check consistent with bdev_zone_is_seq() to prevent this.

Fixes: 0bf0e2e46668 ("block: track zone conditions")
Signed-off-by: Adnan Jakati <adnanjackady@gmail.com>
---
 block/blk-zoned.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 8000c9469..9638c6e0c 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -163,6 +163,9 @@ static void disk_zone_set_cond(struct gendisk
*disk, sector_t sector,
  if (zones_cond) {
  unsigned int zno = disk_zone_no(disk, sector);

+ if (zno >= disk->nr_zones)
+ goto out;
+
  /*
  * The condition of a conventional, readonly and offline zones
  * never changes, so do nothing if the target zone is in one of
@@ -178,6 +181,7 @@ static void disk_zone_set_cond(struct gendisk
*disk, sector_t sector,
  break;
  }
  }
+out:
  rcu_read_unlock();
 }

--
2.39.5 (Apple Git-154)
