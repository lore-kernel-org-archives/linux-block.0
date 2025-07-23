Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A790A95C
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260366; cv=none; b=If6AzqYsgO0Nn/6TzFgUx2K+Rdg4ktUGV1suzFpMmRmZqUROTABZ5pTcYbIJph+o1ZAKAvNzGpoU1X1rQPOOzip5TT6SzeZsFUYw+47DYuAr9ylZAuSSUb03rbU12HAMnEE43q6W0Q89vMEY/DEksbzfUIcPIM/PtRdFI9T2toU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260366; c=relaxed/simple;
	bh=kt/AQVqzR1riEH/JhZGFL67eJRL2IvlNG2B7wKPzFxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hz559gw6SEZEUI6lo0j56uHY7PR8LUSHHInPSRwsRUfeNpdr3JKY3lyp9p+ERz2lNMEWAa7eVaM++N5fLQkSlK/SCOispqrzGYJ0Mf0F6yDS5b+cR5nHlOTrNjCYnmi1QtsqL23PGqEXEqTk0gSvm3DiqlIGwaopERMZz7yWFHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUorYZaL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUorYZaL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753260363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lwDwoJDkvaWB7LHjbQ9xfhrljLJHNe7i273NTEo5hSg=;
	b=dUorYZaLZggwRjGShboKVeu7uxfEgrIDzm3iU5Im9JmntiecVANQcUypuZ5CqUkKveMZhT
	gv5ExV4rsjulwF2X1gDqsny8/HbYllmqb6T/fUb7ID/SV2mOonKbYQ3Y6KIlsrkIs3w5ir
	fbjSYr1QAqj7Pa/rIfub0VxvepHghOg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-xwx7ey5fOFG7LBFJvEnKNw-1; Wed, 23 Jul 2025 04:46:01 -0400
X-MC-Unique: xwx7ey5fOFG7LBFJvEnKNw-1
X-Mimecast-MFC-AGG-ID: xwx7ey5fOFG7LBFJvEnKNw_1753260360
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4ff581df3so342045f8f.1
        for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 01:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753260360; x=1753865160;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lwDwoJDkvaWB7LHjbQ9xfhrljLJHNe7i273NTEo5hSg=;
        b=pfTffyDvJ+ptIeU3MRBe8xTIaKN6pFN0WCrf+Jy1zYolrF/AhFw1NpBF3ULBh6Ih+o
         /ysN+cQspcBvsOXi7iMXMFjPCra+Wb/U10hyQvI+wBVdRBKOQpwQyTTSTMk2+XAOdnhe
         F1/VeCNp+WwSQIBLjFWSNUYJqAFQ89tcHrcDvgdScN4CZqjS5rehP0thLYTdeRQCSkN4
         t5fj5zvf6h8IR4jYsE2d+AknPftWpi5gASYuqfPQ2lpXyLbUyDtSQvuT3EUuF9F2A9Tq
         dWFS8AGQ7FcQdKuYSuJTv1NDKndp/NCgQ96ZT1qOSQms1iraHLuxH9kI7+d7O/XTajub
         Iisg==
X-Forwarded-Encrypted: i=1; AJvYcCVFboif+kyII1QZ9o+WxxF19fAtDTJNuZHnKlVRJM3mRUXakzduXZRh1U5ndQJ1bFUanziw+IvvRttTxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEmvr2G51T/jcwHVis7yI8QARtYwpRbohhmLa2Cq8k424NGKST
	HXzXwFFz2vuMmgDAdM8Y6Myu9C6bFo/faEXAuP4zy0dOHhjzUmYKT7ChEplvbLFU5BpkZN53bBb
	g6R1rw2IUsTae8sz94BlsIL2p9uLRoIejjSo+gd/MqByR9H6LMsfdi2oLUH5aBi2f
X-Gm-Gg: ASbGncuoUSHsRtcRMc0kHgTwF0OTji8QsLhLcrDMrFxigBuU3qXvlfBIuwP+MqQFNI3
	aMv66YR1l4mr3Qc2B9SoP/SVuPOW5VAFzXYZdKSVcyF0Z0hLLsA6F+Uv4OHnxsWzhE+1bsk297l
	vQr761fdVaOpHT5IBRjLAZ41Poa69g+eoQwMH/7e4qO56CBzAPK2qMNtTiYcaIoWp3Y6rqRQhFj
	ZlOtvctNDtWpduAKuhuyeyYPkoeoOvk18Jd0LAr3tz4TFaepesXGbNZ92xmuBhIed1TC1nDmPMv
	ikmvm/OJrpzyadFsL4PG+C/xx2F9YwWe07Si4gFukqMjB8yJoODAM2dm3KWcn201QHv4jx+SOLY
	owf3KYvTwKrktOQ+rpbBBu45cuTzpo5vOxw5nWaBtQ3qQcpFqdMRZ6oWg4LenP7FPX6o=
X-Received: by 2002:a5d:5f8a:0:b0:3b6:cdd:a41f with SMTP id ffacd0b85a97d-3b7634856bdmr4370286f8f.4.1753260359783;
        Wed, 23 Jul 2025 01:45:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUs2CRV37bzZdlRoxR2LvzpvBXfCJ0+7JD5T3DxPlzrfYBfN8LTRYpQ8VI2W2Kjgb1pSmm0w==
X-Received: by 2002:a5d:5f8a:0:b0:3b6:cdd:a41f with SMTP id ffacd0b85a97d-3b7634856bdmr4370260f8f.4.1753260359215;
        Wed, 23 Jul 2025 01:45:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f00:4000:a438:1541:1da1:723a? (p200300d82f004000a43815411da1723a.dip0.t-ipconnect.de. [2003:d8:2f00:4000:a438:1541:1da1:723a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458691b2b36sm15638745e9.34.2025.07.23.01.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 01:45:58 -0700 (PDT)
Message-ID: <e6648680-da88-4f01-9811-00229da858e6@redhat.com>
Date: Wed, 23 Jul 2025 10:45:57 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] add static huge zero folio support
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250722094215.448132-1-kernel@pankajraghav.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250722094215.448132-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.07.25 11:42, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> NOTE: I am resending as an RFC again based on Lorenzo's feedback. The
> old series can be found here [1].
> 
> There are many places in the kernel where we need to zeroout larger
> chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
> is limited by PAGE_SIZE.
> 
> This concern was raised during the review of adding Large Block Size support
> to XFS[2][3].
> 
> This is especially annoying in block devices and filesystems where we
> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
> bvec support in block layer, it is much more efficient to send out
> larger zero pages as a part of a single bvec.
> 
> Some examples of places in the kernel where this could be useful:
> - blkdev_issue_zero_pages()
> - iomap_dio_zero()
> - vmalloc.c:zero_iter()
> - rxperf_process_call()
> - fscrypt_zeroout_range_inline_crypt()
> - bch2_checksum_update()
> ...
> 
> Usually huge_zero_folio is allocated on demand, and it will be
> deallocated by the shrinker if there are no users of it left. At the moment,
> huge_zero_folio infrastructure refcount is tied to the process lifetime
> that created it. This might not work for bio layer as the completions
> can be async and the process that created the huge_zero_folio might no
> longer be alive. And, one of the main point that came during discussion
> is to have something bigger than zero page as a drop-in replacement.
> 
> Add a config option STATIC_HUGE_ZERO_FOLIO that will always allocate
> the huge_zero_folio, and it will never drop the reference. This makes
> using the huge_zero_folio without having to pass any mm struct and does
> not tie the lifetime of the zero folio to anything, making it a drop-in
> replacement for ZERO_PAGE.
> 
> I have converted blkdev_issue_zero_pages() as an example as a part of
> this series. I also noticed close to 4% performance improvement just by
> replacing ZERO_PAGE with static huge_zero_folio.
> 
> I will send patches to individual subsystems using the huge_zero_folio
> once this gets upstreamed.
> 
> Looking forward to some feedback.

Please run scripts/checkpatch.pl on your patches.

There are quite some warning for patch #2 and #3, in particular, around 
using spaces vs. tabs.

-- 
Cheers,

David / dhildenb

