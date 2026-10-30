Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793322670;
	b=2hEiDETdAAbPFAADBbm7sjqJ5+gkFguUaoACyjVYjQCHxmLFZ2NTJ5EyoZNASfIOvd+4
	 MLLMwasvaxDJX5Heq4vkB+j1t0344DWpuLBCd8G0ImdM1npI+MaRNIyDe72+vob/22i/z
	 2qTCqNqtgqKplNZfr0QAde0uo2Fv0NzL4kqx4KcLTpGtDQmaTgDnTtio67vYqm+2enHQ7
	 CmwL0EPupWczZv0Q8MZL80Vfn2qccxGRvqvQE2oVyJgDVzpePbvXz+gU39Y755JAbS7Bi
	 TdleUzoObPqx+ynyXgeYqP+Ttyo1WHUk0od8SM+aQTKW3BoBes9JWxxpwVAueFC0oVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793322670;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=BbrccuzEATnIl27F1SmWJVS73KbzrI6bykqDoONF36c=;
	b=sCTDgcuyw6ElaiDhPI5hPH11a3bOdfPldEwcaFJdHG4TtbbFigx7PbNOhU3sTYzup47p
	 IJv6zZGUCkPhx7OOh5g/S48p+Zi79C1wmoW2eIsCKGckPfoT0YJIc56Zj5X9dENx0I/Ie
	 N7Wgaa7tqkqAFaJT44q830bSlPv5n+kNGsjc2jF4qfrEPJZRzbAdy3pFiT01MIj23SFlW
	 3j98rIWHaaqXxYu3qveeTf7joceIc/oiSkpgLZuRgY0xnLkV/14G13VfRnhIEVtO8NFiD
	 T1YprSyR7QLMZLzbPT3jQYFN94Sx9aZP/B+IT6RJ85eSfm9qpGRQy1ceaIkfCKF7Sag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GvkT0No0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AB7606A31A
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 01:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GvkT0No0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CAE1F00919;
	Fri, 30 Oct 2026 01:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793322669;
	bh=BbrccuzEATnIl27F1SmWJVS73KbzrI6bykqDoONF36c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GvkT0No0YdqTT7U8LBr5MHH8N5MMhjdk/mWmo3Jpp7ic4/jKCtqInB1OEdRndELxw
	 ohlNqZ76KBgPYot3ZtCF8dtPSbefCGj4oKZruKfYs7beVmtBjroTIP7eI81pSS7cRo
	 CV6K/S1F6Vih6zm3ZMH/t6T68zjXK+DzccfwLQo07BSzId9VLelTi4dIUPszcQbEYi
	 bik/YdlXarVbh4LgWbWPA53Qh7PytC0owC1yDV7HgAadDEbfRYRTZMsY3zVk/vPmtB
	 Gfyl08TNGy2Vn4AGvmNjzXMfvn2C+/AKyUx/orLP6GarWbrrSitaMikKvtj/0RQnTw
	 9T4Em0d7r/k7w==
Message-ID: <f7622f59-4b4b-4186-bc42-97bb4a714860@kernel.org>
Date: Fri, 30 Oct 2026 08:11:06 +0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] zloop: remove a duplicate call to
 zloop_get_block_size
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org
References: <20261029150353.2503201-1-hch@lst.de>
 <20261029150353.2503201-2-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261029150353.2503201-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/29 22:03, Christoph Hellwig wrote:
> The sequential zone path has two calls to zloop_get_block_size, one
> conditional on not having a block size, and one unconditionally.
> 
> Remove the latter as the block size only needs to be queried once.
> 
> Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
