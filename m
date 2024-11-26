Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748897E9
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 05:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732597766; cv=none; b=XpRBkqPKZ0HfXK2BD308tAb8lE12qo6RXIM4c+LJeRtzC4QHSVIF6L4EWpQ832HT4gk4b4r9P39ptzP5lZlaZv3+OZdbqGILx3yQtmFfTA7cc8UBYQkPihdO9qoAOJ50pea7T8tMhCl1wMxIr4tPnG7scIaEQ5Uulmz8a1MmF2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732597766; c=relaxed/simple;
	bh=H1aZsnEgQIvx7po2lcBMkzouZrDR+t2RRiBFTGVpj3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XspLvPhad+0tzE+OzIXdPKAlyrwkVIt1b0yJaFBqug6eBxFto6rrLSBJzFSCJsPGfXZ607g2UD8C3OYYrgQ3iTCeVhcrgH7vPizLf3sr3vq4SPr9GxCe5vmAMOMFHU4D3/D1DUevk/A7nIkohyyaC1fSYeyTt8smkXGbG1PhO6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CC7ynGuP; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CC7ynGuP"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea7e250c54so3969286a12.0
        for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 21:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732597765; x=1733202565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A+OG1QCsOSf4XvgOD+GJSm1qpPZxTwxxd1aIUTNljBQ=;
        b=CC7ynGuPBGht9FyvzXbe+RCHGodiczXTNmn0Yl771rbrdld4g9bqhPKbHHQAmN35tz
         ZQ9r3b3cWJ5s1XS0eBi2dOc3AzOJrw/91eLAnbgy/VCjcq63xlCgIXBCYK71aiODNt5x
         S9v6lL8Lh49Xf6zAdeRQ+Sq6kfGmEfgdSvgc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732597765; x=1733202565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+OG1QCsOSf4XvgOD+GJSm1qpPZxTwxxd1aIUTNljBQ=;
        b=bmoZStoZYuWQVevJ1CbGGZpvcLNJE91AE+005RZsrk4fZsHQqR4Y/hceWCSwgNRaZX
         hpNo+LvhpkQY+jrAsonmyuzjJm706WryTIzbizTT9lCuR7q7M0BkDiwRxAJtZUXdRMXR
         hqOY0Dmb6OiE3QiWv6NxqLg3A3QMRu0Wr8RC1srWs+mAtgE+oQMYfbH0JfygPipG7gcn
         epGRUGWeD/e4yK8C+3Az0zHbrO/2zjjNJM9iQyjMHu+zaAVuFIaEYKrJ6EQLFQBFEsM7
         iyuiZUqmbVpZDWxhkeGl14OPaZIlAjs5hoAE8eCtvIcE8Z0DDdHnq1WwjLbyVWjn4lQA
         xsgw==
X-Forwarded-Encrypted: i=1; AJvYcCVU+ei2wGfvrRTe5n2MnodgfV0duCLsbMJYaZA+9AJB999e89aepMqTOMvw6TlmvTtd0nKdl4p9btSDCg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp7Xwhje1eOpJ9i/zkzHabac5bTN1Htl6fI2GN+viRuMJ6/l+9
	yr58cQmcm/gXC9skCOFylb7zAUOqPRoG+Nlj04N4SFWSTodQGZICpPqlMmF0GQ==
X-Gm-Gg: ASbGncuBSgbwf0WkqjDnWyR7EVamujXD/kqL3Xv9MTnkDd/D3LMxcyGZa4fpGp+CK6E
	I8KUDwt7b+OxPiK5zdcSx8/uvObjD+lJB1F3n3ye90lO8are+qMj1/+jKCMVXe0RmE0OS+aHUFo
	hgTBYj1Qfc7X95I+OYXByAlEcAl55IGpr6lei1VXZVmrtTQZyi33lUjemBZ7xxliDClOC+Q5yCq
	Nlrq3o6xEp8bvL7Iow5/CWUleyuTushb1CelworyM0jWwXxwcm1
X-Google-Smtp-Source: AGHT+IGETkofIRaSA+TbiDN7k3Ev3Htnf+AZCTMoSGNyrFrov3FuRj6a4IWrq/2IHSdGeem5NKIjgg==
X-Received: by 2002:a05:6a20:3d89:b0:1e0:d9e9:a2c7 with SMTP id adf61e73a8af0-1e0d9e9a633mr652313637.15.1732597764637;
        Mon, 25 Nov 2024 21:09:24 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:7631:203f:1b91:cbb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc207bbsm74562855ad.228.2024.11.25.21.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 21:09:24 -0800 (PST)
Date: Tue, 26 Nov 2024 14:09:17 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, axboe@kernel.dk,
	bala.seshasayee@linux.intel.com, chrisl@kernel.org,
	david@redhat.com, hannes@cmpxchg.org, kanchana.p.sridhar@intel.com,
	kasong@tencent.com, linux-block@vger.kernel.org, minchan@kernel.org,
	nphamcs@gmail.com, ryan.roberts@arm.com, senozhatsky@chromium.org,
	surenb@google.com, terrelln@fb.com, usamaarif642@gmail.com,
	v-songbaohua@oppo.com, wajdi.k.feghali@intel.com,
	willy@infradead.org, ying.huang@intel.com, yosryahmed@google.com,
	yuzhao@google.com, zhengtangquan@oppo.com,
	zhouchengming@bytedance.com
Subject: Re: [PATCH RFC v3 0/4] mTHP-friendly compression in zsmalloc and
 zram based on multi-pages
Message-ID: <20241126050917.GC440697@google.com>
References: <20241121222521.83458-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121222521.83458-1-21cnbao@gmail.com>

On (24/11/22 11:25), Barry Song wrote:
> When large folios are compressed at a larger granularity, we observe
> a notable reduction in CPU usage and a significant improvement in
> compression ratios.
>
> This patchset enhances zsmalloc and zram by adding support for dividing
> large folios into multi-page blocks, typically configured with a
> 2-order granularity. Without this patchset, a large folio is always
> divided into `nr_pages` 4KiB blocks.
>
> The granularity can be set using the `ZSMALLOC_MULTI_PAGES_ORDER`
> setting, where the default of 2 allows all anonymous THP to benefit.

I can't say that I'm in love with this part.

Looking at zsmalloc stats, your new size-classes are significantly
further apart from each other than our tradition size classes.
For example, with ZSMALLOC_CHAIN_SIZE of 10, some size-classes are
more than 400 (that's almost 10% of PAGE_SIZE) bytes apart

// stripped
   344  9792
   348 10048
   351 10240
   353 10368
   355 10496
   361 10880
   368 11328
   370 11456
   373 11648
   377 11904
   383 12288
   387 12544
   390 12736
   395 13056
   400 13376
   404 13632
   410 14016
   415 14336

Which means that every objects of size, let's say, 10881 will
go into 11328 size class and have 447 bytes of padding between
each object.

And with ZSMALLOC_CHAIN_SIZE of 8, it seems, we have even larger
padding gaps:

// stripped
   348 10048
   351 10240
   353 10368
   361 10880
   370 11456
   373 11648
   377 11904
   383 12288
   390 12736
   395 13056
   404 13632
   410 14016
   415 14336
   418 14528
   447 16384

E.g. 13632 and 13056 are more than 500 bytes apart.

> swap-out time(ms)       68711              49908
> swap-in time(ms)        30687              20685
> compression ratio       20.49%             16.9%

These are not the only numbers to focus on, really important metrics
are: zsmalloc pages-used and zsmalloc max-pages-used.  Then we can
calculate the pool memory usage ratio (the size of compressed data vs
the number of pages zsmalloc pool allocated to keep them).

More importantly, dealing with internal fragmentation in a size-class,
let's say, of 14528 will be a little painful, as we'll need to move
around 14K objects.

As, for the speed part, well, it's a little unusual to see that you
are focusing on zstd.  zstd is slower than any from the lzX family,
sort of a fact, zstsd sports better compression ratio, but is slower.
Do you use zstd in your smartphones?  If speed is your main metrics,
another option might be to just use a faster algorithm and then utilize
post-processing (re-compression with zstd or writeback) for memory
savings?

Do you happen to have some data (pool memory usage ratio, etc.) for
lzo or lzo-rle, or lz4?
