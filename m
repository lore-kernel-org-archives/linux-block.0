Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C7B13B7A3
	for <linux-block@vger.kernel.org>; Fri,  1 Nov 2024 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484062; cv=none; b=tCsmr0TMvkq8y7qyizmDpZQ3ycBsyL1CPQ7eqFjEqo/yNfWoEJzkeszMV/cbyn7Bc61YKpT4GiuRBC6bWLkXOGXu+oA3uXjWVDxWewhhBtLtjFXkUdRCDoPigl0zTSlqK72nxFxoBWjLv34pEkJKpXmUvUYuaIQEEEH7G+znfY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484062; c=relaxed/simple;
	bh=lDxX97HRCwte7/+htCKALpm9+jdEA6tzt9fHi4sSekc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjxAlBbu2DcZb+FAguJpaSqiNNpQ866yucxYycA+3+OqdvN9zqCGcGXGehb0CB1+IzccR6WhaZZk54AJKKe/nef/yGvOhcNGzOVs+V3zpzrE9cAaOHog6taK3ms56Xyry+GrbW3nDBAEGrcDiZ1e/d0ODnIXMrl+2FyAs7e/z0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DszDmIyQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DszDmIyQ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c77459558so20172275ad.0
        for <linux-block@vger.kernel.org>; Fri, 01 Nov 2024 11:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730484059; x=1731088859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZxQwy2JqTWj9mxjVfqetkAg0pKbHnFj/zTWURSyf02U=;
        b=DszDmIyQVe2wigfIQbkl0Bg4gFieFC7pq+S78h2K8uSf6p7SW3bkvkCnNI4RXxZ5Nb
         dV2/Lu7JYKPWbVgbFE5kq9FFFlmOuudCkp4U/1Ar7QgGEQ8ojFdrahEOCiGcmx37kD1d
         nvAgNulv7kSV7GBhufqSmu3tlNEhjvnXvk1YvTiRliJJ5ckhtPtYWBPGrBKL2kmfWEvh
         1oNcuxh1iSyWx6Yfrj5ewuzU1EsXZhUHg3t0s+TlOVOsynQ2/+6EU7gkPT4yc5yQLOYe
         yHGnrviCiXZpBzgThL5aHZemh/ERDs4Y9aNlOaNN5N50Sjp/DcnRgQ3P0UFSUc+2XyEO
         uAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730484059; x=1731088859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxQwy2JqTWj9mxjVfqetkAg0pKbHnFj/zTWURSyf02U=;
        b=NiCrBsFXjCC7a0ZSCzp4dqR6j5shtoLmXfpL+sIuNZokxiiKWM4Xeke4Fk3WaV2r3Q
         Ou/pI/F9veBwMt/lWK0wNjS9GZwazMMXJ2//XSgDCH+JAvlKUuwRtRiG/x/pc2UggKti
         d1tYMxKQ+aRq52XLR8kSbMWTZo/UzXEl+Le6DaUWbhdpzP5kX+wEFfhlzUaF5SFJ0Xo1
         LJ7S5aqgdG9MJIwPZlnBSOYWDfTWaqC2xymo7e7bsHrsCY+du9AqY4d1Qa+nYOYapqyB
         p2yHnJSroUootFp6yroUxxw2g1t22GT6NjO8q5ikNgvJKzEEr5D0ruZiwe1la5tszwNc
         AuRw==
X-Forwarded-Encrypted: i=1; AJvYcCUGTqWpLlGl+cVcdMmCdDEbNHNL4OlFnCe8Y8FTfQPZuQWce18WyOd6VzofwSZZngtJR2eEPx6SKCxfaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YywERKjFNaG2ztWX0vMDDbZfPGbU/Rs9I0+bRt4V4NfV9y3LpxH
	Z6WzTEZ46XbxG/Pn3u0Ay+9aWQyh2jsEtu5IbCPlf3IbUPb/gLfpKPIOSKWXAmM=
X-Google-Smtp-Source: AGHT+IHIuaWcf1xcN43PpKZ8niU1vNOkNBowKv0WWyf5GdmO0yEPPdOW4bYmWtdq3vSnbd4UKzDAZg==
X-Received: by 2002:a17:902:ec8c:b0:20e:5777:1b83 with SMTP id d9443c01a7336-210f75339d6mr153711675ad.24.1730484059189;
        Fri, 01 Nov 2024 11:00:59 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a6815sm24201025ad.135.2024.11.01.11.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 11:00:58 -0700 (PDT)
Message-ID: <a6ce38ba-a10d-4126-99c2-bf3d823227bd@kernel.dk>
Date: Fri, 1 Nov 2024 12:00:57 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iov_iter: don't require contiguous pages in
 iov_iter_extract_bvec_pages
To: Eric Dumazet <eric.dumazet@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, dhowells@redhat.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.lei@redhat.com
References: <20241024050021.627350-1-hch@lst.de>
 <fd0ec853-1f9c-4013-8b5d-89357594d02f@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <fd0ec853-1f9c-4013-8b5d-89357594d02f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/24 11:05 AM, Eric Dumazet wrote:
> 
> On 10/24/24 7:00 AM, Christoph Hellwig wrote:
>> From: Ming Lei <ming.lei@redhat.com>
>>
>> The iov_iter_extract_pages interface allows to return physically
>> discontiguous pages, as long as all but the first and last page
>> in the array are page aligned and page size.  Rewrite
>> iov_iter_extract_bvec_pages to take advantage of that instead of only
>> returning ranges of physically contiguous pages.
>>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> [hch: minor cleanups, new commit log]
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   lib/iov_iter.c | 67 +++++++++++++++++++++++++++++++++-----------------
>>   1 file changed, 45 insertions(+), 22 deletions(-)
>>
>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>> index 1abb32c0da50..9fc06f5fb748 100644
>> --- a/lib/iov_iter.c
>> +++ b/lib/iov_iter.c
>> @@ -1677,8 +1677,8 @@ static ssize_t iov_iter_extract_xarray_pages(struct iov_iter *i,
>>   }
>>     /*
>> - * Extract a list of contiguous pages from an ITER_BVEC iterator.  This does
>> - * not get references on the pages, nor does it get a pin on them.
>> + * Extract a list of virtually contiguous pages from an ITER_BVEC iterator.
>> + * This does not get references on the pages, nor does it get a pin on them.
>>    */
>>   static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
>>                          struct page ***pages, size_t maxsize,
>> @@ -1686,35 +1686,58 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
>>                          iov_iter_extraction_t extraction_flags,
>>                          size_t *offset0)
>>   {
>> -    struct page **p, *page;
>> -    size_t skip = i->iov_offset, offset, size;
>> -    int k;
>> +    size_t skip = i->iov_offset, size = 0;
>> +    struct bvec_iter bi;
>> +    int k = 0;
>>   -    for (;;) {
>> -        if (i->nr_segs == 0)
>> -            return 0;
>> -        size = min(maxsize, i->bvec->bv_len - skip);
>> -        if (size)
>> -            break;
>> +    if (i->nr_segs == 0)
>> +        return 0;
>> +
>> +    if (i->iov_offset == i->bvec->bv_len) {
>>           i->iov_offset = 0;
>>           i->nr_segs--;
>>           i->bvec++;
>>           skip = 0;
>>       }
>> +    bi.bi_size = maxsize + skip;
>> +    bi.bi_bvec_done = skip;
>> +
>> +    maxpages = want_pages_array(pages, maxsize, skip, maxpages);
>> +
>> +    while (bi.bi_size && bi.bi_idx < i->nr_segs) {
>> +        struct bio_vec bv = bvec_iter_bvec(i->bvec, bi);
>> +
>> +        /*
>> +         * The iov_iter_extract_pages interface only allows an offset
>> +         * into the first page.  Break out of the loop if we see an
>> +         * offset into subsequent pages, the caller will have to call
>> +         * iov_iter_extract_pages again for the reminder.
>> +         */
>> +        if (k) {
>> +            if (bv.bv_offset)
>> +                break;
>> +        } else {
>> +            *offset0 = bv.bv_offset;
>> +        }
>>   -    skip += i->bvec->bv_offset;
>> -    page = i->bvec->bv_page + skip / PAGE_SIZE;
>> -    offset = skip % PAGE_SIZE;
>> -    *offset0 = offset;
>> +        (*pages)[k++] = bv.bv_page;
>> +        size += bv.bv_len;
>>   -    maxpages = want_pages_array(pages, size, offset, maxpages);
>> -    if (!maxpages)
>> -        return -ENOMEM;
>> -    p = *pages;
>> -    for (k = 0; k < maxpages; k++)
>> -        p[k] = page + k;
>> +        if (k >= maxpages)
>> +            break;
>> +
>> +        /*
>> +         * We are done when the end of the bvec doesn't align to a page
>> +         * boundary as that would create a hole in the returned space.
>> +         * The caller will handle this with another call to
>> +         * iov_iter_extract_pages.
>> +         */
>> +        if (bv.bv_offset + bv.bv_len != PAGE_SIZE)
>> +            break;
>> +
>> +        bvec_iter_advance_single(i->bvec, &bi, bv.bv_len);
>> +    }
>>   -    size = min_t(size_t, size, maxpages * PAGE_SIZE - offset);
>>       iov_iter_advance(i, size);
>>       return size;
>>   }
> 
> 
> This is causing major network regression in UDP sendfile, found by syzbot.
> 
> I will release the syzbot report and this fix :
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 65ec660c2960..e19aab1fccca 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1728,6 +1728,10 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
>                 (*pages)[k++] = bv.bv_page;
>                 size += bv.bv_len;
> 
> +               if (size > maxsize) {
> +                       size = maxsize;
> +                       break;
> +               }
>                 if (k >= maxpages)
>                         break;

Thanks Eric, I've applied your patch.

-- 
Jens Axboe
