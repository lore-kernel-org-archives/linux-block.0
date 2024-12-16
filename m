Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B2420629F
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372518; cv=none; b=UPpUlwzQp/x4WspYMuhI8VB2gZClr9EcnRfI/H8GGSiG3ilqzjw4ga89f79AQXtjKC6mspVxR+vnGF4ULtyE8FDQgtYh8qytyZrR+w0h7FI5BMtTp5t16f6icvNF6inP2B0Nbax01Tv43LNiXt2UtXQgDjzoZqi1ps+OMDnTgDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372518; c=relaxed/simple;
	bh=L1KYahfg7s0u3hnWbyUAoHDTwqQyvl3ZELjQYmuKc0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSad7+pGUPw7c1Bxh+6g/p+k6nNqBUW+QsEmG/2XyFSjyCCW0uFaKTDPqOm84ZN38kYjuxyKm9zYtnEr+jeUjYyhb+tbZqwTEjIA1jJqrh6CFrS0onUDbPT1EuJQYPP1FEf9ednEpm/8RqKILN5tL03+n2jeXoxG0eyVtzWICO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVL2nHHo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVL2nHHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC78C4CED0;
	Mon, 16 Dec 2024 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734372517;
	bh=L1KYahfg7s0u3hnWbyUAoHDTwqQyvl3ZELjQYmuKc0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qVL2nHHo9uwhOIY2JKR/1ePZA0inqBFatTHn0hM7DC6uPl8VvsKArujAgIe01zmoe
	 sVAsckvuKE7VRgiHVXbe3Dz+JVE8PS+sezmtUcD9SKZeVPFA9+HRd3WRtzxqF5tCV5
	 TwaYQqZCNso3H1egZJor8txjSoq2kbAftGybdYTrfwKRprSyXv/5PkW4vdBW82TC+2
	 RNuWqSr/snoBqGdkGaIe0sg5ygHx+bOmyDp8qfSuwQ+XYBsWSOGpDkJuKDQwqK2cbm
	 xZYNAF5s7w9S+iwWozKje4VyB4FgPaDdG6u70lsVsEEvc12t6bN0y+BsEMukhgtPdz
	 y1hez8/87bvkA==
Message-ID: <039352ff-68a7-4ad8-8430-99061e46317e@kernel.org>
Date: Mon, 16 Dec 2024 10:08:36 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: Remove accesses to page->index
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20241216160849.31739-1-willy@infradead.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20241216160849.31739-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/16 8:08, Matthew Wilcox (Oracle) wrote:
> Use page->private to store the index instead of page->index.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
