Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A34E3C8710
	for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286619; cv=none; b=aqvSx09o9/3P3MYuNfmyZW+4dnFTRrcOGUuNGYtihILuT0f7tfOZCgtnGg9XEwZOFqqHy5DhYvgZStGj7t3h6q4DPxyR1EJI2gspSr3kySuKCx3IPXw1S64v7spsDCOfF7Id8SjwQDxlnxGjDgGucQf5/fh3H2o0qX7jZ+jp3Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286619; c=relaxed/simple;
	bh=9Uw9F7OwVkDoGvSZCwi2v55hPeMIg42rNe8SdL+gTo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxTYtjM9nOlYCvTRfBEdoEa1zPu2RujsxgggbIXEkXpnmH1//4YYXyS6SFzAO2NxgjMZ/92+3SzFeMG6wzoZJH7vCRcGWcLXnUd9+JGSBN+v+Fv/zZKLq5ylL3EZBnS0T2292+3QXEc4NCVb9yEGUZ1ft5u1GZEs0eWb8H4wE7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w6hYZk3c; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w6hYZk3c"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-467e8aaa865so260886b6e.2
        for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 10:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774286617; x=1774891417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nKGOTuIX0ZnaW1UZPr/hJHnJbU9h8TTaf+VWkx9hIA=;
        b=w6hYZk3c05xabYF4YZ2T3mlPDyTThSZ6Rk7Q3LHugqweHRXtc89HL3cTtY/hhl+h+u
         TEwiQwnhV0tzpWEpx5HytAGnlgEm+F/73e0pcjlHCgeFaoAAm7KtcUI9lzJb+tUin8JG
         QvgWBD8d4iXpQjnmEgyDOZXHU2XxeT1BhatKt8x9w9DJR1WOQYOqER7WBx0o0XwGtTSH
         Uc0/mLMp3koeDqHpc6+408LSjQh6W5TezAp3S8j56pVpcgZSae0KvnPoJb3v6xibb64p
         dTdI+DntGR2Gx576cLIzCVS/ZabQ60D02c7YyKl4+PFmVc8dTmdu8x1N2YstxfxSl3X4
         uBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774286617; x=1774891417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nKGOTuIX0ZnaW1UZPr/hJHnJbU9h8TTaf+VWkx9hIA=;
        b=Gv8J7QZdC1Bsz66L4gP5+41cJnkAHzFDGTj+lHLo8RfXySONwCF5bZHvm6Lz24kppc
         VnflO3f1+MLbtLf40i0LQw3RBNcdEk3KQxE8C8jRKabPotbPYvuhGQLI5iicQp2GC4Ng
         Qvd2Qt6RuanyPpYhXMMqX+74/f/Mo16h54Gip6QJ2K8Ra/dSn258KLA0B6ycw4/jJTN4
         NAj/sZs1p7xzg23Oy/sssNb1gr4pBOEUoAjRjBssd+P8rt7uN2EP0HVFjA6z/rSum0u9
         Nv/wQSSuE+DzaijcnfHAx0A/MV5pBd/I4QLSuGvXMFB5bW6wMwAaUS/GNBSVLfWTViDo
         quMg==
X-Forwarded-Encrypted: i=1; AJvYcCVeHA299zt6rDabXGnQXYaW+s9gSdLbZ9UOn/08fzPL83LN8Leg5bK+s0b3qCwMGcPfE9gMUQariXyckQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSCO95RWxJdg8I27bx0s4ZxpKUJg2lnDe5XRaRWRRpWUh01aed
	08Y5okRkve/3P9mUCN83GifSpuqnx9ILD6AH7mdleUkIofRkZiY383UzOERiPBmQny4=
X-Gm-Gg: ATEYQzx84e56mEypZ37P9Qvfo6Pxz4F+dRpyHX1uRoQb1c0CM4qnHUlqQtvt0BV1fzZ
	yPZFWbriE1IkkJH4ppHf1fRvOl+oDBZWb6ltN7aPG16F9Z29tkUcbDnSPBR4yR/jV6Gy0RoNhWt
	TcC8ZaxE4EjVUB2qL8MKWNXl+kDg+kw94j8ShqEk5beCFdNldCATiQXQM3YgKM7Qo+FUKkViNI6
	v0K1gj3GDy7SZL39GwsuRTEP1M2u6GYfA6oYljvsSOR8HNCtAZeGfiIwNyg6R/UV2FEaerZEHKG
	2bO2DjvUTtK9P5DjiWI6J6VA3TJp3Yy9D1ATGpFKKQqiL01jUdKlS8q0VJgco6a+DyNjDGDWQYR
	Cl5Kky82IHgHCoi8SPHidyCy6GiwGdWAk8LMak5nMlGNL69WPnZ6bv8kln5BQgJNQXhegAujz0s
	Y8K6pOuxSaqKMMt3+m+5KFLJkMo0ChMQWCCzb+DsBPNAHEZixdlNR5664Wvq/ygEVFh393yn+GH
	M862bgT
X-Received: by 2002:a05:6808:32c3:b0:45c:9384:3626 with SMTP id 5614622812f47-467e5f60603mr6167383b6e.47.1774286617013;
        Mon, 23 Mar 2026 10:23:37 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7f45ce7sm7242618b6e.17.2026.03.23.10.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 10:23:36 -0700 (PDT)
Message-ID: <f9c32e5a-ea3b-4a69-a269-ba1ebf474992@kernel.dk>
Date: Mon, 23 Mar 2026 11:23:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 0/2] block for-7.1/integrity rebase for mem alignment
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists-infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@meta.com>, hch@lst.de, martin.petersen@oracle.com,
 csander@purestorage.com
References: <20260313144701.1221652-1-kbusch@meta.com>
 <177349768999.37164.10048861817413145882.b4-ty@kernel.dk>
 <acF0aJa-GXGYPqS0@kbusch-mbp>
 <f348e3ae-1def-4728-b8c5-1b32e1e980c0@kernel.dk>
 <acF2l2coqz2K3j-V@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <acF2l2coqz2K3j-V@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/23/26 11:21 AM, Keith Busch wrote:
> On Mon, Mar 23, 2026 at 11:14:23AM -0600, Jens Axboe wrote:
>> On 3/23/26 11:12 AM, Keith Busch wrote:
>>> Did you forget to 'git push' this branch?
>>
>> I don't think so?
>>
>> commit 203247c5cb972af5d46bdb7d41ef40078048810b
>> Author:     Keith Busch <kbusch@kernel.org>
>> AuthorDate: Fri Mar 13 07:47:00 2026 -0700
>> Commit:     Jens Axboe <axboe@kernel.dk>
>> CommitDate: Sat Mar 14 07:44:30 2026 -0600
>>
>>     blk-integrity: support arbitrary buffer alignment
>>
>> and
>>
>> commit 5d540162059598c3f79e12f96064825cc91f0f9c
>> Author:     Caleb Sander Mateos <csander@purestorage.com>
>> AuthorDate: Fri Mar 13 07:47:01 2026 -0700
>> Commit:     Jens Axboe <axboe@kernel.dk>
>> CommitDate: Sat Mar 14 07:44:30 2026 -0600
>>
>>     ublk: report BLK_SPLIT_INTERVAL_CAPABLE
>>
>> in the tree since 9 days ago?
> 
> The current gitweb doesn't show it:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/log/?h=for-7.1/block-integrity
> 
> And I don't find it in the repo either:
> 
>   $ git fetch block
>   $ git log block/for-7.1/block-integrity -n 1
> 
>     commit a9aa6045abde87b94168c3ba034b953417e27272 (block/for-7.1/block-integrity)
>     Author: Christoph Hellwig <hch@lst.de>
>     Date:   Mon Feb 23 05:20:07 2026 -0800
>     
>         block: pass a maxlen argument to bio_iov_iter_bounce

You're looking in the wrong place. It's not in that branch, that branch
only exists to have a merge point with the VFS. If you check my for-next
branch you'll see it, and it's in for-7.1/block as well (that's the
origin).

-- 
Jens Axboe
