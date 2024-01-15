Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A741517586
	for <linux-block@vger.kernel.org>; Mon, 15 Jan 2024 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ny9clbc2"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cdf90e5cdeso1242540a12.1
        for <linux-block@vger.kernel.org>; Mon, 15 Jan 2024 06:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705328586; x=1705933386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+LWZYg1IMV/uEgaqbKLmuusotYPIpfhO8Q0/VlMREB4=;
        b=ny9clbc29nmRP6dPaCAaflI2SLW1B45bgBRLKmyvvHUGotk2CggQpH4QHDcgZvNkB1
         tWo7s/ueK2p6LDMm9TZcAIDNFRVp6Cgb0QzU+uZD4oHwaq0mm59z27gowyBT1UCt6TF8
         KP44TV9JKwysq26oEjFmT5nQgiuvrYW4te2B/HtmLO3lhIoAUMA0US3xMrYcyRmONDxl
         afb8nPRI36V9WcdFkk8et3yLEEUd+WilhDHtTjk2uFV2JWxoqnjlqZ8mYiHk9+rL/Mxi
         Q0kulr6V1lv3ddFcHLiYQZx1GnjygHrjnrL7IXxIHCFZtzd28EwQuKwOkZigmCScjU6W
         mO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705328586; x=1705933386;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+LWZYg1IMV/uEgaqbKLmuusotYPIpfhO8Q0/VlMREB4=;
        b=TsrPiFzHiVFEVfQjQbUUoMExH667fE8TuQcIuKvt53wmSH2qt7nXF5MCGzPOOR3p05
         XgfODh3bGt61jHcDg37ILOjcMZj7zhRBX6zFE8I9wBSkx45YVjAVjZefv74WRv+SjPY0
         qaDsSkzA6m0Al8JI8/n0nM8+fJN1ta8NDYlA6q+UfapwLkZafZeYZzb+fC+Vz+4XG5ao
         KHbg1THTZwos7zNsxjJEyaVU8/InvGYkGLxHxi0Db0XS9MTyCmbFNZTA7Kv5N6vR3O6r
         DJVSzM44paZE2n9ZKpbdaJrq6ZSwX+jPYAdtX+CCDpz/f0M2gYqp4/83HSegZBCY0jBf
         iZcg==
X-Gm-Message-State: AOJu0YyFMA7U37+6OkNw28bilLuB/MKXIsMtHZft8JytJLGoHXCfH93p
	1Qpu/fAvkW7eRODUOq69Xd77seAFV6O//Q==
X-Google-Smtp-Source: AGHT+IF6vT5ts8E+SRYTAuiD26/PdrnGUdMM40hlex8LTcJwPLefiHrO2xrFLrO3zXEdkDNBQXB9Nw==
X-Received: by 2002:a05:6a21:6da2:b0:19a:49c8:b9e6 with SMTP id wl34-20020a056a216da200b0019a49c8b9e6mr12242516pzb.0.1705328586531;
        Mon, 15 Jan 2024 06:23:06 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id z4-20020a636504000000b005ceb4a6d72bsm7944298pgb.65.2024.01.15.06.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 06:23:05 -0800 (PST)
Message-ID: <44a974c6-b552-4461-b3c7-801fed6d072d@kernel.dk>
Date: Mon, 15 Jan 2024 07:23:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix some typos
Content-Language: en-US
To: Nicky Chorley <ndchorley@gmail.com>, linux-block@vger.kernel.org
References: <20240114082532.10751-1-ndchorley@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240114082532.10751-1-ndchorley@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/24 1:25 AM, Nicky Chorley wrote:
> Correct some minor typos in blk-core.c.

Please don't send typo fixes by themselves. IMHO they are fine to do if
you're in that area anyway, but if not, then they just cause unnecessary
backporting pains.

An exception would be if the comment is completely wrong, then
we surely should fix it. But if it's just a typo that doesn't impact the
readers ability to understand it, then let's please just leave it alone.

-- 
Jens Axboe

