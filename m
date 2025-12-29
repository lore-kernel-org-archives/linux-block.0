Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3478715B971
	for <linux-block@vger.kernel.org>; Mon, 29 Dec 2025 03:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766980441; cv=none; b=GWsVMfyKLfBoUpXODj9yQbaSXqAJHmnB9DBj1F4SCfbuFVknjpk/ewqqqcYYFtDAoLWToYilZ4uZxtxqxnSE+9ibFXmfATgk/ELUSVtoN6b9N1yCdSlogBTrrv2bBuLuX5zk8sqRPgjbRMqz39aJNQhArQJykrsZ9UWZrHoccMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766980441; c=relaxed/simple;
	bh=i/2pV3I6wfGKU/F6zki7C+oop7j6XFoO7cS1k967DAI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NRh2C4IZlqv4fvqXEuAd+ov1FfLiMpve4vbUV1ylquGWjMq3iLytTQrtp6VjTgUtlOXXXQjmweRqyDMPlhn+dx75yMvCpB7f2nQM7DZNo7YGiGqJugOs0oVswb59yziibXb4DOEHTS+uJwsn/r/lLxXeAYwKbxbHtAh4zPkOQzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCtlTqKH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dzpich9C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCtlTqKH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dzpich9C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766980438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CS1U9kbXClTn3ClPyOJkBE6Q0JxlFOFOmyrM4XYp2Bs=;
	b=HCtlTqKHCWpuLpTEmpjiR7Sq7HBpV063dko44Alv2Xt6LT9kOovD7L7yU1qGUbsHJNuXH4
	N5VhrXivjxS9mco4QetyNkvbrnRRFIU5UWxx7pgrBaDgURUBskMCjEnDMitTkipPe9snun
	Tq45oBVZ4j+0xFY3MA7mkGzHNYSQ/h0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-1ahESGVOPPCYh-i1a_Go5w-1; Sun, 28 Dec 2025 22:53:56 -0500
X-MC-Unique: 1ahESGVOPPCYh-i1a_Go5w-1
X-Mimecast-MFC-AGG-ID: 1ahESGVOPPCYh-i1a_Go5w_1766980436
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ba265ee0e34so8696114a12.2
        for <linux-block@vger.kernel.org>; Sun, 28 Dec 2025 19:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766980436; x=1767585236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CS1U9kbXClTn3ClPyOJkBE6Q0JxlFOFOmyrM4XYp2Bs=;
        b=Dzpich9CW7mmDdLzp4v+RbuYrzNb9L/kJAoqrMIipAFj0bqK4f4EMQLGLpKwgybxl4
         +8CWXYsyw+LYdUsFVOJ7toXF4cY4rg+wtHCNwFpO5ZJ3yAuqxF/67uUy+L+SMIInpD0w
         fGT7Jo26uUohYMu4FcEs8hUqq/Yn7pyLXO1wnR3/Om/Wzu48G43+sd/+zUwy1/ML1Fh3
         11FU0zdHXpOA3aBDqanPnjidnaATwr//Oz4k2ar75SY4bObtl96qUeQ4MjMZdwf2Im2q
         PYnoRrL3golc9Otb6H4dT6oN2DMAOQwdfZfvTTdCeEi93i0ZZVW4LjPGcGXMKrAlDIkR
         VrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766980436; x=1767585236;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CS1U9kbXClTn3ClPyOJkBE6Q0JxlFOFOmyrM4XYp2Bs=;
        b=k4HVLP35fYQnwa+WiPEUIXe5lsY+Rucjgt36B/Ty03RHn4QuXUdkiCBVbxI02ee8Xs
         Ml0bIIUut7Ezo7GTgTqM6ua294VcHUCIQtcmCGBf+LHMz5O5pPGLrwP+eU1imX9JsWVB
         zdPY6E/v7RWKwaYSBlLIfZ0rtWdfXxVPC1g/rxWPd3VshqYsCdJ79IyUpj/dxP/kWGHY
         xPt5+i5C9hXKZZX94bnTmDboRG86NqfJbsrT+VIFItgE8atEn/by2vH8UvUTPn3WOG1X
         UIzcUoUoEdhivL/WPh5k4X13cT7SzyhTpfWaCpi7qsivukSUy5CSkFgVgPvaaNIPTFGu
         NYnw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8Ai20EfBsrOaJC+qg0PaQJS+TLOkdrdLeRAGOPtUC8vSusiBfcGkjLauQu7tKzzo/HtIDRM6STUEbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLJHB6m0eDbogkQ7TZku/4uTLisAFHtZMC9PDq66UQ91i9RJrl
	bmzSHVnDmud2ugXLW6wQtlYwGqPonQZw8+m6pb81tNzdoXivcZWZmcJ4JAySXyY4WIbbhvRcZHn
	Fv/I2+nf/aYB3Rj9JErYGgjkmOMYfSk7idlDGJULG7+7+b63EBNI+5XbB1N6ac/14
X-Gm-Gg: AY/fxX6V1u8HHwKUhrGUDL1gokcFQ1hfRX98y7vkHQ1PrxMAszFsWvBlFQoE4P0x37l
	n9ybAJ2DTQB5vNK0Lz2RQv4Lahb/ORu9hpXfZfCAFZ7ia4FZZsXzLv8tvLHGThvkr43x4RUb0Mu
	ooD3iIBLqkCN8EdoJ591NdKDFd2t759rN+VOKxi8qkbV2WDSo+J+mPAUtsSywUBRfaTGUjVQgHq
	SFZqZWaw6O7ynMwR6PctSfuoaYoWJ8fCffYBB53Z5Sk8RNu5dTBETxpZwapJzOeSo2kWAn1smJ7
	wXec8pjLwyLqkK+4KrPDNNYhnKH8b9ZiRTM6AM99WvCA0Zc4+5GiAgQKhLPRYf+WhFXpdJmtuAL
	WAaj9t5GhKV9rBWKdFIlyk42esg9twRGa597UsteJCTqw5ObbeZ8C0wy+
X-Received: by 2002:a05:7301:508a:b0:2af:7429:e53d with SMTP id 5a478bee46e88-2b05ebf88e5mr14193617eec.10.1766980435152;
        Sun, 28 Dec 2025 19:53:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwUgAvkgKwyfAg/XY7OmY8/35HtixZhtufU5RpA+DoSNpJWPgIxTe0gLEz02J7RhXsL5qbsA==
X-Received: by 2002:a05:7301:508a:b0:2af:7429:e53d with SMTP id 5a478bee46e88-2b05ebf88e5mr14193600eec.10.1766980434676;
        Sun, 28 Dec 2025 19:53:54 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ff8634csm69342683eec.3.2025.12.28.19.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 19:53:54 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <81f201cc-395a-48d7-a1b0-db8c62b93c9e@redhat.com>
Date: Sun, 28 Dec 2025 22:53:41 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] PCI: Prepare to protect against concurrent isolated
 cpuset change
To: Zhang Qiao <zhangqiao22@huawei.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-2-frederic@kernel.org>
 <e01189e1-d8ef-2791-632c-90d4d897859b@huawei.com>
Content-Language: en-US
In-Reply-To: <e01189e1-d8ef-2791-632c-90d4d897859b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/28/25 10:23 PM, Zhang Qiao wrote:
> Hi, Weisbecker，
>
> 在 2025/12/24 21:44, Frederic Weisbecker 写道:
>> HK_TYPE_DOMAIN will soon integrate cpuset isolated partitions and
>> therefore be made modifiable at runtime. Synchronize against the cpumask
>> update using RCU.
>>
>> The RCU locked section includes both the housekeeping CPU target
>> election for the PCI probe work and the work enqueue.
>>
>> This way the housekeeping update side will simply need to flush the
>> pending related works after updating the housekeeping mask in order to
>> make sure that no PCI work ever executes on an isolated CPU. This part
>> will be handled in a subsequent patch.
>>
>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>> ---
>>   drivers/pci/pci-driver.c | 47 ++++++++++++++++++++++++++++++++--------
>>   1 file changed, 38 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index 7c2d9d596258..786d6ce40999 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -302,9 +302,8 @@ struct drv_dev_and_id {
>>   	const struct pci_device_id *id;
>>   };
>>   
>> -static long local_pci_probe(void *_ddi)
>> +static int local_pci_probe(struct drv_dev_and_id *ddi)
>>   {
>> -	struct drv_dev_and_id *ddi = _ddi;
>>   	struct pci_dev *pci_dev = ddi->dev;
>>   	struct pci_driver *pci_drv = ddi->drv;
>>   	struct device *dev = &pci_dev->dev;
>> @@ -338,6 +337,19 @@ static long local_pci_probe(void *_ddi)
>>   	return 0;
>>   }
>>   
>> +struct pci_probe_arg {
>> +	struct drv_dev_and_id *ddi;
>> +	struct work_struct work;
>> +	int ret;
>> +};
>> +
>> +static void local_pci_probe_callback(struct work_struct *work)
>> +{
>> +	struct pci_probe_arg *arg = container_of(work, struct pci_probe_arg, work);
>> +
>> +	arg->ret = local_pci_probe(arg->ddi);
>> +}
>> +
>>   static bool pci_physfn_is_probed(struct pci_dev *dev)
>>   {
>>   #ifdef CONFIG_PCI_IOV
>> @@ -362,34 +374,51 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>>   	dev->is_probed = 1;
>>   
>>   	cpu_hotplug_disable();
>> -
>>   	/*
>>   	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
>>   	 * device is probed from work_on_cpu() of the Physical device.
>>   	 */
>>   	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
>>   	    pci_physfn_is_probed(dev)) {
>> -		cpu = nr_cpu_ids;
>> +		error = local_pci_probe(&ddi);
>>   	} else {
>>   		cpumask_var_t wq_domain_mask;
>> +		struct pci_probe_arg arg = { .ddi = &ddi };
>> +
>> +		INIT_WORK_ONSTACK(&arg.work, local_pci_probe_callback);
>>   
>>   		if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
>>   			error = -ENOMEM;
> If we return from here, arg.work will not be destroyed.
>
>
Right. INIT_WORK_ONSTACK() should be called after successful 
cpumask_var_t allocation.

Cheers,
Longman

>>   			goto out;
>>   		}
>> +
>> +		/*
>> +		 * The target election and the enqueue of the work must be within
>> +		 * the same RCU read side section so that when the workqueue pool
>> +		 * is flushed after a housekeeping cpumask update, further readers
>> +		 * are guaranteed to queue the probing work to the appropriate
>> +		 * targets.
>> +		 */
>> +		rcu_read_lock();
>>   		cpumask_and(wq_domain_mask,
>>   			    housekeeping_cpumask(HK_TYPE_WQ),
>>   			    housekeeping_cpumask(HK_TYPE_DOMAIN));
>>   
>>   		cpu = cpumask_any_and(cpumask_of_node(node),
>>   				      wq_domain_mask);
>> +		if (cpu < nr_cpu_ids) {
>> +			schedule_work_on(cpu, &arg.work);
>> +			rcu_read_unlock();
>> +			flush_work(&arg.work);
>> +			error = arg.ret;
>> +		} else {
>> +			rcu_read_unlock();
>> +			error = local_pci_probe(&ddi);
>> +		}
>> +
>>   		free_cpumask_var(wq_domain_mask);
>> +		destroy_work_on_stack(&arg.work);
>>   	}
>> -
>> -	if (cpu < nr_cpu_ids)
>> -		error = work_on_cpu(cpu, local_pci_probe, &ddi);
>> -	else
>> -		error = local_pci_probe(&ddi);
>>   out:
>>   	dev->is_probed = 0;
>>   	cpu_hotplug_enable();
>>

