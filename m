Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21102356CE
	for <linux-block@vger.kernel.org>; Tue, 17 Jun 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750181630; cv=none; b=Ospy07aQDjp9KKzEqaLZesKkDiKx36D217hLLfCmz6hNEaBMMJrUqzSwShA22OhoNvg3w1fpFqeKbb0bMGNUfD4tRmAyFTldq0qavVbT54Tzkk0zNYByU397KMSHQD3+GRverYo6DNWekwg4RsAePmnA4DrcngNxTMpfwWf0SZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750181630; c=relaxed/simple;
	bh=Zp21o8ResSkQXCqervR5Dp0pKb5AqFj/c5jJefTfVOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dq/YPb7HnRi3C6ue4TY0fTltB9qbXnHYY12BufN3yYzOzJdvOvRZUnvhEnlGXyXXyxmo+JJtf6vnTMrp8kfnPwofI8TbyobnOfun/d3mLG9SIeM0kt1NPA4Gp/wIzQbhZfU1u1phNoyQosYGmDsNyjwOHFH7ZXfPQbbhk3BIiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVR+pYe+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVR+pYe+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0F0C4CEE3;
	Tue, 17 Jun 2025 17:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750181630;
	bh=Zp21o8ResSkQXCqervR5Dp0pKb5AqFj/c5jJefTfVOk=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IVR+pYe+nAtQrorraWGMsmGCwN3EmEtpyU5blxkJwzQ9qmnLnlGJOPEe7lthmh6eY
	 bHN1omymjyDtrxoaOvvRjtl29KhL48hkB9KmKEFRptZHZkV/YbzJpZaH87+aelD7Pm
	 pdoywMvk4TCZY1cxE5Z2zic71JOKu2XZVUIFIDfirggYH2F73gwvKOWta9Efq8xg3d
	 g+yiaiYIYE1TFxp10i2uJ7kEkLeOveY3yfd5Slny2//LUyHB/jYaGj8dUKkvanOUak
	 s89bKrGDEPCiBwtAgdHRIcBP37DiXp+UidTvi5+PzUaM5CA8oSxVQw4k3md8uW/5Z8
	 0b7vQ5t9iaVNQ==
Message-ID: <500dedd7-4e66-49d2-8c63-91d6a07f2e43@kernel.org>
Date: Tue, 17 Jun 2025 19:33:46 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Leon Romanovsky <leon@kernel.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Logan Gunthorpe
 <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-8-hch@lst.de>
 <5c4f1a7f-b56f-4a97-a32e-fa2ded52922a@kernel.org>
 <20250612050256.GH12863@lst.de>
 <4af8a37c-68ca-4098-8572-27e4b8b35649@kernel.org>
 <20250616113355.GA21945@lst.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250616113355.GA21945@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/06/2025 13.33, Christoph Hellwig wrote:
> On Mon, Jun 16, 2025 at 09:41:15AM +0200, Daniel Gomez wrote:
>> Also, if host segments are between 4k and 16k, PRPs would be able to support it
>> but this limit prevents that use case. I guess the question is if you see any
>> blocker to enable this path?
> 
> Well, if you think it's worth it give it a spin on a wide variety of
> hardware.

I'm not sure if I understand this. Can you clarify why hardware evaluation would
be required? What exactly?
