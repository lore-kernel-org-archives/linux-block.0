Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855DB184122
	for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714503896; cv=none; b=bMlHIc4DV0HSiIYKe7EgKNbMdQkbp6l4kgUlUFrcA7MBkIB8Kt4q2zKNzAfQkr5RPCtAdgWf2T6CXVCPDimUwXPtQewZC8bK5kxLZS5xcMCM7kxUCNn005YsmlEZGeVWEe/mhzhIR14xVBhpo1CDGPEQ6BlLc7azWh9+qOw3dDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714503896; c=relaxed/simple;
	bh=PUmwHRkZpZ8husnv2UW+PtgNM5uFoU+77Xz3woX3+jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwxZj20PIVPnxzcesoG8ilpFBdiedl9oZWEqGcH4veGxUDHW3w2y4PMJ++05Ph4HlLXNOs2MZiv02/EtQhPyQA+dYuq22VOGO2LbUpBjaQUKZJt3nt8EPA0si2hVvs2DDeeKII7HRT94VC240xrLcq8rGoBs0hCzD6ZMvltYg2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZrETWKjD; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZrETWKjD"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7decb824727so18480739f.0
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 12:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714503894; x=1715108694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8YdF3doTeWlJMwEbx+LBvN0OsrsY2e10ycxw5Z87MJI=;
        b=ZrETWKjDHfsrQF+iv3/pmdYdoMJxva4ZWNpbN9RNM7YBmKYsn824FIk3XGR34XJGu3
         ltbSPHIk8e4+v6FHRp8MyOoVYtcTzqWumDZ+xst0Znxxwr1mz4JRMm+X29wVhUAxDiVc
         YFfbLTM5U0E1acfhzFEaH9jS/J93bOCh3PBG+xMigBZFEZUCTB4ExN/f/jf/5PQ8kaH5
         hImHCCpR+EXK3hrPE/EKAuiUpwE+Wlzzvs522RYgLJLsYPNYFqfqkJZykwGuIU5Czu0k
         c5/ZOCFpqSr9ePXRjeBbqYbnvfiRNcyPZy8R0gRBoDIo84xH9ZiGGPa6gu0FwmtXWo41
         qpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714503894; x=1715108694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8YdF3doTeWlJMwEbx+LBvN0OsrsY2e10ycxw5Z87MJI=;
        b=bpTc0gwMzYmuKfnKmvE6V7SRMpRmAjBRvGQFEB/GVVH0euZbwF4OImM2S8hB211nNI
         WTO2vRiuwG8Q+aid1m9CEDK9fPn8Nj95PLtCk2sa4DQCZUj4+Z12fUAlaafx7/fOElTs
         dG+7WUuaDnzWBUGMlGStnff2fWEZJfkEmFpxCOcQDVfTOD0j9FwDM7SgUHSGRl8wpUe8
         Vyzkqrt5/b9GfeKDeqPPxGS9NIRk07B0pviteJ7UZNyIqu2wSQig0E0il8PJ3m3vDEmT
         gtEOtWdN7AHujN+LIUk82r9QAOM1PuYRMsrMeQ8QVIPq+0fO9ebBjoutc9agK4vDk0MM
         xK8Q==
X-Gm-Message-State: AOJu0Yzd570UPiOlOIViD2RRnAj1He83gWfv0mMLOi/iy5j3ujo2GUuX
	/q810c30YFNzpSaLNXs4oqPnAADzz2REJ3Tzv//U/TN8kkC0ZkcPDVUQ64V3RbI=
X-Google-Smtp-Source: AGHT+IFVgLw+AgihydySRNu2M5TSCR05W5WyJs9fmLGdJVjuB078XWLK7FYrKmSFDiHD1ZNqTIIUkQ==
X-Received: by 2002:a05:6602:2bd6:b0:7de:e495:42bf with SMTP id s22-20020a0566022bd600b007dee49542bfmr779930iov.1.1714503894503;
        Tue, 30 Apr 2024 12:04:54 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g3-20020a05660226c300b007deaecfe190sm2315494ioo.7.2024.04.30.12.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 12:04:52 -0700 (PDT)
Message-ID: <4c54e3c8-83ed-46dd-b437-2f01ab1cb866@kernel.dk>
Date: Tue, 30 Apr 2024 13:04:51 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] block: Exclude conventional zones when faking max
 open limit
To: Christoph Hellwig <hch@infradead.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>
References: <20240430125131.668482-1-dlemoal@kernel.org>
 <20240430125131.668482-3-dlemoal@kernel.org> <ZjENF8spyEWrGwws@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZjENF8spyEWrGwws@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/24 9:24 AM, Christoph Hellwig wrote:
> On Tue, Apr 30, 2024 at 09:51:20PM +0900, Damien Le Moal wrote:
>> +	/* Resize the zone write plug memory pool if needed. */
>> +	if (disk->zone_wplugs_pool->min_nr != pool_size)
>> +		mempool_resize(disk->zone_wplugs_pool, pool_size);
> 
> No need for the if here, mempool_resize is a no-op if called for
> the current value.

Still cheaper than the function call though, so I think that's
the right way to do it.

-- 
Jens Axboe


