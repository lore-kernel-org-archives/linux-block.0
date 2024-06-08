Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DADDF4D
	for <linux-block@vger.kernel.org>; Sat,  8 Jun 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717856434; cv=none; b=LM3bnMi7lBqptZvQZywi/eE5ru2BeY6hQipt5qdzsrE1OY9ncX+tNmaQsfNURMrGKl4Wt81r0GX5Nz9FizOKEaRjnGTUTJMJp484gbscCBWF5kxR43TK/9GnfM/QX6ifdjmTjMGg/e+yJ80f8QEo1WIH4b/bVr04RAwjynHnPcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717856434; c=relaxed/simple;
	bh=+M95M9zM1Xua8hLu2L2ls9vAwk3ZDAl8SUNCcKayYaY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bju1iO5zyQtFzIxgz8zC3mQwslPwuB+a8pJCCx+xEJPL0lbnt1M/2H35mBRQm9O+FwB6+GEZmHiZ1Ugiwxj6EdwcA0KZ6IyHz6vdfichIWSjZjvnuQtI1Favbk/wM3N4tpSeOxTd/j50AmvVomnlmdRe5Oknn9Yqpnz4qStg4LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bgscm9BT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bgscm9BT"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4217f2e3450so1990675e9.1
        for <linux-block@vger.kernel.org>; Sat, 08 Jun 2024 07:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717856431; x=1718461231; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpgMHDW7HWh9PLrJnkCM+8lSoR3+8r8fuxKhxkK/TZE=;
        b=bgscm9BT8mxBoc5WSrrmHMvVwlfnGlZtBqMM5VV5I4zx76ZA25VoCdjloCqBQFXKM6
         O2QWJflOHiysCXlFl9cyamX66AH8unhL3mk6taCb3lyoXtfQDIEepVQf96ANH3ZDEUdT
         8X+VfqgQu6RxyJR1T8NrmNUpO9NaB5W3+wYp3SyEF6iBjZJ0xIaH3ARPAmPBOXO15FL/
         BCetjVhAu+90m4+5WYVT1Y7yM18h3Z+otN+K5+wQCuNmqdzJIs7BjAS8SjUIze9AQGGL
         U/E0lEn5/QzSJ4EkQfKBfgk/ZGuS3UKxNT8UQD36oi1hr4sK+tcDtuXyOwhpjB90LhDb
         3MLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717856431; x=1718461231;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpgMHDW7HWh9PLrJnkCM+8lSoR3+8r8fuxKhxkK/TZE=;
        b=tEqyxkrojvWd+ToPt008OBmWkDQtrfFf/IiZuko8j/ZqJx9GLvKKTpxBR8uCSHHRIU
         Fg8ImqR5BUhxzU303XDMYKy3QfID1zAlHBKJbQefu/uCHDnzexT644mgnTPNYJlmx8xT
         Cwe2Y4y+XxkxJA3gjHMdOT881EnCOy6UvFI0apcnseKN0x9vcm9DSAeFOIeAIMIjLN7J
         nI0fPUSBXP5yQd347DkAhNcEBicbAOKKrmteTzOjsOiK1nR6I3wGqkdR8hqASJf8NiNK
         avclTFNlLd1d4ii3CwplcKu/djufGxA/OmO24DDqpEvpCC1tJG6zWo2xeQwqnXPWDQac
         heow==
X-Gm-Message-State: AOJu0Yw7i1iPE2RlknHfKte9Rl+kaLk1uPB0AE4MkOuDxzArFzC6vJ/O
	4A4yBwtA0J/Y+o/rjfLseQl2RJEC1oxE1E36w/xm8mPC2+WspRThcuzhES//9JiCUQl22IYjyW/
	N
X-Google-Smtp-Source: AGHT+IHJBo2xPAQXqmkJm53Bst2/Q2ZUqdvyZbQKJKalb3sdxQXDnFgKqe+7g1CFchPhjzv1lVujZA==
X-Received: by 2002:a05:6000:1f8b:b0:357:3e5a:6c98 with SMTP id ffacd0b85a97d-35efedd7db4mr5738080f8f.48.1717856430586;
        Sat, 08 Jun 2024 07:20:30 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d49f72sm6482540f8f.41.2024.06.08.07.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 07:20:30 -0700 (PDT)
Date: Sat, 8 Jun 2024 17:20:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org
Subject: [bug report] block/bio: remove duplicate append pages code
Message-ID: <af595d26-f8f2-4b84-81fd-09cc81049cf2@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Keith Busch,

Commit c58c0074c54c ("block/bio: remove duplicate append pages code")
from Jun 10, 2022 (linux-next), leads to the following Smatch static
checker warning:

	block/bio.c:1307 __bio_iov_iter_get_pages()
	error: we previously assumed 'bio->bi_bdev' could be null (see line 1291)

block/bio.c
    1253 static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
    1254 {
    1255         iov_iter_extraction_t extraction_flags = 0;
    1256         unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
    1257         unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
    1258         struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
    1259         struct page **pages = (struct page **)bv;
    1260         ssize_t size, left;
    1261         unsigned len, i = 0;
    1262         size_t offset;
    1263         int ret = 0;
    1264 
    1265         /*
    1266          * Move page array up in the allocated memory for the bio vecs as far as
    1267          * possible so that we can start filling biovecs from the beginning
    1268          * without overwriting the temporary page array.
    1269          */
    1270         BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
    1271         pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
    1272 
    1273         if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
                     ^^^^^^^^^^^^
Assumes bio->bi_bdev can be NULL

    1274                 extraction_flags |= ITER_ALLOW_P2PDMA;
    1275 
    1276         /*
    1277          * Each segment in the iov is required to be a block size multiple.
    1278          * However, we may not be able to get the entire segment if it spans
    1279          * more pages than bi_max_vecs allows, so we have to ALIGN_DOWN the
    1280          * result to ensure the bio's total size is correct. The remainder of
    1281          * the iov data will be picked up in the next bio iteration.
    1282          */
    1283         size = iov_iter_extract_pages(iter, &pages,
    1284                                       UINT_MAX - bio->bi_iter.bi_size,
    1285                                       nr_pages, extraction_flags, &offset);
    1286         if (unlikely(size <= 0))
    1287                 return size ? size : -EFAULT;
    1288 
    1289         nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
    1290 
    1291         if (bio->bi_bdev) {
                     ^^^^^^^^^^^^
More checks

    1292                 size_t trim = size & (bdev_logical_block_size(bio->bi_bdev) - 1);
    1293                 iov_iter_revert(iter, trim);
    1294                 size -= trim;
    1295         }
    1296 
    1297         if (unlikely(!size)) {
    1298                 ret = -EFAULT;
    1299                 goto out;
    1300         }
    1301 
    1302         for (left = size, i = 0; left > 0; left -= len, i++) {
    1303                 struct page *page = pages[i];
    1304 
    1305                 len = min_t(size_t, PAGE_SIZE - offset, left);
    1306                 if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
--> 1307                         ret = bio_iov_add_zone_append_page(bio, page, len,
                                                                    ^^^
bio->bi_bdev is dereferenced inside the function

    1308                                         offset);
    1309                         if (ret)
    1310                                 break;
    1311                 } else
    1312                         bio_iov_add_page(bio, page, len, offset);
    1313 
    1314                 offset = 0;
    1315         }
    1316 
    1317         iov_iter_revert(iter, left);
    1318 out:
    1319         while (i < nr_pages)
    1320                 bio_release_page(bio, pages[i++]);
    1321 
    1322         return ret;
    1323 }

regards,
dan carpenter
