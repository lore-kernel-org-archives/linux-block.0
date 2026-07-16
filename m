Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB4740A959;
	Thu, 16 Jul 2026 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201504; cv=none; b=lAKEbAWiES4VgylbcOotO7WP3qLHM968nrRdyOQ3NKJUm55w1DOA8OoSF+BXS/57FWNX71Rnd3+eAD/D8ZTLo5y7qe6IPyyUzkoecZdOfztzB+w8/SdwddLNDYZAfvwJl4ECIv4tP0iUMtzlizAkIsNC1h0fB2NpMWK9h/ypBwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201504; c=relaxed/simple;
	bh=LHRiwVQCRzgKuoOkruEDIDs11g37o0SAeGHE8VL1Eac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKbsw1FMRxBYU8NoLJuHOzBzZ9TxDuVV9ltv3u1MHlbnkvHm+40UdtfBeDDhWT3u6ol8mIQF0Yo8YFHpdx4mAgGh9FnqeOHlBZ9UIOgi6eQbNvZzoecrq182RwAl6Z+PI2+few/mNsr8YD5aFpGPJvpoIRF9wipNVndsq/jFtPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtVZV5+0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtVZV5+0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD3D1F000E9;
	Thu, 16 Jul 2026 11:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784201503;
	bh=q7UXUms6KloG0M77C4Te6rnX4p7ySICMzlut7eIb6I4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RtVZV5+03iuS0nnRTPYvlZR6tsmKe7z1OnLgF163ggqjNqxkHLOKHno8b3zWXuyXm
	 b3jdRH6NvLPFl0AIO/ouXEZ8pHpb/58eaOZBJWF2dUTZuwK7QVxM/kSbFBJo/yAHXd
	 rIpNp22AqPZhFo0IxWEl1tKa9jSxwkmAd/j5dv7d2fqs2qUfuVvN0G7Wj0+jFBslNe
	 7gopLq5uXUQIY0IfjJW5F1CJE2WDVw4tQLdhNRPYXdK9ftJaVPztuAf5yfqp5x2S5S
	 iMPY9SgQK55D4fIMckV20oUyBtoyVHIcPMT0b3o1ueKT0CKinZYeycE7Q7k4gmTcnw
	 zX5QPFT0ZKzQA==
Message-ID: <3cd929fa-f410-440b-bbea-572027d25fae@kernel.org>
Date: Thu, 16 Jul 2026 20:31:40 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] block: implement async io_uring zone reset all
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org
References: <20260716091838.318082-1-hch@lst.de>
 <20260716091838.318082-7-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260716091838.318082-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 18:17, Christoph Hellwig wrote:
> Add a new BLOCK_URING_CMD_ZONE_RESET_ALL uring cmd to reset all zones
> for a given block device.  This can be used by storage systems or
> file system mkfs tools to initialize multiple devices in parallel.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
