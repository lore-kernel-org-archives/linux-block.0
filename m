Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD23F9D5
	for <linux-block@vger.kernel.org>; Thu, 26 Sep 2024 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369756; cv=none; b=FDuJMm87tRGkVwGNiPygXJ4NF8aQZzRluHukyk6/JHJqh+TfdgPFKVsV3Ldhvdwori6K1E3Zq1U3uxeJNnck8IChTelkMukjpEO0ImvmO+rtUo1T9zyAdgkh8StIGyBJkecwEG+tfNm9LBJusN+wQUmtqRzKfPY+3nZieqvvRwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369756; c=relaxed/simple;
	bh=SXSEiQQI9kGrzyiaXlBcGqbkXlxYap13u+JfZINCSZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CERTpK/+IfsP+C/YwbQpfOW/fsQ/cGxSIuGTUszn/dMLwkh6iOqFAeDdahcg6i4Iwtz6NdDDJBdo6U2WDwdS5JYYh5Q/y4Eiz4Qu3z7/VcGXl7yZxMPPJvdPoXgJiqIGuJ+32P6Ml/JBLi+YNvNPaflKwQICnpxxptOn05bKazs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IN5PO9sq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IN5PO9sq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21794C4CEC5;
	Thu, 26 Sep 2024 16:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727369756;
	bh=SXSEiQQI9kGrzyiaXlBcGqbkXlxYap13u+JfZINCSZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IN5PO9sq3jyuQGdQayOLjh31cxzpOk32q721BBOG4n9PvHkz90mM+bAgn6mCbf2+E
	 lTV0OKsgxtArms4tzUIBx73ciHXG7QwXbQ4nO4xy4IgJulMLehy3+3kEEcHyVnj5YI
	 /8T8BsRdo1MV7ojTHjR6SDLETAoHAvn4hcTV3GCumntOgEXpsoYLnietSk6Fsld2lA
	 R0gbDgGNEwt4bgai2vsr3BQvmhoY/I2RKvUdXvxMBHIe6gAnifTeuD6sNn/a6NKZzS
	 9ZkJo8SU/7ExFF3IpGMxLyjIwSCOFQAGdWZrtvI4nAOv556dDY/CdUS8CZVyDhBQHg
	 xo5UhRG16gQKg==
Date: Thu, 26 Sep 2024 18:55:50 +0200
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	Chinmay Gameti <c.gameti@samsung.com>
Subject: Re: [PATCH v2 2/3] block: support PI at non-zero offset within
 metadata
Message-ID: <ZvWSFvI-OJ2NP_m0@kbusch-mbp>
References: <20240201130126.211402-1-joshi.k@samsung.com>
 <CGME20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d@epcas5p1.samsung.com>
 <20240201130126.211402-3-joshi.k@samsung.com>
 <ZvV4uCUXp9_4x5ct@kbusch-mbp>
 <8ed2637b-559e-3f27-3d1f-84a4718475fb@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ed2637b-559e-3f27-3d1f-84a4718475fb@samsung.com>

On Thu, Sep 26, 2024 at 10:08:09PM +0530, Kanchan Joshi wrote:
> But there are kernel knobs too. Hope you are able to get to the same 
> state (as nop profile) by clearing write_generate and read_verify:
> echo 0 > /sys/block/nvme0n1/integrity/read_verify

It's not the kernel's verify causing the failure; it's the end device.
For nvme, it'll return status 0x282, End-to-end Guard Check Error, so
the kernel doesn't have a chance to check the data. We'd need to turn
off the command's NVME_RW_PRINFO_PRCHK_GUARD flag, but there's currently
no knob to toggle that.
