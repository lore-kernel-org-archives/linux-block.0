Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D7215E97
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 06:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765780015; cv=none; b=P8nyZvoJey/N02xfR7qag+TXzO4V7kMQywu5LU2ZEUhfW2Il2mGjnHjERcmZ/jbRMsA1Tplh6fnmAd+hgqox5/Ln5/mwRIewgXxQ6sF6ISs6BZgSQmf/r2vyQF/Lxeugbsfj5ROXegL0JAlcfFNs09uTlXaScVIPfBT8LxkUzeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765780015; c=relaxed/simple;
	bh=ml7ITcR9Z43zca/e9NDCimJbnZmepcQa3r0RufG3i88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sA/oo8eubqEHfrslQGjQxbod/edn+BiWKy72todSqB3+CSsg/CNNPtqvaTEvC+dxbdbpAwA8MLkF6nya+0Q8Q7NNZzO1Qc6no9N4SmdDW5/XWshgCXwb+b6XuCyxgA2P8xOF2bCX9cgus4G7evRghf5yMIAYfnepKeU4M600Nso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9Aji7wC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9Aji7wC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8944C4CEF5;
	Mon, 15 Dec 2025 06:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765780014;
	bh=ml7ITcR9Z43zca/e9NDCimJbnZmepcQa3r0RufG3i88=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z9Aji7wCZ5yhyx1IYUqZ6deyLDxnS60F+rbvkg42BBS7S23EhaGA8ponL2TPnGbDU
	 eAOhmywSqjOcB+LTM22uy43jf08DDuTHMeZSKbyqTPc1VTyJyB40XgFcwhHSAo9p9s
	 MCjaC4CscLVeH1Bz87bWE5PLXqSg5utpwrfO1VLg2QQ0lo7S7XtJxTLRHKbz8UioFL
	 XNnL5c6HlnjmuBWxjY4k6GmkR+PWss8VkwjE/GsZ6OGCnyA5FuZA0lP3rPB7YHHJid
	 Lwn1A/1yPjOmZrnPZ+RcWUgyaWmgcVn0xpm8qKhbkXhbsSc7WxbxDQ0Fo0AzLYw7zT
	 netJa4Hml/7Kw==
Message-ID: <1c1dfa90-74a1-4120-b502-e666c9bcb5a5@kernel.org>
Date: Mon, 15 Dec 2025 15:26:52 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] zloop: ensure atomicity of state checks in
 zloop_queue_rq
To: Christoph Hellwig <hch@lst.de>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <yangyongpeng.storage@outlook.com>
References: <20251213134545.207014-3-yangyongpeng.storage@gmail.com>
 <20251215053153.GA30599@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251215053153.GA30599@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/25 14:31, Christoph Hellwig wrote:
> On Sat, Dec 13, 2025 at 09:45:46PM +0800, Yongpeng Yang wrote:
>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>
>> The state check of zlo->state in zloop_queue_rq() fails to guarantee
>> atomicity. This patch changes zlo->state to an atomic_t type variable,
>> avoiding the use of the zloop_ctl_mutex lock for protection.
> 
> Err, no.  atomic_t for states is rarely a good idea.  And unless I'm
> missing something this state check is just an optimization, so a
> data_race() should be enough.  Either way this should probably first
> be done and discussed for the loop code that has a lot more reviewers
> and then ported to zloop.

Moving the check to zloop_cmd_workfn() or zloop_handle_cmd() and simply taking
the mutex is another simple solution.

Dropping completely the check is also OK I think since the device will never go
away under us as long as there are in-flight BIOs anyway. And this is only an
optimization to speedup device teardown.


-- 
Damien Le Moal
Western Digital Research
