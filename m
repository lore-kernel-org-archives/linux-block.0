Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7421355
	for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eZTTCcFc"
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F439132
	for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 07:05:24 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5b99bfca064so2788662a12.3
        for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 07:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699887924; x=1700492724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SbzSnqFAR6mwR3KcGuOJ/Kh93Fhn2bGB+nEhBmFxq4s=;
        b=eZTTCcFc/m7ItPHtSBXpve6B0E1sZa6Mjk+jvOtJDPdeepf8vVgJ3uCp+47z/t5E/E
         LIXI+MZMaH6V+0iWcaL4maRr1oJbtc/XhmjZIc6g3HYwN6VnxaI39aUx+PGg2J7ZuqBb
         S7lRKVGMoXELgum371NxgigUzzAUkMyja+ht2cJL1+EjRgJRhQb1EeTGgyyCSyXJgZ6M
         jj9IS6YbwXRnfuxhRZmdeMeOCD8svztgHlpiaT0H8XcHkAGMe9YAKrhBFXcm/AanLae4
         NWUvifj8p0KIMPGXQhFa/RRKwvjb7AmBNvMTMmdqLxmZQeyo7wCbrkXMvIrg1stGALfF
         S7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699887924; x=1700492724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SbzSnqFAR6mwR3KcGuOJ/Kh93Fhn2bGB+nEhBmFxq4s=;
        b=OE5H3iC0dlkPO4XTq+3nsxikKIAbPwNdyL/nCFDpFgdZgwuhxrCr8DXFH35g4YREMT
         aE/ArO8I+wXq335+vgDOP8doG3SDv7p/k/Gj6gMNGKeTDLDObTzpjJ8Gaz2isMtn0SQb
         ye9K76doi0m2MdyRkg9gtAsAQEq8vsVO86aU9RKQy1nt7FZEB56K+7vamt6FB/u4omd2
         sKg/jbCIf96BbxVlB0XrtWo+Bgxu/sxSexXU/maZ+UIy2l55s4zbj8FI6nLZniaS+KbI
         +4VqUc2e6M0G1RnOizpNPn6d3p61IRnzVJ1b24EyPTQpQZzJ58uByb177Xouo8YEBhAQ
         SHrA==
X-Gm-Message-State: AOJu0Yz5/Ys/oYhYQyJznBDgLXHO+/kHnVTIzxBDe/kngNZ3WGV7tXjD
	EIVROC3sCRrOtHGxip8CpWrX2Q==
X-Google-Smtp-Source: AGHT+IHJem5aIMZ7rNpAWy/1W8yegYRJqh4hVs3ycIaSi7rD/U+QY2Q6T6m2vQpoUZh+Fn+uKoNmjA==
X-Received: by 2002:a17:90b:390c:b0:280:29e8:4379 with SMTP id ob12-20020a17090b390c00b0028029e84379mr4906585pjb.34.1699887923845;
        Mon, 13 Nov 2023 07:05:23 -0800 (PST)
Received: from ?IPV6:2409:8a28:e60:6e40:4d8e:5c2e:f2ee:32f0? ([2409:8a28:e60:6e40:4d8e:5c2e:f2ee:32f0])
        by smtp.gmail.com with ESMTPSA id fz10-20020a17090b024a00b00268b439a0cbsm3717714pjb.23.2023.11.13.07.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 07:05:23 -0800 (PST)
Message-ID: <d9f1ee3b-c303-44af-ba30-b52137fc29cb@bytedance.com>
Date: Mon, 13 Nov 2023 23:05:14 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [syzbot] [block?] WARNING in blk_mq_start_request
To: Bart Van Assche <bvanassche@acm.org>,
 syzbot <syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com>,
 axboe@kernel.dk, chaitanyak@nvidia.com, eadavis@qq.com, hch@infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.lei@redhat.com, syzkaller-bugs@googlegroups.com
References: <00000000000077ca930609aa9f86@google.com>
 <7ed9f6f9-d309-4d30-9b3b-c465cfa48a52@bytedance.com>
 <f4a6ff9e-d631-42c4-a5e1-87e767771488@acm.org>
Content-Language: en-US
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <f4a6ff9e-d631-42c4-a5e1-87e767771488@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/11/10 02:13, Bart Van Assche wrote:
> On 11/8/23 17:27, Chengming Zhou wrote:
>> CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is enabled in the kernel config,
>> so null_queue_rq() will return BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE
>> for some requests, which have been marked as IN_FLIGHT status.
>>
>> Then null_queue_rqs() put these requests in the rqlist and return back,
>> blk-mq will try to queue them individually once again, caused the warning
>> "WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE)" in blk_mq_start_request().
>>
>> So handling of return value of null_queue_rq() in null_queue_rqs() is wrong,
>> maybe we should __blk_mq_requeue_request() for these requests, before
>> adding them in the rqlist?
> 
> Please follow the example of virtio_queue_rqs() and send any requests
> that need to be requeued back to the block layer core instead of
> handling these directly in null_queue_rqs().
> 

Ok, I reviewed the code of virtio_queue_rqs(), found the main difference
is that request won't fail after blk_mq_start_request().

But in null_blk case, the request will fail after blk_mq_start_request(),
return BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE. If we return these rqs
back to the block layer core, they will be queued individually once again.
So caused the warning.

Thanks!
