Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F55E194C98
	for <linux-block@vger.kernel.org>; Sun, 23 Aug 2026 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787476216; cv=none; b=cBUPcoKN5Qz22ci+x84h+vz8UfCKtth3SbmfB3iFVjlPYC5fHxCWBW+HcFZwDj0l6nRSDF3EYFALUDYn/135jsyaaC6G/z52Efs7HxrblE6g2tIGvNkrWqQ8Tcsk/wwHvLmrdwnbAkkAT9PwsbFfFesT3t0NCIbSd0F018/R6Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787476216; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWIl/qbFPoDmedaq/CUZ9uqlN9iBWp+2SW5XRlDLsnpFU3bxxc6U1xOpUHZi59n3VV8aJ4dbiHXwgu3eT/rEYkQMdGdgCmMG86QONi52tXs3iS4ct+B+p/aAhpjZWnLI0YfnMbI2/fuCFwc0ZAAdXaHZIU+nLn8xEmfMiFppmXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso4285992a12.0
        for <linux-block@vger.kernel.org>; Sun, 23 Aug 2026 02:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787476209; x=1788081009;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=d/e1ulcc0DqqH+mm6dRq4HnhK/paU/T4DGi28C4+T3SFA90WPDs1s61FJ/jk2JseI7
         4vP8Hfga6L+QnK8baqxShgfEFAPLMiTrn/4f2BNwRhx2lLfZJLIVFA4iToqR0k+EARtu
         IkvbqaUlk5+5ezZy4hB40LikluPxEBP94QVtwVognc8GLsPqeUslRibeanvbChKNfIof
         EqEUWCx9EzD9nS8qzwy+YNc1cQ9XVetzqCsX6N8ZKxjhUE0u9ri6yn89MqvQy1lQb873
         KfUxfADRZYlWOc32fvl5C58iBjmY5e0BxVd3JP4SnttbNovZBJBqESUW34G1L2Y1MNcI
         CXXg==
X-Forwarded-Encrypted: i=1; AHgh+RrUgeoiRviGOjQXd0IIEp18UUJvqS6ERcJ+UQ/GMhHK4SL+6YbtlWLFiugJ6e1FlU4w9/UTn0FQYpXfnQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kaAaEWvJQR7Q5NYLzOLJejhz3VbpTa0JYvjgNuU0Po4Sojr+ia
	pbGRF8J4rc2wlIS0nQ/QsPl1l/y+UwyCHb9yw/O6EenjMhwaQJ5KEcq1
X-Gm-Gg: AR+sD13c1EWHRSpLyXzSzy56nRxQSnU40p6P8kKHLAEuJleKsbUeBusBWegKq3qq/YC
	eUqcSlAeAtdronFk1DbHam0xJj01d54hWPo6+EmMwBsDDcE4XV+dyR9Ku8AlLZQ9WuV+sVJvyfe
	rEoBURMT4gQ//2hOuKqygmgT3DU6h0ky/CgfTSmNTCTj3zmv0q8E6IbUmc9xBWxqf4HL5lzh+o2
	VX9RUJPjCgnxOPU4+/y2hzavO+BtqURrZyo+8RwZfMCOmVx8bIadIjq2cVViLh00NIUVxTu1Hqo
	FsF2BkJNRDwffQbcC0Aegqy4dQBgiUDPWz5kB7eF0dpXSY8484M7S8i8J42gHvH/ZUGcCsOQK4M
	V2216yRTNs2owzPEjbmAkmTm6nOb1ZpTHATwdt46z/HcS8gR9OQY5x6Kpkm5qzeNERm+RBzNiZU
	osADDJBzbPD1sumHouS4czXmsNn0p7ka4+i/wHEN0qqHEanYtLgJsRPWOYut0tEXCa4ZNGdUDVp
	7zoLiFEDWR/LPJxT30cnDBeu0V77w==
X-Received: by 2002:a05:6402:2b90:b0:6a3:8586:9b73 with SMTP id 4fb4d7f45d1cf-6a42f111a58mr20139323a12.6.1787476208544;
        Sun, 23 Aug 2026 02:10:08 -0700 (PDT)
Received: from [10.50.4.207] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e0190d3sm2553994a12.9.2026.08.23.02.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 02:10:07 -0700 (PDT)
Message-ID: <74219d85-3b0c-4021-964b-3b1d4586509d@grimberg.me>
Date: Sun, 23 Aug 2026 12:10:06 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/5] block: fix invalid zone append status
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, hch@lst.de, tom.leiming@gmail.com, coshi036@gmail.com,
 Igor.Achkinazi@dell.com, dlemoal@kernel.org, Keith Busch <kbusch@kernel.org>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-3-kbusch@meta.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260519172326.3462354-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
