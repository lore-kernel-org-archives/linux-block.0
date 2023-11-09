Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCE8358A4
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8135B3C07;
	Thu,  9 Nov 2023 10:14:00 -0800 (PST)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so1180430b3a.3;
        Thu, 09 Nov 2023 10:14:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699553640; x=1700158440;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HbhzDPJD1HxXvnerQppqOegYRIp7L/BV2HZFc1B3y0Y=;
        b=hw6jnDfpX73h3sODOlImhRjekStBkcRfRLIq3nHagpCn1YS8FqRlLB1RDFDway5jCu
         kAdVU+Y3TJKqfNgpunoFsKLFng6eDV3g0u9ThPV4kb4dzcZfsQmZa+XRzLsmVz4ywFaA
         WjHDXFJs+8YQukz2GCIHK5oiodTAwVDAs5s2OC9GuTDKGoIMuDkSp25bO53561YrcEb0
         4T3n+slxf0H5Nl/5HP5Ti9sYN57gyPtvTfCfSqycntbqmjyGKotYPPX4BCMwHgWTsZ5n
         y+4L8Cqmicu/u1bTeYSTB2nSeg6f4Nu1bVpav63HWYBYs/tu6UQE45rOflsPhJMWt9WP
         f/qg==
X-Gm-Message-State: AOJu0YxAO8kPizrnJo5SZz+keVAjPyAYqdJ7QVzLUvF8+zOnC2+KR4PX
	7NX6Qb6UKbdHpBRrYVZ28qU=
X-Google-Smtp-Source: AGHT+IGvQ3XEswqosylixgcgqeZAKuuz9zBIcMng8IopMZr1FGteIZ3XgLsavrJGQc1lWfrqUOfmSw==
X-Received: by 2002:a05:6a00:1a8e:b0:6c3:720a:157a with SMTP id e14-20020a056a001a8e00b006c3720a157amr6198027pfv.12.1699553639474;
        Thu, 09 Nov 2023 10:13:59 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:3dcd:f87f:1890:c48e? ([2620:0:1000:8411:3dcd:f87f:1890:c48e])
        by smtp.gmail.com with ESMTPSA id r8-20020aa78448000000b0064f76992905sm10967180pfn.202.2023.11.09.10.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 10:13:59 -0800 (PST)
Message-ID: <f4a6ff9e-d631-42c4-a5e1-87e767771488@acm.org>
Date: Thu, 9 Nov 2023 10:13:56 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] WARNING in blk_mq_start_request
Content-Language: en-US
To: Chengming Zhou <zhouchengming@bytedance.com>,
 syzbot <syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com>,
 axboe@kernel.dk, chaitanyak@nvidia.com, eadavis@qq.com, hch@infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.lei@redhat.com, syzkaller-bugs@googlegroups.com
References: <00000000000077ca930609aa9f86@google.com>
 <7ed9f6f9-d309-4d30-9b3b-c465cfa48a52@bytedance.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7ed9f6f9-d309-4d30-9b3b-c465cfa48a52@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/23 17:27, Chengming Zhou wrote:
> CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is enabled in the kernel config,
> so null_queue_rq() will return BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE
> for some requests, which have been marked as IN_FLIGHT status.
> 
> Then null_queue_rqs() put these requests in the rqlist and return back,
> blk-mq will try to queue them individually once again, caused the warning
> "WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE)" in blk_mq_start_request().
> 
> So handling of return value of null_queue_rq() in null_queue_rqs() is wrong,
> maybe we should __blk_mq_requeue_request() for these requests, before
> adding them in the rqlist?

Please follow the example of virtio_queue_rqs() and send any requests
that need to be requeued back to the block layer core instead of
handling these directly in null_queue_rqs().

Thanks,

Bart.
