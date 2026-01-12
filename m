Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E430E82B
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240448; cv=none; b=IQQli8FoOLJp4LIJNrRuXQRT0rTYrr/yvOxEL4VMVvEEtlLryKO0k/cjKBf042x3yl9eTdpKty3ZoUF4kuWQ8jCnen8b89dhRDDwZ8pY2SwI3pi044oSjPUcpeAAQ+Z1jAvBV1Sg+SuL4ssxFTVqUDQpbNe4slUVFVX1LAMvFf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240448; c=relaxed/simple;
	bh=69fqmCRd2Tf1nBFL5gD9s9xWKdbIFwrikt2C7UGqOuQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=W09jr6keGeBcLlVQPC0iiI6up1Toazczn77N54kpaeXD/U/903/Glmt8bdLi+RC9p3Iyi2utPuwR42GgyZqXRUgYQHpE3EStjoCz/lsrbSb+fbY5XM894ZOp7WItgZE63RHPUG7UUX3eN8CoWUsAnmhrrwDuFvCke+Ury9ZbVts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJufZ8Ks; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMS+qKWM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJufZ8Ks";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMS+qKWM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768240446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9TjQuHk6AbSuF3wU6pHO95OUHC0x3l8Lsr+qaj6DcQU=;
	b=OJufZ8KstiLFvfrro91PWjbQ94BmxSuBhRU9m8vB8uo3kW5WLzNCcgqF9BNIPaLZg2biYc
	9d1fW56upcWZJlvA2/1sGAfM7wO2XMBwreW2TugcSM8I+lZwWcC2R43Q2P38nrVclYl45c
	hnGlxlnIUES/vRZ1ZmpGr8qVzfeBwmA=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-JROwjIrtN_aGtziVPQQSCQ-1; Mon, 12 Jan 2026 12:54:05 -0500
X-MC-Unique: JROwjIrtN_aGtziVPQQSCQ-1
X-Mimecast-MFC-AGG-ID: JROwjIrtN_aGtziVPQQSCQ_1768240445
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5636892d498so7973323e0c.3
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 09:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768240444; x=1768845244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9TjQuHk6AbSuF3wU6pHO95OUHC0x3l8Lsr+qaj6DcQU=;
        b=ZMS+qKWMbzAgtiOZ95b5b8ACdWzxM4x9sBM6AmZ6omRt50avcKiYgnQFchcpczNi0Z
         5wbcfi+GqGL/W+H44x189kjMmOu7+H/AKjM3mNtITG67PLv+TFc01DsJqq9a7X9SM2MO
         CN29O8bEx0OT+bQ4FLWb7gwWLUy2HQvqIf4cZZm+wfPJe5q8mEUU9T0iKe55/50Uj940
         a/9u5REydn/+V679XfJfgbVn1/e4uh3vOCEtUkSs/wcKdHEBMU4XdFN6iBFcddrF5bV2
         zYt3Gc2e31k9oYfQHjWTkgFWX6atHOwgpiDIPcVTI6H8i7s1pGIryuHitaOy0fi0WK30
         bHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768240444; x=1768845244;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TjQuHk6AbSuF3wU6pHO95OUHC0x3l8Lsr+qaj6DcQU=;
        b=lED491bMWlpCIC+YaHqrH6cB7SBb1JvGCB1r1uGq4TUOtSOwgHk73E2yeeP7Uxyqvq
         pqhQ1Rx1LFy59Dw1GSZEuT3s1yzXf7WZFLIIqQqWqsCoIfd5JuQLI1ks3p5/blyXXBow
         G7VKOYBkhU29+CZuwxeNQdR/SakcZ72rxdP85eVAvfdGx34lFZh7UcDtGZABwrvAJ5im
         eNd9TFUTkFJztc+Ij06/u+ILhjt0BK4HCRTjs4Wfw4f8KYc9Xbtqdwk+6q8Q/BE0mwyN
         +6P+CNTFQvm6G2zcS1Kd1P/eehgWA5Xp/MW6VtMyXaNdhRk3INOxiFi9pXewsr090568
         cT0g==
X-Forwarded-Encrypted: i=1; AJvYcCUBHRk7LSClSDBIyxjfyHCOQ+HKh8lqzgmz+AN/ze+J5eGBNsr2SZqleMSYbR2WQA+HtPUEyimVdljKAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQZUmg+Xx18vR+8ytnJ9cRroT5sh86Cud2Avg+4HXB3VkNfh/H
	x0ldzeeF2JJpQNw3OW0pQol+4RgYGWT7YD4juqD6HMuhMzFI0LpvQXFejB+1zjvEBHuHUNbCgAZ
	ZjxK1bYgh6DgGOMIxst0P4sYMyD4Xy7GVFJJudfGeF/J4afT8C4YQ0hek/PSwAbw1bV/y/eeT
X-Gm-Gg: AY/fxX5aPS27hJgYRFqyneflBhWdR31KSI9rQZGy05FrBsz7SJsMtdvjQ2BwVdX+6RI
	c0DYZQkqVk8xFlkCiQvu/ZnriUh8f95rQmx2y6T+e27hQcFvxJy4KubPeZUdsYuz3Q1xwTEmYc6
	K7Fb1XndWs59JE5+GKR74wEUBkwnfenmZrUo5vBsRyhf8SZrK1Ec/t5VoPnK+tLpC2QEnuvfETG
	+BKHo2ipUZnGR7XGk7kK9fVwKl47QHhyUWOsrvpNUyk1NPFq/YMwMUHSrXPtTPQ0k7fBFJMTeYA
	QDonzIbNSAWq9XmqbQZtw/w0MYDKAKl92k+nR6JGXut/Gye9NDsZpmfv//INcls/2ZFOtSXm3jB
	Nyf72G06bFFF7s9XVNGXZXwNVbPAyRRoAEX4GLGNWZdG7fINYXEDPpxe5
X-Received: by 2002:a05:6122:4f88:b0:563:8335:9ab7 with SMTP id 71dfb90a1353d-5638335b3d9mr1837512e0c.19.1768240444527;
        Mon, 12 Jan 2026 09:54:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxwLoMJ4ylgMx4yokJUFTrQvglGoUK2cQ8cuwE9wOBcOJlyALmmG0hMGzOjgHwYtiz9Ob2mA==
X-Received: by 2002:a05:6122:4f88:b0:563:8335:9ab7 with SMTP id 71dfb90a1353d-5638335b3d9mr1837491e0c.19.1768240444039;
        Mon, 12 Jan 2026 09:54:04 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5634ca16da7sm15469803e0c.17.2026.01.12.09.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 09:54:03 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f8ca375e-9051-4c7c-880d-e56e07206788@redhat.com>
Date: Mon, 12 Jan 2026 12:53:49 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/33] cpuset: Provide lockdep check for cpuset lock held
To: Frederic Weisbecker <frederic@kernel.org>,
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
References: <20260101221359.22298-1-frederic@kernel.org>
 <20260101221359.22298-13-frederic@kernel.org>
 <e97d96fc-cbdf-4c03-aa1a-b0cde5419681@redhat.com>
Content-Language: en-US
In-Reply-To: <e97d96fc-cbdf-4c03-aa1a-b0cde5419681@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/11/26 8:43 PM, Waiman Long wrote:
> On 1/1/26 5:13 PM, Frederic Weisbecker wrote:
>> cpuset modifies partitions, including isolated, while holding the cpuset
>> mutex.
>>
>> This means that holding the cpuset mutex is safe to synchronize against
>> housekeeping cpumask changes.
>>
>> Provide a lockdep check to validate that.
>>
>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>> ---
>>   include/linux/cpuset.h | 2 ++
>>   kernel/cgroup/cpuset.c | 7 +++++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
>> index a98d3330385c..1c49ffd2ca9b 100644
>> --- a/include/linux/cpuset.h
>> +++ b/include/linux/cpuset.h
>> @@ -18,6 +18,8 @@
>>   #include <linux/mmu_context.h>
>>   #include <linux/jump_label.h>
>>   +extern bool lockdep_is_cpuset_held(void);
>> +
>>   #ifdef CONFIG_CPUSETS
>>     /*
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 3afa72f8d579..5e2e3514c22e 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -283,6 +283,13 @@ void cpuset_full_unlock(void)
>>       cpus_read_unlock();
>>   }
>>   +#ifdef CONFIG_LOCKDEP
>> +bool lockdep_is_cpuset_held(void)
>> +{
>> +    return lockdep_is_held(&cpuset_mutex);
>> +}
>> +#endif
>> +
>>   static DEFINE_SPINLOCK(callback_lock);
>>     void cpuset_callback_lock_irq(void)
>
> The cgroup/for-next tree already have a similar 
> lockdep_assert_cpuset_lock_held() defined. So you can drop this patch 
> if this series won't land in the next merge window. 

Sorry, the other new lockdep API isn't exactly the same as what you 
propose here. So it is not a replacement for your use case. Sorry for 
the noise.

Cheers,
Longman

