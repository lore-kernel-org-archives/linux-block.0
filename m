Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939B536827E
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779260313; cv=none; b=RCbWjH7EhWI0rAHWRq2ibtqNoGW3w+lXQjaIVklgcAlDau9630EDR7ah6h2Ywu3uMs6TukPuKcpvJPevwwtDiihLIXRpFBslJdT0LaL2q55Vg/rM6jv5qM4YfL2otrhlAmz1gneeWRqN7JhLwZTEoZL7Dm6ZHXsI5j2VnpKerf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779260313; c=relaxed/simple;
	bh=O2tnikSTVyKUTj7P39fhhIt5eWPWx2Du6lsz8h95pTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UL0Cr6ryiKBPeJ7lUanHwjpLKUsY028GUOiVHGcdXZ/u75bC08zTfv44Ptv8zq9dYPmeDjT6Bv933RLsqHdE7wE6DxOwGLh3Q7w/xzWmRLty+Joy/FGTi3E0U3zhf29yZPKL5TiF+wRqUpmikQMAfiym7+A8v2nkDojRJlyReY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqaLa8/P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqaLa8/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C46B1F000E9;
	Wed, 20 May 2026 06:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779260310;
	bh=RUk03tD02nWAPVWUDiXz6OebsNBD2Kwac2rrRjCZDfs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DqaLa8/PbJqWvIfX3g1QZ6m7s0vV6P/N1MMIxxyrqr2lOMrev6U0V6VK95xAFoOBz
	 vhX2nXB09bPUm1JLnlRtsU4qkz95Gi6qoVtmlkzXt9yTo1mhunZoZEUw34scmTtXdR
	 55z7JNqZoYpfZy00Oc+7U1kIBE5cUwrv60zH+aOWrj7NstXhh+ZBjxtpv4Y8+T1eYv
	 xYG22ekc35s/Lz6N2UUk2b+citri2O6waxzjPOr9AMi9PeO/SbuFIlN4OByocOHtDF
	 8z9Os9R4vVzFdiZcw+CsJI3hRLR8fMlgoKXqUxHBH3IREO1BSACFv4NK3FkKpPfiNU
	 MGz8g6GnZ0oqw==
Message-ID: <493f4c2d-8926-47d3-8865-e4ab4b8873ed@kernel.org>
Date: Wed, 20 May 2026 08:58:26 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/5] block: fix invalid zone append status
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, hch@lst.de, tom.leiming@gmail.com, coshi036@gmail.com,
 Igor.Achkinazi@dell.com, Keith Busch <kbusch@kernel.org>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-3-kbusch@meta.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260519172326.3462354-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/19 19:23, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> A bio submitted to a zone block device that breaks the limits is invalid
> rather than an IO error. Fix up the return code to report it that way,
> as the previously used IOERR is considered a path failure.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Same comment as the previous patch. This could go in regardless of the other
fixes I think.


-- 
Damien Le Moal
Western Digital Research
