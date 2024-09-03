Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A721DC729
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392905; cv=none; b=BQQEmURyvqIaWHM+9W8AvMP2+DgP8OHK+4MCUtqflWawI1lBktrgSyKtt/x3Rlfq0e/cs/B4EKe2o/4Xid0pUGemLOOcfXTAjSrNUwkZTavSeKt7Qxb45ImKtzvLIs4/IW4ryky1q4FcbbCwHy90ss//e50SphUcIE3BKMTTi0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392905; c=relaxed/simple;
	bh=XninZ81pnKnsdesUdChjgW+lqNMdx2/p2eTsWHc4Bqg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ox2eSKYhAyutsaQfD5i1GsVKAtqWieF408KiRbeDXjsQdGCPu2Q2RdwPLHxuRWHkTYlhDRctkI4oyJ1mE/ziUeX4l/O39yczb/EGvohZUVWFIjsg5ooFSKX8E1mwi/HT8IIhogyWI5LnauCsWUhWbIBFSBITDRjSaA8gaftuuFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgHylQ/+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgHylQ/+"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso64494635e9.1
        for <linux-block@vger.kernel.org>; Tue, 03 Sep 2024 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725392902; x=1725997702; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3YNa2pV8ipqWd5RFbagHFYqKbz6ZSzLBF1M2VT4HJcY=;
        b=HgHylQ/+E0YcNEcJQM3KlWzRLCLJixE2rZvy1AddS0IUk49LpuatUzIswH9JRWAFWD
         RPjrRe9wmlo9l18/3x7Pz47UretMX+lv7doL7t+j+8m3EPnOf5XQKsaWY0EUOeM2+Q/l
         ypKBvvGzfDTqBjuVWwkrmonlLVQ68pDAaQzj+uLqMm4B+ts+J0dgQ6iz4My2L4CHxqnj
         xjzv0R3Lo0LOF9xcCnifWM2Rcs8EghuG2afWjQQWwSrAK0MOwFJPFzx5FDSnAV4NpGT2
         BRB2IeVdGrMBTNe3C7mTvBtDCg5h1yGWQvdopksYJfXeJxvIdGjOIKGrbQKD6KKaVmwR
         Ym3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392902; x=1725997702;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YNa2pV8ipqWd5RFbagHFYqKbz6ZSzLBF1M2VT4HJcY=;
        b=C1w69orLhrvKpzJyHD1QTG3gDFaRvez68YvRF68AJz16z6WOPukETqp0tuvN6xw4gT
         qPRWv1l78u6i3PMr8Q8WaRCiRDXEQeDlj5sQMFBiF/SubjMoa3WfXOUsq8WwjohBXCSt
         K/NnvwtfKE2RuwO3iyiDQ6yZcAjJ8IxJ8LR4ujL9czEtd2oXf7dLbAG2ySn6JAFiVVHe
         3jO2bc4Kmf5BPBHr8Yn0tCVBnYfA13G04lht8u7LEWXl06PagnWhI+Mp35/Dw+Pt9paK
         7W9zljorU6XMcJM8I1ysk8Il7nz0G96v9G9B4tnQpyKlKolHFOz5zLKExJYj0hVBtbU+
         8kag==
X-Gm-Message-State: AOJu0Yw34/Gu/1WOi9KtbRu71bL6RGngVxw8wr0Dle6x9kIAnnpdWhNr
	Pj6h6L7hv1Z74vi8I/0ccoWXiQV0j2f2HbDeEwdky9E/E6zr2U78z9+9
X-Google-Smtp-Source: AGHT+IEFNOa7CGDITn5YcwwvJ9xuml0dalGvoRal/6YYNTaXAipQRELsFVpEN+0H7ts9OOEF8vFQvQ==
X-Received: by 2002:a05:600c:4f42:b0:426:6b14:1839 with SMTP id 5b1f17b1804b1-42bb0136dadmr174552885e9.0.1725392901604;
        Tue, 03 Sep 2024 12:48:21 -0700 (PDT)
Received: from p183 ([46.53.249.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb87f7fccsm174408135e9.46.2024.09.03.12.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:48:21 -0700 (PDT)
Date: Tue, 3 Sep 2024 22:48:19 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: fix integer overflow in BLKSECDISCARD
Message-ID: <9e64057f-650a-46d1-b9f7-34af391536ef@p183>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I independently rediscovered

	commit 22d24a544b0d49bbcbd61c8c0eaf77d3c9297155
	block: fix overflow in blk_ioctl_discard()

but for secure erase.

Same problem:

	uint64_t r[2] = {512, 18446744073709551104ULL};
	ioctl(fd, BLKSECDISCARD, r);

will enter near infinite loop inside blkdev_issue_secure_erase():

	a.out: attempt to access beyond end of device
	loop0: rw=5, sector=3399043073, nr_sectors = 1024 limit=2048
	bio_check_eod: 3286214 callbacks suppressed

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 block/ioctl.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -126,7 +126,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 		return -EINVAL;
 
 	filemap_invalidate_lock(bdev->bd_mapping);
-	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
+	err = truncate_bdev_range(bdev, mode, start, end - 1);
 	if (err)
 		goto fail;
 
@@ -163,7 +163,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 		void __user *argp)
 {
-	uint64_t start, len;
+	uint64_t start, len, end;
 	uint64_t range[2];
 	int err;
 
@@ -178,11 +178,12 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 	len = range[1];
 	if ((start & 511) || (len & 511))
 		return -EINVAL;
-	if (start + len > bdev_nr_bytes(bdev))
+	if (check_add_overflow(start, len, &end) ||
+	    end > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
 	filemap_invalidate_lock(bdev->bd_mapping);
-	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
+	err = truncate_bdev_range(bdev, mode, start, end - 1);
 	if (!err)
 		err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
 						GFP_KERNEL);
