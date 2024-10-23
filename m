Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14435146A79
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729722718; cv=none; b=McsXIODixiH8S5wJRZM0AuonupVj4Vlbb0STZ/WUyJkXDg0BjILc6bu9mwRAXcTJufglFRIu/nkRoxQ34aJf96sooyGA3s+S46ujH70gSXSbs+HTRwvLshnWN0/rS8EbMLIEySIgAlp0WmQ0HXNzoDaSKmdrlVehJDZ+G1vQdUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729722718; c=relaxed/simple;
	bh=BYm14FssfwBTV3tG4TuuEAoAttZTMnfuF/8jbncTJEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LomRCtveOlLIkvaelOGTDWXe8/vBsR2LyKZJ6xI3vD61dIxUncphDUd4KE/rFFlCVgWCcjFhyM4LfVjTaEC4OpnydGDRlrb/oDRi31hCYvtBKnIqrI1gO18dX49mJtTKu3ee+O5phtQ8KLtBFHSF6FyfRUEgVWb45DGL+QuhyWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=V/z8vGT+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="V/z8vGT+"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c805a0753so2241005ad.0
        for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 15:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729722715; x=1730327515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mc82aySX/lFrTDFr5UI9DMjILh03sjP+rw8kIWX9UZ0=;
        b=V/z8vGT+77XNZB9daWvHAY7FD9auhdtiQ9ys+/Ra/t0BdKElrxOArJQw4pRXb+LjUp
         Zf7e+E8ojfrcfUhlNCXQ3+VlxTvLsbUICoOoR6jhCN+NUpfcJRa/3TQ178YLlxKETZJE
         Gj2h5jcoOBwNYzWLUBGbmmL1OrHySdfdJb1U9CLL5aiTVu5Bu+nbomuCDUGk3XORXjos
         DHgiSR2Md3XzOr/TtmSd/fC6uziJvzEY2sdHsfDzKZgvaRhvV5WTXWCL/YsUKzLrYVq2
         poidRPO1DIwmigZhFvtBlQ5/lhlfhPEDb3LmRutWSlFaLWytOACYwMGPgfArVXgz+EEu
         r/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729722715; x=1730327515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc82aySX/lFrTDFr5UI9DMjILh03sjP+rw8kIWX9UZ0=;
        b=qTyy6yzLCvw2sRLlTbDoObICbmkRi12ibeRtz0ZIXwCc9cCBUFuzKJHNnE16n9HqX8
         miANjHDd6KCUxEoKctW9xhc5g0fu35cQwZCsK/jACN80aNxw5AOlPAmVdHYHSpfd/uhL
         By8+BCMU891N9f/sTG7J48ZyQ4X1ClB7UatujwqBit1ds6pSErAGg5bOcPORa4WsBprr
         AaNa2+9es62JRnf2I30PQDsklxr1OM3iOHDVLiZK0uXP8M++LddafX7zQKOZEnLkoNVD
         vJ5GbL/esQnl9Fdgfa1XfuwtrQmpTXr0hRmqUd5l75TB5cRomdTX/+bYxBQ04yj8YXeJ
         ZEgA==
X-Gm-Message-State: AOJu0YxWM/xaDaNcsZeI6OSLlFVozLgY9NLwBZa6vAUzs5ZptMxk715e
	5RUUK74Tsk4uggGFM0r+cyYR7E/C6npRqaYIFrDfwZAz2t31phEbT5zWb7Agw2s=
X-Google-Smtp-Source: AGHT+IFOj6njzrNVop8H2V8fIE8ErmkeEV/hSpkHOohflvyBrh+BXW93oaQwAu8lmCSNwOUNwZQgqQ==
X-Received: by 2002:a17:902:e850:b0:20b:8bf5:cd72 with SMTP id d9443c01a7336-20fa9ebf606mr53907125ad.49.1729722715573;
        Wed, 23 Oct 2024 15:31:55 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f58cbsm62173915ad.281.2024.10.23.15.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 15:31:55 -0700 (PDT)
Message-ID: <f7c9ca22-02b8-4d1e-a9e3-7770a01fbb59@kernel.dk>
Date: Wed, 23 Oct 2024 16:31:53 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix sanity checks in blk_rq_map_user_bvec
To: Uday Shankar <ushankar@purestorage.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Xinyu Zhang <xizhang@purestorage.com>
References: <20241023211519.4177873-1-ushankar@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241023211519.4177873-1-ushankar@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/24 3:15 PM, Uday Shankar wrote:
> From: Xinyu Zhang <xizhang@purestorage.com>
> 
> blk_rq_map_user_bvec contains a check bytes + bv->bv_len > nr_iter which
> causes unnecessary failures in NVMe passthrough I/O, reproducible as
> follows:
> 
> - register a 2 page, page-aligned buffer against a ring
> - use that buffer to do a 1 page io_uring NVMe passthrough read
> 
> The second (i = 1) iteration of the loop in blk_rq_map_user_bvec will
> then have nr_iter == 1 page, bytes == 1 page, bv->bv_len == 1 page, so
> the check bytes + bv->bv_len > nr_iter will succeed, causing the I/O to
> fail. This failure is unnecessary, as when the check succeeds, it means
> we've checked the entire buffer that will be used by the request - i.e.
> blk_rq_map_user_bvec should complete successfully. Therefore, terminate
> the loop early and return successfully when the check bytes + bv->bv_len
>> nr_iter succeeds.
> 
> While we're at it, also remove the check that all segments in the bvec
> are single-page. While this seems to be true for all users of the
> function, it doesn't appear to be required anywhere downstream.

Yep that looks like an issue. Since this would be nice to backport,
please add a Fixes tag as well.

-- 
Jens Axboe

