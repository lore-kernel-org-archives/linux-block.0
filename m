Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A83F482E
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004965; cv=none; b=tGRPUKYWG90NTS+A05zr3MzwraXtMwO/yYmesDHEESzZXCOZMhayf8bfnbIf5qYvu/AFFJhC9C6lDxggsCP0zmMzTbnHZZlGCpn6oIfWvSZvqQlNaMN75WwNfkKCJLImExFt09fNbfjKDUSxxs8trnzAAFEgA6Gx7TBcNrmWZaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004965; c=relaxed/simple;
	bh=uPTGsqwqW72fV9uO1Q1bBszUUqt+DIw0cPITC9fmsxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5czLBASqPFcxI23MoXZHlOgMxr2r/DvXccEO38Uu8xXRdLRLrTnEgxIn/pILJquMVlCMAoHEHbL6z/se11yviW/mHdD1Up3E0LfH1LIqXMVJpqZNIn/adJZ02/vTTsuxV29T26oCaV2sRCx5WlylOQpnnxWaQdAPWL0OJ1zXuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=0b1t.tech; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=0b1t.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93108a3c326so43106385a.1
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 01:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786004963; x=1786609763;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8L67UEittnM3U78kuIxDIhdFKAHMIN1W6YC5oHWi9ks=;
        b=mxi4xHdeE8ORjfyBnesJiDo7UFusp9/FEyDQncM1c6HPSX1I/DWWZkpoWy+HyNAKMW
         opfiroH4+1IgszhYG6Q9HY8iUh66V4L/1cI4JW1ylqIpUJvzLCYSNvChBb3xy08+BWlG
         6WKgik9e89TWv7MTS14h+dYi3cv7Dj/I3BCpc9RZu9yb8t44Go9QqVYwhAUFPC4ASCo+
         iHuZXq8S4hDQUw1MFBSxmQsU4KCUJDi0G5niU/WHR4ixAsWWJz11wJ2gC3vWm+k5nry3
         TofwxDl2hBZVpJ7Jsz8sPvO0vl4EQMVDLA3fwWlNJ8NwmjoPUQiw60YoKjpTXqKEgtyx
         DUVg==
X-Forwarded-Encrypted: i=1; AHgh+RqFV5fsDfwz2NlDM9Y0Q6IOJvkqgmJzR2eUzbTK95I3cog+rSEr332Am+u2EN1GTbTM6Ul6OPW32t3MQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQkKoJo1bPV8lkkuUYtVu6fNljOa/ptr+33hXwHJU1YpIun4Vb
	18vwaSOo9WQT7ebTt8xxxg9ozrmboLLYRVupfUp9bSaooX3qfd2fC+Kacq0tpWJXrVabcf8B
X-Gm-Gg: AR+sD10ly77xsJFc5ovYdSXbiyKclwCdvhjwV0kBWdhW81lc1PFiffHqyEpfwh9BARt
	AzcdLkmVdt1VR1hS+vsknmnWwyhL+CsxUn6aHtDYn8BJ4h47kJb0I7cM6koCtrte9a/JgYZhn9+
	3NklpyTeM/CwnI0vOwgOQyOTFqIEnufguVrXDtllHa5AlV+lxMKG/hMJadPnP6cvEOxMm3GCYQH
	jqg6kjZItRJ+9Pwd0Pvxm/ULgJKbTVakTWMk97mtwCQ8WIFF5aVFZBeuITdux5abZ3YHVG/ZDEX
	zTYJXn+orT1789gc8/2AKqYiUyzEGE7leEuW/ZJw5lZYSkQkeRvVfiNB+mJSrMeDaDVlk61rCCN
	dxEfZS2fzMkIawzo3vYGWrjtuzmREgeY2OZXqUPigGGL3BFU/ibIzYrxB75RRpuru6S0LaoIdb2
	0D3q/9WDCRb0N3QxcN+J8XgUFtL0kKLG+PtAael8WmfN1JMcHBHI3qBgckvUvNnpyhAMJtH4lys
	Ud4rxuupK3hmMtcfWdIG56+OUdjcis=
X-Received: by 2002:a05:620a:6981:b0:915:5216:e5bf with SMTP id af79cd13be357-9365dfe3307mr231576985a.22.1786004962843;
        Thu, 06 Aug 2026 01:29:22 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364a52a1fdsm350660385a.29.2026.08.06.01.29.22
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 01:29:22 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51bfa429aa6so4343901cf.0
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2026 01:29:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqnWM1eLpu4bFLYcHr/5O6HhdH4XcBI7ThQXtC98CnlHvl59jtb763iN2fqHbV65lSUvS1cbZv8CSuPPw==@vger.kernel.org
X-Received: by 2002:a05:622a:4d86:b0:51c:b91a:33f9 with SMTP id
 d75a77b69052e-52cfb00255dmr55127701cf.13.1786004962328; Thu, 06 Aug 2026
 01:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720201057.1862857-1-kbusch@meta.com> <20260720201057.1862857-6-kbusch@meta.com>
 <anMscoGkR5BYjSGy@shinmob> <anQ-28nxOqBmQjxu@shinmob>
In-Reply-To: <anQ-28nxOqBmQjxu@shinmob>
From: 0wnerD1ed <l7z@0b1t.tech>
Date: Thu, 6 Aug 2026 16:29:10 +0800
X-Gmail-Original-Message-ID: <CAKTh27_RnTA_Q8qAbQ60gBo9Op_OQm7J8KyamQ_tbuTRb4XF2w@mail.gmail.com>
X-Gm-Features: AUfX_mw5QWwwkKt-kO8BytpUZdN-dhibuCeCRe8GGvMpBbYSL4fmaxKXk8xK3Mc
Message-ID: <CAKTh27_RnTA_Q8qAbQ60gBo9Op_OQm7J8KyamQ_tbuTRb4XF2w@mail.gmail.com>
Subject: Re: [PATCH RESEND 5/5] block: validate user space vectors during extraction
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, dm-devel@lists.linux.dev, hch@lst.de, 
	axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org, 
	viro@zeniv.linux.org.uk, Keith Busch <kbusch@kernel.org>, stable@vger.kernel.org, 
	Hannes Reinecke <hare@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Aug 06, 2026 / 16:04, Shin'ichiro Kawasaki wrote:
> I took a closer look. I modified the test case to respect the dma alignment [*],
> and now the test case passes. This approach looks working. Will post the change
> as a formal patch for review.

Sorry for the slow reply, I have been busy lately.

Thanks for chasing this down. The test is mine and its assumption is
wrong, not the kernel, src/bio-full-trim puts the destination at
p + page_size - 1, and null_blk advertises dma_alignment = 1 since
commit 3451cf34f51b ("null_blk: allow byte aligned memory offsets"),
so iov_iter_extract_bvecs() now rejects that odd address before
anything is extracted and bio_iov_iter_align_down() is never reached.
That restores the behaviour we had until 5ff3f74e145a ("block:
simplify direct io validity check"), so the test is what has to
respect dma_alignment. Your approach is the right one.

One problem in the trial patch, the guard has to be against the
logical block size, not the page size. What the test needs is a
fragment that bio_iov_iter_align_down() removes completely, i.e. one
smaller than the block size, and the read has to reach the PROT_NONE
page. With dma_alignment = 511 and a 512 byte block size (the block
layer default for drivers that do not set dma_alignment),
dma_aligned_offset becomes 512, which is below page_size and passes
the check, but the read then lies entirely within the first page,
succeeds, and the helper reports

      pread returned 512 (errno 0)

instead of taking the "unexpected dma_alignment" exit. block/045 only
uses null_blk so this cannot bite today, but the check does not do
what it intends. block_size comes from BLKSSZGET, so it also has to
move below that ioctl:

      if (dma_aligned_offset >= block_size)
              errx(EXIT_FAILURE,
                   "unexpected dma_alignment %u for block size %u",
                   dma_alignment, block_size);

While there, err() should be errx(), errno is not meaningful at that
point.

I am short on time at the moment, so please go ahead with the formal
posting. I will send a Tested-by once I get a chance to run it.

Regards,

0wnerD1ed
l7z@0b1t.tech
