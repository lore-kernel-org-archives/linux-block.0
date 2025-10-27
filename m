Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5E531328E
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582319; cv=none; b=GO2wGhyTzZpvhqcr46g+/nw7SVT9P4s8pxZjuA8s2wxmlf3qhN8M4JugdsLUboU+X6glT9msWaUEF9R9XU5ad4Ot32dcCx76MsDDiIdCdxZSu/E1RicFgT3bgr60bfDUz5AJPVfqArb4e96Gu2u7z1pDBtZ2cjwx5ZbEg+6eakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582319; c=relaxed/simple;
	bh=NHQFCgdRmLY6YieuNEQSpa1ugmd876uhsKPea5BZfmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsnFK/IW9fe1ur2SWZ4THnwWoD3ncg0M7hXF6YSuXpC0dX1mzV01AgoevnIfN0r4zz5EXlq2qmLQIhizdJApc0UrHO9pmxP1cFA6oMkg5WGXLQwcCfEzBS6fSgbZx9IleT8+ko5vlhX6S8x6n1n6+cssVfdifTOfobJkOzGWH5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asAfw8Tr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asAfw8Tr"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27eeafd4882so438895ad.0
        for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761582316; x=1762187116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OA9l/QOwE9NOyiyFNsn7QxEhEu+4ZD2/v3QYZRP7FEE=;
        b=asAfw8TrXNe52MgTI6zG0ry59roNbXBnzpbwCOKcDmHjHIf0j++ZKwWNpcVYZcLEgR
         krxwL4ebPR/mhv+JnBNVyoZ3TgP0+nscEkL/KEtq8amoAqnsXEkM1TeBp6jJDznUK47u
         rkaBuf7952qvWZ+1RfuCQM4+1OqaNTg79oTyv+6P+u13T18Kv1BvGiCA1YwjeXn2AF55
         OcKeaY//V6ad/JIXwSNj44WFDbXPgcIxQG/LIkBBTsyhW2BlmiWo/gpePLeN1F0fhaxb
         1ZpqgTepjH6vOLvN5vD2qTrTm5GcxbHAtMAwOxIfV982TNz4of30hfhDjJ52C3LfkKT0
         jteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761582316; x=1762187116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OA9l/QOwE9NOyiyFNsn7QxEhEu+4ZD2/v3QYZRP7FEE=;
        b=On5UKvkN3Nvvwt0SQtIggKYy0zecvFRso1NusXv9MVg3nkZAMv1m3OVPNOoOJ7nbz5
         2ssBsULsoMkTZqcJuXpGckWXpwQVTcEKhBbCS68XqEDzecoKD90CPDtwgU0LDM0d6aws
         cgtBcPwHKMz5fViNIFGVjz8xJqzv+Oxtm9H+FWz1I1SuN2iJRTTCDuG8BsyFqfbvRKY8
         AXYVgpBxJmqWGciZowq/ym/YXIwMNTsMn7Hm1iyFDekB+fLnU1dcBmQ1IAU7qfk1q4T6
         JflOxKJ5cfAOT0YvJZ1FPmK1NjOCyFCxX1jGIqwXskgl8wM91UeVZAnsy2rF7pv8dkTb
         7v2Q==
X-Gm-Message-State: AOJu0Yw5fLEFsZ1FDP2SK8UEHMD/iMd5Cgl8qZWishG7EBvXzgVbFDN0
	y5t8+PHRJToMO1z2GxyY3PAt32wNoC9QeOG6mvYWo2PDU5rPXYu0o7eWaInfACPpNA==
X-Gm-Gg: ASbGncsH79M7NDa79VclfVCtxiE81o0KVz+FWT62nom70KqMom0TlfdYQQme3ocmB5B
	SG1fcs8cTN2xnqix09UkzZGGmp83QsoZ1cADo7eyzBDumOyIS5l7KcIpVnK18XVWlXvhe1FtqFw
	kcZl8bTItEQNVlsu59ZYgitXnzLzwCBtvFc0BUF0Icd/6okr5P8tlsG8BIEmbsWnPyZNi3GIy2w
	mwp7bKg7GOXOEgaC6MKgeFDyyi0hOrSkXXUcLK0D2pIBF7zGYBWm31Glg7o0U3E/fgRjr+qGARR
	OHLa6ldWc7Qja28AbbswdXLui2BoJoXrc3bH8iFMkLKC8nzwUCSWHJexMcQ143Nqv5bCP+HgXNu
	DV+CqOGpWmdNl12d8JqWINLaNlL/T+WRx1sMvBvkhGLaMKKmWjZSSYTaWuw2v5D+bHEnB2KyTIp
	TjVUuIFlqTodLbYa044X2kSuqjoqBrihIIeKMql5g933sOxbdzZhWf6rbm437QMRB7Xk0cTZF7Y
	l7zw8CPcl3+jl6O9OBLqdsF
X-Google-Smtp-Source: AGHT+IFKZDRX6tQRN5pvW3CwhpfGgubDP1vSSsxiWhhv07ddyAa3jE3sqUCokPVKtw7qF4bHsuW1iw==
X-Received: by 2002:a17:902:ce84:b0:274:1a09:9553 with SMTP id d9443c01a7336-29497bb4f1amr9734305ad.6.1761582316225;
        Mon, 27 Oct 2025 09:25:16 -0700 (PDT)
Received: from google.com (235.215.125.34.bc.googleusercontent.com. [34.125.215.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed74028fsm9091554a91.8.2025.10.27.09.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:25:15 -0700 (PDT)
Date: Mon, 27 Oct 2025 16:25:10 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4 5/8] iomap: simplify direct io validity check
Message-ID: <aP-c5gPjrpsn0vJA@google.com>
References: <20250827141258.63501-1-kbusch@meta.com>
 <20250827141258.63501-6-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827141258.63501-6-kbusch@meta.com>

On Wed, Aug 27, 2025 at 07:12:55AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The block layer checks all the segments for validity later, so no need
> for an early check. Just reduce it to a simple position and total length
> check, and defer the more invasive segment checks to the block layer.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/direct-io.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index fea23fa6a402f..c06e41fd4d0af 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -337,8 +337,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	u64 copied = 0;
>  	size_t orig_count;
>  
> -	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
> -	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> +	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1))
>  		return -EINVAL;
>  
>  	if (dio->flags & IOMAP_DIO_WRITE) {
> -- 
> 2.47.3
> 

Hey Keith, I'be bisected an LTP issue down to this patch. There is a
O_DIRECT read test that expects EINVAL for a bad buffer alignment.
However, if I understand the patchset correctly, this is intentional
move which makes this LTP test obsolete, correct?

The broken test is "test 5" here:
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/read/read02.c

... and this is what I get now:
  read02.c:87: TFAIL: read() failed unexpectedly, expected EINVAL: EIO (5)

Cheers,
Carlos Llamas
