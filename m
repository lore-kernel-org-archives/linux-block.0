Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811CC1AA1F4
	for <linux-block@vger.kernel.org>; Sun,  6 Apr 2025 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743968410; cv=none; b=dXwOMt6quV0h8jSxHVelMjjoX2tPnQaV4LzN1OA83NNyiF+SGjjO/8sYUPsgUQYUvRkXnMK6+fy4h10y1RrysYLSDJpllsh3LH/PMD/EK4o80ZM9CA/7jXT1wR8Qch2pufsmD5MtiPvQznes0Qz6SR/Ii1xerQ1eHJU7lSbV30Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743968410; c=relaxed/simple;
	bh=slLbUHpczO//KKzP4cgazr8GXbC5c+QCuhuKBFgd2/M=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=qEU/nDjAeBdJa2j7/i+05TBRBPqJ+Dv/DgvYQoe8uzI+vfVGAXo9AtN2Pr7lp0B1Ly4/W1lyDem6nhs9M07YIi+03yS0D6z8g/kmoa0zi3LaAy48pxi0EnW1N2RHrUSUdnpxTlg1p7JGN0adLcDTnOQ8rCTKL30OO9IXEm3IkkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1J0kesf; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1J0kesf"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5f20d512fso35848585a.2
        for <linux-block@vger.kernel.org>; Sun, 06 Apr 2025 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743968407; x=1744573207; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mO5fydfHAKGvoUzu82MoiuIQJWkfokSlR1XoSOQYf9Q=;
        b=A1J0kesfw8337shULYj3yymFyrppAzuOYRIiOnM9gZCz3KF4a9CUoOGwJmTzh2SKdO
         y+NtZA/fMnhCeIkNRQRZRfDJI3HTpjpzHuqOB7FyPWdDmT5ADv5o6W0mp80nPjqa7iXi
         5dPjRYOBYRqtfnldrCPs43Ntg3BW+em8uslvHnUIF4JzCXogeXO2Qi83w7At9WWUL0/p
         gWUeaCrrMWa+W22VlIXmsWZ20sSoC+xvjh1nn0/x8n6kjz72WAJu4ZKMaFRN1/sHPeuO
         Ys4GnqeDWOuR0oxKMy5VH+YTo5GzTUCZvkcu+zb7aVDLzvOZjg5KuUgftYBEHw+hhEKh
         bvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743968407; x=1744573207;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mO5fydfHAKGvoUzu82MoiuIQJWkfokSlR1XoSOQYf9Q=;
        b=wnSn+L3TI3ve1dS/6fQzRYpw0/Gk2sRo1lfoOon+MDNUxmNHC/nxUbNgadw0IwPitj
         FPFNhHnMpTYMTZS8McUF90UB+yyAQllxjjB8SQ294MwtjNMXIzD9EdGk85ims7V4Dyfd
         2f/LzgD8Fe7PXCN4ArFXC5d+35c5NHr21F0ifUcVRikwxuJcxywS+AgonOyVWg//sqhN
         ppkAd+Rxlujs17RjbeuxTkdKckTwBG9re4fbUTczSZd7OqSzZxqqFoQqScjxS3w1ZJvr
         0HrpTqDirp3p1/fyuek3Ydla3s0bVRnZGxR/8h0KP/zRl86CShUtkZYZrMHi1zRf9FmB
         UPEw==
X-Forwarded-Encrypted: i=1; AJvYcCWWz+JNOlw+mO45in728ZImPfpCMqdh03EU8XivwEcd0xVCM7lr3tyR2G4ZlgqA+i6ymPH0KbhLjhTZzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjbM5ZegBvo3ZiFr3zuN0Ho4pANPhlzG6e9HQ1WL7p6Xhy1M2M
	QzDKefGFQRT7qLt5wq3acFbs6/xRVFp4dsjjzVJiUwNtthubqmrU
X-Gm-Gg: ASbGncuSiYck4VvjX+cRG1nug9hVMYjxgZUUcpocWarZsTQ7d7HqtvyNG6L6FlrGg3h
	sMYpKKxDVixcYKmS3TEi1EngDO+1lzU4DbxmV6Wy6Wukf1HR214DpFrvCVE6yaxaA88U52iK6Ck
	AL6FPHZTjKgdBlEYWZfssI8mFqdpMutGFH/KdSLSonDtykOKN5qPQBavNIN1jv2j79NM830ZZwn
	+3Axa71FmCO5FqJ9FEBMXveT/T26rm3z9o3kTZdbddldsVETfSEEidr1CHULoniePf5PaaK7HiX
	djTm9K8kAHmEI6BQVumbkShH5ZaDQbstL+mwLsvXgXExewVSlpRIsPTEEXiPhNycMgiE1TmtDLW
	lDlopb20rnvpT8ZlVkNn/
X-Google-Smtp-Source: AGHT+IHshaNiVavKgRypG9Q1JakhTzWtRhNgywqkAA7FhQPQTwXB+tzfd7Sn9ZKxA/TeaV8FIOT9EQ==
X-Received: by 2002:a05:6214:27e9:b0:6e8:8f31:3120 with SMTP id 6a1803df08f44-6f01e7b21e6mr48014746d6.8.1743968407204;
        Sun, 06 Apr 2025 12:40:07 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-176-137.washdc.fios.verizon.net. [108.48.176.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f0483a3sm49244196d6.63.2025.04.06.12.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Apr 2025 12:40:06 -0700 (PDT)
Message-ID: <8dfd97ac-59e7-ae69-238a-85b7a2dae4f1@gmail.com>
Date: Sun, 6 Apr 2025 15:40:04 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
From: Sean Anderson <seanga2@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, Zhihao Cheng <chengzhihao1@huawei.com>
Subject: bio segment constraints
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I'm not really sure what guarantees the block layer makes regarding the
segments in a bio as part of a request submitted to a block driver. As
far as I can tell this is not documented anywhere. In particular,

- Is bv_len aligned to SECTOR_SIZE?
- To logical_sector_size?
- What if logical_sector_size > PAGE_SIZE?
- What about bv_offset?
- Is it possible to have a bio where the total length is a multiple of
   logical_sector_size, but the data is split across several segments
   where each segment is a multiple of SECTOR_SIZE?
- Is is possible to have segments not even aligned to SECTOR_SIZE?
- Can I somehow request to only get segments with bv_len aligned to
   logical_sector_size? Or do I need to do my own coalescing and bounce
   buffering for that?

I've been reading some drivers (as well as stuff in block/) to try and
figure things out, but it's hard to figure out all the places where
constraints are enforced. In particular, I've read several drivers that
make some big assumptions (which might be bugs?) For example, in
drivers/mtd/mtd_blkdevs.c, do_blktrans_request looks like:

	block = blk_rq_pos(req) << 9 >> tr->blkshift;
	nsect = blk_rq_cur_bytes(req) >> tr->blkshift;

	switch (req_op(req)) {
	/* ... snip ... */
	case REQ_OP_READ:
		buf = kmap(bio_page(req->bio)) + bio_offset(req->bio);
		for (; nsect > 0; nsect--, block++, buf += tr->blksize) {
			if (tr->readsect(dev, block, buf)) {
				kunmap(bio_page(req->bio));
				return BLK_STS_IOERR;
			}
		}
		kunmap(bio_page(req->bio));

		rq_for_each_segment(bvec, req, iter)
			flush_dcache_page(bvec.bv_page);
		return BLK_STS_OK;

For context, tr->blkshift is either 512 or 4096, depending on the
backend. From what I can tell, this code assumes the following:

- There is only one bio in a request. This one is a bit of a soft
   assumption since we should only flush the pages in the bio and not the
   whole request otherwise.
- There is only one segment in a bio. This one could be reasonable if
   max_segments was set to 1, but it's not as far as I can tell. So I
   guess we just go off the end of the bio if there's a second segment?
- The data is in lowmem OR bv_offset + bv_len <= PAGE_SIZE. kmap() only
   maps a single page, so if we go past one page we end up in adjacent
   kmapped pages.

Am I missing something here? Handling highmem seems like a persistent
issue. E.g. drivers/mtd/ubi/block.c doesn't even bother doing a kmap.
Should both of these have BLK_FEAT_BOUNCE_HIGH?

--Sean
