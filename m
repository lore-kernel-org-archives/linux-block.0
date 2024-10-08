Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232713AA3E
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 05:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728364504; cv=none; b=N8P33uZS8Ewz0PR7lJXNVioVAw7dYXSgTOBXeoU0F4LwQU5tDEMkEWIUkYtPEzhYC7MbzfmNXgNHDsU95QnI9pCf8NVsNhFh9BenVWij3fj4GOQrXpuMT6ReTPMD9JYdWxSeqI01qlmTXSPdLxbr3DfH399nNCXz9iTUt2zXaT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728364504; c=relaxed/simple;
	bh=VXhFX9hOwQqccTa+4AnN904Jho5KPr6bOmKQVtLfsHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjk7PrV7HAOJgN+JTiP5OlAQgWNDN03OYyuZB22eCCyXbivlT6bmNqLQHFaax/vqgqtRlxfUr2fSoh3NWpK0vEOvFdrdj8KKCwI9Q2Wb049gpQrt8Z/ozBjVREhP9TLFWnPwBI/DnCIEv5YJBLMW4aNKqwtHYNQi293Uix317Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiLqLszY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiLqLszY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759A7C4CEC7;
	Tue,  8 Oct 2024 05:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728364503;
	bh=VXhFX9hOwQqccTa+4AnN904Jho5KPr6bOmKQVtLfsHw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aiLqLszYttG49FUNwH8iMjOfFPz4aZCHDzH0Nv0mH9DdcgTZFtjn03WLlQD6M1+Bd
	 sy9Npm5jdbNiFG1ngTBIpTfOMDnAc+pdz3dRbReCV9h5MB5bYUq6CNhoklET+r44Ij
	 9q2hV5YYggt3rQYmDWhz9iulIDwG+Bx9aVj+lZQ8n9xaQop9Y+lFlYdfHzkV0Wyn0u
	 nCVb6MPl3Tg1YdDZOLWvG3pK0yO6mRh0jGrW6v/FE057uhXjDudLt2eF9kczGQfG0p
	 NrRUQvcGe0Xfj+eBE7ot/LmlP548DALTWNHOS3Vwyv08N7z6xz/tIHJWEgX5C3R0/F
	 WIk6kj2pXCwpQ==
Message-ID: <853a64e9-4247-4d8a-a1d7-f01bdcb3642d@kernel.org>
Date: Tue, 8 Oct 2024 14:15:02 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: return void from the queue_sysfs_entry load_module
 method
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20241008050841.104602-1-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241008050841.104602-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/24 14:08, Christoph Hellwig wrote:
> Requesting a module either succeeds or does nothing, return an error from
> this method does not make sense.
> 
> Also move the load_module after the store method in the struct
> declaration to keep the important show and store methods together.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
