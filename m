Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CE02EF646
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766001566; cv=none; b=oYEr5XCb/y1tgmMGt4g5A10pxoY+mZ5e3lMuEOGeKKvXvgfVGSeQNAtywJ13ugQdSbz3TBcSN7rnsm9Lxv3mw1gDfHTFjyWcljyDxEN1Y8877F4L6T5raiyY8qcgl+zBf2XoeeWcE5kX3pJdvQi+redU6iTYlmmKEWeRMHQioMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766001566; c=relaxed/simple;
	bh=V+ryZgpse65jdzL7I3bov4UY3kdKSBHonGILf/gWTI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+/7lDx+Pt3EmXSsuJv1LmJpw6G9KrYlZaZUKb0QRDLxxhmbVm7ak102dUwBtee/Ck9o4jfPRcl5q+NFmTUgl8wqtVjyBgLdEdqD3WoZ+oZ1u77bgNptSvF/KQ+3IXeWi2BqYW0c1xxYu8UpjBvA8FGLZ4xQbE1fl45j3mHHjLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=ul4cBGQs; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="ul4cBGQs"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-88a367a1dbbso52123356d6.0
        for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 11:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766001562; x=1766606362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=umJwQRcOcv6tN8KQ+xKY+ct7qymfOOSndzlF6qrQs+M=;
        b=ul4cBGQstaGS7tdthuKYGL3gMPgmPggsCaJsgF8WFAYeqAgtwvJ8ek17C3wJMeP08U
         FDeZ3wd12ijYej7nQMq6w8RUPt3n9ZPp1RQiIP+FYOmgwFvBnVKAGI2icuKq4ou136T8
         /kHRJO+U/Ao3MqJojitE0Oe+7l7ISe+f/V8HVtWgd7FoQyLJhmyYAfaIx8efXX/RNFLS
         XTRlc20MiR6nbXgflMbRSLNDXLC3y7bH4GErvdg5E5Gi/XJI4qDmBvjWfaSH82dpmfXE
         XpwmNjWIBiYwpwhCS3YVcBEwCc79zOodOrQgzllZTkr+CXmDyNF3t37pKw6XF01BRKaI
         iKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766001562; x=1766606362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umJwQRcOcv6tN8KQ+xKY+ct7qymfOOSndzlF6qrQs+M=;
        b=qSbLKk0sIn0Dm2v2vaZG+hFPQJaJyAYsB28YYxdapBUnuaXpmyFe+Gb6C9QCzP+O7H
         I4L8EfFuvUevLOUNKa9rNt0MXa/j8zuY4deI7/A537ZWkoLuKhvqnzUljGXe3hSXzqBP
         MlWegL6vm3OVAHP7cGrFBnthUZR+jezRU+X6qMvHx6gSwDFBV8Wuyw0Dv4m0MWwDifOO
         DFNeXMix0S+uJo9J3fZzul4M+cCs1iDDV3Tp96tey9uh7dhRfQ7UqvQq2w6ITX8nx1NV
         mQZhv4krtM4bg9vi80S/pAXezfXKxvyiYZpVDBwAD3K2akGtSWzAtlWtiygNSYXFb0HI
         YFmw==
X-Forwarded-Encrypted: i=1; AJvYcCUalQv9X8IgJxfCyz2lrXYf4y/4LIis6P8Yi+A2J+XXU3rfX7IFP97Li4Fld4W0+kHaw2pB6jDmcrgs6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy93DCiojVQZRFEGEKBjdTh3HB/Gy+ToVbDD7NtinPTsE25KMUY
	xa7ILqLg72J4JYWzKyZJx6A1olG6fvZlGYSDOOlRydER+s4OwFe+uLmbqlsjxnhvJGTMPXIWcZ3
	agaXwpF0=
X-Gm-Gg: AY/fxX7FNeJh+aOuBxpoGPbKqB+QioEbn1k4dJbS1EAwIWR8oP7XP0kGXKz+gWMgK+p
	yykq0RQnAMmZVhphkjToFjOwpWwuhoJ4yJdsDFyecJ3MSfkgpLisAoI8qIqYdUPf7bAm98u+ZPc
	gTX1mmj9FUZP0+N6UgcXOmywMH9oWMO1BJ/RhI2YBFaiGue8YmQWC4fZv/ZsvacK+TcmlDWE4dk
	ccYfElgd1SKy6EHqszfPtAQuehI+1yirPWSTPgKdNIw74OVl6lh/pyPVuAiggWFD96jkcuxvbVS
	tI/RWqdyPeef99Y2RdkDoLwQc8em8JnjxNKVP+01cakgyaWlFD9EOenGT1SQW5sVCzocIXUPCIR
	127ibMDEABZvzTtbkmzlRgvP1y+VdjH3skpT6sHjct7p1qs6A/FjTYfFbzr+gM8WzwCb5ix5NWF
	RWme3iOgdwhfZPLfOgpxFp
X-Google-Smtp-Source: AGHT+IGkgd14mqGKPn7evzONaa5NlqMwbBZNXipPmIuU2TNCHRjQ90/wuY54LLEAOA2jYshzbetrvA==
X-Received: by 2002:a05:6214:5b8a:b0:87c:1ec5:8428 with SMTP id 6a1803df08f44-8887e127b6fmr309717816d6.46.1766001562229;
        Wed, 17 Dec 2025 11:59:22 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c61674467sm2152596d6.55.2025.12.17.11.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 11:59:21 -0800 (PST)
Date: Wed, 17 Dec 2025 14:59:20 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: retiring laptop_mode? was Re: [PATCH] mm: vmscan: always allow
 writeback during memcg reclaim
Message-ID: <aUMLmJ0En24pQBX_@cmpxchg.org>
References: <20251213083639.364539-1-kartikey406@gmail.com>
 <20251215041200.GB905277@cmpxchg.org>
 <aT-xv1BNYabnZB_n@infradead.org>
 <20251215200838.GC905277@cmpxchg.org>
 <aUENEydFvVvxZK8r@infradead.org>
 <20251216185201.GH905277@cmpxchg.org>
 <gweo3wdh3agfavhiky5cloweu4m2hvgzk2j2euckbka5x7n47e@ezjmx7eq7ks5>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gweo3wdh3agfavhiky5cloweu4m2hvgzk2j2euckbka5x7n47e@ezjmx7eq7ks5>

On Tue, Dec 16, 2025 at 03:23:53PM -0800, Shakeel Butt wrote:
> On Tue, Dec 16, 2025 at 01:52:01PM -0500, Johannes Weiner wrote:

> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks!

> > --- a/include/uapi/linux/sysctl.h
> > +++ b/include/uapi/linux/sysctl.h
> > @@ -183,7 +183,7 @@ enum
> >  	VM_LOWMEM_RESERVE_RATIO=20,/* reservation ratio for lower memory zones */
> >  	VM_MIN_FREE_KBYTES=21,	/* Minimum free kilobytes to maintain */
> >  	VM_MAX_MAP_COUNT=22,	/* int: Maximum number of mmaps/address-space */
> > -	VM_LAPTOP_MODE=23,	/* vm laptop mode */
> > +
> 
> There are 8 earlier enums here with names like VM_UNUSED* along with
> the information on what were they. Should we have something similar for
> this one? Something like:
> 
> 	VM_UNUSED10=23, /* was vm laptop mode */

The other enums in that file leave holes, the VM ones have a mix of
VM_UNUSED and holes. I don't think it matters either way since the
sysctl syscall has been removed and nothing new should be compiled
against the definitions in this file, right?
