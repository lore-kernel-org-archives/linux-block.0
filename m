Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182618;
	b=H4/PQpYKEiWUe/GDuzzSMruPMVVXZvc3VwiT6dRMu7SMHkXDiPQULcR0BqYB7Xl02q+s
	 rj+5r0n3E8DQAgJNcpb/sPMFYsg3XjSujp60IcM5sM1Fr6xfZuIxktY9spebCnvFTO1hx
	 qPmXWNydlcRUVbtqQDVKmy1VtzW8qcQdwzDuSQPZ1MruzkzGqRqAipEJKtpa64gOqgCI5
	 NRjJs3MMDjZYc5s/osIvQHpGHcHgioeVTdoSmeOSYopt0z4KOmvSD2To3dcjXuxm/Wx1d
	 bqJNtIyUyUzQ6MCE1J9CHp5a58QxZkCR+4Bv4vmSvUI39u3MNOZJVAPyPm1ReMjyjXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=uU+g78pFe3woDmujMNPfhZ/0Qi8mHsxDvK4Ws3nTpkw=;
	b=Pjr3+GDw8zjHadkqlhYI9+QUZEGsK0FHWyPw0/zaN/pvEprcLCQA1DXh3lHLdmoSE+CP
	 7N98lrN6yIXpaZmWyrDaUGQHRtwWSkM7P7kQ2N099h+YQpPkx2X2veGX+CLqYQzJR4S3+
	 VAYKHYBpIAzvt4pfswI8OuY18edouzERGNMinuz8U68cGNiPZ6A9zlQrYdpjL+9pwWEWD
	 DYXiCJiKxOcgiswvQ4eHS55uIDkLMsdEQS1eDay631IpfjNGPGWnIVAP5Wqj13LenXMib
	 xbrk7q9pYDIZzrFQ+mwbOUQ2eLKNN0Sbk2o/SX0D/s/ySN2SgC3ZCbPybkMkAn89xow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ehz6mMEB;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A009F606A339
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 13:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A009F606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ehz6mMEB
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-949680e6d82so131312285a.2
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 05:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795182616; x=1795787416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uU+g78pFe3woDmujMNPfhZ/0Qi8mHsxDvK4Ws3nTpkw=;
        b=ehz6mMEBp7FU9O4IkG6ucYOPrN/2FptPlSVzAMegQhkSAM21Hz39XQX76haUWfk977
         A2S7LqWAyzQ/MMpQcJ9hlw5/i8t5QmFoKEbwfS2++6OthszxDFhEwhu48SFckK+V0pvW
         ZrB7pLti4QW/zlyDdG0NHqvUQqc55WcUlTDasvdx4/7cbllh7O44dOopIvf3GjZWbJGD
         Hp2pPFYqt09CILTVYoO85olovSxlw20uhMs3fEFAaJjWsbuz4Ruyjz74FAK8xTbPsjJm
         YNZjjLR6Muw2SduJu6y83jD/L3yp3ZXbUhG9xHOIQjqowZufFq2KjlStO23Q1v2+do05
         Ehqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182616; x=1795787416;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uU+g78pFe3woDmujMNPfhZ/0Qi8mHsxDvK4Ws3nTpkw=;
        b=Y5uId6kW6/0LlOH8lzDzlpJDCDRWXDnTxAUMNMO3Ah8F3ciSz2gAZLpv3YtmbVNUWX
         exa1y/nA8e4EU3WxAS9wziYBqwegrnGIHiT8YgpFWIBlKgv/RtTdjlqkNhlzzj0lLH16
         k7hHxIbNWwE0d3sJUAyIgFAGrJEk0qm+OOqq3W/677ybN8KrS1svRwVs9f5mpCJhteDl
         7sKkFQIvKwjbCGrb+iLiNOoK9fgNJq0056D1qMiTdC4maNFsPz1N2Fz4bma+9zmjWDJG
         htdTeaqDqztvUBW+9b2ZvHEktm+ZyeVWpCHiRkJewuPYfixwRsRCgH14x/mwdbFp89LA
         7Lfw==
X-Forwarded-Encrypted: i=1; AL+hErHCBLvrTla+JCOTBwyMUh3jL5TT1JiqYnEypDv95hc+nXxaL5zxkD61hJEoxxR9Gkp4cukJ8r8Nr5wwIA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/6zJcHi2E5vKVKFTJsyAk9H4ctEGuJLo8Ht92kBtGo/QVuLtRS
	LCGn401okR8u4b3I8R5z7SEa/eGUmlHgRebmmrslzlAWQrrpWqcpDrisX20uGdojJNU=
X-Gm-Gg: AYBFou0dmvfChDCJjmXnrmrjxgfPaM5PHAEr+ruJlCkve7HNJv7N8F6j4BbG+CNItgT
	2Xrs2insBf2P+MNsBXDMrIgHwtS0dWZWCPizIX8BX62D4Z3nNMUPZZVJ/s3yyLGkIipM8d0T9Id
	bOEq7Q646WCoJrvEIDNXfLs55/0q01+Kk9+i3tpkzJE/xoPFZF6+brRanwiZjR/Z9aqt7+cRCrs
	t1ora7LUN2TH6yLEe83ZgOoyerDb8THje4ibPYrXSI6rL+CUUb6L+JPiOUv7j1wL9D07O56kWsu
	KlyYQryTDSVGcwViKbEf7XcytGIuKdyXJcLh91fVpF/4o1iq7wisRmBSq56tNMqnXZzWpZvGlZN
	T2Ie6x7LMGOPqUTygdVv0sDUsz9gHc9ts/iZKV+MLl5nIESEtJ1TZCqHIejxeOq7ugUJFSsdB/E
	xGLFHzaZDkHk6uAMbYLzp6qlyIsLF7SjyYwv5/2syph3fay+7tveUV5Bp0yZsE4yfhcR54EivVG
	yC/OjPet58/9XMVwX+4b8GvfSJqhoViNuKC09glB/iak35HumWeTJmlIGhU9vt7mfx/rGlh0Qvm
	3YjHvw==
X-Received: by 2002:a05:620a:4111:b0:939:5cd5:e243 with SMTP id af79cd13be357-949ba80f8acmr491343985a.6.1795182615989;
        Fri, 20 Nov 2026 05:50:15 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3f7cf3sm190597085a.31.2026.11.20.05.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:50:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xUP0H-00000003hHG-3ovL;
	Fri, 20 Nov 2026 09:50:13 -0400
Date: Fri, 20 Nov 2026 09:50:13 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Luigi Rizzo <lrizzo@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vlastimil Babka <vbabka@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Luigi Rizzo <rizzo.unipi@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>, Harry Yoo <harry@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Naman Gulati <namangulati@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 00/25] PISA: Pre-mapped IOVA Superpage Allocator
 for DMA and CoCo
Message-ID: <20261120135013.GO3115493@ziepe.ca>
References: <20261109182533.3594984-1-lrizzo@google.com>
 <20261120010655.467825-1-lrizzo@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120010655.467825-1-lrizzo@google.com>

On Fri, Nov 20, 2026 at 01:06:30AM +0000, Luigi Rizzo wrote:
> This is v3 of the RFC previously posted as DMA_PMD [0], now renamed PISA
> ("Pre-mapped IOVA Superpage Allocator"). The text below follows
> Documentation/core-api/pisa.rst (patch 25/25), which has the details.

I thought the conclusion was to just do this stuff in netdev pagepool,
now you come with an enormous AI series spread across the entire
kernel?

> - Needs bounce buffers: in Confidential Computing VMs, PISA allocators
>   pre-decrypt 2MB pages in place, avoiding swiotlb bounce-buffer copies.

It seems this was ignored too. We want the bounce buffers in CC. They
serve a security purpose. You cannot loose control of the shared
memory buffers have have them leak into SKBs, user mappings and so
on. It is not secure.

I don't see how any of this is valuable or necessary for CC,
especially when we really don't even expect to have an vIOMMU for CC
very often..

Jason
