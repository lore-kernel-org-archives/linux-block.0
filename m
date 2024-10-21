Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165FC1E7C26;
	Mon, 21 Oct 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510207; cv=none; b=ub0hkIpxAqmGPmaRB6orb28LsTwI495raPV9glToywBUHbOycyXnTkgQAIWquJZaBBjwSHpLAf379vw0c/IbBydWxo+uj1DeVTDS7dpVEZMmrhsdJ3aOTkEYk4FGtiigveeYmbzneniX4hiC0yDBHe7oZcP0e0QMxsExNN9kod0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510207; c=relaxed/simple;
	bh=K5GkbffwOE1U2oBrMiRamUsxE1wrltguIEEmB0wp4PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwVVyp0++xf2DnYkWVHsW4cuB03oMkdosx7b4gL3HZFwxlX9RitSOirm4DcVaIhMXTjeU3e+3HnITyoW6idq+jJ65AnbIX7FECniFqgjZnAGlCIdud3emoWKry7HPm63D84OqRT+CoA2fI9eHxKtGA6tzAe/kSDv0TcVISGnGGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so44569495e9.1;
        Mon, 21 Oct 2024 04:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729510203; x=1730115003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LTJfKmuI0AsDNtueSvfDv1B8tVY2xfxReUx3Zx8L+Is=;
        b=cpqq2MZmJvXv1DfNmQ5jpY+1yjgPfz0TjfALGCWv6nRYjTwOH65qpG97W/z/2RZwA3
         EMJqvvHTvekj8rw9AyJwtYIif1M1J5G3FRaCcwk/oQFMLZkz1YvdtL00fneNo58voxwN
         QuEO3Vc0bhLN3dm1nn3UI19fauBhq5st9yjE4IU4JSmu/k3SskRPSBa0GCgFGIbnhdgz
         g4qBzqJHaRvHdCQ9iz7z4gSGDakryrIplF8Pb2uAn8IpyQ8X0vcH41oBxo4bKDYvGScW
         s2EVCQ7nbIlJZsEVEuf/++aJugzR30+Vwqz4Nup8w+8BIyagMzh2gs345FLVm9ac9OHg
         siSg==
X-Forwarded-Encrypted: i=1; AJvYcCUblRol2H6NFCQQt8xovcPWDS4XtLyS8kEFaERudIrQtH/BIzsLegGgg5THixVU1nUvyFASN4sBQZ/OMyKD@vger.kernel.org, AJvYcCWVLVqUsZmUUo0QT5YnKEGP2LCA1kLmelOPKjyfQl22oo2MCsMTuy45dADPujbavkyBC/7dznizR7p4OA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT3omV2c/nYosrDKmeR9mwUM3+ZGrZnov9hOBweKWbYPZlJvWq
	kRU2kSlWiibnsOdwbWtc3I6XLP1C6LRZ249jrYsvj8D/nlh7KlFs
X-Google-Smtp-Source: AGHT+IHbayAJI3QNFHIobPOQHH8sUh2FU4OTF56IrfvdfLiWAa5xFFH0sEWOcjkLHMaJUaVVOZyUtg==
X-Received: by 2002:adf:e40a:0:b0:37d:39f8:a77a with SMTP id ffacd0b85a97d-37eab0faa93mr6301280f8f.8.1729510203166;
        Mon, 21 Oct 2024 04:30:03 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b944fbsm4129957f8f.72.2024.10.21.04.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 04:30:02 -0700 (PDT)
Message-ID: <ab2ed574-5fb8-49d9-b6f3-5030566fc64a@grimberg.me>
Date: Mon, 21 Oct 2024 14:30:01 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support mq
 ctx fallback
To: Ming Lei <ming.lei@redhat.com>
Cc: zhuxiaohui <zhuxiaohui400@gmail.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
References: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
 <ZxWwvF0Er-Aj-rtX@fedora> <064a6fb0-0cdb-4634-863d-a06574fcc0fa@grimberg.me>
 <ZxYRXvyxzlFP_NPl@fedora>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZxYRXvyxzlFP_NPl@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 21/10/2024 11:31, Ming Lei wrote:
> On Mon, Oct 21, 2024 at 10:05:34AM +0300, Sagi Grimberg wrote:
>>
>>
>> On 21/10/2024 4:39, Ming Lei wrote:
>>> On Sun, Oct 20, 2024 at 10:40:41PM +0800, zhuxiaohui wrote:
>>>> From: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
>>>>
>>>> It is observed that nvme connect to a nvme over fabric target will
>>>> always fail when 'nohz_full' is set.
>>>>
>>>> In commit a46c27026da1 ("blk-mq: don't schedule block kworker on
>>>> isolated CPUs"), it clears hctx->cpumask for all isolate CPUs,
>>>> and when nvme connect to a remote target, it may fails on this stack:
>>>>
>>>>           blk_mq_alloc_request_hctx+1
>>>>           __nvme_submit_sync_cmd+106
>>>>           nvmf_connect_io_queue+181
>>>>           nvme_tcp_start_queue+293
>>>>           nvme_tcp_setup_ctrl+948
>>>>           nvme_tcp_create_ctrl+735
>>>>           nvmf_dev_write+532
>>>>           vfs_write+237
>>>>           ksys_write+107
>>>>           do_syscall_64+128
>>>>           entry_SYSCALL_64_after_hwframe+118
>>>>
>>>> due to that the given blk_mq_hw_ctx->cpumask is cleared with no available
>>>> blk_mq_ctx on the hw queue.
>>>>
>>>> This patch introduce a new blk_mq_req_flags_t flag 'BLK_MQ_REQ_ARB_MQ'
>>>> as well as a nvme_submit_flags_t 'NVME_SUBMIT_ARB_MQ' which are used to
>>>> indicate that block layer can fallback to a  blk_mq_ctx whose cpu
>>>> is not isolated.
>>> blk_mq_alloc_request_hctx()
>>> 	...
>>> 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
>>> 	...
>>>
>>> It can happen in case of non-cpu-isolation too, such as when this hctx hasn't
>>> online CPUs, both are same actually from this viewpoint.
>>>
>>> It is one long-time problem for nvme fc.
>> For what nvmf is using blk_mq_alloc_request_hctx() is not important. It just
>> needs a tag from that hctx. the request execution is running where
>> blk_mq_alloc_request_hctx() is running.
> I am afraid that just one tag from the specified hw queue isn't enough.
>
> The connection request needs to be issued to the hw queue & completed.
> Without any online CPU for this hw queue, the request can't be completed
> in case of managed-irq.

None of the consumers of this API use managed-irqs. the networking stack
takes care of steering irq vectors to online cpus.
