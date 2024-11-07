Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF7209F4B
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981258; cv=none; b=k2kaLKfN/2ThWftaoX0rQg4CqA6QM5Vl5oeEfp3vRRwAkggsfIBWn2zEDt4RgMgmMT8ns16FQ+phxdkvkDDr7oJW9z85W0mmhcCd61L8KFV9xX4DGLFksCC2xQkJ4+jZX9jO+Fe4sTsbTf144X71zBYtoGtEC82HUAKWeJe7SxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981258; c=relaxed/simple;
	bh=f5Rhfa+Lc02svgre5YdteFCCE7GUJMGmpsHVPHGc0P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4QucwiO8xaH7HU3yAqdz/CKszyHNsE1bX3jGTWFPTVl2GI6wEJ7CUidGw3LRdnlPOUVtLzs+7M0WLDxrMcO/B52K7DpyEat4szeOSjV0fXCiFLUQSz/XnXcXNTe1ro/LiqiaqGP/86HapFYF5eqiUHtJRvXhV9RYU98HAtcXNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qT+awccX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qT+awccX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D222C4CECC;
	Thu,  7 Nov 2024 12:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730981258;
	bh=f5Rhfa+Lc02svgre5YdteFCCE7GUJMGmpsHVPHGc0P0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qT+awccXdu2AVRFRy6wmsVMMBt2o8I98SJEzT6Z0Gr0LwEAZ8aoUM0OXoK6ZWgYgM
	 Ls3p8OVRMED1cCKYlAsXCy7DJDuNW5p+5my3fLY0wImWpTureYAUKKb5CocLJ386/r
	 YocNUG4aLxtwEr88tR+2DZTUDlEqhueYQOIDtsq109PhcJskgEuqWaTRYsrTtkxgIK
	 kB+hhsvchO7rjzfNc2POIDYQ6f4A8x0onph3K7+O5v9lsP5zr1/D4jAVWf8KQy/IiZ
	 DPYcFRWBIefwY8oMiYXWr8GPUaIhxPjJWYMwDge1j0IL+iRWHBA0PMQQogFJ3S8gn9
	 JydPeOXimQXPg==
Message-ID: <13ac0849-13c3-4c87-b3c3-e6259dea0155@kernel.org>
Date: Thu, 7 Nov 2024 21:07:35 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Switch to using refcount_t for zone write plugs
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20241107065438.236348-1-dlemoal@kernel.org>
 <20241107072719.GA4408@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241107072719.GA4408@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/24 16:27, Christoph Hellwig wrote:
> On Thu, Nov 07, 2024 at 03:54:38PM +0900, Damien Le Moal wrote:
>> Replace the raw atomic_t reference counting of zone write plugs with a
>> refcount_t.  No functional changes.
> 
> I don't quite see the point, but if Jens wants to take it the code
> changes look correct to me:

The point is only to avoid kernel bots screaming about the use of atomic for
refcounting. Nothing more than that.

> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks.

-- 
Damien Le Moal
Western Digital Research
