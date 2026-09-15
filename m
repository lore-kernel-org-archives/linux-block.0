Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551040B11C
	for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477102; cv=none; b=Udm/2XkZ7jj66hjJWr9Bh72XyX/NajHVC8EdJvS31Zb0fl4XgQAODuDfO0DsOGdkW6bL8yfl6A3Hps2eVxGGnA7kP5CO8oeaSMJy1IU7MawwD2zcs1JgJeFUfqRh8LfZMXS00g/Q0ymnd6aDFTgyijKAObsVFxWt0aBgQo05jHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477102; c=relaxed/simple;
	bh=VM6/gTszegzLDkMhRYU8SiMNJVw7mv9dYOaeox6jj+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ll4W66Xz3woUv5IkSBgxyoP+z/LF+qrYb8pvCPSz9lq6vwKDyEArkXtE3+heEHkESxwE6b4jEtJ+K4IFppAz4ue3mMqOg1jZ2lumFcZkfXFzubZknVQr5EcrwWHXL0r23UNdWj44QTQD/1ZZSINsJWHNgY9t7LNkIx/hXjiiqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=sjfgPR1N; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="sjfgPR1N"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c2790ccso1891782f8f.1
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 05:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789477099; x=1790081899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Er0zjJDdbxqw+VhqpF+p5WmT91AIHucD89gdFQHtXtw=;
        b=sjfgPR1NVfwg5duhN/v9eWc8qyPFSqWXZDPiepN+XxgCnHY/E/SLT5uGaZiELQDafu
         25lDGGjnHjfu8kFSetZpkKa6bjlrBT8gEa0ZDILUrfqulkWQHeIRpYq5DG7U8Iewv6KP
         lWbkBXUryXxjgbK9SCxR/cUAy+grzlLSMAV4fXvtsH8XQ2/Uh9QMy7U3Scowt4HB/zXR
         7AadAQAP0qH26y/cInV9wQkV6BqAmi2OhvU1KAJz8lCBa6s6OKc3EyfEIYV748TxbJt8
         XOl+RP1fCGp8x14HW1IcBEZUzeoxe2A2JmTrPB9MuRaPpRlIiGkrmr1F1tbyHF/8veEg
         YGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789477099; x=1790081899;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Er0zjJDdbxqw+VhqpF+p5WmT91AIHucD89gdFQHtXtw=;
        b=jshob0jR9coS23v6K4wv0iA/M9bmy5S/GHtd2ROKuilQlLgagsSTO5ghXvAGhTxryR
         eiZJeC5Wx5vOJQrEWkhjyaWAfED5hGxtrSTMjDGLA7LLVVETnB0mHZcNgqZGXYvtVXxl
         SiHDnXm5KMz2nItxR/cecXOrJnk2M478JdtntQn3kRxd1aAAZQYeI1UKkawkKzYDlWTJ
         xQRlp0DXhjIIuZ6bW2S/I28FLS9m5wu9r9YBVkjnebemoq6CdcNKGzV+g3ASm4JBgDES
         qYHXlLt+cKKNV4PbQ9MFC8QsJ+RpyIBoWoMKCubiVbg/cMTDyfFtneQa9Loccn8pbkpi
         lVAg==
X-Forwarded-Encrypted: i=1; AKwUvByLmt7NZvqbyZvC4VGNFTBYJD7EDbf0Bw6Awz+JkskkI1yOhdw7Qdxby5KkkbuBzW29m4wyusYLOaK7/g==@vger.kernel.org
X-Gm-Message-State: AFuF++lGRl2sNXkpg89nLbv6+nNJLWWxhbioieWgrtUIFQpqcIIZxDMK
	7C9/HDxFRBFzNnehBoNFJQhG6GE1zgeUZnfkrDpklBzhrNkeBG3QoHKwAPPxVjBUEGi75bldrys
	LPdnt8x4CgA==
X-Gm-Gg: AYBFou3h6gs+/FPxEHcaobdbVMnvmO9sdIiU3HNJVqBe869x+WviLva6MFVYaS/YbbU
	khCmi5oKBWJYmyVU/1c6ZkOkOmX62i5FACb+EmgHnDpDWy+lF8CTMDC/ThfPbmerhQptxnQ0cR8
	nYjlwMxPwew0/P/Z/YURyc9MLqcj9/nZlmyvM08FqLStD9qEE69LyY1hwaNf6RBP+2zeQOiDDYr
	yjKp7lFkoCPuezT5wsA7BWY8ECSge6yPaDw8EnJuvcVuqVlomg1CgQmQJNBD/Y5wDtb1uRGCAsW
	yQ3lZA7K21LM+1mWt9O8GG/JtIwWFj3VjASTDbDjA//ChmVXY3drECoalv8VYYDIHaGDF2jjq/I
	8yWKoWa0sRi+sZCiczvWqX+5voVqV4zzQNYwdHbF6tJAvsVdmFbzUVAX6lwVqgq7apPPWBS0YoF
	QTA1hHb1fvfuetBiV2ayvKKxaLsvYjvuHQUuPJmrZ5IVL2k/5oAepff6T2SGJ/kDzHTc/cBHseS
	gUZWR5NA4nrZL38gUkJskon5zHYArCravfhV/4+0B7uj/lMbL7uQMZa8SHmwl25U+ytsvxeNjC2
	9oV0i0bk2y977pA9m7Jy9QD6nw==
X-Received: by 2002:a05:6000:2892:b0:487:62d:37d9 with SMTP id ffacd0b85a97d-487062d38demr8340499f8f.27.1789477098884;
        Tue, 15 Sep 2026 05:58:18 -0700 (PDT)
Received: from [10.160.16.196] (150.red-80-32-100.staticip.rima-tde.net. [80.32.100.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb350686sm38064158f8f.27.2026.09.15.05.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 05:58:18 -0700 (PDT)
Message-ID: <12a0d1c9-cdef-4876-8fc5-c7ce45ec0dcc@kernel.dk>
Date: Tue, 15 Sep 2026 06:58:16 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix comment typo in blk-merge.c
To: Ruslan Vagner <rusya92266@gmail.com>, linux-block@vger.kernel.org
References: <CAF9RqJ4zT5saHf_HhWBLsKKL1zBPcC=AQOd72g2Vun0Y+_nA-w@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAF9RqJ4zT5saHf_HhWBLsKKL1zBPcC=AQOd72g2Vun0Y+_nA-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/26 6:55 AM, Ruslan Vagner wrote:
> Fix the spelling in comments. No functional change.

I don't take spelling fixes. They just end up potentially causing
problems with stable patches, and they provide very little value on
their own. Yes the word is mispelled, no it doesn't really hinder anyone
from reading or understanding it.

-- 
Jens Axboe
