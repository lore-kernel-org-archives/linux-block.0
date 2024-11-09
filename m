Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C701E505
	for <linux-block@vger.kernel.org>; Sat,  9 Nov 2024 01:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731114263; cv=none; b=hcxXWoOPig2Bn+fOi93Qu1P/yAjL258gaAXETXI71B/OtwhEc000stQHNjgjEx9zNOuIKPULW/cPJVAbdbu/iKaGsj/ZFs90BwbbgAgr+ki+LVVR9mdnC092bIkfwce4N67S3cLpNoFR3fb8FsSPcG6Co2Ad//+OUNNg5eOLrJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731114263; c=relaxed/simple;
	bh=YbECG0nEUQAij663Nxk1dSmlb3CQ5b7HusIkri3LK7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CaJBkZ7Mhmtm2PINmNQ3SojmofwBFYhP1CtVb9GlS20AkyV9gZQpuK9Pwl04zwEuwXcPd/O8zaOGHws5Ox88BQBA7mU/Nt+8lTcMI7ZbBqgrP02SX6/jBbjTJZskWXjG6HBVrrDLHzzkIU8P9YjfmX5fCs4psaLMLqtTaMVC3uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jT5O3WI5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jT5O3WI5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2BBC4CECD;
	Sat,  9 Nov 2024 01:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731114263;
	bh=YbECG0nEUQAij663Nxk1dSmlb3CQ5b7HusIkri3LK7I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jT5O3WI5VeHSVk7suKEpnhFitqvD8LX40s6S4pOBw2O+DUcyUlOcV6B9oAdNOxF4E
	 Ikb34i8YskJ3NNa20B0toeRhO0kUogYvByIpc8VcEyoBHhBXPdcDjUWCU+mVzTab7k
	 ttCmSsjWm5ZENoF3+5YKqczaaxH7ERsD69Wcpv6KCVErggtImioGfvN0Xoe/4Yek2x
	 10EXEcK/OSJWVpFpynFGrXDA/b9B2dRASMT2V7c/qciVolBP6whMDD8xzPP3B8GK71
	 +1l2GJwk20j8dORMQZ0HYYhUdoL7rU21bwVS5JQjTtwOOdVSKRdhBZHkUpFWHa3tec
	 BlcTwUgQSHcAA==
Message-ID: <4f011880-dde7-43e0-b648-7710a877c609@kernel.org>
Date: Sat, 9 Nov 2024 10:04:21 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-multipath: don't bother clearing
 max_hw_zone_append_sectors
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20241108154657.845768-1-hch@lst.de>
 <20241108154657.845768-3-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241108154657.845768-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/24 00:46, Christoph Hellwig wrote:
> The limits stacking now properly zeroes it if at least one of the
> underlying limits clears it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
