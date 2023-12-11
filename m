Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DD6C3
	for <linux-block@vger.kernel.org>; Mon, 11 Dec 2023 09:20:03 -0800 (PST)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d04dba2781so28757525ad.3
        for <linux-block@vger.kernel.org>; Mon, 11 Dec 2023 09:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702315203; x=1702920003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y/JdW9KB2Bz5CkX3RnkrraHjFEyd3VbuIm/2hum62tc=;
        b=NZvBFq0xwFRpdHgEUXLYma19JMx4EX2NilKv34/itkul6lG2Zftp2yTUlvQE5af0wX
         3Iwx8E+agbRNdLTnyQWi/31X9sOZLcQ0gsqqdWKFJcooomwu3euqqq+06UiyWtSVo2ox
         trEJFnR8uUsYNaVJz0D5FohPLNh+21C4Y0JJ0YM3tB7NW3SadbOZlKXvUhNyKdsrosBr
         8DWx0rJjpuJIAILGbdjB6/96M2j2nagXWwETu0RZ/9Wo+utrmLwdC+v/Ru5Yj9E6Xy4s
         fhCy0Rl5C/dtcf4/FH7S4Yz42a9yhEn8AhaKGeNe5f2FbCgeJo8HVlJ5EZA/dhz8ZOit
         KHLw==
X-Gm-Message-State: AOJu0YxPWEjFECsQBhToUV0W52LrioNMG+xtRq86oETHv9lmrAiRYCtU
	nr6u/C2DDVfJ1sPg5qz5jx8=
X-Google-Smtp-Source: AGHT+IHhoLD/ou7QFpeh2L1SBV1+Ro8n+zLfRooWieLDwkdOZe/9X+JXEzmTRHeMtvQXJ2dPkWvsDw==
X-Received: by 2002:a17:902:7b91:b0:1d0:6ffe:1e6e with SMTP id w17-20020a1709027b9100b001d06ffe1e6emr2478070pll.81.1702315202683;
        Mon, 11 Dec 2023 09:20:02 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:3431:681a:6403:d100? ([2620:0:1000:8411:3431:681a:6403:d100])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902f68c00b001d09b006bc1sm6884557plg.21.2023.12.11.09.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 09:20:02 -0800 (PST)
Message-ID: <7d323197-c85d-4692-83db-9867104c48fd@acm.org>
Date: Mon, 11 Dec 2023 09:20:00 -0800
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
References: <20231205053213.522772-1-bvanassche@acm.org>
 <20231205053213.522772-4-bvanassche@acm.org> <20231211165720.GC26039@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231211165720.GC26039@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/11/23 08:57, Christoph Hellwig wrote:
> Or do you mean your f2fs hacks where you assume there is some order
> kept?

Hi Christoph,

It seems like there is a misunderstanding. The issue addressed by this
patch series is not F2FS-specific. The issue addressed by this patch
series can be encountered by any software that submits REQ_OP_WRITE
operations.

Bart.

