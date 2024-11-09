Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF923A9
	for <linux-block@vger.kernel.org>; Sat,  9 Nov 2024 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731114245; cv=none; b=Yhuk60dwuu9YHRy2U/Oc4Fq6XBE6KCU94/sU9t9pMGCpHTznImKpST2JDUF40EFEhs3THnK65XHFs2pT+0iFWEF9RDZW3o+YBDVyRQ84tBfqntqmGN0Z90qJwy1p2np6DqdA75cb//2PDuCdR8HNbUmcuqoFkhpMcVYSFqzTVuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731114245; c=relaxed/simple;
	bh=6Oi2bMgwEQVtMzIHnMsC57CiynTb6sc3Vj22r2MeqCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lj71saIlaApzgEtDgFRUNNyaNfLzBxc/1tJ8ahfE1KtHXtbnTPmgTlaDr3bmEQztqArCZlSz4t/cb0Lf0dzCdzFOcmXU1wBt/H99c6TxGFc9vMGNUYBaGnWZd+Owx58OR5s6ERfW2wey8ZoUIy+EA5Rc7Ouc6plnNQvxB2uzM2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvbGRKJ+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvbGRKJ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB71C4CECD;
	Sat,  9 Nov 2024 01:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731114245;
	bh=6Oi2bMgwEQVtMzIHnMsC57CiynTb6sc3Vj22r2MeqCI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qvbGRKJ+TLGORFKososvRFljQxX5/rX8ULTRxwD4iJV9NP2ESd/rl9W2UqGqQRFsp
	 KHEQMXiTSLWlybqjULrSzy9X0RH6JEFJ7MHLE9FK4m1QvnsJMBEJOL95p4vjtvsPPl
	 dZt4E+iQLENLCkLSO5hc/NdTcelFlHh6lL8pgAQ82N0QcWRWZihufAV8h89VSWhdhv
	 KE98hTlso4Uzm4LulQeoMHdgTC4+ISzbywrvUxP3t0Lwzo0NxfxrpFDMA1rDoI0fdk
	 ZHSrkeV/BLpaQtMerTyzElADNVF5LsNb0HoKpErlhZbSCeO1U+JCFeI7b17EuXSJF4
	 wFHUdnYYLcIpw==
Message-ID: <a1fb0d6b-79f6-4ce5-a350-abb8631ae8ed@kernel.org>
Date: Sat, 9 Nov 2024 10:04:03 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: pre-calculate max_zone_append_sectors
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20241108154657.845768-1-hch@lst.de>
 <20241108154657.845768-2-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241108154657.845768-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/24 00:46, Christoph Hellwig wrote:
> max_zone_append_sectors differs from all other queue limits in that the
> final value used is not stored in the queue_limits but needs to be
> obtained using queue_limits_max_zone_append_sectors helper.  This not
> only adds (tiny) extra overhead to the I/O path, but also can be easily
> forgotten in file system code.
> 
> Add a new max_hw_zone_append_sectors value to queue_limits which is
> set by the driver, and calculate max_zone_append_sectors from that and
> the other inputs in blk_validate_zoned_limits, similar to how
> max_sectors is calculated to fix this.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Link: https://lore.kernel.org/r/20241104073955.112324-3-hch@lst.de
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
