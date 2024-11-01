Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AFC13777F;
	Fri,  1 Nov 2024 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480755; cv=none; b=Z5XSBjOIdOXWPs/5aoIvRoZlERZdxKK8s9Ou8HShWcEJQ+U9Fzq1/ZrV2DyBVC4jJMh7H6tdSR5INII27qvUqgjLiMIkcaGfiJ/CL9quI/gQq0HByuzBfj7AgiktepZ3np3UJKF607GyrLbiUyDm3Q00APxU2ToKTzkrygR7uVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480755; c=relaxed/simple;
	bh=fvKU8UuaTqRR5Z4LRqcCoG02dwX6YLfJIFDpn1caeS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvZh+4EKDRg01mJ2g1lQi/bMFmPZ4hFAa4UsIN92n+s3NlaqAfUDVWrZShbeN20zKAIV2dyT20lBZizb/vq6sjUsUr0GHLasMltmLA+5pvlrYywRc37RFU9XNEclRKRr1UTPj2BcyLdfOiXNxv9a6R0mD5oUZ2ymPWIwnfCpKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1VhrDEj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1VhrDEj"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4319399a411so18605155e9.2;
        Fri, 01 Nov 2024 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730480752; x=1731085552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmqtkOU6+PBavj/Ih1Z8tJY8WXE1TlCtR2OHsjYS+Bw=;
        b=S1VhrDEj7bw0TAVgFBKFQUKkphObZLo++eb4QELc02oUK2erVZCTc9LoA5JS2suVAM
         Vf386vk495urHWEu+U2XiA4TfgNkuLhbi0+1A4W6cn/cjo1iSJmkGKdKLJxo97CvlfsJ
         spgQkUZ8jkDF4nISi8cN3ikoj+LcKd60+e+jUutbEdWb+Yl4BcJM7O3I397AOP+fg7Uo
         H+MKHR3b8iwQ1eY6pwKyt65lf4p6T0QAC+1oMzYWoYMbwD5Pzr8prZwWM0vWN/NA0Zwq
         /51zReDKo3GP1P2t7QDIU2jmBE8lVg6YVMeHMFRuNvRsizKkAIn/++yovAQyM2+s0615
         jPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730480752; x=1731085552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmqtkOU6+PBavj/Ih1Z8tJY8WXE1TlCtR2OHsjYS+Bw=;
        b=uAHtuw2tqOmaaOWHtsivZDy+Avg903Kcd/bEP8g2IBpWFKB1W1pccd+PbQAWs/hwn/
         aFS1E/ru6NEJ6As8E6eICxsJ2Du94PQ0g6RGJwbvBQfGMnEK+J/xumP9UmK2Nm+QwoOU
         4kBb4/ZWH0HJ5VhEkfCLVGpj3/TKqvu3x3XCLOWuh6SUNE4zcjd0RijJDXDbY9jeFEMy
         pyLBe6YhHZd69/FkpyXJnlQpZUgU772t3LwBnhuvqcd5lXsK5VEmLPYfJnPq1l6WeFPl
         FEiZs79AisJLPGzJL8Iqd9QLsn0ndogdyyu6I2xwothknOSzvYWeg2B42T8mSWcHuetx
         vFEA==
X-Forwarded-Encrypted: i=1; AJvYcCUXLyUvnh8IiRzZJ7Mww9TYXa2vbjvFl8xqvrlKorkU3ARauKdwwV7mgcs236J4HqDmEVEpzUN2zfwWdQ==@vger.kernel.org, AJvYcCVD694WSf6Kl+QOkFZ1dXv25BKCrMO50S+2DhzDIpflj0hv7vph35vfW22ClQNubBZJBprtIJxIf0gIx/EA@vger.kernel.org
X-Gm-Message-State: AOJu0YyIJWgI7CUKqh273Gma4pCrvH57xKgb5Q64m6FcFnVGpJQ1Xe0F
	CtSUQrmmjkCHorvzhXCrhUeMD5g4euoIknW2lR76hBPi4wiOE7O/AtHxBg==
X-Google-Smtp-Source: AGHT+IHZo9f36HKeHQ8nkIIaPeeueznTV0N6jhrOw14GjbzmHqPBsExDr3l3qs5vRNQhImyulbV87A==
X-Received: by 2002:a05:600c:350b:b0:42c:e0da:f15c with SMTP id 5b1f17b1804b1-4319acbb947mr184117575e9.20.1730480751451;
        Fri, 01 Nov 2024 10:05:51 -0700 (PDT)
Received: from [10.0.0.4] ([78.242.150.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd947bf4sm101333405e9.27.2024.11.01.10.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 10:05:50 -0700 (PDT)
Message-ID: <fd0ec853-1f9c-4013-8b5d-89357594d02f@gmail.com>
Date: Fri, 1 Nov 2024 18:05:49 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iov_iter: don't require contiguous pages in
 iov_iter_extract_bvec_pages
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, dhowells@redhat.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.lei@redhat.com
References: <20241024050021.627350-1-hch@lst.de>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20241024050021.627350-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/24/24 7:00 AM, Christoph Hellwig wrote:
> From: Ming Lei <ming.lei@redhat.com>
>
> The iov_iter_extract_pages interface allows to return physically
> discontiguous pages, as long as all but the first and last page
> in the array are page aligned and page size.  Rewrite
> iov_iter_extract_bvec_pages to take advantage of that instead of only
> returning ranges of physically contiguous pages.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> [hch: minor cleanups, new commit log]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   lib/iov_iter.c | 67 +++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 45 insertions(+), 22 deletions(-)
>
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 1abb32c0da50..9fc06f5fb748 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1677,8 +1677,8 @@ static ssize_t iov_iter_extract_xarray_pages(struct iov_iter *i,
>   }
>   
>   /*
> - * Extract a list of contiguous pages from an ITER_BVEC iterator.  This does
> - * not get references on the pages, nor does it get a pin on them.
> + * Extract a list of virtually contiguous pages from an ITER_BVEC iterator.
> + * This does not get references on the pages, nor does it get a pin on them.
>    */
>   static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
>   					   struct page ***pages, size_t maxsize,
> @@ -1686,35 +1686,58 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
>   					   iov_iter_extraction_t extraction_flags,
>   					   size_t *offset0)
>   {
> -	struct page **p, *page;
> -	size_t skip = i->iov_offset, offset, size;
> -	int k;
> +	size_t skip = i->iov_offset, size = 0;
> +	struct bvec_iter bi;
> +	int k = 0;
>   
> -	for (;;) {
> -		if (i->nr_segs == 0)
> -			return 0;
> -		size = min(maxsize, i->bvec->bv_len - skip);
> -		if (size)
> -			break;
> +	if (i->nr_segs == 0)
> +		return 0;
> +
> +	if (i->iov_offset == i->bvec->bv_len) {
>   		i->iov_offset = 0;
>   		i->nr_segs--;
>   		i->bvec++;
>   		skip = 0;
>   	}
> +	bi.bi_size = maxsize + skip;
> +	bi.bi_bvec_done = skip;
> +
> +	maxpages = want_pages_array(pages, maxsize, skip, maxpages);
> +
> +	while (bi.bi_size && bi.bi_idx < i->nr_segs) {
> +		struct bio_vec bv = bvec_iter_bvec(i->bvec, bi);
> +
> +		/*
> +		 * The iov_iter_extract_pages interface only allows an offset
> +		 * into the first page.  Break out of the loop if we see an
> +		 * offset into subsequent pages, the caller will have to call
> +		 * iov_iter_extract_pages again for the reminder.
> +		 */
> +		if (k) {
> +			if (bv.bv_offset)
> +				break;
> +		} else {
> +			*offset0 = bv.bv_offset;
> +		}
>   
> -	skip += i->bvec->bv_offset;
> -	page = i->bvec->bv_page + skip / PAGE_SIZE;
> -	offset = skip % PAGE_SIZE;
> -	*offset0 = offset;
> +		(*pages)[k++] = bv.bv_page;
> +		size += bv.bv_len;
>   
> -	maxpages = want_pages_array(pages, size, offset, maxpages);
> -	if (!maxpages)
> -		return -ENOMEM;
> -	p = *pages;
> -	for (k = 0; k < maxpages; k++)
> -		p[k] = page + k;
> +		if (k >= maxpages)
> +			break;
> +
> +		/*
> +		 * We are done when the end of the bvec doesn't align to a page
> +		 * boundary as that would create a hole in the returned space.
> +		 * The caller will handle this with another call to
> +		 * iov_iter_extract_pages.
> +		 */
> +		if (bv.bv_offset + bv.bv_len != PAGE_SIZE)
> +			break;
> +
> +		bvec_iter_advance_single(i->bvec, &bi, bv.bv_len);
> +	}
>   
> -	size = min_t(size_t, size, maxpages * PAGE_SIZE - offset);
>   	iov_iter_advance(i, size);
>   	return size;
>   }


This is causing major network regression in UDP sendfile, found by syzbot.

I will release the syzbot report and this fix :

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 65ec660c2960..e19aab1fccca 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1728,6 +1728,10 @@ static ssize_t iov_iter_extract_bvec_pages(struct 
iov_iter *i,
                 (*pages)[k++] = bv.bv_page;
                 size += bv.bv_len;

+               if (size > maxsize) {
+                       size = maxsize;
+                       break;
+               }
                 if (k >= maxpages)
                         break;


