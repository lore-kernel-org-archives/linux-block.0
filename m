Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4A57083C
	for <linux-block@vger.kernel.org>; Tue,  4 Feb 2025 00:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630552; cv=none; b=TYA2QzAPE5P3pT8oLMXKAjxwJ2DOK6e0qEDUQmJosYBdIcxvM9k2moTlazZvkZrcxyNSJ+DO6UO03z3+8AWwQl8/WeYD+o/Yv13O24IURGPvTIAx70eGAopbPlmP+9N1HM5HOVLQ4yxlKcj8KIp2fs1/DyvQhdO3teArLzxWJRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630552; c=relaxed/simple;
	bh=uWRoplezh3ZJG/KAmyqujOERSjcwDam7X0R7YDnLEfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEmKF9XD9/ZGD12qw/N6bmF7gpskQPbuMoZIkpLpczOGbK9mV3t0fxR1cF0Un/3BvQ1VxsVJbblkDlSZ4WiDUbvMv/Yl2TZcRXKnznyNzCLdypXE70QO7eT9I3hGQo3PVsPyF0ppMOJBo6ciH0VPrcS+pLPCEq/1etefZyVROIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkVPAj4u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkVPAj4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363BFC4CEE4;
	Tue,  4 Feb 2025 00:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738630552;
	bh=uWRoplezh3ZJG/KAmyqujOERSjcwDam7X0R7YDnLEfc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mkVPAj4uj/Q8Fq8vQenvmuyuabG+9mn6dzSIQozMHFmqaNarTdAmvvVnAppluh7px
	 gJM7cxGoB025r3GiVcLvZIxq5wfo9Ix/A4nfs5HTe7oDHscEWWk41Z+CxLt9d8KkUK
	 32yhNmH9IFUNR20I6oNKJrpYmpXyBTcNpWLTjU5Xgv97roJ1ek04TjJSWTCoWISLtM
	 rAp+g6bW710ZyHTKPl+zwYE3/Gu1FeNpI5bWoFmbI+KcDBKDbJTbdV94rZpy+y+9lD
	 3m3yM7FKf/eTO30WGjTD23tJmeaKV0/vO395Y15blAU20/OylcOsJ26fCqZxEG/0U8
	 oq6eN5qryxxpQ==
Message-ID: <d0d899ba-3014-4977-b107-c16168b3fa54@kernel.org>
Date: Tue, 4 Feb 2025 09:55:51 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] loop: set LO_FLAGS_DIRECT_IO in
 loop_assign_backing_file
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20250131120120.1315125-1-hch@lst.de>
 <20250131120120.1315125-3-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250131120120.1315125-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/25 21:00, Christoph Hellwig wrote:
> Assigning LO_FLAGS_DIRECT_IO from the O_DIRECT flag is related to
> assigning a new backing file.  Move the assignment in preparation
> of using the flag more and earlier.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
