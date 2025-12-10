Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B01C3F36
	for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765385845; cv=none; b=YRSY0xFpXkq9NFHmgM+L1nU9Jc8gzlpOgyp6t6ozQlhUVxP6OM8H7s1KDPKWC2MvwE6gShiO/evHIcoQk0tk4ti+rw3L5wnS5glawIYF+4ezLlVjJIU6qftMj8As0meWNwi1e6sIyAkOvjDR7SYzpv8Y9NrTRO1MGsgyxKaRWKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765385845; c=relaxed/simple;
	bh=ne8NvOAvFFZDyWLijTFkORn2krR9QgII4t00fOofTpM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sAOsZ57ezGwXy6fZd2ADFscahrzeHlRUX+QbC3is/wN6/eXfLauqNAq9tDZF9Tt12SFq+I5lLIl6FAzO5cVDgPVVt6DhfY77dfRM1RrorwYN5GrC1xWWcFX/PleXBlXoMr/majz2lnr58546SRwiQZp3/ra7aSdSKw6FfeVZVos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GtQOUgUi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJnSgk5q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtQOUgUi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJnSgk5q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765385842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n4vjuiVWtSeDDJf5R2NBM1m79JOYpshPwskFvViMdAw=;
	b=GtQOUgUiYFGGcRH62PMmkaKekNitZoWxqIufjh6W9Y1OQup2hIj3riQU3P0dO3ArPtJjIx
	XcDeXx+BT0Fsn3GIZ/yXrgaeIXiZW3AL3XpHGQl/g3EZUCHSp6ju9JPcBQzB19BvbOx0pf
	FqyNEA7VAfrNSHLptJtNdpqntmqcZXg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-2kAMfJf6OR-jhqgqm2Q4kw-1; Wed, 10 Dec 2025 11:57:21 -0500
X-MC-Unique: 2kAMfJf6OR-jhqgqm2Q4kw-1
X-Mimecast-MFC-AGG-ID: 2kAMfJf6OR-jhqgqm2Q4kw_1765385840
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477cf2230c8so153295e9.0
        for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 08:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765385839; x=1765990639; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n4vjuiVWtSeDDJf5R2NBM1m79JOYpshPwskFvViMdAw=;
        b=FJnSgk5q991QaPpIHJbOj3ZLbxdCKin/qMtbPTBXhdvtEGpprZIGemtUjNzYUfYDqt
         YFYppDbmYjXKAGsQcj+Tv3fYJp68adSLipMQOcVpWwlzM9vRB571jF0TT3WTfd0/22Np
         xTRZxmArIDAbFABJCPFF2+WYopGcFPtI1OXL3igzYpCPkXXDJw9gwtlOdX8+dSQBgGfy
         FMRTds3x9SSo0T8jeAesI+8MitOGMGYq1dK8aa0Al22XweZCg/eSlEOpRKVEpTikHdyB
         w6+fM5Yfgus/lIt7fPEiKr1nC6kW42wSniRuz/vhX2f1MEXbu5VQESS8ALLYTJT8HhVU
         kWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765385839; x=1765990639;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4vjuiVWtSeDDJf5R2NBM1m79JOYpshPwskFvViMdAw=;
        b=GjNXWjj1j7VerlC/k6GFbpXarKJ49hpQHmbASzztCHedZPaXbCdGiesnITsc8KoAji
         ya24e4II08f3l0Lhqv8q2qY2xXSr1uP1gYjF258Qs5JNiERoLuuFuko+bKuerkFteC9X
         /fFVPYpZyqAdurzCKoSf7bmR6rbtlEeo47lpqcfh2knuYReYbNq49wp/KCfehTCcca6p
         i6A1mCX8+hURMCpggXbFQsI1DyOwN7IOgToPXC+uh99J23T6nR995nEbL5vlGvhmy4qH
         B62nFRHVZwoUmAw5dzChqEM/IPxvHllQMcNMXmSkmO/I2YV8ZQSWJW+6oFxSROyHsA43
         Ch1A==
X-Forwarded-Encrypted: i=1; AJvYcCXuLPfljr3RP7PSTuOh613qJPhGXHopVj5W5rOCQBZrn2HIfNNliCjLKGZnj1sNDTNhWP0vuBtHsA9InQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSM2qlHWKriKMp3B32tPmP03fEAZEI1Me/C1OvYlQQHcavNx12
	pmYBdFyq04ycMNoR7i0HjbjBCOYNe9/UbLwRPMvPLoYYa3qhWe6mi/8dwW4lbFiap2gJxO87uRK
	tn4ojMXO0G0l0CRpQB3UaYTwmrn9zu+uUMbUPvludNxrf+Nd3XoZozHQ5l2cRcUv5
X-Gm-Gg: ASbGncv7Xfz37RK99nTr+gCMuH2HjcjKbESpIuhePIKpNLvbKz6DVctZLxeka7YWchb
	3CmjG1aALRgcMkDygsNWvYz+k+8EqXstAuO9DgWgquSqv306nB/Up2bIH+WqFch22mTHsuxQ+c2
	ICPdlcxt/fBPfAQZkZZhtmHjxFs9IQUR2VRRz/mdTnOM7T8tKovlxt5lJM9MURlJRDXCNvXe0L5
	HbkADo+wtSiKSZIyMtZLELneAN3LpLcQtQi5+OPlZRsCn2G9SXyy4bXOeeb/MPMOhv5vCeOA7Aa
	XvJ1oKorJRiEz3qrrDRMn8/rNGjcsMJy0C+hSsP51zKutOKy9NgkdDvKs+JvM9SyS+73XNUi/NA
	eSNftww6S/nPOjmnXpmtonOh/A5Rht+lGnMaqPx71XeeZ+fLhEwVf1NhsIrM=
X-Received: by 2002:a05:600c:4703:b0:476:4efc:8ed4 with SMTP id 5b1f17b1804b1-47a8380c006mr28364445e9.11.1765385839633;
        Wed, 10 Dec 2025 08:57:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1ErKmvwfO917QfwpOmc3kdwchwTX5DWogSYZNPVxkP8iDCKVQ0toYxrjvCOwIlDXwEtINDA==
X-Received: by 2002:a05:600c:4703:b0:476:4efc:8ed4 with SMTP id 5b1f17b1804b1-47a8380c006mr28364255e9.11.1765385839191;
        Wed, 10 Dec 2025 08:57:19 -0800 (PST)
Received: from rh (p200300f6af498100e5be2e2bdb5254b6.dip0.t-ipconnect.de. [2003:f6:af49:8100:e5be:2e2b:db52:54b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8837fdd5sm1473825e9.13.2025.12.10.08.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 08:57:18 -0800 (PST)
Date: Wed, 10 Dec 2025 17:57:17 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Keith Busch <kbusch@kernel.org>
cc: linux-nvme@lists.infradead.org, iommu@lists.linux.dev, 
    linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-xfs@vger.kernel.org, Jens Axboe <axboe@fb.com>, 
    Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>, 
    Robin Murphy <robin.murphy@arm.com>, Carlos Maiolino <cem@kernel.org>
Subject: Re: WARNING: drivers/iommu/io-pgtable-arm.c:639
In-Reply-To: <aTlXuhmsil7YFKTR@kbusch-mbp>
Message-ID: <6cb5157f-c14b-5a86-c26d-50aaadf8d3ca@redhat.com>
References: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com> <aTj-8-_tHHY7q5C0@kbusch-mbp> <acb053b0-fc08-91c6-c166-eebf26b5987e@redhat.com> <aTlXuhmsil7YFKTR@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 10 Dec 2025, Keith Busch wrote:
> On Wed, Dec 10, 2025 at 12:08:36PM +0100, Sebastian Ott wrote:
>> On Wed, 10 Dec 2025, Keith Busch wrote:
>>> On Tue, Dec 09, 2025 at 12:43:31PM +0100, Sebastian Ott wrote:
>>>> got the following warning after a kernel update on Thurstday, leading to a
>>>> panic and fs corruption. I didn't capture the first warning but I'm pretty
>>>> sure it was the same. It's reproducible but I didn't bisect since it
>>>> borked my fs. The only hint I can give is that v6.18 worked. Is this a
>>>> known issue? Anything I should try?
>>>
>>> Could you check if your nvme device supports SGLs? There are some new
>>> features in 6.19 that would allow merging IO that wouldn't have happened
>>> before. You can check from command line:
>>>
>>>  # nvme id-ctrl /dev/nvme0 | grep sgl
>>
>> # nvme id-ctrl /dev/nvme0n1 | grep sgl
>> sgls      : 0xf0002
>
> Oh neat, so you *do* support SGL. Not that it was required as arm64
> can support iommu granularities larger than the NVMe PRP unit, so the
> bug was possible to hit in either case for you (assuming the smmu was
> configured with 64k io page size).
>
> Anyway, thanks for the report, and sorry for the fs trouble the bug
> caused you.

No worries, it was a test system in need for an upgrade anyway.
Thanks for the quick fix!

> I'm working on a blktest to specifically target this
> condition so we don't regress again. I just need to make sure to run it
> on a system with iommu enabled (usually it's off on my test machine).

Great!

