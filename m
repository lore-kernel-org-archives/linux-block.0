Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F8A25D546
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752621628; cv=none; b=ZHaWllU3ywIwnij+vltPyxgE+oYEsEdDUYv6GtAvyw1ujuAMZPFQS7qhOueXDFuFan/y+a9Cb0gSoIXFZbShyQqnGIu3wdgc/wF1nm9QB2FPVIIiQMBrGw8f1zvdsdexe8mbVlJE+OEr5G/8sBKHld2CEiwwfwNc2BcpulBD37g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752621628; c=relaxed/simple;
	bh=qy2cjWbHWJM6kU0GX6ykV281K4zXtU1P/chwouTryTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYYA+QBBKyERphvbaENgmqgs4INsEz+BSmSGBs/vKoce8FAaETJ+6bYg3zywvmT0OvHujCt67RzwCC2M3T1UttOaY/FS/vCAtyFhg8DRRY30S/OWXw/1VslAZBNEOg+6D5QwTS7DHWoGFU9QvI77DrrACBTzOipKOBTkZYDUsVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qM9b+ndd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qM9b+ndd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AEFC4CEE3;
	Tue, 15 Jul 2025 23:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752621628;
	bh=qy2cjWbHWJM6kU0GX6ykV281K4zXtU1P/chwouTryTE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qM9b+nddFeKahG3WkmDGiD8K3KLuRqFchQRdD7k2mn54C/9XEtwDEgbE7rfCVAykw
	 Y6/10dxF6S1xes2j9GD9zS11Psy1wJTo6+XMsnz5c59scxDnBd7PXmhtcVCmW25N2t
	 nktC1oTuHAN2TqKDdCVpoKKfU0WLbxdWaKa7dux2rYFL2CZ33nAN4aDJBrEGgF6+ey
	 KxgkXdK9JQVGtCTxNqXHe7LS1s8lKxRxGtKClMxabk62ZoMnLGqAcDxnMtWmt7kpGh
	 TKVQ8KIeL9LSI8yZUGAxazE1yP8OEr0hEQXf1YcAUtW0E2axaXAxV9FcWzzR47mfcu
	 lP3OnddxTk7Eg==
Message-ID: <e4eaa5b9-8133-4776-a3b4-bc134fd2f1fc@kernel.org>
Date: Wed, 16 Jul 2025 08:20:26 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] block, tracing: Remove superfluous casts
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <20250715165249.1024639-1-bvanassche@acm.org>
 <20250715165249.1024639-6-bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250715165249.1024639-6-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/25 01:52, Bart Van Assche wrote:
> sector_t is a synonym for u64 and all architectures define u64 as unsigned
> long long. Hence, it is not necessary to cast type sector_t to unsigned
> long long. Remove the superfluous casts to improve compile-time type checking.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
