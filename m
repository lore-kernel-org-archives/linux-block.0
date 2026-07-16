Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891341A907;
	Thu, 16 Jul 2026 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201434; cv=none; b=KNWrSMpsLIfMfqnH0Wzpa8c1n4CARSAq8iiYl2pJXd5ACcQdys+CuREBsq5ouOaVFtRL0zSIMMBhkYw1kGHqxgbXSlRv408XVMtXs6Wz+Kc/W3waXyO53xJcuCVZZGJEB5LoyJjEinTkmML69en8lutanBZFvAdp19LkfoyX3aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201434; c=relaxed/simple;
	bh=h+hdFB285YT+6bAFIr/Glwc2f8uDmj1XmdRHpmTT9vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FaBLJXeza+kxfh6YOGKG5Bd87+WaVuGgWjkBhQo+7uYO2898fEJ9gXf/4EE19Mt7MhUMyfoZBAXP3QZRnqUO/nUV9Q6xPwCrSxJLgNerXp7ilqyWGy3hmXNHjW4nKWLlGFUpDX3MJEHoBdHo5c86CIREHbwpQ3LZ4XdT2nO1fds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH4fdZ74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kH4fdZ74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18C91F000E9;
	Thu, 16 Jul 2026 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784201424;
	bh=Twzbmu8qp/l0UZnjoRNGCaH20/ljpVEp4099tQzxxOU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kH4fdZ74Tqf/5oAcFYaGiuMVZv9ei93YWCF1cBnvhtxgYVZ8ae6YyCXl/MzZpKGzt
	 Wx29ADywTKxrfFVNgdqIsNL7aBc2uViZ/xfE5bcy8yjRlKm0D6l+Bf1eqPv9UWcrgH
	 kKsJ34eh/VbNlf1RK3s2MD1XSUan67hXmKlJ/FD2FijTPTfqstiYng1wERr0cGATEW
	 1MAvEisNk75cqipOAgGTy5xd10Fa21unxnCv34gK1Fh9SdoSXTxH4RnIv69hU4aLOy
	 IWIW4zJJlBFQ4mWA7ykogPYOfVs3yejyehn0Oim2DttH+9MoN23alKDxkkXWdDBiO7
	 oCbVcicz9MgqQ==
Message-ID: <ab4dbd1d-cfaf-4293-a136-80999cf45598@kernel.org>
Date: Thu, 16 Jul 2026 20:30:22 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] block: remove most blkdev_cmd_discard arguments
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org
References: <20260716091838.318082-1-hch@lst.de>
 <20260716091838.318082-6-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260716091838.318082-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 18:17, Christoph Hellwig wrote:
> All other arguments can be derived from cmd, so do that to simplify the
> calling convention.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
