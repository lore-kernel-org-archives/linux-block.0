Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D012931D1;
	Fri, 18 Sep 2026 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693199; cv=none; b=K5SsM1j81pdLYEIEflZVl+QkDfA1uPJQutlPWgpClB79dd0nNgZxkRsHw6BCMqyulQFQIccxEISfbrbEtbLJiykoRUJCkejT2lbfBSRb1Jr1yieLTaPcLW6zTkIFUPIa1t0SyjXGoozSa0SVNBZ6CZU6zJylCMi+gtqcu38VITI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693199; c=relaxed/simple;
	bh=2FZBEG782xVVAZ2d7HmCDIYG/FPSFRAviFUgtA8ujR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQHGw8T4geVXJVfR96WIWHUFawAL/P2ySUVfLqcUY2JF6IpIrV3IhMxIe7CqZr5jvngZL48piCOaX3jsH8xZSjjhjX/gUFeyOpGUISKiZiviFy4D0c2u+5J/UilnQRm8DNhkivDSYIDJRByfwSxtNMkZxh1F7n6uB0/SU/uJYh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=gnoRmXfz; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="gnoRmXfz"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hmDmm5FMzzlfvpd;
	Fri, 18 Sep 2026 00:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1789693186; x=1792285187; bh=2FZBEG782xVVAZ2d7HmCDIYG
	/FPSFRAviFUgtA8ujR8=; b=gnoRmXfzRhk2W4lvcNJDalod8OYLo4kT1XyK8GGf
	wdnENtNk6cyOrgyRlEe5dTuKagze4eWJyoNn4IjpdilD7jepAUSe1SBFI90pEC7B
	D25+YCPK80NThF1NBYViXhOPRTY1GR0tdBf32QVQWVp/QD1MZElCwq1uz2ZcjoBo
	rHfZ0hBauvom8itGKAt4qZCvtkWFx8sLU/aC0Hn/xD3ccYF1lWYshKHJWkN2MyHv
	k/aX2inbavbXiTp2BeSGGuqt6jkaAN6bNQIuk382L/hweJZN3fuAqPEqdzrs0IAY
	iqJF14gepaeKWU39d7NhHnV3mxo9NL57Fi5BsYvbQosRHA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id m7ub6BL-3NV9; Fri, 18 Sep 2026 00:59:46 +0000 (UTC)
Received: from [192.168.0.215] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hmDmX5d55zlfvpc;
	Fri, 18 Sep 2026 00:59:40 +0000 (UTC)
Message-ID: <e1ad1d8a-b3ac-4316-9135-41ea250072d4@acm.org>
Date: Thu, 17 Sep 2026 17:59:39 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] loop: Perform __loop_clr_fd() after disk->open_mutex
 is dropped.
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Brian Foster
 <bfoster@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Hillf Danton <hdanton@sina.com>, Markus Elfring <Markus.Elfring@web.de>,
 Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
 linux-block <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Nilay Shroff <nilay@linux.ibm.com>
References: <60bf7af2-b84e-4056-9195-a26ad51ada46@I-love.SAKURA.ne.jp>
 <9f1273a7-6dfe-46bb-966f-fe08876f4375@I-love.SAKURA.ne.jp>
 <3883b05e-0a34-43f7-b2a9-a46d2b0c5ffc@acm.org>
 <08b0057a-280d-4e55-8e94-e510ec1a371f@I-love.SAKURA.ne.jp>
 <d89aa722-2d13-4733-b5c1-f0194bf4b342@acm.org>
 <15037162-0e54-4722-ac7e-c9a863a8a2f7@I-love.SAKURA.ne.jp>
 <b700652d-ed63-444a-b879-ec2725affaa7@acm.org>
 <6fdefda9-c7e4-4368-8d9a-280043b4051e@I-love.SAKURA.ne.jp>
 <e8fd7e8c-4a14-49d6-8bce-16fd44d864b9@acm.org>
 <2dd38a68-4ceb-48d5-953d-7ea2c7122418@I-love.SAKURA.ne.jp>
 <e2eca9dc-09ca-4f7b-9fca-9ad6ce72c9b9@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e2eca9dc-09ca-4f7b-9fca-9ad6ce72c9b9@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/26 3:18 PM, Tetsuo Handa wrote:
> Since you are mimicking my patch, you agreed that there is no problem with my patch, don't you?
> Then, why not respond to my patch with Acked-by or Reviewed-by line?

v2 of your patch has been integrated in this series with you as author:

https://lore.kernel.org/linux-block/cover.1789679858.git.bvanassche@acm.org/

Bart.
