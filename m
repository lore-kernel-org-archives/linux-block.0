Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC5414A24;
	Thu, 16 Jul 2026 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201247; cv=none; b=PZooSEeCPK2wKaM0gHvvvHpYDmmM28wcsAlXXwbK9GRnbaC5MHK5GHJyNra7BfotK6ISjwCZxrp5OUML1+Do6xNYCLxE06RQAZa5u+cmb6PHSUI1mZ0qj7kj1X4ZzZRjzal0xqMjKPdS/TE1i8u37Dy97MaZB1kNfaxkfNwdqSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201247; c=relaxed/simple;
	bh=+t7ON17WO1ZDAdzvAdtnrmUfc1lsi8udXZEZmta+HX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dU7iT2sJaKt5yherXQ4q3uMTHajbKsKWRj/drYqiRgInW4x0ApK+UFX87REBV1JmDkMhgvmqfpVKsZQg8P1wXHE5psePlM7Zy4bDIIwW3WkBty88tRZTG+D2DoUomGZrn5qyVIu8B+PbeIsJmP5xxZjjZBYitzj8wc7RFhYiaoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaAidFa1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaAidFa1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77001F000E9;
	Thu, 16 Jul 2026 11:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784201246;
	bh=Ro1ol3v0QCX6fNibh0uVJa1cs8GDbqAaB+K8XxK+amY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JaAidFa1H5U9LkqzTNRijInaOuX3yluLteJx4CAmH2qDADBWNJgGIcCCt6krrfym+
	 571KO8FelM4WC+xLw35y25Syropi/iufz8Cbb8Pp1t5lB7Nz+xEcDb694tTMzCgGGT
	 Kg3WR99ANS5t99OtaYc2aqXVWe4ep99DITIqMgDJwZ0U1F9DGcQD9BORYXW8Gxhr6+
	 986Euiy1cxA2mtL1g1xeoKluRdCT3B5jcEgujGdzCwczIcgPHyoag4K/qyixPCyFMg
	 mYkzHkfGQcYCuEIYskRfVuL61RkYSrDagAex6L2N4O7wmE3xZQGoK96zZIHE76ZCFX
	 mW1yzZK7xjP2w==
Message-ID: <852a57f3-c87e-460b-be38-8eade20c3f4f@kernel.org>
Date: Thu, 16 Jul 2026 20:27:24 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] block: allow REQ_NOWAIT zone management commands
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org
References: <20260716091838.318082-1-hch@lst.de>
 <20260716091838.318082-3-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260716091838.318082-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 18:17, Christoph Hellwig wrote:
> Commit efae226c2ef1 ("block: handle zone management operations
> completions") moved all block layer tracking of zone management
> operations to the I/O completion handler.  With that REQ_NOWAIT zone
> management operations are just fine, so allow them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
