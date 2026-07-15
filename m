Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B590D3C553B
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103991; cv=none; b=sSUkxP1tTxmMbhWrDq8xivfcn0MkdpEgiBIrhO+Vwb4KWXAS39bm14InL0Lg0gljHBF0a2Kx02q76Cz6ki6ukPL5ikf33bZ09zCjZ7AMksPMYH/I5llk+O0LGP5kg5XUDxgzirB0UnelJqKH9quEDFa1FIZN4mrFhfWksAR83U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103991; c=relaxed/simple;
	bh=uoSYTWKnyLl9lQRqnnVBIuHGO2s3Wd2JzJfEhH1KYjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r96kkfKilDW9RngewcKG9YeSLqUt3dCYdnttymrzQCF4+LUJC0RamXarQwMpdiFpvw/20qleIijv6hvPef4zOiyxZVyYRMUvIbDUz2ZW9tjviOI7l1lBSpdbymr3nwZ1+fUizYHrsfwYPNqZeRTLJQci/9Cv/0JyDBQbtA4aGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiNeOAbP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiNeOAbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29311F000E9;
	Wed, 15 Jul 2026 08:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784103990;
	bh=TC1jYvsI/erlZoNf7WcRgNZkScJS3/ot0aaO8Gml36c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fiNeOAbPm09X8VrBwt8tAbIu2l8n42dWds4gFuJfNEtRuZaLl0CPXejEX9f2r9Ed/
	 TB3u5tlci1I2b9/a6Hlx4/ndp1B9YEQGmCFMUmqJtY5rySPWoQWQv5BdLjd58nZFKu
	 RNUNZT4cnvG/jB5/dnRAxLu+wdwmraYMbyJmn3e0w6SpHKVRH5sRJXfR6626CwjEoR
	 Ugw19Sl9UXjEIYF1zPz8H3Af6JuxbWqSBXFDjEe3K68cjP2fxeMHGoHknYZzH45VZI
	 yVDBjZHkZs9dCyLQAFu9rnUU1OHgYRVXCeo1QCes814BdnBLqNODO+5u2c/xdvLNUJ
	 Kifv3EZvTgHZQ==
Message-ID: <3eff5b2f-f635-4422-b55f-04d06434d149@kernel.org>
Date: Wed, 15 Jul 2026 17:26:18 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: implement async io_uring zone reset all
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20260715063734.2933511-1-hch@lst.de>
 <20260715063734.2933511-3-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260715063734.2933511-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/26 15:37, Christoph Hellwig wrote:
> Add a new BLOCK_URING_CMD_ZONE_RESET_ALL uring cmd to reset all zones
> for a given block device.  This can be used by storage systems or
> file system mkfs tools to initialize multiple devices in parallel.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
