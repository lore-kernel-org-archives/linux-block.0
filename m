Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3581D1946C
	for <linux-block@vger.kernel.org>; Wed, 14 Feb 2024 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910177; cv=none; b=eWbGKN20fW4iVDbU1J7P1znob0TEJWiv+pVfMCGi3EALFMgnQKg2QkxqdAB+u9u4ODwanzRrpm+3IHkRGz2mG0MMU8CeefISn4Ij2JV0uWlZ3S0RG1BsW6dNTHggO50FhNRLMHtvE3OLGib0QwRlRyA4vamH+LFX4oSDIZiJJ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910177; c=relaxed/simple;
	bh=qorJ2faBobJZxD7xFFq7reEJL0r1JNE7FwfezvL3u/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezqcR45IfvV1VzhWxObWLYH8CzYntRiA96thUip4fze9FA+9a+O7VOVuhXvdz/n6U9rsBN+4rVumsMKkjfccA2IMBrn4n2zd0mvjR1WXGgbdJLuC1s+muGvRskUL9Vs8R0m5k/NWSM/5siTkyGnVHGZbz+6Qvwoc3sVw/8o4EnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jB8K+yMa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB8K+yMa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B882CC433F1;
	Wed, 14 Feb 2024 11:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707910176;
	bh=qorJ2faBobJZxD7xFFq7reEJL0r1JNE7FwfezvL3u/Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jB8K+yMa5h3v2DC/stZZdIsv5DtNjLFrZj/r7lF5X7yz3ILIeuoCTgXMvs+AyF4nk
	 vxIIJ7OD2VvMyeQWmgrJbxTHeiV60+O+QI6DZnMi+aYWT/atRJbe7NSiVcIoWXxaux
	 xP96ACQ4PYjw4hTB/2VE+elqAC4mROsI3XfbFhHfBpzI656fkSa/k3HlzaoRF4q1mT
	 Ejyobt2QMXdg1Z78ENpIHiAQ7G1sqVdF5xW3k7iGrZddtX5VSoUD8iEuld5N9USXkI
	 ksYSoC10k0v6VFdWdk7K8W0+tGIuInDGUSVuj6wYloDly7pE33dgU70Z5rc4qwkEMJ
	 U94ZHieI8CTZA==
Message-ID: <ded648ac-6747-4226-a0f3-8de4c1a67792@kernel.org>
Date: Wed, 14 Feb 2024 20:29:34 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] null_blk: refactor tag_set setup
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20240214095501.1883819-1-hch@lst.de>
 <20240214095501.1883819-4-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240214095501.1883819-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/24 18:54, Christoph Hellwig wrote:
> Move the tagset initialization out of null_add_dev into a new
> null_setup_tagset helper, and move the shared vs local differences
> out of null_init_tag_set into the callers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

