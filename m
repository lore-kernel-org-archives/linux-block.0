Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA13149C7B;
	Sat, 30 May 2026 21:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780175718; cv=none; b=LyfHRP8KK3Vq10PDjizg7Lve2cOpccim1SIKH6WJgM9Dsaz7prG4PCQ8LvzSH00Q4t+Lg+w6IKaD0PK24tPaNlJBjpbukMF7tRSOJLhbfyBo9np3sSedvSk5Uv96doUZz/t+PYziThJhsfuNybxlATDE9XAsIkFZa9FE/pcKyh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780175718; c=relaxed/simple;
	bh=iNFe8impGfoXJI/kAgj2fXANAxAe+VzLZrwQW69Of/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvYkA+j04UQ2TpmR/HgJKBL/eUy+feHT9YJ3M1eBTVCT9D19J8LOLc8gfXaOwEBAW1nqi3x1c5UCLxV/yzLs8x48G8KtbW0GcUYh/ysihfQPwIztf/zhi+NKL3w3HrwFZmOX1wD8ermSwIYCr9InHyF1csIlHPV2csbkEgr34kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=h8ajhG6p; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="h8ajhG6p"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gSY0N2j1Rz1XM31H;
	Sat, 30 May 2026 21:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780175711; x=1782767712; bh=IRwHpRUYnA+YScRrUns+KOGi
	IP9qM0C02GB3no9j6To=; b=h8ajhG6pzsFYMkY+T20P2R30kWYT290kA5rCMYw8
	bD/hRlHeMZ2gT0XsqsfcNE/fyrxf3pmdSf3M2siM13lUvw3UrY85DXy14m+vLS7a
	utK/s8cLX5Iz5iD55hG13E8XJYIcgtXsUoFjTxvwCgLYJdTs5u7yjrVIivCeuHGM
	30QY5Zia/QziWeHSq0UquXLkegg1CoriMeNmSZoo5qdcM9E+FWrkG93hi7v2WNlR
	rjzPezIO25bfv0FgPn6HU/dhhDrxEifSfLG7rafmShuFk5JgOXQx/DNxmskbbDzU
	rX2kHdvn0vO12C7SJJOmxTKEssSZ2BCBgPTvAJlMSdFi8g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id pTDWQqUyw3KY; Sat, 30 May 2026 21:15:11 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gSY0C5n9lz1XM5jn;
	Sat, 30 May 2026 21:15:07 +0000 (UTC)
Message-ID: <4cf7ecc7-932c-4589-9d0f-3e025e83e27c@acm.org>
Date: Sat, 30 May 2026 14:15:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: assign caller-specific lockdep class to
 disk->open_mutex
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Ming Lei <tom.leiming@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>,
 Hillf Danton <hdanton@sina.com>
References: <147ed056-03d9-4214-b925-0f10fc00cf27@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <147ed056-03d9-4214-b925-0f10fc00cf27@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/26 6:45 AM, Tetsuo Handa wrote:
> -	static struct lock_class_key __key;				\
> +	static struct lock_class_key __key[2];				\
The two elements of this array have different roles. From the point of
view of code readability and maintainability it's probably much better
to make this a struct with two named members rather than a two-element
array.

Thanks,

Bart.
