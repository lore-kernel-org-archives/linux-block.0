Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE0623A9AC
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589113; cv=none; b=pQTetHnk1SUOHdeKO+0MEMjwkqCqpkOsezR/Kqo5U9EKjZOIr5qn7jEBrY4aQ11M/oL5NtLm5Ud57IwcjM9C3RUMLXq3YpHQ/LVS1YiwKNv2MNziMSxTz+24gt8ntyTu7yPO2EkYxAMGIXXmuShH0I9e/G9aTGumYci7xWln7Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589113; c=relaxed/simple;
	bh=q6++1c2ADBvgs9g4B37AnH974+HtqY3SPSEInNO/cyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bh3zcVlipJgr0D+O0TcYhBH0blcLL8f7li17UbbWUn5qhtq4dappoCo9jIUGUmdfKR+joMMrniIrBtN8+/8xsuT4SfvVP+b1jayihUxYOn60Fj9nYyERkS80rY3/wOGsDm9T2HursgAgmrj7aGRjr85pWrrDgKG6u0oPdj5NYxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Elb+dvkp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Elb+dvkp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752589111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iCz3aFtz9BoXuFwRStITMsUKAM3VRx5ZileAaCmlgUc=;
	b=Elb+dvkpDrd+BKVrNBAT6k25Yt5h/ApO6tanaXQ546iXtyxfBcf5y3qQwNrgfiuLbyj9Xe
	QoIDaFGV3HjxmPHBWbX4avMpSaDPdb1aMDifuTSCv+Hf3jIc+lnHe4AZ8Qa+Bn/3bkb0n2
	IXQ6G1y6MBgUnUk8YMwq0Mcinctpr54=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-0sGx_4wsNsGO20QnPA6LOw-1; Tue, 15 Jul 2025 10:18:30 -0400
X-MC-Unique: 0sGx_4wsNsGO20QnPA6LOw-1
X-Mimecast-MFC-AGG-ID: 0sGx_4wsNsGO20QnPA6LOw_1752589109
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so2500063f8f.0
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 07:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752589109; x=1753193909;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCz3aFtz9BoXuFwRStITMsUKAM3VRx5ZileAaCmlgUc=;
        b=aO2rsQqMA27NNaiCd9vZmQlJI5gvzFVB0gnq2/Lte64pjIihWLd2nwTRiPkQ8H4d6f
         Z8DgBh3a4nQGKEHKC7Fjt1H/N7g5rouTxBJapZQt971Hq65gcqOi/g7g1zF73/3LbLlw
         FTbz/LzDKQdm4uZO7IpvLOVFZGnMe5mr7LTGvVQmDQ3zst4uutvB0P+JBChCS4EMDyOt
         qg+uV6iLi9hDKypkPryktU+K8qIuooEegNXb2D6Yg8OXWNyjirkw+o+u04gwqEUPlTSx
         0SdmOYEvASirVrAQ2gSOJhuTkY5az9mB3UYzxoNrH8NH0KtoMfq6itRDYHRqTagFuXoy
         aM5A==
X-Forwarded-Encrypted: i=1; AJvYcCUugCScDx58rbdCRlCur+2ZlhLKgjox4w/xf6DSwNDFQ+IQn5KLErMiNkolBY6jUga28thaZOi5bD/kJg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn5oDfq4ffLs6ROGOo6vqEeZk5KuUMEVVaF8HRfuOFEvQd6eZ6
	VWKm/ezy2RcisbvkjkQ19HsWF5NzBOv/kGu0jOADsKSu1CAROCGLXm/vJUpZqU6yfyRzjaKqwMd
	Gl3uiML0pyz/OXU0MXdVuzRyHGJRFzeJ82KYawZpPXGFufUudfG2tMUKn8gWTVDwk
X-Gm-Gg: ASbGncuSEkXkfwKSWtKPlaB7NQ49J4qB219ISCQymsoy5vTIqkbbSlGH1VbfExURsOW
	CaEpcPe9x5m2gNZ6k+ugbU2+I5pvYwBHNcU+7OUPlywIjs/sYt58QukrzU/yWDfOkuBhdqWLee+
	ixbNFA4gHHFfjSbxGlOOHkZEdTu2958gr3IZWhcrs+eZmu1BRoQR+b1H6jxBPrjYSFLlVq2DV/p
	RbPRBTOTChM0VdV7L6HM3RoUJ4ALRFO9LqoBfzlxoSaHXbyYsNpKtjed2lBrzgCrgshEFCYAdNP
	kP41dvX6oQWUL0IhEKFcDJPGcRdEvQqbUO3/8SG8uU9aSAUSUpeEhHicjo2ko4tDoQAmHdmzbap
	WOJcLhEs0/+KA4hnHrjaOheYc+tJSnT1Ei7bby+apMfKMkk1nB5S6dbgTet3jx3H1ZXQ=
X-Received: by 2002:a05:6000:643:b0:3a5:25e0:1851 with SMTP id ffacd0b85a97d-3b5f1875e37mr15346483f8f.7.1752589108655;
        Tue, 15 Jul 2025 07:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiBepijZKJjM02yAnF9OJBk4VUiu5bY/nT8xuLFQ4t33OnHfJOgjJeATj2QBAyc/L6yPLj6g==
X-Received: by 2002:a05:6000:643:b0:3a5:25e0:1851 with SMTP id ffacd0b85a97d-3b5f1875e37mr15346404f8f.7.1752589108184;
        Tue, 15 Jul 2025 07:18:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1de0sm15098577f8f.24.2025.07.15.07.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:18:27 -0700 (PDT)
Message-ID: <3336b153-7600-4b1a-9acc-0ecde8d32cdc@redhat.com>
Date: Tue, 15 Jul 2025 16:18:26 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] huge_memory: add
 huge_zero_page_shrinker_(init|exit) function
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-3-kernel@pankajraghav.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250707142319.319642-3-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.07.25 16:23, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Add huge_zero_page_shrinker_init() and huge_zero_page_shrinker_exit().
> As shrinker will not be needed when static PMD zero page is enabled,
> these two functions can be a no-op.
> 
> This is a preparation patch for static PMD zero page. No functional
> changes.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   mm/huge_memory.c | 38 +++++++++++++++++++++++++++-----------
>   1 file changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d3e66136e41a..101b67ab2eb6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -289,6 +289,24 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
>   }
>   
>   static struct shrinker *huge_zero_page_shrinker;
> +static int huge_zero_page_shrinker_init(void)
> +{
> +	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
> +	if (!huge_zero_page_shrinker)
> +		return -ENOMEM;
> +
> +	huge_zero_page_shrinker->count_objects = shrink_huge_zero_page_count;
> +	huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
> +	shrinker_register(huge_zero_page_shrinker);
> +	return 0;
> +}
> +
> +static void huge_zero_page_shrinker_exit(void)
> +{
> +	shrinker_free(huge_zero_page_shrinker);
> +	return;
> +}

While at it, we should rename most of that to "huge_zero_folio" I assume.

-- 
Cheers,

David / dhildenb

