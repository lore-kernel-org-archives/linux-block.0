Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9749DE54D
	for <linux-block@vger.kernel.org>; Mon,  1 Jan 2024 21:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hdsr7phr"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-58962bf3f89so1650254a12.0
        for <linux-block@vger.kernel.org>; Mon, 01 Jan 2024 13:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704144420; x=1704749220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8kpBoPyhUaQAP/gLzTZh/k1bq/vx+Y3mPraIQNXEeM8=;
        b=hdsr7phr/y9IYt06Z5ptd6KmNu6vQODXjRQ1LMdPvDKunk/cHKOtYtjzylBltoAhDi
         iqrSZg1ANSJRgcCO6/dT+vsZT+0MevhfHi4elDEXpnY+Ef160jlPrXFH65nFbpFepy3E
         rU6cz027U7V9BB8rqkP3SU88UmoyiFZaniDZMO0yDV+hsbrHYhSDszzoXrMSLkhKP4k7
         UB40jEBPRs88I7VFM4cj0PeDZMKY9k9/WgMRUTr3B9IeBt/gSlPFHIb1mySkm7m0+kNC
         ldxgoGGEA9jOuQTCQgQ6oMwUrM6MiPj0k92sNz4LOR0H8OX4bUoTa93LeRpPQ4iMVhkg
         rvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704144420; x=1704749220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kpBoPyhUaQAP/gLzTZh/k1bq/vx+Y3mPraIQNXEeM8=;
        b=mRt42ZlEqWyLqrSkBeDTagznph8iKg47NnoIbBEhrTV9KR8qsuFnIRPVo2wZZCvhug
         0QvNHq81IMFSSzzjqWsfwKdKwncKfWuryWOTRs8/1h+eeYpyqZURW9EaMbtEvUbHbVwn
         bKqwqG2xcy1WyNKn+9/YFlYR+8M/pTRk6Ij9QigQ4iBcWImRCdRouoeW8J7TPWbCOQHy
         7Ay8ZkaAfwLdyLTo0kxxzEkVcRFBF8AzMgJNic+H8l2ppEx+JcRfbO4N8xKMAnJAXpDh
         z+JfEGd7TW+R86/lDGq9+QixafaIfqsatdgbbC9aMo0mk1YxNf45aVlNt5LdXnHvfHtD
         5CvQ==
X-Gm-Message-State: AOJu0YzyNpH8Yh9wjMTCYRlD9lF9jd+PSMNwbBrW9nOvzvZ1/tp0Eme+
	rT+p+tZTbbNRApsujcegzlPYgSflxE+7Gg==
X-Google-Smtp-Source: AGHT+IH60O+WpJhiQAiTUmpw9aw4g+0VyfS3W8LLnbH7pnoug16WNT1+Bsebt70bWPu99FnB4b6w4Q==
X-Received: by 2002:a05:6a00:6817:b0:6da:83a2:1d5e with SMTP id hq23-20020a056a00681700b006da83a21d5emr5282807pfb.2.1704144420574;
        Mon, 01 Jan 2024 13:27:00 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id b5-20020a056a0002c500b006d9a16ca748sm15997842pft.122.2024.01.01.13.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 13:26:59 -0800 (PST)
Message-ID: <cb12eefa-9588-4244-a1de-b1ea62f6096d@kernel.dk>
Date: Mon, 1 Jan 2024 14:26:58 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix length of strscpy()
To: Guoxin Pu <pugokushin@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240101175051.38479-2-pugokushin@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240101175051.38479-2-pugokushin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/1/24 10:50 AM, Guoxin Pu wrote:
> In commit 146afeb235ccec10c17ad8ea26327c0c79dbd968 ("block: use strscpy()
> to instead of strncpy()") , the length that should now represent the length
> of the string with the terminating NULL was not updated alongside the
> change.
> 
> This has caused blkdevparts= definition on kernel cmdline to be not
> correctly recognized and partitions not correctly initialized, breaking any
> device relying on such partitions to boot, on stable releases since 6.6
> 
> This patch fixes the lengths to contain the terminating NULL.

This needs a Fixes line.

-- 
Jens Axboe


