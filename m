Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3CA1FDF8A
	for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706629; cv=none; b=MMiin1McDM+gDp3ESAVy0su6p/uGAxoswLYJwwxOth0QVnizxNVS1suBVAJvvryHSuSOyR/1MpliFDUDAiBo5xcQ2cLLrKVFxI7qny3oowhJiR4t7yxyS2sB9MRjF7Dwp4bFAIpYl4zbonj5qNm1M/2msElt0hT4Idg7taPLkd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706629; c=relaxed/simple;
	bh=Oeuk4NT8mGLS78CfxbKlyUY850mOCryg7B/6qGI60DI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RPwIFLQ3gbZ1xnDEUgPpQmfhCQXy5IhECCdOjI+p9omJXCY3fq2Xt6XKy8mE5wxFQ0JvkigshVEFg+mRLvfJ3mM3k5Mn18gEqe5i1/aQeJ47kW+Dq/SCFL6O23ce7pI0Qx13yRYyfkdyqdWvWxf7rZUvX88CTIed2+ph3e/hRtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hSnbt4cp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSnbt4cp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731706626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ivw2cPuuJQRwyJNSHiIw+Pyk/jnELW2tJEH2/eI89rI=;
	b=hSnbt4cpX3C+EdGGcITARG0JvCDCvcfJIdr9Kp4WyWEjuKWdRWNlO6/ixJr1A1leOzKpf0
	KLOEvut1SYXVb0+7ZOmQtOb0F6slYyMv7jbHUP3dRNYCxKQhL8Afb3ys8mp98o7D2ITA39
	tiq29wmOw2ghXU4XAkVFHb67PBIJK9c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-GxMxgJlgOmOXCdSJhgUXNg-1; Fri, 15 Nov 2024 16:37:05 -0500
X-MC-Unique: GxMxgJlgOmOXCdSJhgUXNg-1
X-Mimecast-MFC-AGG-ID: GxMxgJlgOmOXCdSJhgUXNg
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d3736a62b0so29101476d6.1
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 13:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731706625; x=1732311425;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivw2cPuuJQRwyJNSHiIw+Pyk/jnELW2tJEH2/eI89rI=;
        b=YW3tRVTBimeVyEr8MvqvjNZMDubtOKLDe7PnBNmRq57NS9lG1SlNDcj/OTIVvrfcED
         J8NmSbaxHaYKVDsDwySTIhgRS/A51uTp3xpry6Bj2UFqBXM7ZZC/VHR8H/8dWPTDFti7
         raOHevJPY9IBE8SYsEg4ZuvgU6ZkaB3On830JcomHMLun4a09p93gSUofpvRR4WWrF/3
         vP65nfzU85XKnYuCg8P7JBitZx3oqYTJ/kfda2HmmKjcTCzvUik6SRV7pYbMSf1yB574
         9fFEuohwxtmamuHSh/hZD7q0aQxRqoW7z87Vzi7z9byhtbfxAjngeuJNpl99LyfRzRW2
         nY8g==
X-Forwarded-Encrypted: i=1; AJvYcCW0y7jg1KYZU1AliFam832TRI4oZodCV7iNXy/MosYVQrAZnFl4t4I2qK+qAtbQUotGcQdj8aVVulshHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3vlkJyVeZd40KjoHYEPf2tOFFLqET3oWgAgjDrdTS6oCBkKK9
	qsAtSzb/BX/kPtwhmi6PbpQfv3ZWLg83awF9kuj+xRHDhxww+E206J0AgHbCNmU4WwZxv2B6cfa
	qQQaXMrh2uvN/hkOpk0Tj72fbshqljxjY16BIzCqcnX1eq7NE5mOEZ9CCZttG
X-Received: by 2002:a05:6214:5690:b0:6d3:f984:1a82 with SMTP id 6a1803df08f44-6d3fb858e8bmr57294576d6.31.1731706624178;
        Fri, 15 Nov 2024 13:37:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXgGPocZvxQ5d5NSN9sIHyVoelbF9oeCyFH1sagwzbxZngNT5v49ggcBb3EADnzAeGx3RMzg==
X-Received: by 2002:a05:6214:5690:b0:6d3:f984:1a82 with SMTP id 6a1803df08f44-6d3fb858e8bmr57293356d6.31.1731706622468;
        Fri, 15 Nov 2024 13:37:02 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c984691sm203656085a.2.2024.11.15.13.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 13:37:01 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <67e8e089-4df2-4175-851a-4b49b964eca4@redhat.com>
Date: Fri, 15 Nov 2024 16:37:00 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] blk-mq: isolate CPUs from hctx
To: Costa Shulyupin <costa.shul@redhat.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: ming.lei@redhat.com, Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
References: <20241108054831.2094883-3-costa.shul@redhat.com>
 <qlq56cpm5enxoevqstziz7hxp5lqgs74zl2ohv4shynasxuho6@xb5hk5cunhfn>
 <CADDUTFwYKjbPnzdzQA0ZjW4w3pHBsoZBQ6Ua5QbFp=X2-GfGtQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CADDUTFwYKjbPnzdzQA0ZjW4w3pHBsoZBQ6Ua5QbFp=X2-GfGtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/15/24 3:25 PM, Costa Shulyupin wrote:
> Hello Michal.
>
> Isolation of CPUs from blk_mq_hw_ctx during boot is already handled on
> call hierarchy:
> ...
>          nvme_probe()
>                  nvme_alloc_admin_tag_set()
>                          blk_mq_alloc_queue()
>                                  blk_mq_init_allocated_queue()
>                                          blk_mq_map_swqueue()
>
> blk_mq_map_swqueue() performs:
> for_each_cpu(cpu, hctx->cpumask) {
>          if (cpu_is_isolated(cpu))
>                  cpumask_clear_cpu(cpu, hctx->cpumask);
> }
>
> static inline bool cpu_is_isolated(int cpu)
> {
>          return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
>                  !housekeeping_test_cpu(cpu, HK_TYPE_TICK) ||
>                 cpuset_cpu_is_isolated(cpu);
> }

cpuset_cpu_is_isolated() can be removed once the cpumasks can be changed 
dynamically.

Cheers,
Longman

