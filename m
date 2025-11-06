Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1C16D9C2
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 04:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762402671; cv=none; b=p0Nr81/UPMrL9giGpTddf/a+FE3ip7Mt/YAWk99fp/VgxFhdb5lqnK4dfaZW2ssR5eiYt0+12ifUCN7oRuhe37WK1irecOtzU1Fz//NF1fBsL7Pmf7GFGOLt6NTisJKtDpjRwf5jRJHBpMCoMrwQkXos1TuH957R98HZ1Bo4SC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762402671; c=relaxed/simple;
	bh=vwUFvRUitr1SzrFfGf8Od7gI/AEfpIZtThK0fWIaM4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5h4f80Y6wzULSWNqHChUam78wOHhKxoFfgooHWaqhsbZd56m3YiiThhtFZBv23Uju3JvyILk/+5wS3fO61Jc8+yoZNHbZXNzMRyJ+2UYdOjCfNm7B9qM7xExLJ3S9hM8WXnh+p8/mRzCrrEC9/7/u5Xv58sZ1c54nnxVIsCNdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G01hgaN6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G01hgaN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D87AC4CEF7;
	Thu,  6 Nov 2025 04:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762402671;
	bh=vwUFvRUitr1SzrFfGf8Od7gI/AEfpIZtThK0fWIaM4o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G01hgaN6EcEpu2A2aas6n5M4Vy9HGSd0YxRJ71C3e3xEW9AUCOwrhlTK98Msmzk5Z
	 APs5OHTbuvOk+DkFlRe3Yt877O9CwE9AeIZ7mSOCIPjdnfjIRnPcgs5SmN8RtKrjin
	 B6gYDHaKlea1XiIiyMd3utpk1PnyngTXXuyhsz+Mf4sfvA2/sVWoUd4VezG4el0Qdt
	 29Lz9DLODNsJ2Pm6AlqFOjg2rFtHm8M8m4DfuqH10DVkEuj9MKWlvz3ETpcCQFrMuO
	 pTKPkF5zk+SHS4lNxc/wC2UFoWlFHmkDK0UWmZI9AF2+3+c3VSEbJY1BIgEPsiUqxc
	 t/YuAKzQvQMEg==
Message-ID: <75d1c04b-c436-41c4-a6d0-b40ad042a499@kernel.org>
Date: Thu, 6 Nov 2025 13:13:56 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/4] null_blk: consistently use blk_status_t
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, hch@lst.de,
 axboe@kernel.dk, hans.holmberg@wdc.com
Cc: Keith Busch <kbusch@kernel.org>
References: <20251106015447.1372926-1-kbusch@meta.com>
 <20251106015447.1372926-3-kbusch@meta.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251106015447.1372926-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 10:54 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> No need to mix errno and blk_status_t error types. Just use the standard
> block layer type.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
