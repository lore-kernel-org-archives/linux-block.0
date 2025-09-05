Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5252C11ED
	for <linux-block@vger.kernel.org>; Fri,  5 Sep 2025 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070607; cv=none; b=qHzm1AUC3jbQvXHA7EBHUfsn7UwJITVOKaRBb1pOur22kRKolj4YZ4Gjys8hcNEocKOViYhwJ5gH22+D4WDwVQ1cx8NYY+7G7Rb/34xSAdLVgMJyQZDcnadcGXI1gZB7kSfknx4FIHSt1SqjxrCkpijfNxYCEP4Zkt7htsSlMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070607; c=relaxed/simple;
	bh=QPzWZEX1+iXz4xeWsm/Ze5/xwkDEBmjRNEiNpyWm4nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URf3eDBNM5g3Un0phHPzrfckpsKzmjYUYUx24tpi+1YRTBgwtQiqM8hfq000uCh0JThBynaFZTJkLwGzf7d6OZcjGqgSh+wDFFTwZ37A0LLsTIgInYrI0yeRE4LH9IjzKuFDaURj/CVVJ5O4gql1BZpO/a74BjPY4kKOKcy86Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BaL9Or17; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BaL9Or17"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e9baa0310cbso1948292276.2
        for <linux-block@vger.kernel.org>; Fri, 05 Sep 2025 04:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757070603; x=1757675403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kH4k+vgMusymzilWVtDDzMEtxH2riGhE/9BXIqTNcdo=;
        b=BaL9Or17dwtAAa9OvtnhQIrNq/MJ7+oRpFw5aCHjYMkiOfaVGrx+p4lKIiyqK/Ry+I
         xTNztdSVHCnNrzqwpXGAmYXGJkXqYqH7SSLu+m+tXdxZpzod6nvbl6l9HS6/elQ2fAod
         TgDxRC8lpMQdYdgwh0KExciUt+KisB7G5bRvNN/El1/aLMXKTZOZjZeylw1gpJuYDQx7
         X7KlGxErZ40CtsQIp+NEWu+BIIEbGkrc1AeM7se5K7NCyUXnqFSbdTMnyEwcdY2LLfsH
         xm+UI24SeRgW8XvDHqJQ1jPnH4kO2UVaQvP3D5w5jwXmc6rWRMnxNvFPLGQaKtLrP8FV
         Pa8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757070603; x=1757675403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kH4k+vgMusymzilWVtDDzMEtxH2riGhE/9BXIqTNcdo=;
        b=aPM+NmmOz/zQcbrzm6muRacOxHxjrN8SZ2BOsqjOcoPrhK0l5FiOq8bTdJ+3V8wVnx
         4DkvUawiY/RhZ7iECAwpMkxYSrvbMHPYYFKLB9AdmL5r8tQEQaTLUygkaU9jInwDu2ze
         W3mJhBowsoyTlHJ+f4rHrh8JMv49qeSi8YDUAoaNrZZ4plGuJrkJtAijMEH+k6Mgm9On
         rGhLLwCF1jrSJcGzfcUM12H8ZDOu2oiGRwV/5DXubSF42JDXYA/G+ROLomNpQvk8lzTE
         xWfnpRafo6QE1QjNG+J4QqQl/M6mDjQdbVloUz3Ca0yRWpDvNNZkPdbgUrBa+wIoRcnf
         NWXg==
X-Forwarded-Encrypted: i=1; AJvYcCWvOVSZ26P6jdQhI46PjnwzORmj9++4DkzOSXF+8J4hoV8uEsgv019sC545psuqbcseaRrsQcLRuzgqGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHeAwuQAy6XYnwl3hb7AtLrB/eMZ0nzHfQLAa4FbcqZleqyds5
	Yey9SXieiuxrLLZU0wbl1RqyVFWDTo6S0HFsdf83/7o2UWZFUPR83SJ2aBqlVLWhBrY=
X-Gm-Gg: ASbGnctGsJxKBEICDIxl/RT0HLpzBT7GCrl9zLplhJn5+OEyZ1+DrBId8AopsPOqyY7
	BHWeOXf/jgbNxsPdisRvY39LWZ8z0HYqnje0CICMsskdTznu3stG2KLW8FLJpYYAG5bRcoaUqmS
	nM3UIBPMG7yU/4s3CeFK4EwadIPVLWWIYrM+r4EIEnRaFdd1NCYuyvgczEY6hByiuYxhgAvtSw/
	Mr41aOlb6fs3svQ67ATJDw1ma+OJX42nKLCzE31AZwMxsHWzikynUtddk4NeRMwiXjZa7Zd//cB
	OK0moBjYBHpKKSFUcu9t2s80WR5rmby2cGsATzBmQzk1h0dKI6rTK4y2R+i7JypEO9AsZX44xtG
	yfTkMja3pFRbecB/NLQ==
X-Google-Smtp-Source: AGHT+IE607H1ZTvS2ezW84WkH7Jo8Ljp6fWy9CEubh0Qr+eCimJIp7duBSOXT7YtyNwwo2EprTo1Pw==
X-Received: by 2002:a05:690c:338b:b0:723:c010:c3ac with SMTP id 00721157ae682-723c010c58fmr85163677b3.29.1757070603044;
        Fri, 05 Sep 2025 04:10:03 -0700 (PDT)
Received: from [10.0.3.24] ([50.227.229.138])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723bd2cd669sm20712167b3.0.2025.09.05.04.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 04:10:02 -0700 (PDT)
Message-ID: <47c46735-2e23-40b5-b0b4-9db39e59ceef@kernel.dk>
Date: Fri, 5 Sep 2025 05:10:01 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-6.17-20250905
To: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
 inux-raid@vger.kernel.org, song@kernel.org, linan122@huawei.com
Cc: yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250905033517.1179192-1-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250905033517.1179192-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/25 9:35 PM, Yu Kuai wrote:
> Hi, Jens
> 
> Please consider pulling following changes on your block-6.17 branch,
> this pull request contains:
> 
>  - fix data lost for writemostly in raid1, by Yu Kuai;
>  - fix potentional data lost by skipping recovery, by Li Nan;

Pulled, thanks.

-- 
Jens Axboe

