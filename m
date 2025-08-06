Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3211028BABA
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484525; cv=none; b=tizuhQTOiX/egXkYvK1jbChAIsyfcM2D5hg1NzvyiClUSO8VVxfAG7CeLBY1yj6ECaGPctG1s+Y4ZJvAj1aNAMiAtLzyqCs2JVn71VtJpwdZ8SOh2RdPNaJDHcCtBF1wwa/SC7caIP+z1wTVgejgK0+qhP5nsoCXJXG57kC4Gbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484525; c=relaxed/simple;
	bh=/CwT3ye57xrzmTFKOJsEykyxmMNNDq/+ChRIJ14zvms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBqmSE/37IdxWqk2apmUXxMPqY16Ddlmw/rza9BnGn8CA+Rw1WdYnFk4imBOLOprKyY6D4EJ64GOsKNaRynXzFCE8qyesFPVTG9N6Ylh5EO+SOLRDMVBOR9R3Otsvlp5mPIanu07u3Ljbz+eIvNFmIZaJ7njXPzJI/r4llk+Evo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ikWs6J5d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikWs6J5d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754484523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kd9TtjMY9qlGHRoxZCwU+VUHOBngdR5vc0FuqtfK3A0=;
	b=ikWs6J5dlwUdbqWSJA3pMcD04PqQL6jtkBnPOP1qg+XIZ5l3k42FV7oUeIg/t0tSjZFkOl
	MxRFfMuu/Ii+Z5mXk5eoXyRni8sL53lDNaBlRhZEsS07Dzcqph5vvCvjJcsMPgBvnxWcY3
	oZghBCEPW/DECScydcp+KXpARU0G/wk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-cQx1FLcQPaeVzkDqd6cy8g-1; Wed, 06 Aug 2025 08:48:42 -0400
X-MC-Unique: cQx1FLcQPaeVzkDqd6cy8g-1
X-Mimecast-MFC-AGG-ID: cQx1FLcQPaeVzkDqd6cy8g_1754484521
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459e30eeea3so10684205e9.0
        for <linux-block@vger.kernel.org>; Wed, 06 Aug 2025 05:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754484521; x=1755089321;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kd9TtjMY9qlGHRoxZCwU+VUHOBngdR5vc0FuqtfK3A0=;
        b=hBChJPcQHw3rSZuu4CCHp+FnRD/2/cbIh4yGlFNhB8dU0EDfrM1WgmY9uAau0H4hn+
         AcGt8PCely5W8JyniKXCadDr5ADzDwgmJlOZD3CE0GxODFrStIpgPN9au0pKXS02zpED
         nReSJK/nFONaiPQz36BX40Rc8peNj5L8VtZPo1Ve0FHgezRAViJJVyLJ/rqL8uHrSqiO
         rXi7OreRkKmPRzkgh94dVvwgbdVg8upBk+s7YsQ+5U8zUtiFNV7oD5JkuoTZc3JaboBB
         E6tQQSNEBSnunYgJq7RZQOThs1evjdgAdAdznxn/rgNUsHgpG/g5zxCLs9VGkk1YDq4e
         FKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Zqd0NZjreM/xFtWJjMfY3XJTXQ9D7ay8AmrCjp8cdaiNf2Tixc1JwSwFUWfSEM8B66eg+bqp1Bc20g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD2L/6oS/uFvlh1bNGE9XbGQrxUICDIut12o8JdrO9NkH2XC5b
	mbDAgDqq6CxDl47R9G2isMoRQbCWzz+TmTOzjw8Y2DsFekOMVEr809JTXvDZuFtvWwVCVZE/lVL
	Gzk/gD1gGyKioAD1eKM+OPw9Bwg47CPYf5rTTlgb0LFRE+WrqoSYvLdwArR2eleqj
X-Gm-Gg: ASbGncssTag4VQPQgc01akTINSYF2+USy8k00bdvzRRefFRkY80mMJZKWibTtgTVL5E
	RWXE6ByhR73I6sZ19CduDWp+yng2aNMdgRnTWN269LPt1sJeEmbjhGmaCI7Y7kuPFc4Qh+EfFUu
	Yv8gunuJPyBAisG6f+ughFJoXBJNOdquMrWxV+YetMvHV5A1Qo3OE2P7ZKeLfbEBssyV1vUKxmn
	8dxvmnrZzkagqKrQUNCifXJH+yyehR5RVjUjb3X5/TWC/WiFaqagGg8WdtPoukCM5yO75zAEYlS
	/bfnq05lNvqQMSGR07T4cdodEbKvP3uC9bEzfjyLJiI1tA8VvrL1wYi3VM0njpf8QWlFTQM6IOQ
	cLWItqUeHNpOrmY0+pTZg/05wMSW6I6hwXsWgOUCzBDMEZtMt5mCr58PajGJ/wURFUFE=
X-Received: by 2002:a05:600c:4f06:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-459eb99cf40mr6834385e9.24.1754484520816;
        Wed, 06 Aug 2025 05:48:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/0rN2yIF2agG/vG81ip1EWBrfms9ZbUi9pJdD+2A9S9B+Yl3xnrI2Tl8AjbH/66V9kuLDCw==
X-Received: by 2002:a05:600c:4f06:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-459eb99cf40mr6833975e9.24.1754484520361;
        Wed, 06 Aug 2025 05:48:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f35:8a00:42f7:2657:34cc:a51f? (p200300d82f358a0042f7265734cca51f.dip0.t-ipconnect.de. [2003:d8:2f35:8a00:42f7:2657:34cc:a51f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e587ed97sm47763195e9.25.2025.08.06.05.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 05:48:39 -0700 (PDT)
Message-ID: <76e26491-e91a-49fc-9a5b-eb6d840a066e@redhat.com>
Date: Wed, 6 Aug 2025 14:48:38 +0200
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
 <bmngjssdvffqvnfcoledenlxefdqesvfv7l6os5lfpurmczfw5@mn7jouglo72s>
 <e67479f5-e8ed-43a7-8793-c6bff04ff1f4@redhat.com>
 <iputzuntgitahlu3qu2sg5zbzido43ncykcefqawjpkbnvodtn@22gzzl5t77ct>
 <9a657c84-99fe-41ba-88ca-097acab4b96b@redhat.com>
 <lyfgmdjehtfjb2gmj5ciao6l5lmkvlfe54wtlnlhjjf7ge65sa@2dyo3tb6ka4i>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <lyfgmdjehtfjb2gmj5ciao6l5lmkvlfe54wtlnlhjjf7ge65sa@2dyo3tb6ka4i>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.25 14:43, Pankaj Raghav (Samsung) wrote:
> On Wed, Aug 06, 2025 at 02:36:51PM +0200, David Hildenbrand wrote:
>> On 06.08.25 14:28, Pankaj Raghav (Samsung) wrote:
>>> On Wed, Aug 06, 2025 at 02:24:28PM +0200, David Hildenbrand wrote:
>>>> On 06.08.25 14:18, Pankaj Raghav (Samsung) wrote:
>>>>>> We could go one step further and special case in mm_get_huge_zero_folio() +
>>>>>> mm_put_huge_zero_folio() on CONFIG_STATIC_HUGE_ZERO_FOLIO.
>>>>>>
>>>>>
>>>>> Hmm, but we could have also failed to allocate even though the option
>>>>> was enabled.
>>>>
>>>> Then we return huge_zero_folio, which is NULL?
>>>>
>>>> Or what are you concerned about?
>>>
>>> But don't we want to keep the "dynamic" allocation part be present even
>>> though we failed to allocate it statically in the shrinker_init?
>>>
>>> Mainly so that the existing users of mm_get_huge_zero_folio() are not affected by
>>> these changes.
>>
>> I would just keep it simple and say that if we fail the early allocation
>> (which will be extremely unlikely that early during boot!), just don't ever
>> try to reallocate, even not when we could through mm_get_huge_zero_folio().
>>
>> That sounds as simple as it gets. Again, failing to allocate that early and
>> then succeeding to allocate later is a fairly unlikely scenario.
> 
> Ok. I will also document this as a comment just so that people are aware of
> this behaviour.
> 
> Thanks a lot David for the comments and feedback!

Sure, as always, feel free to object if you think I am talking nonsense :)

-- 
Cheers,

David / dhildenb

