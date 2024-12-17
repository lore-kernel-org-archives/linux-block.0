Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942691F708C
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447377; cv=none; b=jUPLR5tMQkaKBHGuOeiQNvYrcwuV5+Predpx8qm5hyyco3IGCgs4uBHpxQcqCwkSgq13vgBIFblrJrqihJmQktK8iPQVylIzYLrnlHm9R8OBu/bU6OxFWB2fJp1TymmaXMsleEBI/BlgZl6spCwz60M35/zXrI4D7OQjD2ei15w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447377; c=relaxed/simple;
	bh=d8uSYPYg+uB29p8FEL1yPx62TyxQnNT178CLAmROko0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnWDMqXJ9n7+3xdAVzob9CIF/dETDd0qs5QjNTbuZQra6XTQijcMvYNtS47ULB5ugerRfOa+nxJzHCfUvGZLJAlGECFDPLE5sP/5uEuuTx/9VXEhziJz1fCZ7HbqVmfLKJzn60hW1fZskNYAsHuyumC3PQhO2CeNbeTNvLCDdR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4SGu4Bf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4SGu4Bf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4BDC4CEE0;
	Tue, 17 Dec 2024 14:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734447377;
	bh=d8uSYPYg+uB29p8FEL1yPx62TyxQnNT178CLAmROko0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C4SGu4Bft0F5cNPUMniQBZoIa+b9adcoS4OD7ORI8cKGKPlki2isSiYqu9Y6hafV1
	 rlYLQP9LRs3Ls7/O9RDG4Zw6Wp76ow+5K9iXzOuX0Ro3vgErhGK0qGVK+UweQ+Uyg5
	 63pi1vUK2guPTzzxP3iq840JFGLC4hHwnbdXWbAEkwztdZRqypYNGFrx3Rl+o/sDKJ
	 gdXwswbYYnXDrl7Q2e4y3od7QGBavvx5NI9jodaHQzfVz8GprAtxPSGVjkH22kEXv1
	 HBglf9DF3X/7E/pMRnYITviW8SJg2+i6jItdK5QRNUzP/Id1AlfUJVhPiEShYnRQr0
	 k12PmmJftyrXg==
Message-ID: <5534fce5-4fe3-4979-bb04-5cbddf613d0d@kernel.org>
Date: Tue, 17 Dec 2024 06:56:16 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Bart Van Assche <bvanassche@acm.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <ed186d84-1652-4446-8da1-df2ed0d21566@kernel.org>
 <ba8caf98-8b09-4494-add8-31381b04cd33@acm.org>
 <3bc4b958-73ea-47d4-9b94-299db1f7ee3e@kernel.org>
 <955aacae-7dde-41a2-8eb9-3bbeae8c3d18@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <955aacae-7dde-41a2-8eb9-3bbeae8c3d18@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/16 13:22, Bart Van Assche wrote:
> On 12/16/24 12:54 PM, Damien Le Moal wrote:
>> Yes. But I am still confused. Where is the problem ?
> 
> Here: 
> https://lore.kernel.org/linux-block/95ab028e-6cf7-474e-aa33-37ab3bccd078@kernel.org/. 
> In that message another approach is
> suggested than what I described in my previous message.

OK. So you are talking about an issue that potentially can happen *if* you
modify zone write plugging to issue more than one write at a time per zone. This
issue of reordering cannot happen today as there is always at most one write per
zone in-flight.

> UFSHCI 3.0 controllers preserve the command order except if these are in
> a power-saving mode called auto-hibernation (AH8). When leaving that
> mode, commands are submitted in tag order (0..31). The approach
> described above provides an elegant solution for the unaligned write
> errors that can be caused by command reordering when leaving AH8 mode.
> I'm not aware of any other elegant approach to deal with the reordering
> that can be caused by leaving the UFSHCI AH8 mode.

As I said, I do not know enough about UFS to comment on potential solutions as I
do not fully grasp the problem.


-- 
Damien Le Moal
Western Digital Research
