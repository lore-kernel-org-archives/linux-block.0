Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B074030C146
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 02:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785984110; cv=none; b=A/Sup+B+RZU/BeVkj5HIIfr8CDGJu0O/Sv6VkhcWowV5gbDeFbAKMSRyMwROofW3qsKJZFuxJs+MIq5uAi/lajeroA0MJJdJnqmE9EU3gLctd0JkibNYPb5f+nTQzip/YEzjZPYMwbNm8nCD9XhHpJfJSbR3yxsKxwUfbNyh4pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785984110; c=relaxed/simple;
	bh=S15LZOm+KfHL9mBtd6aWQBqL0BNGnQ8cfSi1s5Qwqzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NK72ujAHz+rayseY7+T+GSROBzEACZce5e4uXo75uJ0SvzsYiOiQWVhmFosgiT90H3FbR0zUmWX60EkOfGpFDpyAEIH/R0eD7JMRCom/hq8llZfNxKrLE0nWmCXl1r349MQO1BAVx+3lR6dR49XYiFgz12wHSMtFm65snUyn6qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H7zPE9zw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H7zPE9zw"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d049069377so17819465ad.0
        for <linux-block@vger.kernel.org>; Wed, 05 Aug 2026 19:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785984108; x=1786588908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EdkmU1B5dTzWBQ42Bde/rqNgo2V5GhgoLHg+J+XmMtI=;
        b=H7zPE9zwIFuqtLRkftfVodwJwA2mLCMumQofO8NoM3yPsxsgGYY7YEIIF5mh8rSv0w
         nU31ZEPIR0kWaVpx1p3Hjc7IpQ0ixt0SH0W2iIDFq5/OZy9bVw63hHaAPmYnu3ADTX/R
         YxKXGpLZbO92MOR0D0wXIY3Z0y3YRRQBEZE5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785984108; x=1786588908;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EdkmU1B5dTzWBQ42Bde/rqNgo2V5GhgoLHg+J+XmMtI=;
        b=tN9WrcVfEbH757Tf75UldQaSKscQ0rjswn2ELLVUbxkIRyzjH9uhORG1iXZdfGu9tB
         tP6owCw/FAEYxejrvLA2akMXqcF8c3R3q9fophDucwCoeBpYjm2vdABFeV2yqJCYhQ0h
         8Csm4PTGUnX6Nho3Ocx6UqMmvcK/yjYnvIFo8b52dmL2QrCHd1Zxj8kSYuXppS0UrElw
         zx4JgEY1V9fIFU/wEpJqSNXbu7PUmVVm1YL+l+uDqvlwn0RjyNlpjJLBOxwdGSm4twpc
         Rq1Gq05Fw+zZsBKtp+el1MfcFSVamrmRtiaXzVLilX0cN2J1uaOVd2QAb8m5l7jnteds
         CvMw==
X-Forwarded-Encrypted: i=1; AHgh+RqP9fIjMyxMSEYsA91jYAMWm72x0mQ6Lp1FdUkWNdClq9WMUSRGE27klg5apqQA7johP1RgW/PQPSV5KQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx1nRuH5/WEi1dlFKge3NYbLexZfqxj+QUzdXEYSDgZg07Dglo
	+ygb5HHlj6a3z2vx0eIxiGM7NGBfAtgICDOe9bxx5HXELkqDzENKO5HLxJyvF4pbqA==
X-Gm-Gg: AR+sD13dbeRDp67cnoua53dr5OU9vGE2veQgJ3FVzJxjgai9DCy1kIWumvOo5YnDHhy
	zZg9SqY1/9uT9I8weQueSMSyjE0CTVdHkLrvCXiTV7cef1JllLe0QGUtJ6ZNSvM28imjjBcet/u
	glFFDDoOI2Uhf2LyI0YcF9YB+nyDfaJIbGm/fC0hukvfcbHvhTJ+oLYfTEmNaXh74R2tEd1n60P
	NqA98ufaKQOFO0wNuM9jG+BG0nF+FuQCu3vsktxRkbY5CkhuzeuZF7ymaLVmlfEl3ZoabrQQ8aI
	/wqiHXRuoo9gLwh6zwONWeJTERh0PPYQs5CCWAmb5UNKifzppgrsBKWjefKiaB13wLez3Y526wz
	OYNO0fz8au8QTwPBSG5JNiZ72ErQuZ2u4xRvV0ivqog0Vi2WiTfDR5OHlbbs0l0uJYKyv0sFw+N
	gj0D2HwCqvdNEbztOPFrugGKOdWV43/utxtQWPvcqBDmaHS6I0TavGlotYycMIyNI0S2gtdnBeZ
	kNa7ZHsKvCnjXE1/DqpwfY1cdMG
X-Received: by 2002:a17:903:3c0c:b0:2ca:b4b9:4586 with SMTP id d9443c01a7336-2d0ca981aadmr143618055ad.19.1785984107913;
        Wed, 05 Aug 2026 19:41:47 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8002:2a47:a704:5a58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4cf714sm23091755ad.67.2026.08.05.19.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 19:41:47 -0700 (PDT)
Date: Thu, 6 Aug 2026 11:41:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Longlong Xia <xialonglong2025@163.com>, minchan@kernel.org, 
	senozhatsky@chromium.org, axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Longlong Xia <xialonglong@kylinos.cn>
Subject: Re: [PATCH 1/1] zram: reject disksizes that exceed slot index range
Message-ID: <anPz9jWFvXlc8BXs@google.com>
References: <20260804143832.146129-1-xialonglong2025@163.com>
 <20260805115424.a0c8abdb9bbd2f7caa6fb66a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805115424.a0c8abdb9bbd2f7caa6fb66a@linux-foundation.org>

On (26/08/05 11:54), Andrew Morton wrote:
> > From: Longlong Xia <xialonglong@kylinos.cn>
> > 
> > zram uses u32 slot indexes, while disksize_store() accepts a u64
> > size. On 32-bit systems, a disksize larger than U32_MAX pages is
> > truncated when zram_meta_alloc() assigns the page count to size_t.
> > array_size() then sees only the truncated count, so a small table can
> > be allocated while the original capacity is published. Valid I/O
> > within that capacity can subsequently access beyond zram->table.
> > 
> > The same oversized capacity also lets full-device scanners compare a
> > u32 index with an upper bound larger than U32_MAX, so the index can
> > wrap instead of terminating.
> > 
> > Reject disksizes larger than U32_MAX pages before aligning and
> > allocating the table. This keeps the table size, published capacity and
> > slot index range consistent.
> 
> Oh.  Rejecting large devices sounds severe.  Can't we just fix the
> 32-bit trucation issues?

zram historically used u32, I never thought that anyone would want
a 16TB+ device.  But we don't really have reasons to limit it.

I can look into converting to unsigned long, Longlong is already
looking into it.
