Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F17748C8A2
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814747; cv=none; b=ShOc/fZNTR+4HPUN9S6mkEubdqFhyw2mhtla4xJbMzTD1SCvzqP+m5d7rggqJvN9CP8/tb5VcroG2pRJaJLoRTY6wAj15JfaDOR8hVT61N2tNkQJjKYWFI0sH8X+zFnwBpE2m7/0HwmgpwIHdwHmjk8wCcthzJTXimc/iawUAtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814747; c=relaxed/simple;
	bh=DC1suGPsOzyEumODaTv5fKhmral8lVRYD0bBPBKzAPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbCyrGr9wYXvZvDd24OcDqIbeMTnwlxOIrU6Rn4asi4ZDz7otvb2W/fchQKoEkUSeMtZU0F+2bFTPEusFhbIOQp6ESb0T2hQyHnw7O0Y8GWu7OPXMADNun+tLTHnHisUy53MTKmWsvNXIdkccjaQvZUtSPBll/QEiZz1uZI39m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pqjnoe2E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pqjnoe2E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868BF1F0089B;
	Mon, 12 Oct 2026 14:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791814746;
	bh=QBI2Qxrbpv0iuySygOnALlPSX94sfNI8QI/TxCiaMZ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Pqjnoe2ECIWdCc5mN9KUb2wa+DPI7Vce/y9XDOLAtDJ2iXJCM1LbFfWcjus/L9yre
	 X9TmlRpaDdAqm7SNEXKgz18A1OCmPcSZywElaP4L6qbSCyjAXT0D6OS44G9b/kF+Bt
	 TB6a0/zdlmgtXUcmA0bp++uHCdVpqRjsyYpHdxlA9zNpnI76KYrVd/5WCPqC+I6PH6
	 ZhyVyF3yFz7u/1aBrt3xckmg6GAXISyB/BcgpDNAfyfrMbJhY57TmLbA2jSiMhs5rI
	 ohSAQdf/sqKEYqjCeYLOysY64EhXDM+WPAsA7LQ5GnLm/sN9Qn0FZhHqrkKyim66It
	 MYGpOlyrQ+d5w==
Message-ID: <df155820-49ca-4e3f-8fca-14da73cb03c6@kernel.org>
Date: Mon, 12 Oct 2026 16:19:03 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] zloop: explicitly mention zone condition when a write
 fails to it
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20261012141551.1336261-1-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261012141551.1336261-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/12 16:15, Christoph Hellwig wrote:
> Don't print the impossibly large write pointer, but directly mention
> the zone condition when a write to a zone in a condition that does
> not allow writes is received.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
