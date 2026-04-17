Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A1D34216C
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 20:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776458371; cv=none; b=XVKDW1VtZSE/U9Nk/q5PCYqtgd+JY0rLz7avBRIf1cKuQUkBnkX+IqR+OdOprqkx+GAbiPcVgzRBEX5OdOB4KetuE7E8hYIAbV//bv+5rmTtOJbRW9gq9PvYdgIenXHxjROjfQ4mji1/ksC1pm0qce9rwhZbUSWqvoKNUZchVks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776458371; c=relaxed/simple;
	bh=R9cfPSOj4lFrYL3++B34Ovkiwrp1hUKfb0CY6CfUYII=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KN30q7FpopyU6PPVNT+uc2MIjDsi3SEtbO8i/dIBllc0Ggemzl2UnVlcKEe6/dHqVP/RlUN9HM8Z/yIdp3xEZ/xdg5RsElrYhbw7EIWSS6XcAunHzJ7486qLu0zV6IGXgbd/lwqN2QOF58UrfkpFKQ4UQP3f7ZFpXcNfrQmtTUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=F1gt6e6n; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="F1gt6e6n"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dbdcb85067so1033640a34.1
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 13:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776458369; x=1777063169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgN4UqmLQKB8jT5zdq3MW4Yg0/LUcFaPoFS2jnD1LNc=;
        b=F1gt6e6nWM1RGSiKuE8O5/xowAqkOIcBCM04NTrQCIvO6afZMa41iRUX5UYpbxN/sJ
         9nVCam3HmMIqFfDPoVKauIT1W4QsUAIgs2m4aQFwCRm2Ga9PH95tjnWsPaxPKPu83kgU
         KFONJ+jYrZKtFH/ys1or+yBdkphzXPFnA6DmOXyK+IQFtvV+NmY49AIN/mVU8TxoJVmK
         l5RBhJonXxXBLceFv6qREft013l6uTN6srSiO794YCK05E58JYPkaSsT4TnTP7nPwaX6
         3HnCugYzPe4G2Zp4kSPTSt0/jHibgy1zbqpKOTor7KSqPxXZg8MWfPnwPV+NalflN31j
         UUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776458369; x=1777063169;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pgN4UqmLQKB8jT5zdq3MW4Yg0/LUcFaPoFS2jnD1LNc=;
        b=KhzzgEN82oAuFFzvEGcvARUBYyrn8gKv8BPs6+2uyhUNcgQPr789/ZdqkHmbVREj2+
         0cOoSFC40lhldfrV9yBbeg4j8hp1bnEv///Xy25sbKj4M4ucaZAFD7DUxZPwQcRqxf/F
         PwAemZnMb7AjtyLs0aK1oNLeAIlAK+Z/gJuRlMypW6Ajr4z0fWDPD9iXnA9T6hMwxLjO
         jVEt0sy9PeI6cN9VG2vFySjoe0gS58+wFNPRU+B73YlHTOcexAPRHC9rwltkh5UTC0/X
         a7CXdjhMLy0j8vguGp+puiHdRxLNCfZkH3pdNeab4c0mUoTMY+6wKO/TnPf7Ze64sIru
         ruJw==
X-Forwarded-Encrypted: i=1; AFNElJ9mBu8txwyq0i9u3DPMhMO7I+jd1xA0MoySW/Ye/2L7pwVSNE9j+pA0kokbt0jhitCxuNJdGdcG2X2ryw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhBTdUlBU5DA8PSeDOGxh1y7ukZsNnHSeaD8XjeFvIJ3XbMN2T
	0w1gLYE37HRlyqpxGyQQX8QJG6n0oKbBC5tjwLG/T3qM80aE3Vs6vVjHAdB01R3Sjb4=
X-Gm-Gg: AeBDietnpnmwKPyPRmxcyaPihZv9ET8ZXyHJoKQUlCM705mE7My2Y+AbJh3KGabj+38
	bUK9+niHNY6kzumXEf2MZeK/X34W1I1ZlSUiVauDeoueyhsMP7NkX36js+eLJTmWKG8Pwv6N3B5
	AX4v9YFDp7+oT2hhy8bB4KDvQLLv+a/7FCPPhiKZTc56seWCeZBn6cNDwTH6CFnHn9utKRR9cQA
	C8ZdM5zO0tLw53ASYQNmWlXvqaZqfV/3UPaDdnO6blqEQQPJwjES2R5tPEqy+Chvi/a6jToqOG7
	v55lS+prBxcCusEOTALqqFEgnqm8asw0UKI/T1+cf+mTAp0ALihwz17V0WXJ4GK4dh8Jb1aw7JS
	pC8YOTuYbpx6NnQKePhrY4WuattuNXbJGskmm91RxjCKDdYx/utopeocOFsfwSpNL3irNRuec5z
	Jp5M0vZOwb6uwVJ8NSeH4UB3C23VStocublSyp/TRf73YOHyYeoF2I2Dw7chUNm26XG6mMwQc9/
	5tJYHxyMNT2AXw=
X-Received: by 2002:a05:6830:2b0a:b0:7d7:da43:387 with SMTP id 46e09a7af769-7dc9518bfffmr3040335a34.16.1776458368771;
        Fri, 17 Apr 2026 13:39:28 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc9759bfa3sm1926469a34.13.2026.04.17.13.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 13:39:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
 John Hubbard <jhubbard@nvidia.com>, Logan Gunthorpe <logang@deltatee.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Long Li <longli@microsoft.com>, Michael Kelley <mhklinux@outlook.com>
In-Reply-To: <20260410153414.4159050-1-namjain@linux.microsoft.com>
References: <20260410153414.4159050-1-namjain@linux.microsoft.com>
Subject: Re: [PATCH v2 0/2] block: fix pgmap handling for zone device pages
 in bio merge paths
Message-Id: <177645836732.906013.8594129071302545302.b4-ty@b4>
Date: Fri, 17 Apr 2026 14:39:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 10 Apr 2026 15:34:12 +0000, Naman Jain wrote:
> When zone device memory is registered in multiple chunks, each chunk
> gets its own dev_pagemap. A single bio can contain bvecs from different
> pgmaps -- iov_iter_extract_bvecs() breaks at pgmap boundaries but the
> outer loop in bio_iov_iter_get_pages() continues filling the same bio.
> 
> There are two problems with the current code:
> 
> [...]

Applied, thanks!

[1/2] block: add pgmap check to biovec_phys_mergeable
      commit: 13920e4b7b784b40cf4519ff1f0f3e513476a499
[2/2] block: relax pgmap check in bio_add_page for compatible zone device pages
      commit: 41c665aae2b5dbecddddcc8ace344caf630cc7a4

Best regards,
-- 
Jens Axboe



