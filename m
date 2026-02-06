Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B117993
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400891; cv=none; b=bUukxThxLEOoRJkxxgxkCt/i/PAmpGCgJbMq/u7WnaWmhhidyPiRsZwrKP0IIPuFB0aIRTs4waBBvjcqOwgIgw31HURQINLMrerOg8G6eSjqoV9HnsS80Xc2wbjaB2h32En+oiyOw6/mV72NfO4zu0s57Q/C1WxBplvPi8Pf8E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400891; c=relaxed/simple;
	bh=lSzknfIv//vW3XrZo3ZB5GwoTGxjRj4lI8kJmwNoH0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VvLU6CKedZkC47JHDEI3sAAF8You2fTfIxjMtebdS81huBGCbyagV6JAJt7d/5EqI4hHLlmsCcXBhBbL1Y3JyFxamAfp4qlBvNLDdsGAYAkYqvpDSss7+g5EuNny/e4elE61kVkJwgO4mUzdzrSTwZ9kHsUAeBQrUfAOIHMRRpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXH925yQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXH925yQ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48068ed1eccso25362905e9.2
        for <linux-block@vger.kernel.org>; Fri, 06 Feb 2026 10:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770400890; x=1771005690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=chld7W3Rbl2PUp6cBiIbC1iT7uESUsO9DngY57S8hBw=;
        b=nXH925yQME2C/lv7xU3N2pyQIphEEpo2HaEr2mjExOB/V12/17synnPdfVx259zHFa
         s/OseDtCvCMxhdFsZLcZGyLFKeicyTGl9TNKK2V162hPxUPSZHxJvxdUWBxeC/uRPbZV
         ba34+SNbt/Tyv8GVhI7vlL39IXY+/iV9t0h1tjdxAzd5rIXvEQYsjGIB/YCOysu+iWg7
         Iu/7ambw7HtnGIKk40JQ/GMgK1cQalk+dr13K8cVTiJXvWpMR0GV5NdL01XtEFRO/VwC
         HQnhdy7a0ZGyIpNM5WWwzlA4q4iNp6c8P5xGdITM5xHOLCZj2YzbHJzegInrFimdGerZ
         mTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770400890; x=1771005690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chld7W3Rbl2PUp6cBiIbC1iT7uESUsO9DngY57S8hBw=;
        b=SGn1Dvyy4U3V564QyJyX7bhS+njinpzTDS7vY9ssyuSmXiJ5EvGkCeYJRHg63kCWKa
         mLdNHlqaaueL0EF1wDu2qkIWmW+Xdts74pegAkfbdSgUHFJxBZLmvBtEop6HlFEMmCnA
         oeqTjT2xC5zjzW5XAUOiAB4x6xvID6a92xrC3TukJwphmTGIYPQF+lLtks4BzyXbDvA8
         O28b5p/05vj7sIdRM+8AG8YrA92SsqluZNxeMV9KRMZt1/c5jYxRMFIRjPiDs5stfjvd
         BEJ+WAZNh8Jox9zDZoVoNMDwGwDAHz37jX5o63QtYZvkQKk2ulzFC7LVYf7hf8JPP3EO
         QE9w==
X-Gm-Message-State: AOJu0YyM4wdZWH+bzk0Cy+nBM6kX5sjb929SQThpyvSnKaeoEG3X6b/L
	qGgPEG+GxWD93HqbKETxyIrs2yVFAQPQ4yFhd18c+fslsoZQFYWA8/LI
X-Gm-Gg: AZuq6aJiEogPt6LuDtmfWSwkennWodXAd3C/jJt+lTNJrEBiUNkSikSi3e7bdQGQ79n
	wh2n6ku6cIOLMlLQGqq3hugRGX739P3g7qnNQLs7S8Fu1qGIY3GqYX1Wk2PkLKWzA7/grYQUyqW
	RVLv2Gcfydfqe38XhU/pl0/kTYML+/vOrwH0DLkfN+Lq/FdQkklaB2Jh0VnIt4JEBTCFPrAVHfH
	1OUjY1Nb64tLq3AIGZijtpi0uJL4icp6ClMpk3YT+2mW0zjp3QMgAVsizfdsTEYNqSmhuVIAgrB
	In1hle22ADpXdVODwKm349DTFqRd/4ZmzpFubybVSPniEqGd/pe6AEUUHNc5fgCG7y4GNmpoy8M
	tcr0Q6i/C5XAHLt4ex2Q0SUbMOu7PIu5/Y+gNEinltrnIYG8n6SDEK+RbXFb48HuwqAa0nvbtjT
	QJx8byyWcVtRlwKDfSfzJS7uEijfLzgySdITb+Nkx5KVOIzlxBd2Brjz2s/1Jq9Nn4FerrRucz/
	BKBjljQ1M6ROoEoaHrPKJmSi28qxIT7rb/0ce27id8v2lEaGQCwwcvEuGUJxwwVyg==
X-Received: by 2002:a05:600c:628d:b0:47d:6856:9bd9 with SMTP id 5b1f17b1804b1-48320216d31mr49104765e9.23.1770400889507;
        Fri, 06 Feb 2026 10:01:29 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483203e126dsm51230805e9.2.2026.02.06.10.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 10:01:29 -0800 (PST)
Message-ID: <b0ec01bc-4cbd-431b-bcdd-084cc14553be@gmail.com>
Date: Fri, 6 Feb 2026 18:01:31 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 05/11] block: add infra to handle dmabuf tokens
To: Anuj gupta <anuj1072538@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
 <CACzX3AupFeAy0-pPsZ51ixd7qW++LYYjiKBZ3aK5Y2JDrB_JWw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CACzX3AupFeAy0-pPsZ51ixd7qW++LYYjiKBZ3aK5Y2JDrB_JWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/26 15:08, Anuj gupta wrote:
>> +
>> +       dma_fence_init(&fence->base, &blk_mq_dma_fence_ops, &fence->lock,
>> +                       token->fence_ctx, atomic_inc_return(&token->fence_seq));
>> +       spin_lock_init(&fence->lock);
> 
> nit lock should be initialized before handing its address to
> dma_fence_init()

Good catch, thanks, I'll apply that and other suggestions. And I still
need to address bits Christoph pointed out during review.

-- 
Pavel Begunkov

