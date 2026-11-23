Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456255;
	b=TBmo/dnqRji4/7l0D61gpTI+IQw7HJmnbXU0pVv5uT/ebpA2ytt+3e+St45DjTbC0ADr
	 6ahGWEwZHISyZyBltPdaCTfUo5Wp8lPCZMkXCp1RudwVWvok1orzt0kRs9cs4pzqzKk9X
	 Fo8GVd1mZBkXkqioBjQmmHzGH7oY9u9Q82Zz1M/8o9wbcX8HCgpg9VHEFEeVJwzm8ukZ0
	 ImUycXT2RDe8C9HEzU1+/s/x/NVDEHmMfYSKoTctbokB/UvrljccfRkRipPfpZ4Rh4sw0
	 1xYM74r34Nt6JVXd0IQX1TK1I7z4NJdiJ/jfSryMinBFIp65Kc5mfeBXuXkdaF1DjfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ezlDWRMj9kmxxJBJDvLQDaV+rNJm+P/qJAKPI2Vbze4=;
	b=fMTrYfTe01EjSpSZC2r7BR7384wTcjTnSlklZHHzc4RmhbemFf1MlbUU0447n5/ZMmqW
	 InZQdEfjOK4ZONx93nVg/20dAK8oDTCyU4XMEQDsWOLP4lnbH7n9fL/AmYmHq9MocfYQx
	 4Sb9R4dUfJnw4aSKxvDsP1opQS7dXgD3OpH+e1rbaxo/kniD62LFjAvqtcz+MtosyXZ86
	 TCCgAIk7Ml/gOvTxku7TVqFdGEV3EEJaX3quE4MNSj8eNEZP1ol/1vUUSg+VAZaMyWiGm
	 TooJy5seKEunLx0Erv3ptE6bCP+0SuNcsR1PErqj0gAlyEkDuKNMDUbGi+T1A58B1og==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Rw6Pf2ZE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E307606A31A
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 17:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E307606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Rw6Pf2ZE
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb6860f867so102445e9.1
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 09:50:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795456254; cv=none;
        d=google.com; s=arc-20260327;
        b=Kul0sSdrRGJY8kRsKhU5SwXx5LuuC2Pg2se6RwBgDcd4jDtrqHMx77YuwfuZOUOt3J
         Si+ZOP47NBOzl383gEbMsozkDfrKLxLCGYOFK6sZiZCoIBfL5eaQNVQthOxlAuW1T0PS
         4m3adN83EmXzGwWmVyniZ7/n9AvO9wNt3Q5WSoW17okhkxSO8ZFsctiX9klrFmd3G5WC
         Zg76j5Cn027Q+q/Y26Xtb3qhD/GSDx5QITiHGe0q/tVZzGjECybCzYkhrU5uALqMslRg
         bcVOVLVA15cB8c03Ubztaob24kkqVmwdw1RDd0p+/8S7F5Kf7MolKILd59sPMeNjtCq7
         xRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ezlDWRMj9kmxxJBJDvLQDaV+rNJm+P/qJAKPI2Vbze4=;
        fh=/aJsAOl36ypIEf89QEx+4A/CMyIxgGSbpaqOTj5g0p4=;
        b=BJ1EyH7reAT11suKEbge/QStTC79PIxlMTj3B6TfjaBUwGZILsj2Lj++uxUKWV56ZZ
         Teacvmup4FgRItXT6APrdM0aemc1VcoQdOz1t86/1Hz9LAWQ/UoiR2r9vC2KpSuk1jIL
         XiZr6bMeIw+VdiBJV/BhPs4t8OmOkeezbMhVEwODYS7VPuz99wm9VAsDrpSJckRLeEsl
         KE2qmo4py9j4aNK6kgBVRxUabTh41zcJpejOeVd0s3RvwJQBh8fA9xevZWBZDAk04w8q
         cf1wYJUi4RJasDTH30jGMXsXtqbO2HR3lEu0F7ynqQXGaU9SN5A6xuCj/QwidZMLMvdD
         HhMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795456254; x=1796061054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ezlDWRMj9kmxxJBJDvLQDaV+rNJm+P/qJAKPI2Vbze4=;
        b=Rw6Pf2ZEwkI1UXO7urWIQFYldmXs8W5N8krS6E97FFE6mZKhIHwUDIn10TfS01gjv0
         2ad/qxb2eC2QJ2UwmKmpX8g2xrOhdsb+6+H6gCquaMukF9SRNBjDmZHbmjQIwwKtRQiz
         4OnUASOkQ+gEQPbp4T/4aQR4JKBPgDMoGv8nxz+UYm2NOW8p0PGH2bBJwz/WImNU3r1U
         7r8Czk+/KdZ24CppBqkaigsCmxPO9BAkydO5jrN1Xf3tfO/6af1kY2RhTIaGc/+at7nS
         QY++jE75t3ZW+U8KeoNEjOh2ljFPeod1xGq4fsrYeZNmNMxs/loEagZUSbz58olNW7Oy
         5/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456254; x=1796061054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ezlDWRMj9kmxxJBJDvLQDaV+rNJm+P/qJAKPI2Vbze4=;
        b=XbDi5wfVW6pFkgQ6acM7kyEIIxBS5EP2nCP7leERH2o+CfsnVtK8jTiRB+F5/WT1zH
         IIQZYi/GFZUojc9BxoseBkNI1MR7uu7wLqB3WFPug0EG1MzvFaJ2M9PUla5oqTan+HKL
         VxxcKzWJo5xvjyVvkXSO9WbJJGPtewuGxgMCrCG5zLe7LNIud5QYO5XSIzr6t8RVr7Vp
         bMAjrqDGvnSHTrgqdXrL/1zZ4mtfyO+a+2nfkelGxkflByYtC5r/xoIpqX3QjMrjQ7fu
         k04M4g36WCIRfD96AdzOZd1fxDqb4rYhZFq8UhTahiVb9jE+B+7cEQxuTlFzVc4qE3Zj
         AY3w==
X-Forwarded-Encrypted: i=1; AL+hErHgfgIiWPmoQ0NPrIH7DetYb/MLdYUxqgv7BQJYDnJQ0V5wWVOe2CLVTZUXvW6D/3tf8iDlWpJtVwS+pA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZNvHZ5jlOw1XYEv60NHQ4b5yz7s/TyvgTky/GeF7l31HYRx/5
	8Wy1GazdQOy5XQnB4xpM9WlMmS0phRYfLHziJ/Hn41hY6F6zpQbhyfwGlZRf3go9DDceqeh4P7s
	vc++rCqUQ5F3nqrSo2Wd69NzFMwOzaYORoVnMtgAO
X-Gm-Gg: AZFdTZcT2fSBC9hG98TmJ7EM2yWWFFtxGzQvWM5EtsGUESg4z43TonNyKBpUggYUUfj
	Oouh4YkqqNZGGFrFuvMVpFpCiEFNkZeJI6aTK2WD8TZziUGLnjt/mC4Fr+cpsehdwhd72wCFV3+
	7jfhpJl5gE5ANTVViXVYJQ43SVhPtro/9218V9ws1r1M6ooghQ1z52/p2l3nDvr3uk8+9QhJgn+
	BobbbYJraqCipj71D4EOmsDJ6mQ+d6RmzYj7BR+RgplH2Xc1j2MzWzWY8wRSwYlkX3u5RT/XIUP
	ZMOCMHzJVuQJeSdQqRH+LFyDKZgNd8AaCkWw7NdKgrz/8lChc7Cml4m5I6KzxnjDPFr5/q1o1L3
	bMswPP7z4ub2zD7FzmR2qw4JWW1fvOjC3GTZb4lViXfz5rTTUZ4/MgWmI4Bb62nwK86U=
X-Received: by 2002:a05:600c:287:b0:4a1:e368:cbf7 with SMTP id
 5b1f17b1804b1-4bb909d0619mr1867585e9.0.1795456253076; Mon, 23 Nov 2026
 09:50:53 -0800 (PST)
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
In-Reply-To: <1f10002ea9ee16a17087bd06e4a1685a973fdf6e.camel@linux.ibm.com>
From: Naman Gulati <namangulati@google.com>
Date: Mon, 23 Nov 2026 09:50:40 -0800
X-Gm-Features: Aa3M54qK7IY8ZMBupflhQ8_7jK3YPX7yjpTGqvTp5f5henwr9osR6FHQsicVdiQ
Message-ID: <CAMP57yVZx=s-JXHfQfd_ouv2jV6MMsJXpxVLkQQHG=7qfFVJfA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/25] PISA: Pre-mapped IOVA Superpage Allocator
 for DMA and CoCo
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Luigi Rizzo <lrizzo@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
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

On Mon, Nov 23, 2026 at 2:10=E2=80=AFAM Niklas Schnelle <schnelle@linux.ibm=
.com> wrote:
>
> On Fri, 2026-11-20 at 15:19 +0100, Luigi Rizzo wrote:
> > On Fri, Nov 20, 2026 at 2:50=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > On Fri, Nov 20, 2026 at 01:06:30AM +0000, Luigi Rizzo wrote:
> > > > This is v3 of the RFC previously posted as DMA_PMD [0], now renamed=
 PISA
> > > > ("Pre-mapped IOVA Superpage Allocator"). The text below follows
> > > > Documentation/core-api/pisa.rst (patch 25/25), which has the detail=
s.
> > >
> > > I thought the conclusion was to just do this stuff in netdev pagepool=
,
> > > now you come with an enormous AI series spread across the entire
> > > kernel?
> >
> > There were surely comments claiming nothing outside net/ cares or needs=
 this.
> >
> > I respectfully disagree, witness is the fact that e.g. there was alread=
y an
> > io_uring proposal which is smaller, but does not address applications
> > that want to use the standard disk I/O paths (libaio, buffer cache etc)
> >
> > Nothing has changed from the initial series in terms of size, use cases=
 or
> > subsystems involved. Large files are placed where they should,
> > the series covers the same three use cases (disk, network, CoCo), and
> > touches three parts which it has to touch: mm (most of it; it is a
> > memory allocator
> > extension after all), dma (it hooks into map and unmap, not a large cha=
nge)
> > and net (the pagepool change is a couple of lines; the tx path needs to
> > touch more places because the current stack assumes all paths have
> > the same I/O requirements).
> >
> > For CoCo, there are very fine grained controls so the bounce buffers
> > can be enabled only when they don't pose a risk, which in turn
> > depends on the threat model.
> >
> > Specifically, for network tx buffers or disk writes, the user-to-kernel=
 copy
> > is basically a bounce buffer provided it is used correctly and not leak=
ed
> > elsewhere (which is the design; of course the implementation
> > needs to be verified and possibly fixed so that it matches the design).
> >
> > cheers
> > luigi
>
> Hi Luigi, Hi Jason,
>
> I've been lurking but following this series since the start. I am torn.
> On s390 where the IOMMU is always enabled on our closest equivalent to
> bare metal (non paging LPAR hypervisor), and where we also default to
> an emulated IOMMU in KVM guests, the underlying problem is a real pain.
> We're also in the process of enabling large IOMMU mappings via the
> generic_pt API which are 1M and 2G on s390. So, the idea of making
> better use of larger mappings is very attractive to us and I applaud
> you for trying to tackle this very real issue.
>
> That said I do have to agree with the critique. This series is too
> invasive, too unclear in its layering, and most importantly it feels
> like you're trying to do everything in a big swoop ignoring advice from
> the maintainers just because it would limit the scope of a first step.
>
> I also don't think Jason's point is that nothing outside net/ cares, I
> think, it's rather that the IOMMU and DMA layers already offer the
> tools and each subsystem needs to use the right combination for its
> specific requirements. And if a tool is missing this needs to be stated
> very precisely including how the addition keeps layering intact.
>
> I don't claim to have a simple solution to offer, if I did I would have
> sent patches already, but let me state my thoughts. First I think this
> really needs an iterative approach with much smaller self contained
> steps and focus on specific issues. With that, I think this should
> focus on the network stack, while the io_uring specific proposal can go
> after the block layer. Also in my experience networking is where this
> hurts most.
>
> Now, I wonder if we can't start with something simple. What if the page
> pool could start by allocating in batches of PMD sized and aligned
> folios of contiguous pages that can share a single large IOMMU
> translation. The page pool can then still hand out pages from that
> batch without having to do sub-page allocation but would already use
> much fewer IOTLB entries and the locality might even help non IOMMU
> workloads. So, I'd even hope this could be enabled by default and this
> is actually something I don't like about this series, I really don't
> like having a tunable when we know that larger IOMMU mappings are
> strictly better when you have an IOMMU that supports them.
>
> I think that approach would also align with Jason's idea to keep things
> within the network stack and to work with the tools we have until their
> limits become very clear.

Hi Niklas,

I have been working on this idea exactly - extending the network
page-pool with a memory provider that allocates large pages, splitting
them into N smaller pages that all share a single IOMMU entry. I
breifly shared my approach in the v1 PMD series [1]. I'm readying a
short RFC to share shortly, would appreciate your feedback.


[1] https://lore.kernel.org/netdev/CAMP57yWvHO0pWCR3-9q1gtwVe8WV4Y6i69trmw+=
BJRVYf3JB1g@mail.gmail.com/

>
> Thanks,
> Niklas
> > >
