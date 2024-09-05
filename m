Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA5DC2FD
	for <linux-block@vger.kernel.org>; Thu,  5 Sep 2024 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555000; cv=none; b=bjKVtutPfL91ATAWV10qXRuTGIPTR9KDQDU9u1P8pbg330PYZkAHTzeqZZpaPHxWcE53kh2ecRSTSWtIGB/LniEwuONO3nYajTZnBXlbiPUv9nn5t9pA0jUSMIf+/hI0KJyvVMxRjl88wANQpRfePFMF1ArNnACkYyZz/4XTb/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555000; c=relaxed/simple;
	bh=6ppMJTCUMDHEIy2+XrldZ7rp1llWL3mtq6EatVCi7i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDego82wtko1z08sTj3KHjGgVIZvO4P/91Xo6Gl8qFZ6zfMO0lkRSCbB9L0l60Ac55MO2PLr6waaYA77SHEWyb20N0rrbumUDeKfqRLcCzK4PYO/2xgMN+sUSUNg0njzEJ4qIISz2uFIKKvjSN1/DMHEC4CEaDYicOr0dXf9OWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZACdSF07; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZACdSF07"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-824ee14f7bfso38498639f.1
        for <linux-block@vger.kernel.org>; Thu, 05 Sep 2024 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725554997; x=1726159797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gzYI42De5EJ7Y+DuQYyo+Knog6etwcYVpNZv0Merlic=;
        b=ZACdSF07KpFc8wDzzIEB2ciTOZTTsK0Dvb1n/fh6pbCI5iPL78SYHsC3bwdbj0+ynn
         IB/7Rppj3lKJS03oGbcJRlzAZvhQ7i4PgG3vXpINZYtB8+lGv8wHdd9lJ/Roz8D8iwJi
         fIPMGorRHM7hjRSB9rw6DTLVG6LjQU4eDuh8JPo/CbgkyiQmEcmMscxJ5uCQZnzJiQIq
         KTEpuDOqF4EXCsFf3tc9vewcIzg6LESvOalZoprVYSflDIcxxfwpHiPSYYpc13sQrkSV
         anpNyuhc7FiQAai1Idb8R2DtolqBsAqUZ6y1VBy97wf3RabBrnAuY6t0lM9g7Ynklkev
         PYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725554997; x=1726159797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzYI42De5EJ7Y+DuQYyo+Knog6etwcYVpNZv0Merlic=;
        b=Y5jXnYTmAYlexyDwo4aKQ7r6f5Bz1KiVVUm7GuIDvY1ZrSDTVUgaB1U3H2fMy9WWw0
         pqdSKIubEGps51aJYHejsqmdE3yPQ6WTKXYhngTBeigUVMSLf+K7B8gCiAK/mXanTTM/
         9qlYfmeIY2Wuh/m6nTn4T4tEu93Nn6lKL1P9K3UBHbesQC/ITv3KEaaF92J0xr8sUYM/
         akZExv4gwzYYppK/8cGJWcBMHFnheI0A7xa5r2ojM6uhRNVaHzgOvhBYEBNBdM7tT3iN
         GpX2CX42LVzXpFNNQWD598h4W+jqWwlmtoJIm/5Kkl2rCx79Gjk2vNHjCQxp6OZBCByQ
         uYBg==
X-Forwarded-Encrypted: i=1; AJvYcCXpGZtpsBsW5UJeYqivq9cg/5gBR4V/N1GO2FmH+JiLzBe4g6RH9RU4jMTkpy3gIhLqXz+6A3mUtzaL0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOCOfIqflAIQUE00fzVzeAEipkbklOsXwegDG4Hf78DCJmoEVl
	4w4DCxgIbpR4QfdHELKRXib8slSzi3T+YQb4xGzrYWVKko12G+1IZrgUpiOVUOs=
X-Google-Smtp-Source: AGHT+IGTnYovPt2hYcnHubtDxpOg5gYI1JO9bdw1XAH4HP10BdiydNOPRjVz5S6Ysw5b9Yj2djDYQw==
X-Received: by 2002:a05:6602:6307:b0:82a:4419:6156 with SMTP id ca18e2360f4ac-82a44196334mr1747748239f.14.1725554997543;
        Thu, 05 Sep 2024 09:49:57 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2de78aesm3713121173.65.2024.09.05.09.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 09:49:56 -0700 (PDT)
Message-ID: <b748a4aa-504b-4e58-9988-170e462401eb@kernel.dk>
Date: Thu, 5 Sep 2024 10:49:55 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Move the BFQ io scheduler to Odd Fixes state
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-block@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai3@huawei.com>,
 Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
 Paolo Valente <paolo.valente@unimore.it>
References: <20240905164344.186880-1-ulf.hansson@linaro.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240905164344.186880-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/24 10:43 AM, Ulf Hansson wrote:
> To not give up entirely on maintenance of BFQ, add myself and Linus Walleij
> as maintainers for BFQ. Although, as both of us has limited bandwidth for
> this, let's reflect that by changing the state to Odd Fixes. If there are
> anybody else that would be interested to help with maintenance of BFQ,
> please let us know.

We don't add maintainers that haven't actually worked on the code. As it
so happens, we already have a good candidate for this, who knows the
block layer code and does many fixes there, Yu Kuai. And they recently
sent in real fixes too. So that's likely the way the needle will swing.

-- 
Jens Axboe


