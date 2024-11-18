Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFB617C98
	for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731923806; cv=none; b=NoPq6YIbIVS7muxJvFC50mFpZano+/2M/FWdB+149fetJ9pfep+v4vVQXtOZwwnWLdrkFt3xdCMxAhwd6QZDEdmVnTkOdq2RW1n3/Wb+e65kwSABZbXB291h4rsE+DNWQTc79yAZHCqoJuPc7/CA+X0z/7uCM3gmQLWeUoL/Fx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731923806; c=relaxed/simple;
	bh=mkPHkvb3dTwE1RBJ5dE0eW5SpHQx+TdaDPciwsfburQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgghISUCy8az3Ddkzqf3bfAFv5cJdceTUhkjisY4dj83shqM7PJ0neR8sEC4OBFdSKqho2IWrAM25KXt1RK6oxFuRT0CTAjVJYady5lAMzi+FMey0oQLQ6Livn3wvXuSLrRQovo4uDfrZbO5+dFETu7d94R3hXyUOhy0eAQdHcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gA/INESV; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gA/INESV"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso1152000a91.0
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 01:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731923804; x=1732528604; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xDxyMOW8qq4uHaUaCSJGmCcwLH0nXDKtKPK2l00TB9M=;
        b=gA/INESVvZ9TYV5neDQcUUIDnDD4wxol+qlsU4l3EDfiGwn1ztf6nrSb6m96UIleU0
         wWtYWFeGwn7QrjXBu/XMTCvSK4nZmDpoIKXdFF8LS2Aaw5AC5f6nHPRWzOEBcjRU4/Ib
         vu6FiZZ73QoSOzOASKe1YywjOXEJjV54gPhbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731923804; x=1732528604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDxyMOW8qq4uHaUaCSJGmCcwLH0nXDKtKPK2l00TB9M=;
        b=BvC66WuuRLsz9pyhPg11uvrmHCSfLKbHN3qhMtkk+B2WJZ2ZAY1JWAWST2XUU8YjCn
         0SEemYwWVPX0ewIbEBvJp7DMpID61PrMQDbzi2icE8P70FF6ftpd74aCsObO/HXIgsmZ
         zHB1uCmScVMPCNzmfaLQrx5whGlNXQ8diXWMfmZ7JyMWjCn8yyE9x2ExEOmg478g/Ahk
         qYpLRIL8oOkXlsEWLrsF+qmRtRh3zbZwOjyZyCE7cAqU1LA3RQ+Gg5GI1tQqHEfGtVPe
         icRBLqqQccGj+kmgMK19q5upYg7FWBuAKvvSfCoMbPy7a4ZqpIqTU2ZkYna4GC/ccBlO
         pkAg==
X-Forwarded-Encrypted: i=1; AJvYcCWKDkz9NI9gpTBvKq7fd4FY9YTUh2wfpSofhbx8apLV6Z2qJVcTCBDy0qAwCFvekHi4QFpKA6iuBZgwdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxX+zwwmw3W46KvV2uuCYtoEbmJGHI7xhsPk+6XIucLt/6SmHFT
	dhdgxVOBu7+AGXMmmN9FMdFF+Mx/RQjCM57/32PA/0sme95ptQWIltagPT0y0g==
X-Google-Smtp-Source: AGHT+IFwPscuRl5WTyZwAWgtpFuFGwsGo+Y2Tqh53iXaIkKHWf6n0kpAE7XdrS7yorkIewCxZDW9Qw==
X-Received: by 2002:a17:90b:38c7:b0:2ea:712d:9a7f with SMTP id 98e67ed59e1d1-2ea712d9de8mr4244800a91.20.1731923804004;
        Mon, 18 Nov 2024 01:56:44 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:8826:78b8:a8fe:1066])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea448cd342sm1857344a91.1.2024.11.18.01.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 01:56:43 -0800 (PST)
Date: Mon, 18 Nov 2024 18:56:36 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Usama Arif <usamaarif642@gmail.com>,
	"Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, axboe@kernel.dk,
	bala.seshasayee@linux.intel.com, chrisl@kernel.org,
	david@redhat.com, hannes@cmpxchg.org, kanchana.p.sridhar@intel.com,
	kasong@tencent.com, linux-block@vger.kernel.org, minchan@kernel.org,
	nphamcs@gmail.com, senozhatsky@chromium.org, surenb@google.com,
	terrelln@fb.com, v-songbaohua@oppo.com, wajdi.k.feghali@intel.com,
	willy@infradead.org, yosryahmed@google.com, yuzhao@google.com,
	zhengtangquan@oppo.com, zhouchengming@bytedance.com,
	ryan.roberts@arm.com
Subject: Re: [PATCH RFC v2 0/2] mTHP-friendly compression in zsmalloc and
 zram based on multi-pages
Message-ID: <20241118095636.GA2668855@google.com>
References: <20241107101005.69121-1-21cnbao@gmail.com>
 <87iksy5mkh.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4wOGPbGQgqDidnYUCCpAT8sw+S92NEU+trAQL_rnC10ZA@mail.gmail.com>
 <28446805-f533-44fe-988a-71dcbdb379ab@gmail.com>
 <CAGsJ_4yuZLOE0_yMOZj=KkRTyTotHw4g5g-t91W=MvS5zA4rYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4yuZLOE0_yMOZj=KkRTyTotHw4g5g-t91W=MvS5zA4rYw@mail.gmail.com>

On (24/11/12 09:31), Barry Song wrote:
[..]
> > Do you have any data how this would perform with the upstream kernel, i.e. without
> > a large folio pool and the workaround and if large granularity compression is worth having
> > without those patches?
> 
> I’d say large granularity compression isn’t a problem, but large
> granularity decompression
> could be.
> 
> The worst case would be if we swap out a large block, such as 16KB,
> but end up swapping in
> 4 times due to allocation failures, falling back to smaller folios. In
> this scenario, we would need
> to perform three redundant decompressions. I will work with Tangquan
> to provide this data this
> week.

Well, apart from that... I sort of don't know.

This seems to be exclusively for swap case (or do file-systems use
mTHP too?) and zram/zsmalloc don't really focus on one particular
usage scenario, pretty much all of our features can be used regardless
of what zram is backing up - be it a swap partition or a mounted fs.

Another thing is that I don't see how to integrate these large
objects support with post-processig: recompression and writeback.
Well, recompression is okay-ish, I guess, but writeback is not.
Writeback works in PAGE_SIZE units; we get that worst case scenario
here.  So, yeah, there are many questions.

p.s. Sorry for late reply.  I just started looking at the series and
don't have any solid opinions yet.
