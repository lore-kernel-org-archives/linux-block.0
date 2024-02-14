Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB091B7F8
	for <linux-block@vger.kernel.org>; Wed, 14 Feb 2024 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910239; cv=none; b=FycpLhL9Eczc9VtH6KoZpARXdzLj1MjRZbXp8gZ2V/dTANiGT0X+YwHFlYWUhQLMDVz5zUl6b4dX+zkSzRwBUBtonQZ4mvvMQVKT3MeESKtHR1alzI6zUT+GAbnlLss7ZBkZotCPUas6HD7tACxTfh32gf3zpFzSHTCTgFNU+kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910239; c=relaxed/simple;
	bh=t3ID9M/oqfQ0gNRgQNobZ++m8H/v2qL3qQ398BbktkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1/LATl3Vvabs9ItPOCLzTVirXO2xzL94xMXDbSaIGZ+g/NYepWKs4MT/ob1Q4layKnUdxDGaFtoB0c83BknjiOPa6ehLiKoSfHE2sSZElwMzuo0TUEtSnYS9wKtfZMETWlwGI1AOpzX450d9E9EUWSMne775t4oU/9pB4Nz094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGgM7oiW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGgM7oiW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CFEC433C7;
	Wed, 14 Feb 2024 11:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707910238;
	bh=t3ID9M/oqfQ0gNRgQNobZ++m8H/v2qL3qQ398BbktkU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EGgM7oiWdF2lErwqVlRZrawy9DiKVomkHtepIo1wKKM3Xm2foupkJceOKCvTDXUXE
	 tUfeC0mQJyE7RWFifO26yveBic6z1XsnrbyWUf57Djrsy9B1vbdgbNIQb+e2PqWciQ
	 V2khSjKWq1BubetAbYnuGp8hGthxLEDXP5KT+xxa3Gno8q2l1euf4enm0Nmx21Y7AP
	 XXMQXMwVh7ZJKNxeeT9L9Ajm6KjqHQEmp1Vastznfm+REEPwIkrWx/Ej37orTt9KjE
	 jw90z14HEIfidiwcjD8IDJt/pLkjsvicZ27Eql+mSENkQ2Pa6VXoy7JSp9N8uB+N/H
	 F1eWB9yg9aPTw==
Message-ID: <764c5522-6fe2-471f-aaa5-3dc43793b3d0@kernel.org>
Date: Wed, 14 Feb 2024 20:30:37 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] null_blk: remove null_gendisk_register
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20240214095501.1883819-1-hch@lst.de>
 <20240214095501.1883819-5-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240214095501.1883819-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/24 18:55, Christoph Hellwig wrote:
> null_gendisk_register isn't a very useful abstraction given that it
> doesn't even allocate the gendisk.  Merge it into the only caller
> instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

