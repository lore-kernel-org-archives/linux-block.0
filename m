Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F73E3F54AA
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622126; cv=none; b=kXbXr52m1jrtTkpqkbj+VIAnT0sGDo0yYm/7zdxGGlTmhqOavFYFlL1/W4qNZIdrIlnuTI69JMP7Kjhf3DkcmuH/NYW4YmVDInPNb1tgVt/fppmR4GONka30CPF8QYooj+FQjfHGPILcPIQjRsBMj8VMkVJ6xY/PU2rq0zCssfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622126; c=relaxed/simple;
	bh=6gt4mIuCNglYV0gvoInF8PrydGqnKI1b7UtZkcogXVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l39PTSVX5gTyCBAAxONhuf6nQLtrpjZe4dc6AiKukbGTlmDWTP3qC4rkFfZeSpudOY2C7Ia6wsXQaeldH+cn1oop93JGB6NnMGb9Vk9ua5JC6fhZ/qSpATAP4Bqhc6DUFHd9K6XT2KE43f6n1Bo8a/lnbP2FcgMAbNrRpLufWT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kupUsVVO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kupUsVVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4446C2BC87;
	Fri, 27 Mar 2026 14:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774622126;
	bh=6gt4mIuCNglYV0gvoInF8PrydGqnKI1b7UtZkcogXVo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kupUsVVOuamVESFiTbFVHu47X77bTrkAqGAZdgMHV6gf0n5DFVjXomGwlMch+SS5O
	 Sgx4sVrbhFl8/gwmTETGvRMymRno5ZRFB/x/lg15gLnhxnitdX4anFY7h+SanhQkjZ
	 TfaBrPNXJtIZH/BP68vKd2RgNCCFZVQMhQXSNnoTbG2cUIPR1Ga8yNM5wm1/hK7Wf3
	 bSuOzifLt/iImBIRTPou2kfK8QJsTbr696Pf7LD3/z3b+q1l8dTPSL9lQC3cuGsyW+
	 e8bVTEBLcR1J/Ij2i2TKyclMg6EBGxonAWV2Nc7qhgYoXnRasLzLfrgO9wulnljwZU
	 qCn9jfjS3EZbQ==
Message-ID: <4795774a-9888-482e-aa8a-472809aee47b@kernel.org>
Date: Fri, 27 Mar 2026 07:35:19 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: refactor blkdev_zone_mgmt_ioctl
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20260327090032.3722065-1-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260327090032.3722065-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/03/27 2:00, Christoph Hellwig wrote:
> Split the zone reset case into a separate helper so that the conditional
> locking goes away.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
