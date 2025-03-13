Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F77A3BBE5
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 03:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741835369; cv=none; b=leBLoS9J67gnunHl/Aik6CYdfnpC2VkVtir5+DTf5LTROy0Qv9RYmWtR7cWSsroDpg5hbKj9gZvRePtSg2564kGAusICpqwSQ/BGcbtQ0d+hTkM+A+iGST4zLoWrmdmMNjC+ZXEf1A/rYjBh3LJ+GURpAJHKPw7y0ns3axDhk/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741835369; c=relaxed/simple;
	bh=+WFlGMAcg1dSYyKmxTCSAfJCHc1g1MepJvAxDiPw50g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0LmeeDE02gtKIpLpQmfj8EcJ9pvZO0tZJlSZCOp2oQA7ZuZwmLkupTn9TWPCUV6IN6PnzCxDiIYohRscoGXVZBZoXQLkECS4IR4imXJf4yWOm4E3w/ZfVOupwoSNrKY7ELpk0xbcCRs6WcnH+4WBNQcllG+W3dpS61yQJIFWKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Iz13WBx2; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Iz13WBx2"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff4a4f901fso885206a91.2
        for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 20:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741835367; x=1742440167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2w2NNoyeUMTe+WJP3vOV4lxBW7OxevPqpMtYOQZ7KSQ=;
        b=Iz13WBx20soGyVCdjJoO4Hw/0zhDlnCSEx1nQ8vWgQInJ1ZdmnaUB0yKxYWbzTxqvS
         k73sHBNXqv87XktOLNuH53xsaUvvrdFhmuT4u6lkXgtvtfeoVbEfpmgH8z9BEaTgxBNg
         y46EuVtGH4SgrLQh7x3STtlYPY+URROwP0yRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741835367; x=1742440167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2w2NNoyeUMTe+WJP3vOV4lxBW7OxevPqpMtYOQZ7KSQ=;
        b=EyekYx/n8M8HjYt5WtNU4OFJz6aPnCW5CyUHDMTjYdEOrST/vgXeho9W99009CWOXU
         zAHCV/CzxtUuR/vPnsFhpyyN+KxsfcAT0a0KyvmnKASY8jpdx/8uW0d+d46JD6QOGapm
         Lbr89e6iOn+IlsYLEJ6ZLeeWvUjDwrQ48JP5QNUZFk4AkscMj9bZ7N4Cqv4KcE8cm9u9
         ejLKZ5u4QweiNe07aIGScR2lV/2UVyDhsi1KbZnqJTS3Wtma8csPhYzlwJBrs5cgW2LM
         Xv9mq2L295INyTsLfBOq3HvEEcOZACmx04xvcl0CiRYiJLxvEYTCpgFb2yVNK9Wd+GFW
         yZPA==
X-Forwarded-Encrypted: i=1; AJvYcCUhkMWJCi2QSmDbE4gym0gEtFavJO8HJ3z2MiwlbtrZ9gajRGiPFc0z6EUo3NFHi6CoOmyIkv5jDXQIGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4Ss4HUevvivbXhBMFnnkbv5X4pY24D+JabP7jLdGB5ejRqJv
	rz0fEYCwrugN2eoG/aFnlSKBSB/6L4+4rNe051omAYUSWvFUwkrIBsKwdIceqg==
X-Gm-Gg: ASbGnctWKnZ43sNpdBD86PbUWFmVgPlib8pRoCRh9EbXg6mTYYOsSmpJGwWOqkTS1dJ
	V9KN5o8TqvPsrZChdYgC3ldgUPdRUeLCZG6JxN5ZSBG5Di5IdvQ6teB4MeLSGgUIofuTKW0ekjt
	Td6MjJnsOHwabVHXNvVrOCPAy29MSshHk9Jbis/+lmQjvSGX7hRxRv736xS46ysFMbLd/EZnIeH
	IwVFYnP/EKefj8qyFJ3ZUb7aXKuIGs44kE7Fp2N/RTuA7RsebolhfU5cU30LIUp5Jx87Wn8Nbl2
	+qTUrZImhC3JhSvyjH8U9APRnn6H0AkHuE3M3ZMeCmwzmdc=
X-Google-Smtp-Source: AGHT+IGFWO2nTLQPYrZdNHWAUjr4TV9jgOKxZGHY6bU9yRm/owksjVUBeXx/Vr3GQFVpil54DqonnA==
X-Received: by 2002:a17:90b:2f4c:b0:2f9:bcd8:da33 with SMTP id 98e67ed59e1d1-300ff10d6d1mr11929540a91.21.1741835366628;
        Wed, 12 Mar 2025 20:09:26 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:ef7a:848f:3b9:98dc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301302a8995sm848639a91.1.2025.03.12.20.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 20:09:26 -0700 (PDT)
Date: Thu, 13 Mar 2025 12:09:18 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Qun-Wei Lin <qun-wei.lin@mediatek.com>, Jens Axboe <axboe@kernel.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Barry Song <baohua@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Casper Li <casper.li@mediatek.com>, Chinwen Chang <chinwen.chang@mediatek.com>, 
	Andrew Yang <andrew.yang@mediatek.com>, James Hsu <james.hsu@mediatek.com>
Subject: Re: [PATCH 0/2] Improve Zram by separating compression context from
 kswapd
Message-ID: <5gqqbq67th4xiufiw6j3ewih6htdepa4u5lfirdeffrui7hcdn@ly3re3vgez2g>
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
 <Z9HOavSkFf01K9xh@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9HOavSkFf01K9xh@google.com>

On (25/03/12 11:11), Minchan Kim wrote:
> On Fri, Mar 07, 2025 at 08:01:02PM +0800, Qun-Wei Lin wrote:
> > This patch series introduces a new mechanism called kcompressd to
> > improve the efficiency of memory reclaiming in the operating system. The
> > main goal is to separate the tasks of page scanning and page compression
> > into distinct processes or threads, thereby reducing the load on the
> > kswapd thread and enhancing overall system performance under high memory
> > pressure conditions.
> > 
> > Problem:
> >  In the current system, the kswapd thread is responsible for both
> >  scanning the LRU pages and compressing pages into the ZRAM. This
> >  combined responsibility can lead to significant performance bottlenecks,
> >  especially under high memory pressure. The kswapd thread becomes a
> >  single point of contention, causing delays in memory reclaiming and
> >  overall system performance degradation.
> 
> Isn't it general problem if backend for swap is slow(but synchronous)?
> I think zram need to support asynchrnous IO(can do introduce multiple
> threads to compress batched pages) and doesn't declare it's
> synchrnous device for the case.

The current conclusion is that kcompressd will sit above zram,
because zram is not the only compressing swap backend we have.
