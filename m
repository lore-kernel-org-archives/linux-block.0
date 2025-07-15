Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB73244691
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593230; cv=none; b=eigZjyvOel7hRUu8II2dsGI6LNd2OR0sYrLawJtBUJu0P9TZeDZwtJXtNoTsBHmtxWi/dE2UdqeXiEKJ6ZW94eP9c/JRPnZvE4I+wrkMX6WBs6Gs3TaiVnxb+NOpITAcBddAapYmW5lKkSeQhRIsQsTrcpleNwXo3ewbAMdWBCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593230; c=relaxed/simple;
	bh=AjA8lwVX2aCPhNAKXH4DmME3PdKKjhtmhXiSvdXvquE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGYzhmZMrBruCiCxntHryv3Z3nz2GRL0IKRRMSJ+tSuKur3NECds42VZrMrmB85uOPUHWiWdBJebgh3T9fbB4t8RHt8OxMrmwfjsChtG6B+p/JdCY127SNZ2qsDE53nnzuLJ49lnBG3XghK5sFxqD/feM1YbRKdVUZKLIBpRwLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lr0e4ZA+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lr0e4ZA+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752593228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4xLowFzrxXoeSPcmnmzzy3XsWlNaO4fQFtqJRByiUOs=;
	b=Lr0e4ZA+K3/H9J8rE/1WjMCHwIQtBSefPlSReDlEOnT+O1jcVnpn9wgrHNEvSwQ0VJiiBF
	qOr302UUMHhqMLxrwOV3MBAKJquYTwdUQx2A0t/5P4EHUMy+HuwtBvytCDyxd6FuVaK91J
	/cy/jOW1GYaPO5Adq7LwXx5VgsGb6AQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-w0CAj4lsPVWznxPysDk3aw-1; Tue, 15 Jul 2025 11:27:06 -0400
X-MC-Unique: w0CAj4lsPVWznxPysDk3aw-1
X-Mimecast-MFC-AGG-ID: w0CAj4lsPVWznxPysDk3aw_1752593225
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4fabcafecso2755346f8f.0
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 08:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752593225; x=1753198025;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xLowFzrxXoeSPcmnmzzy3XsWlNaO4fQFtqJRByiUOs=;
        b=U23XK8ACBqCDk6JralnAtNnPy+i8HSNyyLhmEWGDRadhyVGY6weftxJfiTZ0v4HAp5
         ZOjtdOxDeMM8Vdy/7p6g/RvAX7wO28nV9BuyDCCKW52m5v1oSxK6AH5uLyFDPwaPxALo
         fR39W056i2V00RRsNqopztqh0dD2spbnv98TbFxRi4yadElevY8aX+o7E7S2oX7anKcF
         ypNHLNbi7mka97qXDIOFyD8wwhabD7h0VI17tnrQa7GJABqvMgFbjad9rKSG5nDPhfU9
         ZUOHmpBMtPm3q8Cf6MlMSwjRttUAYuKMM47kOfPvVq5V2zbd9TeCnxJhcvjoOdc2yQx8
         Kdqg==
X-Forwarded-Encrypted: i=1; AJvYcCWr49F9zBeK0qOBVD3eVKOZTK1HEc+J0Kp62W4XYo2S5Tcw/Vecdy6sNQ8WFPOs8ut1u4fu5e37t1hKzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxhNOi8V/+UytH+bQcJlSEoWVa8Fo6IbYhfvlgCDYoTAHXRG8p
	Z31Zn/4PRouVLEsFDucVhO0Yh6hk0x+R1MlOhY3E/OBfkIJAWpDf2D2O2SDtFc2I1KD0zPPM3lj
	NYrkpsGlsz2cmn38/5eMwNimiO6Xe4ROHaM4WTWo2Uf3SUEFXN6TN4YkQprqZKl5k
X-Gm-Gg: ASbGnctkntvHWPEYwkefM5ozFqXpoLrso5r39uCTGRXGEwHsiZ00HTlRDQFxtjmgAoV
	9XChLNgPjE8WxFJ0PIeuQR5yuenZYxjUQBBEdJGZrl9PDjh/7mkf6KZwpRC/aQNZ6vciym9nynZ
	fuSTDsS5uTSNdOlygQ8Cgf4/ic3EJPhT0CQqtG8xGlJkFHR299ejG3aLgwP9KH2htiroskLxtlh
	E6n2zm6xDSYhMMei8AxdtrL4Hzbwb3Y3Ksa23yJV30zf9CX+fkgj6dyvfA+AaH5LOYWRdRgn+if
	P0j7sUWNNjJfmspYAhmBqkpPa0VXCOucaOUcdUb1yLzW6vNJPQaTIVLeDc2J66XZ2KQCQh7FOrX
	J6RG8/fPQzvGJXg9W/e2wrl5HHJV+wwORQAK6QSBIWUeNWLQiHphfQAIML8NxZeLc2G4=
X-Received: by 2002:a05:6000:2dc9:b0:3b5:e6bf:5e0c with SMTP id ffacd0b85a97d-3b5f35783b6mr13134611f8f.31.1752593225356;
        Tue, 15 Jul 2025 08:27:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExi1j3X34LWijmZqGxFKMW/7Ro9qGKbZaBrDfu2Bv2+AMOygCRmfqoHXyTXT3YBDGfY/fQZg==
X-Received: by 2002:a05:6000:2dc9:b0:3b5:e6bf:5e0c with SMTP id ffacd0b85a97d-3b5f35783b6mr13134570f8f.31.1752593224856;
        Tue, 15 Jul 2025 08:27:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc91e3sm15253625f8f.43.2025.07.15.08.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 08:27:04 -0700 (PDT)
Message-ID: <a35629df-290f-4adf-9f18-661ea86ed59d@redhat.com>
Date: Tue, 15 Jul 2025 17:27:02 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] add static PMD zero page support
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <F8FE3338-F0E9-4C1B-96A3-393624A6E904@nvidia.com>
 <ad876991-5736-4d4c-9f19-6076832d0c69@pankajraghav.com>
 <be182451-0fdf-4fc8-9465-319684cd38f4@lucifer.local>
 <c3aa4e27-5b00-4511-8130-29c8b8a5b6d9@redhat.com>
 <dca5912a-cdf4-4f7e-a79a-796da8475826@lucifer.local>
 <d7fa2e67-1960-4b1f-a8b7-147371e37010@redhat.com>
 <bdlp7psevt6qqtssknhp55b65sfmbrnz373hudn3i4hqkoxa7u@oabcqpvc3z5k>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <bdlp7psevt6qqtssknhp55b65sfmbrnz373hudn3i4hqkoxa7u@oabcqpvc3z5k>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.25 17:25, Pankaj Raghav (Samsung) wrote:
> On Tue, Jul 15, 2025 at 04:16:44PM +0200, David Hildenbrand wrote:
>> On 15.07.25 16:12, Lorenzo Stoakes wrote:
>>> On Tue, Jul 15, 2025 at 04:06:29PM +0200, David Hildenbrand wrote:
>>>> I think at some point we discussed "when does the PMD-sized zeropage make
>>>> *any* sense on these weird arch configs" (512MiB on arm64 64bit)
>>>>
>>>> No idea who wants to waste half a gig on that at runtime either.
>>>
>>> Yeah this is a problem we _really_ need to solve. But obviously somewhat out of
>>> scope here.
>>>
>>>>
>>>> But yeah, we should let the arch code opt in whether it wants it or not (in
>>>> particular, maybe only on arm64 with CONFIG_PAGE_SIZE_4K)
>>>
>>> I don't think this should be an ARCH_HAS_xxx.
>>>
>>> Because that's saying 'this architecture has X', this isn't architecture
>>> scope.
>>>
>>> I suppose PMDs may vary in terms of how huge they are regardless of page
>>> table size actually.
>>>
>>> So maybe the best solution is a semantic one - just rename this to
>>> ARCH_WANT_STATIC_PMD_ZERO_PAGE
>>>
>>> And then put the page size selector in the arch code.
>>>
>>> For example in arm64 we have:
>>>
>>> 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
>>>
>>> So doing something similar here like:
>>>
>>> 	select ARCH_WANT_STATIC_PMD_ZERO_PAGE if ARM64_4K_PAGES
>>>
>>> Would do thie job and sort everything out.
>>
>> Yes.
> 
> Actually I had something similar in one of my earlier versions[1] where we
> can opt in from arch specific Kconfig with *WANT* instead *HAS*.
> 
> For starters, I will enable this only from x86. We can probably extend
> this once we get the base patches up.

Makes sense.

-- 
Cheers,

David / dhildenb

