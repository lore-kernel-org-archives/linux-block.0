Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EF523F40C
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395846; cv=none; b=ZXFwocgET+svSIfRi6wpNLXK8aXMq9/Sdrbbp94q+wfR2iLL/hvPy1pTu5/i/Iy04TALjCz+qZpLITLhDUp/6MQ6zU09JXUUf/wIwIcO6eulj7RX5oKen11ES1XNHn5n0LJPL+ZvIuARN6L6IcDca1U77NomtO8r4hmO2Cw/J7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395846; c=relaxed/simple;
	bh=dsbomZ2TJrqJxB3vb/LYF0ouD+kHHvZ3VGqy8aWySIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnZCvcRKbWm+y3kJSp70J/VjEhpY5H3Awjuhp5XGf/e4H8osk8KrZNudBj1rpRC5zkNB5/cBEjg5WSfvr3IaESE9WQB00h4HXacfuRek6TfBR2Xd3HdHMYqsbOZIMuAeTXwICjrtsX6BBYlf5S0TsXq5OMv5/L/xbVsR+s9BrOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bP0AIIQV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bP0AIIQV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754395844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mxPZ9mV2VGEDs+TcyLyleA5F2IOZRlRZriZVa56GH68=;
	b=bP0AIIQV1Je0WcEnkmGqaJGd0nAyN5xTZwMLhbKrsxlL9kqpVkk8w0zG5ICW/kIBB1EqWu
	C6W9O5LsFnO3pdzgGRvQPG7GhD+eFKC8URRR1qLHdDRSceLhhm4/fVyCtHc6gj3C3i2992
	4T2/LY9iB6dguH/Rb+0/OxdNHksXr/U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-A7cIHG6LOsCTQ3j1F-urHQ-1; Tue, 05 Aug 2025 08:10:43 -0400
X-MC-Unique: A7cIHG6LOsCTQ3j1F-urHQ-1
X-Mimecast-MFC-AGG-ID: A7cIHG6LOsCTQ3j1F-urHQ_1754395842
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459d4b5db81so12228415e9.2
        for <linux-block@vger.kernel.org>; Tue, 05 Aug 2025 05:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754395842; x=1755000642;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mxPZ9mV2VGEDs+TcyLyleA5F2IOZRlRZriZVa56GH68=;
        b=WN6Br5b3mDt/ZXDlgpqz3QsQuwmIGc3L5xzFyT7o9EOic6ZUTkr/mzy08zryYAtsmj
         c3mZg/hLDbFrsX6rnYMJ/GWEzLBbW/qKDus73uFvmjphWS7kU3mi1Z+6rA40gYcUZOjN
         SjVZGWTxXzwbrteLoEQdkIlqGEin+PAiwl6T2VqC9D5zMuPTEKQhfe7SCM5X3RO9XkXR
         pmr6uTswN1P7Ct8m1RtITnA/67MuxD1s31wDYtXop5CeUd7+BBT7xmgv/vafz5ZApl0l
         +kyIvAi++o2bFDA5a4eiUCSu7OojvM0IxMfUNDVcBSOLd5J/eICUXdub/pHwV7vVqtW3
         mQOg==
X-Forwarded-Encrypted: i=1; AJvYcCWk1UMd3kiBLGFzeF2lQipPBsGjuu9WnhmQTYS3JNOOWIFOHW73/kO1OXMXFp2R+8bjt8sPigVK8w+MPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2BqBQbA5IifE76pYCD9Pxy5oWTn8o0RBn5lX3SxzRtHluVDdo
	MLdUQ0cH6WlCgfMnAWTycU6WFnTeYQ+sL2Z60PLVH5QTex5i9MYMajcZgICN1xG4C6BbQXiRwkz
	HATsdXASEu5bc4Pe3U40g0ltQ3iLEXaeF/SHuHWeqopyvsNJomZj83u/bWlUj4T65
X-Gm-Gg: ASbGncuE5eEdq2c5uscytYRCmBUyMev+iqeIkvY0ZRkrnJxF7JCJoHgvFp36krDyzLM
	UPKOiRwgREB56Sz4+roFMWCQhR3uGN5swIAqzc5K4kPvJ1NnncEjGjOUtrIufgf3F46x4UiOkVv
	u/eHSWHWZFXLzFsTJEwcLvhUOI4hGYJeeSFpTbhY8hXnCwYu9i6ca9Ejiup5Nc+my+2YXbF0ic4
	Y1VkGVBEzfu2INkIB4uJgpGVfgPXl6r4PAVPxph4sJqFPf3FY8VqHxkU+0hwA9Hu1ECD3hfwmmI
	R40mFjtfR12bAi/kTm2VeQrHAzjAo274vHKPv/5HSdobbpKFMiPEQyl7YkrV9CKNG/jWGeJ5hNw
	CNVGSjhYxpPCMY/coi/FZQ2i5IA3QeZQ3ApG9R4pHkf00y1BwHugmjMvouo7q/1j/za0=
X-Received: by 2002:a05:600c:1391:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-458b69ca295mr96547445e9.4.1754395841903;
        Tue, 05 Aug 2025 05:10:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRVCbz9qSTE0QSs8VJxnp/4QbJ3PPlhM2p3GCusUFNug/XIQgjZ+Xc7sBO+ds4FESyakyM7A==
X-Received: by 2002:a05:600c:1391:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-458b69ca295mr96546975e9.4.1754395841451;
        Tue, 05 Aug 2025 05:10:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:b200:607d:d3d2:3271:1be0? (p200300d82f2bb200607dd3d232711be0.dip0.t-ipconnect.de. [2003:d8:2f2b:b200:607d:d3d2:3271:1be0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ed07fsm98317775e9.22.2025.08.05.05.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:10:40 -0700 (PDT)
Message-ID: <ca35da97-13d1-49f1-95b0-b8b9c8a7f540@redhat.com>
Date: Tue, 5 Aug 2025 14:10:39 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] mm: add static huge zero folio
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, x86@kernel.org,
 linux-block@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
 linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <20250804121356.572917-4-kernel@pankajraghav.com>
 <4463bc75-486d-4034-a19e-d531bec667e8@lucifer.local>
 <70049abc-bf79-4d04-a0a8-dd3787195986@redhat.com>
 <6ff6fc46-49f1-49b0-b7e4-4cb37ec10a57@lucifer.local>
 <bc6cdb11-41fc-486b-9c39-17254f00d751@redhat.com>
 <dwkcsytrcauf24634bsx6dm2wxofaxxaa4jwsu5xszmtje3gin@7dzzzn6opjor>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <dwkcsytrcauf24634bsx6dm2wxofaxxaa4jwsu5xszmtje3gin@7dzzzn6opjor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.25 13:40, Pankaj Raghav (Samsung) wrote:
> Thanks a lot Lorenzo and David for the feedback and quick iteration on
> the patchset. I really like the number of lines of code has been
> steadily reducing since the first version :)
> 
> I will fold the changes in the next series.
> 
> <snip>
>>>> @@ -866,9 +866,14 @@ static int __init thp_shrinker_init(void)
>>>>    	huge_zero_folio_shrinker->scan_objects = shrink_huge_zero_folio_scan;
>>>>    	shrinker_register(huge_zero_folio_shrinker);
>>>> -	deferred_split_shrinker->count_objects = deferred_split_count;
>>>> -	deferred_split_shrinker->scan_objects = deferred_split_scan;
>>>> -	shrinker_register(deferred_split_shrinker);
>>>> +	if (IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO)) {
>>>> +		if (!get_huge_zero_folio())
>>>> +			pr_warn("Allocating static huge zero folio failed\n");
>>>> +	} else {
>>>> +		deferred_split_shrinker->count_objects = deferred_split_count;
>>>> +		deferred_split_shrinker->scan_objects = deferred_split_scan;
>>>> +		shrinker_register(deferred_split_shrinker);
>>>> +	}
>>>>    	return 0;
>>>>    }
>>>> --
>>>> 2.50.1
>>>>
>>>>
>>>> Now, one thing I do not like is that we have "ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO" but
>>>> then have a user-selectable option.
>>>>
>>>> Should we just get rid of ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO?
>>>
> 
> One of the early feedbacks from Lorenzo was that there might be some
> architectures that has PMD size > 2M might enable this by mistake. So
> the ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO was introduced as an extra
> precaution apart from user selectable CONFIG_STATIC_HUGE_ZERO_FOLIO.

People will find creative ways to mis-configure their system no matter 
what you try :)

So I think best we can do is document it carefully.

-- 
Cheers,

David / dhildenb

