Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AC1A1
	for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 10:19:34 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d0bcc0c313so33002155ad.3
        for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 10:19:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702405173; x=1703009973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snpcOimcmH3F5F19UYxkdyQBSUKJClC6kyBl9+sL+rQ=;
        b=KxYOE2368z5LSPbG5vfwzAy9fQhv22O/RT0P4N6yMjqZc03vTQyoKVRC8wnk8H4yv9
         HdGTae6sPEZLuVj6+7A6uvS842GZdURTXPWBRJWMKIHds7HPMb7W00YikLNTEEibCF/C
         e2cxkGyPW9vsPgVLLMLD4uGPDURBF6dC8w8mKnfetWK29TN+qZs2R8p15yzS26APtzS1
         A74t8KokQ8eSuOcPLvoj0/Pvrs1XknmkHBqCPLoqIhIqDzWlbeiCCx26bxrBwVMFpVwO
         633pExa0f10MrCp6SLO0Iht0OtFw6NPk55LejwrVNxXnD/HKxK8sTMf9f+mI33j+/Z44
         bbJg==
X-Gm-Message-State: AOJu0YwJxFfKORMbe9yLjjrgVwsiJdemi6iG/2u33c0wZN4qx//B7yFI
	5ILQsjHGXV/E6pvEGusyuXM=
X-Google-Smtp-Source: AGHT+IHQhrXVLippotU00M/klp1wQMs17rmpBuxv72Z0D1JXRzvz/WHrMgtzG5ZhleUMpYYBFrOowA==
X-Received: by 2002:a17:903:2791:b0:1d0:6ffd:836e with SMTP id jw17-20020a170903279100b001d06ffd836emr2887690plb.121.1702405173421;
        Tue, 12 Dec 2023 10:19:33 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:4cb1:76fa:137e:ca8? ([2620:0:1000:8411:4cb1:76fa:137e:ca8])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902bccc00b001d0696e9237sm8866970pls.118.2023.12.12.10.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 10:19:32 -0800 (PST)
Message-ID: <19cd459e-d79e-4ecd-8ec8-778be0066e84@acm.org>
Date: Tue, 12 Dec 2023 10:19:31 -0800
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
> I don't appreciate all the work you create by insisting on a fundamentally
> broken model either.  If you want zoned devices to work you need something
> like zone append, and your insistence on using broken methods is not
> helpful.  So if you don't want to change the standard to actually work
> for your use case at least don't waste *our* time trying to work around
> it badly.

Hi Christoph,

"Fundamentally broken model" is your personal opinion. I don't know anyone
else than you who considers zoned writes as a broken model.

Bart.

