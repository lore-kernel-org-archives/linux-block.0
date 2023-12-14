Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81660A6
	for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 16:08:08 -0800 (PST)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so6510502a12.3
        for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 16:08:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702512488; x=1703117288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Duqp3Dxd1KI5gc7RVyZhAPKMaKa3fsTC0IdPOz8SHg=;
        b=Cgs5AGsZ2oBOZ8hz2772Bo/QAwRxoLKI5iweTgSAYrH5NQZwjEDWnM4EpMNNFyQOg1
         0pTSVvOmmdlhmul38qOb/6wYRLnJzOIDSvXpuFdMHP+tfOe9gRgr9G5P0Lx947EVY/iB
         L7AbazqWmSsEp3p0SuVUPd18G9KXzXrcZK0235FxNblRog55nC25vaqco5nZujQvmt+n
         doCpProm37t21MRfEU96h5RBU/uV6sOIfnTPh4B4bnN4ozgLG5WTmZfTdHco825K0fyv
         GTCED2X2/+EkTl38rbOpjAe7S87N+pMHjFcMk3sQ5RZ+l5uS60Ctcg+4XJ4uo9/H2mmf
         Z98g==
X-Gm-Message-State: AOJu0YxjXvfXs46IWUZrmKFTDqUwDd44zihkX2P6u0P/t+lIZ8qGmlFy
	zc1gwTNpeO0TpaSQHynpKN8=
X-Google-Smtp-Source: AGHT+IEo1oWm4MYCE8xgrj3lPAaSQrofktW5jb9IJuSzub0zdl6lwI8I9JhlyqTVLT/yMimree8gZg==
X-Received: by 2002:a17:902:a3cd:b0:1d3:5a4f:2263 with SMTP id q13-20020a170902a3cd00b001d35a4f2263mr1148623plb.27.1702512487737;
        Wed, 13 Dec 2023 16:08:07 -0800 (PST)
Received: from ?IPV6:2620:0:1000:5e10:9fd8:30da:e54c:ac33? ([2620:0:1000:5e10:9fd8:30da:e54c:ac33])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902e84300b001cc52ca2dfbsm11097472plg.120.2023.12.13.16.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 16:08:07 -0800 (PST)
Message-ID: <697f5bc2-88ea-42f8-9175-fbc414271ea3@acm.org>
Date: Wed, 13 Dec 2023 16:08:06 -0800
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
 <5b7be2e9-3691-409d-abff-f1fbf04cef7d@acm.org>
 <20231212181304.GA32666@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231212181304.GA32666@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/23 10:13, Christoph Hellwig wrote:
> If you want zoned devices to work you need something
> like zone append [ ... ]

If F2FS would submit REQ_OP_ZONE_APPEND operations, the only realistic
approach in the short term would be that sd_zbc.c translates these
operations into WRITE commands. Would it be acceptable to optimize
sd_zbc.c such that it does not restrict the queue depth to one per zone
if the storage device (UFS) preserves the command order per hardware
queue?

Thanks,

Bart.

