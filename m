Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F29C17578
	for <linux-block@vger.kernel.org>; Tue,  4 Feb 2025 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630865; cv=none; b=hdkBq7uerDVgK/YfjwZgLxvdJcRWWsiLklQYhZ9q+aLPvCSYR6ikPiXOnSTdlwP73/EzV/6B6HVq+ssRp+aahH6aUAtqJrs2M+/WqFcR/iFOvkzz4FmeDTVpzVk2KGQAje/JAXrLe0qNl1eNRDaO0qLxwksLcYCSWQzD010OOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630865; c=relaxed/simple;
	bh=6OLMHyRLVeGvzO/n+3Wb7XLtkEovIWtXiXXcqm5zRto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oa0nz92SHVnTEVqButBLjPbFRPP4AdZ9X7d5AdG1Jdq5Su7Ghdr3dmouVTokNn1cweZqblhPVaNFBXkHVEXG6cPkbNrvXRR4hhmM2FiNJ0nU/+LD1s3rKQj7oPgesQi5oquKSM/694JZcVSjArNNuF92Pbw0JakXjWzPCjstmss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdL0t5ut; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdL0t5ut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D63C4CEE0;
	Tue,  4 Feb 2025 01:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738630864;
	bh=6OLMHyRLVeGvzO/n+3Wb7XLtkEovIWtXiXXcqm5zRto=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pdL0t5ut10DgZGDAhwviOtH1hzbhFHLv2lRHOARr1xGtojv3uiPpH63VfPXWf2KKK
	 YEtld1aezTWw1nWsVzGFN/NKqL/h0pxvTXfHVLPh3x+HPVLENBT9naLEF8G3oSY9Gr
	 84rKSkKZUN9pX2a4Hnqzxa4l9VNCUJlPGCWYtqwJnrSiOwgqPs+GKLOiZoI0aRsKYQ
	 GR4HSoFsYX2mG0VX9gNi1+9bbhz9zD8F/RHYt1CUCOwFqmQsb4WYMslwd+qCSQoImA
	 0R5GhgjmsxKisYvfet5mj0FBE4S0v3ZgQcp+Q2p9mRJDaZ4P8CWfrT7j65qGMGeCvJ
	 CCeZ6043MS2EQ==
Message-ID: <83e10a67-3f1e-4433-8f3e-8cb008592710@kernel.org>
Date: Tue, 4 Feb 2025 10:01:03 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] loop: take the file system minimum dio alignment into
 account
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20250131120120.1315125-1-hch@lst.de>
 <20250131120120.1315125-5-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250131120120.1315125-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/25 21:00, Christoph Hellwig wrote:
> The loop driver currently uses the logical block size of the underlying
> bdev as the lower bound of the loop device block size.  While this works
> for many cases, it fails for file systems made up of multiple devices
> with different logic block size (e.g. XFS with a RT device that has a

Nit: s/logic block size/logical block sizes

> larger logical block size), or when the file systems doesn't support
> direct I/O writes at the sector size granularity (e.g. because it does
> out of place writes with a file system block size larger than the sector
> size).
> 
> Fix this by querying the minimum direct I/O alignment from statx when
> available.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Other than that, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
