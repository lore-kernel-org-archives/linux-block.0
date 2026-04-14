Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394163BC666
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158880; cv=none; b=l8uS+XZyE1yHe4v5Z7DcRjAf+VTw8iBYZEcuwbPHgnzvIWmy1sD431UyozGkxMVFPoVpv49mSx3UYHSbDZH0A+TKP9VmFDkrvW88+GbIGcLm/ZF3DMGN3Pcfww+ZEjPYxqyyuKU/8cvcwIYhW2+OCI+cWokDnnlst+AqgpjTpug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158880; c=relaxed/simple;
	bh=jG4Ww6WTzTnomPXLr0mcXBVW8WGYZ8hjsWkIA3a0Pn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWoVw8zKBbek0w0HP2jKIHpCS6Q11aHupTGowaKSKzg+OzWFlDtZQhBi4WcUcMCR9yK4AmK/O0AoZOAtSIm7FuTrtpMDPTgnnaCzRq+TzbKC8eZLs2iyay/EXxjHrfPzI3/5QUzcXiwwKPKN0bXDG5liZnoMD8X/koAjL9PF1Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyEUgn+V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyEUgn+V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD5FC2BCB4;
	Tue, 14 Apr 2026 09:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776158879;
	bh=jG4Ww6WTzTnomPXLr0mcXBVW8WGYZ8hjsWkIA3a0Pn4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YyEUgn+Vfw3S0x4fNG3G9MGUOT0SKTfcpxOi40W6N28N8oxW+il3K9p5Exn+lqxXg
	 rHDFFCFNvjoUXZkU1o6C9Xyf6/5ADyrVnxI6y63Bf4qQ2r491Q8/FiJsSnQu1mVBh1
	 rdyeYMGhOr+d2KpEKfYxGG6Nz3PN9EpDcFC/W9sPLY3HVTcJmsNrEun4Y/kaYfLkRF
	 qnIi2k8qRgjVHgMYAFLtITCOlbX3iuTnOF4A6XesKLwJ2MOGM3RX1pnhGb5uSPspNc
	 Xf+TqeaUILxml9JINVHRUQRkYu/R0MxibgXBnB48jAPvCfSnq+6hAj7zAIa2Poh1YD
	 FGsZm6sXIsTgQ==
Message-ID: <b18d031a-103a-4264-aba8-f047204ce476@kernel.org>
Date: Tue, 14 Apr 2026 11:27:57 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] zloop: improve the unaligned write pointer warning
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20260414081811.549755-1-hch@lst.de>
 <20260414081811.549755-4-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260414081811.549755-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/26 10:17, Christoph Hellwig wrote:
> Use the IS_ALIGNED helper and avoid extra conversions, and tell the
> user what the unaligned size is.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
