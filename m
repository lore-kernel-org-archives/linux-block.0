Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE72B3D5648
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983508; cv=none; b=AjbevmJvuMcyojoCnzh7kZgt6EjoxVqWguqpe3uxQmIMXKxHqDhMsczh7FSP31QCjeG9ovGyNbjH2hu23krGQP717B6UaEC8LnAhZc9gIS490H80P7jSh6LdzHThDrDYLkz07j2ZhH4fbsYpK7qTasdDJbVt/urrBDC6uVL/2RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983508; c=relaxed/simple;
	bh=tu4m9MlWesRuSRXlBeURB4PAHLSdi/y3uQLg2G5OUx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkRhltkd9bKnAZ1WZi4ZI1dXpJvj3F+d9LdDnAlbjLtWUK24cIK6bKxMBRVn7mXTDXeXPEPfWYTB4j2eBr8BznWsAsoK8Y31l9h5vkMPH7eIZKEQNK8c7Vk56f64u1lp2j65mLlmiFT2r8u9AgSWBBOu5SD6AwwPO4QDmS8mhkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwIT6XHG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwIT6XHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D431A1F000FF;
	Wed,  9 Sep 2026 19:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788983505;
	bh=pCS/AAUGEG/Z2FwvFf5IZTi2Ov195XLa3ROw+NarEqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZwIT6XHGsXhT9iigkewO9MoAKhab19x7R3yYmV+3SJqpI6d1Ju8Mk24y/cub5JLbK
	 ogk8UjQyDzcQmfAB2B7gKSjBKJMVn807mHGPMJhY32Pqs9urq045yBImVTWaBEwV3m
	 Un0GbrFf11HFqepbeGZs5wy/SVRiwlzN0BUzLZsvO2MDVNH/XKWSqgNeGqHIbCshLx
	 DzqhFmDlrdmmFrIHRhR/wXTERSsj+inVV0BHBKQVB7oIltnfjXekx5/6gEdR5xMPBZ
	 re5fct0GaDbXUle4gL8WgakmNwUJorpjhi1Z0hzgR5JCH9JjAP4ahlbhyCrOlKs7j2
	 wmxOSmPM5v9rg==
Date: Wed, 9 Sep 2026 13:51:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maks <mi9992828@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: block: zero logical block size leads to infinite loop in
 set_init_blocksize()
Message-ID: <aqG4zwW0r8jGuBPE@kbusch-mbp>
References: <apm0q8sNDooT53jU@kbusch-mbp>
 <20260909191107.53134-1-mi9992828@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909191107.53134-1-mi9992828@gmail.com>

On Wed, Sep 09, 2026 at 10:11:07PM +0300, Maks wrote:
> Hi,
> 
> > How did you manage to get a block_device created, but bypassed the check
> > and override for a zero logical block size in blk_validate_limits()? Is
> > your driver writing over the limits outside the API's update path?
> 
> Yes, it does update the queue limits directly:
> 
>     volume->queue->limits = limits;
> 
> There is no blk_validate_limits() call on this path, so this bypasses the
> normal queue limits validation.
> 
> Given that the driver is clearly bypassing the normal queue limits
> validation, would a defensive check in set_init_blocksize() still be
> considered worthwhile to avoid the infinite loop in this case?

There's just a lot more places than set_init_blocksize() that assumes
bdev_logical_block_size() returns a validated value. If you've a driver
bypassing the API's that manage this field, then there's many other
functions that also won't work correctly. 
