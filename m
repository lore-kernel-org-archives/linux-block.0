Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795782569;
	b=Okg/452xMb/LH1gOpKavbdTPFo+xdMYFpTLMCZn1rEGCzrCCOtMsi4x3YmGdt6LU0CmE
	 GlAt54/uXLIvHywgQdxpEL+dw4Lj28rsq/TE9Lpp3VoH8XmkQB5IvelAR/HOU2fvH5JI3
	 YIgT5IyNTSmSYMylomnQX61wRE6oV+llCrStSoLZ3S6D5AxZ28PUFWS1YyJc9VPt0YX5y
	 HoBNCHnkbZgcSEn+/7/ckz+qTHY98erU985jrAr6rTt1/Br3omvTIrqE2mS4U/Cji8UzO
	 WPAqkiQzf/wY4w68Fak/Tl/iuCJjwgdy/5OOxouwr+3DLIKdouwx/EUOtUOiyRbzDtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gXf5stEDIYuDZVQjUcNyW733hx6qDRKNZoyJXoBIROc=;
	b=SybE7eZZ1X1tMvbsZtdS0dY7ZVBXSYSwnkUdiijvlHOpcpi90Ln8OBG6puWX+1PgTqMp
	 NyNdXlgO0JDgRHVD3r4AnFFW3iPBeWXituw/uu+AmSBtbyeCRgFpu9MUIC7LPsiIGrGxN
	 LhXaZTxhB3cMN41l7P2Ng/oYzdzRD0OV5c1lShmGU80kUJsUbQgCWTyntmVLyzVOqKluI
	 9ngGc5pZW1+Q4/5bRHv8YPcMT98Hywv7397wiOPdcSIXuYGm85hUhVgR7U9/k/IzB3NFC
	 rCX81pDz2n077ZbDRbMhPv72S65RFgKN5iVfdW4CE92kBZbvn6mc7JeMpohNvg2SGjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IDtGKepm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C244606A326
	for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 12:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C244606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IDtGKepm
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-55be673e029so1832161cf.1
        for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 04:29:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795782568; cv=none;
        d=google.com; s=arc-20260327;
        b=N7IJlQt0A2hjKpy4aHj+YFCJGb/I7WHgi8yqpbJcUvicoAaNrSp0v4dh1P/7bPV6JY
         h6MRLDWJJBvqGb/bpqc169Uoklw+0wGB05k9Veo3c7lHdrbR4kqhO4djzprDmrtuqnq4
         wD4SKkGjDdveqG15oJgKhPxvrfMBRShOgg3B1bfGO9VgQ2W0qIwuLH7rH+k0vLle4JyY
         x2pE1u12Gk7pkuem0br9v8AhSpI3ubxOf6DaaUPk9LUuC9uSdbKoYWYrjtnbwopgJcp3
         BKVVRcrT6gTu6mg5qnKfoInyA2UD5qZMuyiAbFU9CltBikG+ONyW009GLGTlH25ySSgd
         /xQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gXf5stEDIYuDZVQjUcNyW733hx6qDRKNZoyJXoBIROc=;
        fh=ZosvrFKr8Fpy2oXHy9pCuVjKetm95B3IbKwfVcf/xKo=;
        b=QvYA5eS/vfDJIFEnkVcsLWj4bexnJA7LpOhqE8TuSSbc2UwEBQaLkYYb4GAo/4du8w
         S03Iam2/qJXZYaxFXl8Z5F83o0ZMtT9tKTYjdq0beDIgXvXPWy7DcpwuGZ8xzRFizXrA
         Aej9Xb/ciPWOJH8Xfft8UoWYLYxbi7UGIGDtrHfc2VHVdQWvYvHu+TQ1kc75Q4iG3DHg
         aa1G3ECAeDLuw42+3Mq4tUeqJ4qu//Vun1B5GcgngCH4RGTH2AGQQ/jizEOGKdxWPrMr
         DGUQa2Rznm0ZqSUjpkJf1VzJt807y7dE2xAZdu1z1FlkH5Cv0sxhCbkXGI2vhPQBeCQh
         MHig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795782568; x=1796387368; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gXf5stEDIYuDZVQjUcNyW733hx6qDRKNZoyJXoBIROc=;
        b=IDtGKepmhQShYR7D/olwV/obTk+1pmvySEjMhbDi/ma/1i93QiS/JtjUrgxBSMhQ0k
         JL+ilsf6MgB7rL0RhzqkxVfHwpWehnk7Fk4Q747FAHE3PcGDe+yn84ff6jYRMPlMbx0e
         QokdEvRzq0preycHEpMBQ2Lohvx+Zw/uSsx2DMrkiT1qcSSKYLtRImSCVnyuzNksYALX
         NtWTa/1okzanV5FHK0NJqjKm441asfoZ8MYagjrt+QkZuqm+fqNCuiCSxrGhrELhPKIE
         fk/8Dwyrnu3Us/ZvtQsa36mEXHtFs/36/ZYUVzpvU3JIUzDhbiIDtqOBlvidXDxzNxSY
         eJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795782568; x=1796387368;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gXf5stEDIYuDZVQjUcNyW733hx6qDRKNZoyJXoBIROc=;
        b=nhI8Nz60c5oylNNvaKS24xSpg2WfiOORsWAPkNzlccaozRPLbVBkn9EPPDB2NdzMg9
         NufBJwmaalnx0HpO3SHF89IFzGp74Zn+Shqv2HyL+Kno0R9BfM+fhkbNm6mEswyAfaPQ
         4c9/sG2QlCVCRzb8EDy1E9IIElXULrhJGIZ6XGOhI+7O650gINndUjRAu9Fv/tKs2sg6
         v4z25KKTA+lIBq/8D9CkdSPfEApZli/MvZc+2rpxKvO1mnien8BdL9n7peN9Lgqre/j/
         H6AwGgRy46KCOE02JFDBJzxtdaS+jaR9C+j3Ck2oPc2fJbbxGYFsVqxfEMENNY8qBQIY
         H1SQ==
X-Forwarded-Encrypted: i=1; AL+hErGRez9R0G0NF7kI6kiMYioHd2+V9DYTT1gzJFWMjUNnNUwlYgoxORWsw9nD0adVlvZr+tu7D6atr/Udpw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+lEbdWT2+THyp/nklh9jyeCbFKuPq/v4lvRiJys226bXMsBnup
	tVLweaXOSQ5VEmSSusl0DCO2vN9MHz0pRxoSjPZpxf8B6hxyN4VM8/6X1ck8APBNY+c3Y3vkENP
	T5creqXHEmrbq+tMVPaqbqWbPwC8OjyEuk4AN+4Z+
X-Gm-Gg: AZFdTZcMx5uHOR0RQgYvAHCRkaoWZSIFGu8xyBhpWi2uR4hNVGBxwlt3J3OKI4Yj4j6
	Ida8hFCOdGaN+t9XBOr7k3QBJcOf/p2GzGzdigGnXhsQk60Xmcv4HX0lKuicKRAa3YNz1wmbfW6
	FtEzL7C8GfUP4VArEB14Mzq2wuKpj3QgOBdiHMd1PDRQHhznfx5JMCIJn0BGeS80vffVGGB7dw1
	OjrMu8nl5AXsYEypiINsffmPXkXEG5M2EGvr+lChHsV6SoYCntvdvs8V5ZWIhCSoADkiRNzzAfn
	oDwdB+OxJSR90nnMxSNrn/m56MnG5kQ7Vl+fxo82qf8/uE4ibVuedBeDig1P9JWXbkGKHGZGc97
	UA7fX1pbqJxGIoFZmkuLEa2WL30WgiXBobYapyg==
X-Received: by 2002:a05:622a:a14:b0:536:6ae9:f55f with SMTP id
 d75a77b69052e-55d8900bdcfmr34062041cf.7.1795782567558; Fri, 27 Nov 2026
 04:29:27 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109182533.3594984-1-lrizzo@google.com> <20261120010655.467825-1-lrizzo@google.com>
 <20261120135013.GO3115493@ziepe.ca> <CAMOZA0LmZ9PFzxLcc1SuS8piFyZu6P=vX_qR2jy-3QRUoNCUKA@mail.gmail.com>
 <1f10002ea9ee16a17087bd06e4a1685a973fdf6e.camel@linux.ibm.com>
 <CAMP57yVZx=s-JXHfQfd_ouv2jV6MMsJXpxVLkQQHG=7qfFVJfA@mail.gmail.com> <d42bd9452d00a0b2a5b7d6652d556c9fc8d2c830.camel@linux.ibm.com>
In-Reply-To: <d42bd9452d00a0b2a5b7d6652d556c9fc8d2c830.camel@linux.ibm.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 27 Nov 2026 13:28:50 +0100
X-Gm-Features: Aa3M54o01jhZM9dCQYVFb8_-yMQWCkVYamRB04RwDLjyCo_Cf-5r3I24fRo_Jr4
Message-ID: <CAMOZA0JMZ8wUrV08YznFUH7AkmyqXcNdzfd26KsoTtzqt69SVA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/25] PISA: Pre-mapped IOVA Superpage Allocator
 for DMA and CoCo
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Naman Gulati <namangulati@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Harry Yoo <harry@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Christoph Hellwig <hch@lst.de>, Dragos Tatulea <dtatulea@nvidia.com>, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Catching up on a few comments:

On Thu, Nov 26, 2026 at 9:46=E2=80=AFPM Niklas Schnelle <schnelle@linux.ibm=
.com> wrote:
>
> On Mon, 2026-11-23 at 09:50 -0800, Naman Gulati wrote:
> > On Mon, Nov 23, 2026 at 2:10=E2=80=AFAM Niklas Schnelle <schnelle@linux=
.ibm.com> wrote:
...
> > > I think that approach would also align with Jason's idea to keep thin=
gs
> > > within the network stack and to work with the tools we have until the=
ir
> > > limits become very clear.
> >
> > Hi Niklas,
> >
> > I have been working on this idea exactly - extending the network
> > page-pool with a memory provider that allocates large pages, splitting
> > them into N smaller pages that all share a single IOMMU entry. I
> > breifly shared my approach in the v1 PMD series [1]. I'm readying a
> > short RFC to share shortly, would appreciate your feedback.
> >
> >
> > [1] https://lore.kernel.org/netdev/CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69t=
rmw+BJRVYf3JB1g@mail.gmail.com/
> >
>
> Hi Naman,
>
> This does look more contained, but I'd say you should still go simpler
> and fewer steps per series. Some thoughts:
...
> - This is still a LOT of churn, my gut says much of the benefit should
> be possible with much less churn. It's really too much to follow but a
> cursory look makes me feel like there is duplication between rx and tx,
> which is weird since for the pre-mapping they should be quite similar.
> There also seems to be very little integration with the existing page
> pool, rather it seems to set up a parallel mechanism for the pre-mapped
> buffers. Really in a first step I think we "just" want to use a more
> efficient DMA mapping and contiguous memory chunks for the page pool
> and also keep the page pool API unchanged as much as possible.

The implementations seem large because they expose limitations
in the current kernel code (or our understanding of it;
but the proof is in the pudding). Networking for one, since you
mention it: the tx path allocates memory in many places without any
hint on how the memory will be used (loopback or device with IOMMU ?
cleartext or encrypted?).

If we limit to the easy parts (e.g. just network RX) we may avoid
some churn but we will not resolve the problems arising
from reasonably strict IOMMU deployments on large systems:
- IOTLB thrashing (network traffic uses separate PTEs for
  rx buffers, rx headers, tx_buffers, tx headers). Rx buffers
  are only 25..50% of the total. See [1] for some data.
- per-buffer VM exits on overcommitted VMs (same problem as above)
- IOMMU unmap serialization (with strict DMA, I measured over 10us under lo=
ad)
- swiotlb copy cost (on tx and a backlogged queue, most of the copies
  happen on the TX softirq handler).

Also we will not be able to see what is lacking in the current kernel
code to address all the above.

What I wanted to do with my series (Request-For-Comment, for a reason)
was to identify the components we presumably need (meaning: implement,
or figure out where they already exist and actually do what we need)
and get an idea of how intrusive the changes would be.

Then it is completely fair to say that the goal is not worth the effort
and should not be pursued, or to take the low-hanging fruits out of it.

cheers
luigi

[1] Here is an experiment with a system using bidirectional TCP
traffic on multiple NICs, where IOTLB thrashing becomes a bottleneck.
Below is how total throughput (TCP payload TX+RX across all NICs)
changes using 2MB mappings for different regions.
We really need to cover them all to recover the performance
of identity mode

Use of 2MB mappings         total TCP throughput Gbps
-----------------------------------------------------
none                                  440
rings                                 572
rx_buf rings                          577
rx_buf tx_hdr                         572
rx_buf tx_buf                         649
rx_buf rx_hdr                         674
rx_buf rx_hdr tx_buf                  716
rx_buf tx_buf tx_hdr                  734
rx_buf rx_hdr tx_buf tx_hdr rings     744
identity mode                         744
------------------------------------------------------
