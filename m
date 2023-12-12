Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD12C94
	for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 10:09:51 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ce6caedce6so3758389b3a.3
        for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 10:09:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702404591; x=1703009391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYC8MrCT3cDMhdTTvJ2AQ4G+DdCSziC7lCIFRSgLFqs=;
        b=UVVdev8ZI8p1cVQgWmALuXbnY9PrdAPNc+jWQPxACE3l7DHAOWCULq1x6UqUm3+sQ3
         fAkS47stXd4C/YBxoMm0XZadOG4OKy30lnzwcKdyrG6y1K9RQw6H0XQ3HSY4tDvrWc2o
         /qlLid+6EUP60/eeSS1/QLUJbBQle12pTM25xaM/+X4RVM81lqwJnT8XJqW4mXH0OM7Z
         Z5AWoQbcfQSxMLNfZ1JocZfuA+XvjNH8+0o2bL+c6JF00RDjLQjCTssp9KGw1iLxUPa2
         SbIQpPQmO9Dzhfl7JA1q6u89unmRbIXlm8Bzn/urh2omN6UKTgbRozVWCuJX9kDB+Rcf
         dHJA==
X-Gm-Message-State: AOJu0Yz3vV0Xf3diasJDioblXa79QFpRrdujdTiNkgklIf3fQ3zOmC4+
	9V2c+lJWuZRHLZdne/mDF8s/fA3WZRc=
X-Google-Smtp-Source: AGHT+IGDUYPtAvdqrCZC/hK/+e31xVicD3/9w6Q1CyGBxy/b87oW9IZrZIQLa289Jh5BktuhpdRN0Q==
X-Received: by 2002:a05:6a00:80f:b0:6ce:6265:fc21 with SMTP id m15-20020a056a00080f00b006ce6265fc21mr4762220pfk.26.1702404591062;
        Tue, 12 Dec 2023 10:09:51 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:4cb1:76fa:137e:ca8? ([2620:0:1000:8411:4cb1:76fa:137e:ca8])
        by smtp.gmail.com with ESMTPSA id n56-20020a056a000d7800b006ce75e0ef83sm8802549pfv.179.2023.12.12.10.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 10:09:50 -0800 (PST)
Message-ID: <5b7be2e9-3691-409d-abff-f1fbf04cef7d@acm.org>
Date: Tue, 12 Dec 2023 10:09:49 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20231205053213.522772-1-bvanassche@acm.org>
 <20231205053213.522772-4-bvanassche@acm.org> <20231211165720.GC26039@lst.de>
 <177773fd-c8ed-4822-9344-3058e820ddf0@kernel.org>
 <20231212154140.GB20933@lst.de>
 <42054848-2e8d-4856-b404-c042a4365097@acm.org>
 <20231212171846.GA28682@lst.de>
 <686cc853-96e2-4aa4-8f68-fdcc5cdabbba@acm.org>
 <20231212174802.GA30659@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231212174802.GA30659@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/12/23 09:48, Christoph Hellwig wrote:
> You keep insisting
> on using a broken model despite having a major influence on the standards.
> Go and fix them, and I bet you'll actually have plenty of support.

Hi Christoph,

I do *not* appreciate what you wrote. You shouldn't tell me what I should do
with regard to standardization. If you want standards to be changed, please
change these yourself.

Bart.

