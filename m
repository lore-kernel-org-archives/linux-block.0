Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89098339B34
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771964949; cv=none; b=sdK4nP2JbOTeG5S/RQd7L4yCD5MwxTz1Czhvj79E46oT5Ie7AtQgWMNtwGvrvIbK/pSlCKorCDyZuMSIK5/pGhnczFu0oWJCwD4NV+7qx6enVmcIeId0jUZRUdC9jB2PYbYEqTlmem45cntSC0ECCwPB/0mDzj8whzb7P4cJLTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771964949; c=relaxed/simple;
	bh=5ZOuUFyOug6eFjlhd3amwZkuTm4qcGTxk9u+xhjkyoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u41PS3HkDR0A15Et1BqIf6I7jkJBkS76FPODGxlfjFn4BFlkSclMKedWVIWlFLTKiPgLkVJ4VXAZsdNZjQPd3hbKHl2V52KPDoJI7+I5TqOqkEcgYkGBNJozpfV+uj7TyxzL3bCobPqPKkUudMHTc7+0ZLRM+0EOtyM5vEsCRE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6AFLme+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6AFLme+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF89EC116D0;
	Tue, 24 Feb 2026 20:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771964949;
	bh=5ZOuUFyOug6eFjlhd3amwZkuTm4qcGTxk9u+xhjkyoM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X6AFLme+x2I7jyj5kBFp63iYJjWULh2mmjQvZkEsNu9d83UL2ELecTCmOg+nHB5r+
	 mw234v1/1jHFcMCqe64JdE5rXwUY0OrdygrTPfKlkdPwO1ZgdxuFREsPspBGRxqdIk
	 mz2q1ZDoKdLDAW2tC3/wYsOQQTxsq3Wofgi1C6bvwmK9sAerlxr1FguEJGsGKIBGZA
	 jEFlWq2FkVIqwLtxQVQJ0eheCBUi9BwpTZa5McON5G37ZJ43XrnYtcBBWFtj55Hu65
	 YE5pZdfrxYZaEF0U3qiiBRfCXYm3Dd+8QRDk+vhxMSPmQVJYgOpl0m2Qa+ridk9fgw
	 gdlErJ/iGiFGw==
Message-ID: <75f48cfb-b426-458d-8f26-17d6de2f2a2b@kernel.org>
Date: Wed, 25 Feb 2026 05:29:07 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] zloop: check for spurious options passed to remove
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20260224142153.368472-1-hch@lst.de>
 <20260224142153.368472-3-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260224142153.368472-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/26 23:21, Christoph Hellwig wrote:
> Zloop uses a command option parser for all control commands,
> but most options are only valid for adding a new device.  Check
> for incorrectly specified options in the remove handler.
> 
> Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
