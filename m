Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7328D17C
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 05:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736142496; cv=none; b=J7p6Y0gJdKqoEsmk3Ftc1P13oilZPcJp1QG/HNF0Eg3rcFkYVsBTvHJ9YjWv3rgZxTSjyD+0Z+vPnWFnbiRiMr+s0PHKgve5riEfRyF9SX12vmQGvAVfGSkc9XqbH/NY6AVyeTgkUt9iiedvnsUMWO29ogt8YwM2CmywbSVTdQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736142496; c=relaxed/simple;
	bh=a6wyxo78lJkkF0tq1kCPArQP3Ts2PBAd9lkiuQgmYq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oa4Lz4ji30PD0YW86NOVAjpkia0NaNq/Ma16bUXw0DP8MLBUuEeaFnn6DNbVwJrKQrRSG8S7B69lQqnmJsVt2jfrVW8KMpAYEP7XdWAbzg4QAlwUZnJImE7cBgGjDFmQKH2SqPIOQYK9HJoWK+1yqI4YhE94UYa21pdvRnFWOUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rypOU+Qc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rypOU+Qc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63648C4CED2;
	Mon,  6 Jan 2025 05:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736142496;
	bh=a6wyxo78lJkkF0tq1kCPArQP3Ts2PBAd9lkiuQgmYq0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rypOU+Qc7rZis9098jrn1k8uSbkMX+oROgioKBiRnLvLenJh2wVLYs7NQ6DRnUz9t
	 Bzu6Tec8vZgaGFo7LXqhotBUb3UhmR8JIr1exa6ko0XQXNJWsHTnfjmQ4MFycyr+VI
	 sxpBbLJvdrRFtoE+/GQd/e0NTu/x6L7h9tSKVvYlxuB/ljO4L4zaMHb6BYD9YvCEO+
	 YKTYpTB8UdYtXQu5XytXKvV7B5mjKwH2QKbnVDLv7+xAuHrT5jVkfw+gNsb/2dFn9k
	 sMrcTeCddctLQ4SpQmmQ1Dqxwxfw/czccAAFI4F9be2pO92Tr4mKgJtrYNQur52qt1
	 sBOuNgeUkARTQ==
Message-ID: <96ef93cd-4555-4fd8-a1fd-8016573f4162@kernel.org>
Date: Mon, 6 Jan 2025 14:47:31 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v2 2/4] null_blk: do partial IO for bad blocks
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
References: <20241225100949.930897-1-shinichiro.kawasaki@wdc.com>
 <20241225100949.930897-3-shinichiro.kawasaki@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241225100949.930897-3-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/25/24 7:09 PM, Shin'ichiro Kawasaki wrote:
> The current null_blk implementation checks if any bad blocks exist in
> the target blocks of each IO. If so, the IO fails and data is not
> transferred for all of the IO target blocks. However, when real storage
> devices have bad blocks, the devices may transfer data partially up to
> the first bad blocks. Especially, when the IO is a write operation, such
> partial IO leaves partially written data on the device.
> 
> To simulate such partial IO using null_blk, perform the data transfer
> from the IO start block to the block just before the first bad block.
> Introduce __null_handle_rq() to support partial data transfer. Modify
> null_handle_badblocks() to calculate the size of the partial data
> transfer and call __null_handle_rq().

We should have an option to control this behavior to be able to mimic actual
devices. E.g. SAS devices may do partial data transfers before hitting a bad
block, but ATA devices will not (it is always all or nothing with ATA). The
current default corresponds to an ATA drive behavior and this change allows
emulating a SAS drive behavior. So let's control this with an option.



-- 
Damien Le Moal
Western Digital Research
