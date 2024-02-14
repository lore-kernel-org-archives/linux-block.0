Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816A118633
	for <linux-block@vger.kernel.org>; Wed, 14 Feb 2024 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910015; cv=none; b=CIf96Fc/Clso7H1QHpX2vELtiuS5b7qQwwn4QETIW98bMmtbquisU/Uc7qyaRNm20yAuyPuH8eNVFrB98lvqhGDEk7nGnhnsqCuZ16z3dInq35iW/vhkt+w51KlhCiDnGxegEGTSfijrMPXzqzLuTSv16xHwOKQ5AhYjwpk9Xes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910015; c=relaxed/simple;
	bh=FGqSmwr/xZzdEidc2ugLvnSPrmPEarKodxHQZ8fpABE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXa7W3lt1Ic1xzG4QLdS5pYePGTX+wMDv9LpUdb51HywAnw2qKnJTpqYiNMal+dcNfU3ebaJfzyren6cwjIe/5cXyD5gC5JZK+cg064Q+gIQbrKqTTPYveQz8xdIg0ElqBjBOghg1+vZc1Kn4ZcFwQQ6sxm4LfEC6Q+ad/h+/6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1lLxxB9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1lLxxB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40523C433F1;
	Wed, 14 Feb 2024 11:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707910014;
	bh=FGqSmwr/xZzdEidc2ugLvnSPrmPEarKodxHQZ8fpABE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b1lLxxB9vamVA6gHTebJouTzxF+ClIafOd63TbEJyjsOTfN3SqZ/11RrqdR0B/ndB
	 fJmtMzppaDSeQY6Ce1P+nYsqa81IDnejzFCG5PAihE+Bg/lwLe7+b1hJYUYLWH1+y3
	 SQfUNbEecvvklhntaTKqa4RPgBvgwSCLJpilYciQNWxPFaaMcD7lEa5ZHwvgboxwAo
	 GopCesDFAghXZc4umDm50yjRQ9mp39sYr5eASE/lR4KtFGaADMcI9eUj+/hA5Gr6JV
	 T4gkY0o8kwqxAkqEMJqy+Jj+6hhg3jtMYSevU/qMrycRvDB7ubchHDJLuQE67jluGJ
	 tXTZ7JP9SnYEA==
Message-ID: <f600ea47-4a98-41f8-84bb-1689377d49e5@kernel.org>
Date: Wed, 14 Feb 2024 20:26:53 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] null_blk: initialize the tag_set timeout in
 null_init_tag_set
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20240214095501.1883819-1-hch@lst.de>
 <20240214095501.1883819-3-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240214095501.1883819-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/24 18:54, Christoph Hellwig wrote:
> Otherwise it will be reset to the always same value when initializing a
> device using the shared tag_set.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

