Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1FE2EAE6;
	Wed, 22 Jan 2025 06:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525744; cv=none; b=baV5NAKY9JKenN8d9vxfZN9010imNY9/3N66eQshawmXLGZPVV/On2qapuj5+tlxvhHKo80hh878OKjj2x/Vs+dQ2r0gwazTwH1mgTyqmoYb/y6Nw1fr2VAbqSYIpYEGKEg5GnRCQet10Fi3yBv4dgVZz6avNxYy01hipygXzzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525744; c=relaxed/simple;
	bh=TNvHJMZgHgdHaNFpM4zoT6LsarEJ44kzyCGoCgFz8fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAwkLaHh/VZ6aQUGK7bR+L/lGgXonIovz/CSDPVBNT3ZNYmyRY2k3MA7PkryBURtySgDJYolXN8mrddldyNGi7lZTijMEPLnqLjaNBKPhbvbiGm71J2AGTd2IxxRxaz4tVcPg7bo+oyyJPAPgUplIMl+dhuG4z7EtEnSOsuztlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edW/MqCY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edW/MqCY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA3EC4CEE2;
	Wed, 22 Jan 2025 06:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737525743;
	bh=TNvHJMZgHgdHaNFpM4zoT6LsarEJ44kzyCGoCgFz8fc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=edW/MqCYAZFzOV7NOn5Dy2OZ+vEOwfcchRLaBoc2RdfhBTIYUwanyeBQk62oxB3Og
	 SSWeFun7XeKd04xaGDCg/QFtK22JCZyR4G/pHINpechiU6ME/VTinxSlGNIJR3qA7c
	 7rRpiiarRogaoXYfiVVett0au5voNW/+hl4g5MxA8J02fcU74VOZGJxYnbWtYI1f9i
	 Pk8TYdCPNgonNVw/H3VrpgBk6/c7k5Ob27Bmix6GMuB8CYEJCRnWQrD1SO6dsLI0VF
	 I8K/ZRQgRPh3iWq8upL9O5KGUQ2qZZeKZPDl0Z0Ku/MhYcadCAiCP1z/PVdaTogPSC
	 zGksG6u3pUNUA==
Message-ID: <6b8d974b-58b6-49f7-9101-5fd5c33750d8@kernel.org>
Date: Wed, 22 Jan 2025 15:02:19 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: mtip32xx: Remove unnecessary function calls
To: Philipp Stanner <phasta@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>,
 Li Zetao <lizetao1@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250120162020.67024-3-phasta@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250120162020.67024-3-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/21/25 1:20 AM, Philipp Stanner wrote:
> pcim_iounmap_regions() does not have to be called, because the regions
> are automatically unmapped since they were mapped with managed
> functions. Moreover, that function is deprecated anyways.
> 
> Furthermore, setting the drvdata to NULL is unnecessary in a driver
> remove() function.
> 
> Remove the unnecessary calls.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
