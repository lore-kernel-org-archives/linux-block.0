Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C38C1B27B
	for <linux-block@vger.kernel.org>; Wed,  3 Jan 2024 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce942efda5so1703333a12.2
        for <linux-block@vger.kernel.org>; Wed, 03 Jan 2024 07:55:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704297323; x=1704902123;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0OnKKY+fbrv22QVni3DX5GzxsdBophteO91sfC0m9P8=;
        b=rzJIB1Mhi7UV2gccHNXujaiAxFMKm+LBGNRMYDAgggAAGWUJFQzr2wlxZvgKtTBJkA
         VHqHv6zbqUZ30gEtZskezA/8cVeBkqyJY5g1r+WtSTzpfXhNAW4QfYIZKYydHaVkK3w2
         ucrQxXG6XVneDIRhD2MgomMQPnUAXqVpABlFlMaB9Yeo/lusMt6XxOvwGuXoYj5pFNHA
         Kq95EHm6J6ndKYHPaznneXun3o1sqVEmmkwEH/PwddMhSx/rCl5CVznrZn/6EgnfvNha
         qOEBG1oZGKL0d60x1IiZwbLQd7Q8RvUBtp8U1nxxA0xt4MymGuu8/U+L5gP+Prl0yqK3
         cUXA==
X-Gm-Message-State: AOJu0Yxg9+w1V8Ech3bTJfWYr5nvafdBzy8w9ATKknmRpHRlG6QGyGxZ
	t/TjsDH9UztRjxkpTUXCNZJPbJziz1E=
X-Google-Smtp-Source: AGHT+IGYbjEa7UL4hG1pY8vPWwN8VojBLolqQpnFGkS83U8HdgQ/c+MXzl4q5zWVMvozzs5M41ycAw==
X-Received: by 2002:a17:90a:ce14:b0:28c:1eff:ac45 with SMTP id f20-20020a17090ace1400b0028c1effac45mr8687645pju.77.1704297322858;
        Wed, 03 Jan 2024 07:55:22 -0800 (PST)
Received: from ?IPV6:2601:647:4d7e:54f3:667:4981:ffa1:7be1? ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id pq8-20020a17090b3d8800b0028b845f2890sm1927268pjb.33.2024.01.03.07.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 07:55:22 -0800 (PST)
Message-ID: <34ea6da8-9ac6-4449-abb9-5be02df08869@acm.org>
Date: Wed, 3 Jan 2024 07:55:20 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 1/2] common/null_blk: introduce
 _have_null_blk_feature
Content-Language: en-US
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <20240103114940.3000366-1-shinichiro.kawasaki@wdc.com>
 <20240103114940.3000366-2-shinichiro.kawasaki@wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240103114940.3000366-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/24 03:49, Shin'ichiro Kawasaki wrote:
> +_have_null_blk_feature() {
> +	grep -qe "$1" /sys/kernel/config/nullb/features
> +}

The above test can only work if the null_blk driver is already
loaded. Is it guaranteed that the null_blk driver is loaded when
this function is called? Wouldn't it be better to examine the
output of modprobe null_blk?

Thanks,

Bart.
