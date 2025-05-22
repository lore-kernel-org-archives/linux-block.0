Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7141E47A8
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747941751; cv=none; b=Ct+twj8QntiYUaevWdvcUGTQoPgf8mfb4oMaZSiDX1XGvnACNHXBv3qLc+rWZNdp2uMkxcK6pNZmDv4PdR/BqFXGTAe8vGswaV0HXEEbup2TaBZDayfOuEV8AuAaANhAVff56fWT04INTUk7zxtp8dPz6wP4Ex6v0uHlNaf9ngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747941751; c=relaxed/simple;
	bh=0Z26MqgcTOImtc/Rea6ADzYZJmlhrBMtNSggPUWESpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbjtX8vl5UwqLdOItLuty1O7zUu/EtPspW64i8+ZE9MVz8gYIc3qCfycfte3cCkM3JEmDj07lKRVqxlzHE8aHBM/m5+W8ILMZ34pTqRXcxJ48gvK0PufPgbghyvadmi57uYmDSErr9TnDCJzxrpnSYy1xKcvZKihqNV6SZn78z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=I4KEani9; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="I4KEani9"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4b3J8N64Fzzlvq4c;
	Thu, 22 May 2025 19:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1747941747; x=1750533748; bh=Hlsj0CNm0FNhCgCvXMuT7qCE
	UtEyzcx7IgOufwzD5bo=; b=I4KEani9lRtHMVQz8LZym4oJiZWsUYPwqCqDUkWx
	oLNdjofBjmy7L4vFMTAj5iDAZwOnhT1uPb+qYEIZbMGr3uQSKIz+kxbmuohMKSy8
	jtpIfg65ueHQt4dtND2c6C718ENRVh5kwOAJ/GIWFgaDKwGzD+kbaY4aUbDd13b4
	mhc4X3XSq/VGLoMHB/HnVNgNANjn6WFmlI4j5A5GNrp6isNpRqaUrF89WmYdG8Vt
	JB7XVVvnyLChSXwG+Cd3hu+4sUBXis+pi5tjz1sS8uBTK3p+SW5+vjGcm1xKY7jV
	JvgnaaimBk7C8NGnSc8Qjd3Lkr7hb/k3bKTri3i5jHxOLw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0odirWVGG6U8; Thu, 22 May 2025 19:22:27 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4b3J8K1tWqzlvnMh;
	Thu, 22 May 2025 19:22:24 +0000 (UTC)
Message-ID: <468be217-40d5-4674-891e-d11cc96b1c2a@acm.org>
Date: Thu, 22 May 2025 12:22:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] block: new sector copy api
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250521223107.709131-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/25 3:31 PM, Keith Busch wrote:
> +/**
> + * blkdev_copy - copy source sectors to a destination on the same block device
> + * @dst_sector:	start sector of the destination to copy to
> + * @src_sector:	start sector of the source to copy from
> + * @nr_sects:	number of sectors to copy
> + * @gfp:	allocation flags to use
> + */
> +int blkdev_copy(struct block_device *bdev, sector_t dst_sector,
> +		sector_t src_sector, sector_t nr_sects, gfp_t gfp)
> +{
> +	unsigned int nr_vecs = __blkdev_sectors_to_bio_pages(nr_sects);
> +	unsigned int len = (unsigned int)nr_sects << SECTOR_SHIFT;
> +	unsigned int size = min(len, nr_vecs * PAGE_SIZE);
> +	struct bio *bio;
> +	int ret = 0;
> +	void *buf;
> +
> +	if (nr_sects > UINT_MAX >> SECTOR_SHIFT)
> +		return -EINVAL;
> +
> +	buf = kvmalloc(size, gfp);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	nr_vecs = bio_add_max_vecs(buf, size);
> +	bio = bio_alloc(bdev, nr_vecs, 0, gfp);
> +
> +	if (is_vmalloc_addr(buf))
> +		bio_add_vmalloc(bio, buf, size);
> +	else
> +		bio_add_virt_nofail(bio, buf, size);
> +
> +	while (len) {
> +		size = min(len, size);
> +
> +		bio_reset(bio, bdev, REQ_OP_READ);
> +		bio->bi_iter.bi_sector = src_sector;
> +		bio->bi_iter.bi_size = size;
> +
> +		ret = submit_bio_wait(bio);
> +		if (ret)
> +			break;
> +
> +		bio_reset(bio, bdev, REQ_OP_WRITE);
> +		bio->bi_iter.bi_sector = dst_sector;
> +		bio->bi_iter.bi_size = size;
> +
> +		ret = submit_bio_wait(bio);
> +		if (ret)
> +			break;
> +
> +		src_sector += size >> SECTOR_SHIFT;
> +		dst_sector += size >> SECTOR_SHIFT;
> +		len -= size;
> +	}
> +
> +	bio_put(bio);
> +	kvfree(buf);
> +	return ret;
> +}

Is avoiding code duplication still a goal in the Linux kernel project?
If so, should the above code be consolidated with kcopyd into a single
implementation?

Thanks,

Bart.
