Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E9C7483
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745548828; cv=none; b=CjPQg6sdm6unHV9lOpkWfSNbc0zM15mkCHb9w9ckwIMYljQVqN57n3iPt+CbXMkvqb/88pqhVBdwsnKq8FJAU3vPWUcq/1oJTUxUXPQfzwPNMdgv+O/7jUqGzlZzRoexnM7tRcWHgViw1DdIQiYhNF/SR+50j+le7VFdj5RSHBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745548828; c=relaxed/simple;
	bh=IOc9ugYjCFV82Pir4bUEbckx+boiU5DHn+5MOzPNxAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVw//5fOhbIme3VFvgG+lJlB86eeB3ItayGmBcgciAi3MyS1455sZLmS2UI/wMhravOcswRUIMQ30xge0Vz/wXIj/gdzm2ZWiWxd7glnLAGrfImege8M9/wffX1+Iecm+2GIlfBEOS6j2Us0idQ6DVDkJpbs7D3GzB6ZS52oFFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=k89EETB2; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="k89EETB2"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso9651065ab.1
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 19:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745548824; x=1746153624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=viKGbo00S5J9vQp5avpf40UBRQJ3a3rob14D32XEglU=;
        b=k89EETB2BxL0ZZPgqwjO7H+bxACT24dsI7bEyfJY9uKSPmbUsyhaN1Zcl+74l0JyVZ
         uGW9s5XJkyHhGnCPJGtUuJcuoNOf77JRd1IHy/SG6SDBI1+/XrA3nj02Ca/6xowlD8Ai
         QJCkwGmFzW4hUaipVy+uCAQclozJ3mxkzM/3aFvXRL7z75qVkPbtGQXqV4JGBB6hpAac
         X8lBvO5duu7Ei3p2Rosy717Docb50OenF4mOHlJEdepp2BXx6vvWbti5yd9sfceCzH30
         eg4tn7Bm9mLnsQvJLbhRCS5k5rJ1UD7jWgz0Jb2OK3NlsHyefbIiRBE8fMpcOTEvjrxZ
         rgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745548824; x=1746153624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=viKGbo00S5J9vQp5avpf40UBRQJ3a3rob14D32XEglU=;
        b=dBehpwJ3hWzPuG+6KphRuRowsYNZVJqzpFt3LhiA4bzANkIpHabWzLX3EMiHwGznMy
         RMc5aeRcqjf9GoUJ9yBIh+52CGtQPjYIBiHyHnRtTTY/Ya6+yuQ9LKOeACoMy41/z9m+
         EVOKTWWSHkzWYBTumKh5HE7sBomtmFhF9gNC/fkEW8KhBP7+xZv1t9+t/nrx2H7xefkP
         HMp7LjsA4x+q3ItLMCj3beaXXedhR4mro1MXEbCgWAJykDUCecWfbBfKA28ZwGMZOcQC
         xBX7K6Q7CDyHWulTDI2ENxymR4MA0wX9NpvujyuFGzzPbDRjf6gB9WTbF1cwhNvKEiOG
         08fQ==
X-Gm-Message-State: AOJu0Yx4sUNFLFBNVebLMXK7AvZJ6gH63M1cfx0hE8XRk7vTBq5djuTY
	CCK+6oDOKAAG1uBXGVMvMXT+7cKjqdD9MvtYuhkfs5J0/yV5UWfE4MzkJed+6HA=
X-Gm-Gg: ASbGncvEwSOK+rDLgtz5qkjegHORXnrz+clOOc8fo4j5BXPKHXv/cUjbXKvx9UtIm7k
	lfPHS4NzD+Jn8uf0cCog7+jY3Yzg2hyZWtzuE4KKqmX7vMChJSfm5TJaicErpkjp6Hc4BlRkLsI
	Pjo5kVa8A5OkVeHm0bLeCI4EBO8jJIrDvnd2zMcHH38jMB42q7nB7QiAcVVN/S6Z3U7NNoeae/t
	XqYAvaOunN0ENKUQOCkclJi3kMFYmoGQPnfcLN+5+fsJSzORPS+OKDuZVXZ4TiP4MSDtX2W5rvr
	9n0udSnMryT4/QzYVNpYE/qRg9axbixgDpTpLQ==
X-Google-Smtp-Source: AGHT+IECJV8CCdR02FZ0JRlS5jxcu364IcbtNEm57VRDcxWQt6J8PPzMYUElfcOziYG+iGtCrCI6bA==
X-Received: by 2002:a05:6602:608b:b0:85b:4ad2:16ef with SMTP id ca18e2360f4ac-8645cd5b2c8mr80694539f.9.1745548824606;
        Thu, 24 Apr 2025 19:40:24 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824a7fc65sm566012173.71.2025.04.24.19.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 19:40:23 -0700 (PDT)
Message-ID: <55e0a09d-08fc-450e-ad8a-8f4ff8cbcfbd@kernel.dk>
Date: Thu, 24 Apr 2025 20:40:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] ublk: refactor __ublk_ch_uring_cmd
To: Uday Shankar <ushankar@purestorage.com>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Caleb Sander Mateos <csander@purestorage.com>
References: <20250421-ublk_constify-v1-0-3371f9e9f73c@purestorage.com>
 <aAqyM1DyLL22b7S9@dev-ushankar.dev.purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aAqyM1DyLL22b7S9@dev-ushankar.dev.purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 3:50 PM, Uday Shankar wrote:
> Hi Jens,
> 
> Can this series get queued up? They all have reviews from Caleb and/or
> Ming.

It can, but I was assuming we'd have conflicts between 6.16 ublk patches
and what is queued up in block-6.15. And looks like I'm right... I'll
merge block-6.15 into for-6.16/block, and then please re-post a version
against that.

-- 
Jens Axboe
