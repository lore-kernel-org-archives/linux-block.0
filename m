Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B267D220F5D
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 23:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753314812; cv=none; b=KUjWqB/N8xnQaryO6JvoCc+VIHk79lhqdrqWvVzRxROv+OG9PK0DAVdKOdoBRkv0tDHDVFj6zfSQD+OpOMvWAyVM8MPRZrykT3xFZdS0dqztJmnrLTNfawZOzUwPQ/D6hUT+hWUhMDXJFlSg/gzUGF/rnl9jZ/b0teY5rpy8Ys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753314812; c=relaxed/simple;
	bh=Qyv8wtZsdddDC1tA/U6PoM6WbPlvRO20sUbpH5X3kPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGYJTD+5TzAg8aKHqVkqBDQtwv1MaHpbF8T46d8cSqMK0ju6y9xfR9r1m14ChmhDDeJf4I4e1jwt1fNpCCgXQINzyoYg77a1FlSh5SXWOhSWj0ER10CFZ77Yb7Tws3mJ0svWFSo8eTUn5+n9FR4ndz6yVMuONVnnr15BPoddjLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVfpkPb+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVfpkPb+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23523C4CEE7;
	Wed, 23 Jul 2025 23:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753314812;
	bh=Qyv8wtZsdddDC1tA/U6PoM6WbPlvRO20sUbpH5X3kPg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XVfpkPb+3JucCXx0Mom7C0hnGZTmF0Ctdt9hPO/zriSbBtfBVZn1m83gXtKa3DpIk
	 T0JrDN8sV8KcAx4IHauGWUHguD1Yar+uQLreWbtaca0/JqadQwJQ2cPhA0vrj9IO5V
	 UKZtiRRQ2KJ5yDbF2JhC54Cc8o/Y/2NJg/qrmPFTYtuAR0jrY6mZ6lQ1Moykycr6m8
	 Mu961LELSpu6SCGQcT2LtfEeSMRhEVBWE0WrgBcFH//CC4CklzG3cPQtGchgSbN+Q0
	 MA1AYUmwtwy0EMbDTkDxmyf6JyER5etnjsLJBcJ3zWifpKEYt+mGV4Ek+CsaSzEkUs
	 WpocqEJ6ev96g==
Message-ID: <5e56095c-bcf4-472c-941a-9580b0818c6c@kernel.org>
Date: Thu, 24 Jul 2025 08:53:30 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/2] null_blk: prevent submit and poll queues update for
 shared tagset
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, yukuai1@huaweicloud.com, hare@suse.de, ming.lei@redhat.com,
 axboe@kernel.dk, johannes.thumshirn@wdc.com, gjoyce@ibm.com
References: <20250723134442.1283664-1-nilay@linux.ibm.com>
 <20250723134442.1283664-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250723134442.1283664-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/25 22:43, Nilay Shroff wrote:
> When a user updates the number of submit or poll queues on a null_blk
> device, the block layer creates new hardware queues (hctxs). However, if
> the device is using a shared tagset, null_blk does not map any software
> queues (ctx) to the newly created hctx (via null_map_queues()), resulting
> in those hardware queues being left unused for I/O. This behavior is
> misleading, as the user may expect the new queues to be functional, even
> though they are effectively ignored. To avoid this confusion and potential
> misconfiguration:
> - Reject runtime updates to submit_queues or poll_queues via sysfs when
>   the device uses a shared tagset by returning -EINVAL.
> - During configuration validation (prior to powering on the device), reset
>   submit_queues and poll_queues to the module parameters (g_submit_queues
>   and g_poll_queues) if the shared tagset is enabled.
> 
> This ensures consistent behavior and avoids creating unused hardware queues
> (hctxs) due to ineffective runtime queue updates.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
