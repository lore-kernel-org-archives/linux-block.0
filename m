Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293D64120D
	for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KC7r38fj"
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD677114
	for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 07:05:23 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc2f17ab26so42178055ad.0
        for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 07:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699974323; x=1700579123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YG9lz3Q7V8byQ3pbms3zFQZsFgW+qQ2vsca18euKUKo=;
        b=KC7r38fjLbxCsGe8xaM+fFxwMiOR7rXQFPO2eKOAHia9fRMYLw4/4ZxLW59pjD1IgD
         KMmmkMipfBoJqj/HQDqZO5mxtgPqLRA/+saQslTsaoBqeQ55yWIqhQRmAp09aFWgdKCQ
         AHHlTMMJyWZD0nbZr3z84GdM/e5lWb1mapcz931dMeteNa9VxAGb65/foAnykKyZO/+6
         q0IZSEol2qN2cPNvZC6DFpbB2RyTZjKQq+wKRqXslCl6cUPLnw7jkSKn9M4+63hjbX4B
         KfZmk9z2sEEu84NUUEbbtZNslrvM7/SNVvEtVaMil2dNKD6WiuT1S2GiSDYr7/nE0ECM
         aLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699974323; x=1700579123;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YG9lz3Q7V8byQ3pbms3zFQZsFgW+qQ2vsca18euKUKo=;
        b=u1f8NVfzVCmaN17l1S0WQLmr5drF2wqcVv/B9M5iPeU9yQXPwYJ+5yywhD0SW4qOOn
         gjYP0DGv/YAzqoFkHNnsLI749QDARDRrrDAQlHCRQelwTUGnK9lFkjVs3Q5bxIPUZ7Kp
         6Pz5nxdndFnboa/MzhfTll95HGcQipPC80nZhGsxvtjpth5EspaiM4cAfiUU/abLpcnQ
         n7hblsqYlmNggPkgHYqevDDQhvyrquJ7M/Zd0cRelXYKSDMXaYVzwzL7MYIEmnz1hp+s
         BYKQhacsvNn/i0fgij4YjzvlMR/ZUihid+LOOthqUIn5JI0apldNiiKhmY1GfRWQH6wk
         ySkw==
X-Gm-Message-State: AOJu0Yz3DxMpROJDij6qWuCbfB3QXjKTj+Byx9CC6J+XQydbPmJ0qqGj
	hp1TDLVaqssx7wsVxj0vSZ1uYQ==
X-Google-Smtp-Source: AGHT+IEnIN5gyz/hEms93r0CqoIg3S5ZdYQSCrRMRRSvX1FVrXZLdluDJR3bBHguvUPLHjv3/6pbjQ==
X-Received: by 2002:a17:902:a401:b0:1cc:5899:112c with SMTP id p1-20020a170902a40100b001cc5899112cmr2290346plq.23.1699974323110;
        Tue, 14 Nov 2023 07:05:23 -0800 (PST)
Received: from ?IPV6:2409:8a28:e60:6e40:5de2:6afc:2f43:5fdc? ([2409:8a28:e60:6e40:5de2:6afc:2f43:5fdc])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902c40700b001bc2831e1a8sm5788558plk.80.2023.11.14.07.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 07:05:22 -0800 (PST)
Message-ID: <7fdb796f-9301-4898-b038-cc4f546192e2@bytedance.com>
Date: Tue, 14 Nov 2023 23:05:15 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [syzbot] [block?] WARNING in blk_mq_start_request
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>,
 syzbot <syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com>,
 axboe@kernel.dk, chaitanyak@nvidia.com, eadavis@qq.com, hch@infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.lei@redhat.com, syzkaller-bugs@googlegroups.com
References: <00000000000077ca930609aa9f86@google.com>
 <7ed9f6f9-d309-4d30-9b3b-c465cfa48a52@bytedance.com>
 <f4a6ff9e-d631-42c4-a5e1-87e767771488@acm.org>
 <d9f1ee3b-c303-44af-ba30-b52137fc29cb@bytedance.com>
 <3f2c2d33-2e5d-4c7b-80ea-e76885981dfb@acm.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <3f2c2d33-2e5d-4c7b-80ea-e76885981dfb@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/11/14 07:57, Bart Van Assche wrote:
> On 11/13/23 07:05, Chengming Zhou wrote:
>> Ok, I reviewed the code of virtio_queue_rqs(), found the main difference
>> is that request won't fail after blk_mq_start_request().
>>
>> But in null_blk case, the request will fail after blk_mq_start_request(),
>> return BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE. If we return these rqs
>> back to the block layer core, they will be queued individually once again.
>> So caused the warning.
> 
> I think it is safe to move the blk_mq_start_request() call under the if-block
> that decides whether or not to requeue a request in null_queue_rq()
> 

Right! And null_handle_throttled() in null_handle_cmd() may also return the
BLK_STS_DEV_RESOURCE, it's also needed to put in null_queue_rq() and before
the blk_mq_start_request().

Then request must return BLK_STS_OK after blk_mq_start_request().

Thanks!
