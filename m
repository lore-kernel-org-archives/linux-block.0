Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DA54BAAB
	for <linux-block@vger.kernel.org>; Mon, 18 Dec 2023 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so14931285ad.1
        for <linux-block@vger.kernel.org>; Mon, 18 Dec 2023 09:35:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702920905; x=1703525705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRMbBHJ6JPkWhgZ7IJi0r2WuU9keu0hs9Rw89irI2Qk=;
        b=in43KONjbc4Pa2+DfLQ9XDbPDaPMNvp+bIbp7urT/Z4wFKE8iJX0rbJ22BTF4xBFFc
         RJfF0m58OlCfg4TZlVzTJo4iNGcBw3zDjop1LSm394AF+BmQPGZ0B/+lPZg9bPLseqjE
         Ba2U/dgUA7VE9rPBn8jHz3MkyG1CM2pw0K0p25ohq+V5Zimr5SCn7sebQTICQrjCrRXR
         rzRi/l+L4FS8fiLQpd2iq8AKnXD4hflSNuXa414/1cjlYtjBCaLZZjhFOqnAPNaJr+7A
         3Myv6Ag4N7bLW3/OaoMXRO7Dy2E9PJ7MVttMxc8xVVdsjtLdBArOixzSniJB4M8wNT6q
         BLRg==
X-Gm-Message-State: AOJu0YxdwRO0LGDDME65845fQI2/dewsr1AkFV1Oguh+5sF86O+q88dr
	H3dReBivGQNG0yA20a/8X0wBOA2XI2Y=
X-Google-Smtp-Source: AGHT+IEY06QPijbebTcAK5ljIq5FLPjAmcxvUKJo3FRpsmGorHV+p4sfaQ5nyVjbcHXpLdg75oa7cg==
X-Received: by 2002:a17:902:dacf:b0:1d3:d489:f99d with SMTP id q15-20020a170902dacf00b001d3d489f99dmr572337plx.58.1702920904534;
        Mon, 18 Dec 2023 09:35:04 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:e67:7ba6:36a9:8cd5? ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090341c100b001d33c85ce1bsm11875452ple.2.2023.12.18.09.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 09:35:04 -0800 (PST)
Message-ID: <439d8553-c9a1-4bbd-b67a-dd053d2c72f2@acm.org>
Date: Mon, 18 Dec 2023 09:35:02 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block/mq-deadline: Introduce dd_bio_ioclass()
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
References: <20231205053213.522772-1-bvanassche@acm.org>
 <20231205053213.522772-3-bvanassche@acm.org> <20231211165537.GB26039@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231211165537.GB26039@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 08:55, Christoph Hellwig wrote:
> On Mon, Dec 04, 2023 at 09:32:12PM -0800, Bart Van Assche wrote:
>> Prepare for disabling I/O prioritization in certain cases.
> 
> On it's own this looks pretty useless to be honest, an with just a
> single caller it can't really make future patches significantly
> simpler either.

This patch helps because a helper function can have multiple return
statements. The alternative without helper function is using a less
readable ternary conditional.

Bart.


