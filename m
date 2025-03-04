Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E187290BA7
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105147; cv=none; b=EW4Uet7NCZSA2q754+7ZWQ4yoqqB0H6K/ew1GbOZENtZwSwLy8CY2JwXqwcQJIMg5MjtNYHUy9M8Nc0dG316UQw7kuW5ULc8j86Vbja7i6xG34tpZ0yyPypT3QUFeKdpyCsN6wtuZnLGM8Fe7YiEbJ3kyuq1WRFURxtv6uhKDfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105147; c=relaxed/simple;
	bh=Y6IhqAMyuypLmPTH+Xshl5PBsPx3QPOHwZtDka96QGE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Pql1AgqxtZQlbiJsr4gmt+dS2G85wPLtG6jdKO84w53Q4a0ZpAYw5N1E+BqOO41EPALk73g8bM6DmdgxY1b9Ef8mCX7iZsTc0mGtKpDH15/7VET0V9w6MJt2mhhf4TV0SUotmQK621Iwj+SwQ6BGWcooEO6UdfOzY50vWUnYhRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBAF3P6j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBAF3P6j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741105144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkY1q4GVy/AgzNXZlr3UCoSg7uwWVuhY86KyHkjXAyU=;
	b=IBAF3P6jST2LlBK6PNJiDrAsSJjEqbRhJygjKVm0NbYc070OWWGpDhJB2MuyTFYSgAS4XO
	n1t5ey42f2Gk3wKAT+ek/B1SV0QPjtwPcZnkmtQG4xohh3wqf23njQJb6hHLlrjpDzJ7aA
	VkrtZZ0is7/isDNYUi/77ao0aWpZDGc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-EWiwk94FNZuB5-9JpPm1KQ-1; Tue, 04 Mar 2025 11:19:03 -0500
X-MC-Unique: EWiwk94FNZuB5-9JpPm1KQ-1
X-Mimecast-MFC-AGG-ID: EWiwk94FNZuB5-9JpPm1KQ_1741105142
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e88964702cso126304056d6.0
        for <linux-block@vger.kernel.org>; Tue, 04 Mar 2025 08:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741105142; x=1741709942;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkY1q4GVy/AgzNXZlr3UCoSg7uwWVuhY86KyHkjXAyU=;
        b=UUSZgbv3td9ChpRzP/ptabRykmciuVpCqiLEP4wBrjdJVnAOvwGk8bWztTCSzVhLNy
         dy69ja+7VKUZGyr/Uvucv9Sm9mLD5LnoSrRWndT8Z4G8NGEUzn46zHA52mxdTd0Jw5bf
         q0g4x7yCQ3wJ7y19PxMJTMon3ZZW9d90LRUY+pHufDUqja0NypkU2cDZs7zIB4Y18UbW
         HYC6O6utLSpOFO3xt/b/zTBUypsHx8V+RQXxliqcaMjTYMzu1vK7VRatfq5Q1HJUvXOU
         91vN5lbcR2cYzttE7Z0/zp8a1pPWMBuCBQnpRXJEutY1lbYJTmkEU5wNA2cWsaVB/41o
         inKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEteRNlrMOhFZkqtQW0XiXe03mulDdd/xDDZ7WtzGikKsF3jEYDQoLPwB8eJVZhoGKKg17Alig9D3OwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBVkt5CecvmfLuh2ZsSpBOSGIpXtUya/wdehzfCWhfcnZSotmE
	OOdCduUoFqBcDuBJTZdDMx24wb72ESZpE74xyOhdNofo5LH8uVOXhCf6FHLPa1yMXQckJ8ac/HI
	j0mhza9rf9lRo09LeE2fjrKcTqxTnnXLTzjR78NVR0GUjnVHnpV/3sP7QgUEn
X-Gm-Gg: ASbGncvOnLfl20/m5sFh59Ogqmo9Vsv87eRDnnWAcEYYEwkzjOCThRyUsDE0zM6AEPF
	CmAcIMWYD0cIcCIUTQcI6CSJWoHB1HrdEgxfS1eU2hmiX82J7MAnNGnTMqXGVt9rLOxcx31zJZ0
	D0rL7xDq2vyxKVZ7lAbb9BwVtzoj9o8qyQwtC45VdYJnlCF5oPm54z9SdA/8SSTLJUW2uNCs7b4
	lfGQaotNYkPbLxHpWxtVJJhIF1KAbR7fSucp9P36zgKOovylE3+e9FUaY8bs7RDn5z+81ECye9Y
	/SA65j3yubokc+CY97UKsLV9lmmUEmN8mmrMeoKWYuwC3eDdfnatAD0bevk=
X-Received: by 2002:a05:6214:d0a:b0:6e2:4da9:4e2d with SMTP id 6a1803df08f44-6e8da86c4e6mr54175526d6.9.1741105142535;
        Tue, 04 Mar 2025 08:19:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGf9Lkg6ASc/ykDXkK6Oa+0eE2cY96omReERphGYblNYllL/ZY1FB1NRS0/OnykdtBdUDLs1Q==
X-Received: by 2002:a05:6214:d0a:b0:6e2:4da9:4e2d with SMTP id 6a1803df08f44-6e8da86c4e6mr54175276d6.9.1741105142174;
        Tue, 04 Mar 2025 08:19:02 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976608e7sm67966136d6.51.2025.03.04.08.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 08:19:01 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8b8f0f99-6d42-4c6f-9c43-d0224bdedf9e@redhat.com>
Date: Tue, 4 Mar 2025 11:19:00 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] cgroup/cpuset-v1: Add deprecation warnings to
 sched_load_balance and memory_pressure_enabled
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250304153801.597907-1-mkoutny@suse.com>
 <20250304153801.597907-2-mkoutny@suse.com>
Content-Language: en-US
In-Reply-To: <20250304153801.597907-2-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/4/25 10:37 AM, Michal Koutný wrote:
> These two v1 feature have analogues in cgroup v2.
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cpuset-v1.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 25c1d7b77e2f2..3e81ac76578c7 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -430,12 +430,14 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>   		retval = cpuset_update_flag(CS_MEM_HARDWALL, cs, val);
>   		break;
>   	case FILE_SCHED_LOAD_BALANCE:
> +		pr_warn_once("cpuset.%s is deprecated, use cpus.partition instead\n", cft->name);
Should you use the full name "cpuset.cpus.partition" instead?
>   		retval = cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
>   		break;
>   	case FILE_MEMORY_MIGRATE:
>   		retval = cpuset_update_flag(CS_MEMORY_MIGRATE, cs, val);
>   		break;
>   	case FILE_MEMORY_PRESSURE_ENABLED:
> +		pr_warn_once("cpuset.%s is deprecated, use memory.pressure instead\n", cft->name);

memory.pressure depends on CONFIG_PSI, so it may not available in some 
cases. My suggestion is to add a "if available" suffix.

I do have some concern with the use of pr_warn*() because some users may 
attempt to use the panic_on_warn command line option.

Cheers,
Longman

