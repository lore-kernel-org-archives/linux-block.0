Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0C83D4133;
	Thu, 16 Jul 2026 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201221; cv=none; b=CZ9VBimt/r0Pg9rqCAQL+ErXQQyOe6XyK/+wRJXHzXMkhGTRIrJNY49Qms7N/3iW0HErzXHjPTZkLZWhVIuuvSI04oR1ySvtNqj8dlW9QxQMAbPcQss6MPl86fSl724lvz3Df4RcrRiXmATgJoWFEevP5Yv+9cr3Vb6iELWHBbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201221; c=relaxed/simple;
	bh=7lOqgcLSR78K4v74j1QpsvxAsKGtzYD0wLbe5ek+LBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mX6VVqvsbAAmQYDwxjq9m/4TvaxKTfN8ABF026XjKRMlgWo/LBoEfL1Jt4YidJwmHK7rIlK0XoS5h4JL+nkRVpPOoObRcmvXS/wNiAMJ4W4/ImiFVYkHOmu5ujmpBfsv2vG0XrcTX2RAES4pAhykj3g4xl3eaBN3iu4FpImQ4N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uz/zjn4w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uz/zjn4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA761F000E9;
	Thu, 16 Jul 2026 11:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784201220;
	bh=0qf4hrSDM+YpjMd5TMoRfdQsbqJ9bmsBv0H8VnPOoKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Uz/zjn4wwb8iBQ/5GEp0veYslzAvd0uCG+h05Qw7KSdnyDMauBaXPqz1YHrJkNBTz
	 9WsNHSPZ9E0h0gWtBnY/ERXnBLShHdMV1dckjaUyi8XRoTS1JSD0Q0WtlbSQvQFSlQ
	 2PoL1GXcpc3POZD1BUfsTIDI9nEwfXtubKa85Bmj3D3rUqmjqBZX6L0sFD+rm2dbIM
	 r08do+MHzklWSw1nP9SAS22SoGx8nqH8loRlHzpu/mJRsQL6COFlL2oK/fvy7nk2oJ
	 9PEq1GdIAwKhieJUlVjZuRk5RMBQnUNSecpXXspVL1qDlhRRcLpSU6PTpqNUPaNGc3
	 DO+0sgH0fOqFA==
Message-ID: <46ec9252-81c0-4ee7-bdd9-50fed25ce0eb@kernel.org>
Date: Thu, 16 Jul 2026 20:26:58 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] block: remove a dead return statement in
 blk_zone_plug_bio
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org
References: <20260716091838.318082-1-hch@lst.de>
 <20260716091838.318082-2-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260716091838.318082-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 18:17, Christoph Hellwig wrote:
> The switch at the end of blk_zone_plug_bio always returns, so remove
> the dead extra return statement after it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
