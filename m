Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7EB37A832;
	Mon, 28 Sep 2026 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616598; cv=none; b=E68wY5BP2kcKfCWfKYF1Jf8pgvSjuo+80hU/AcOLy/TSGpMTFk2LP3L5iX2NumS5PwyOB+II238UEMPHoCpFpU/SycQ8a24xyJkoVPUoqxx0LnuzdBhJOFJf8SXGY/QiG20KW1TRF8/koRX92ntUXDVF1TZdll9I+1PmAeG/PAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616598; c=relaxed/simple;
	bh=8Hg+e9wsO44fKwytjmdTQ+WgDx+EGZIdiXlQj2FNCOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceNgkn/QZMJBnZRJzIGR/L2oyNL8lodpmtCBjAuX/ZB0pwnmOXFFiUsaxcf6bK4vn0wkS2mJDRRj7KhoiYYKEFcLWYZQUhUWS4+nb39s27hqqrvpoVPeHedswHoh6KORSRzbtZ2KRKt+JeP1L+FPdnci//h1hDZAJXcBM9qJolw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YA2or/s+; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YA2or/s+"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4htpGW6xd1z1XM4Sx;
	Mon, 28 Sep 2026 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1790616588; x=1793208589; bh=8Hg+e9wsO44fKwytjmdTQ+Wg
	Dx+EGZIdiXlQj2FNCOY=; b=YA2or/s+icehhafUB0+98XckTG2pFHGs8XdcpT7H
	g92mRo+mcSyPKJSrk1MB5t0Qzx9dG/vV2z4vGK6hMq/5yYOEVNbza7GeXhzQz8JF
	Objsr1lo1k6jlrRqFpjE0H7HlB3wS1Xycf1dwMYyeWkdyKPs6nmwgcygWbXZPNJN
	b4vpHelS3ETIDDkvQ7lXsubXjMMqDmCCp2yAQ5ib56hRJgL7RlAGKR/3j1O6CQLn
	pNt8lYOjaU499PhEriT861o2gjtH7+WSuUCGxCujK/hltzvbyyvbbK2Zz8l4f0Ab
	ZizDBykwUyIbG6uO48HZINZ/1KqhZCxMqxVcdlKL5BkOQA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CtyQTrmQk4aD; Mon, 28 Sep 2026 17:29:48 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4htpGH2KQSz1XM4TB;
	Mon, 28 Sep 2026 17:29:42 +0000 (UTC)
Message-ID: <472c3bcd-45d4-477b-9e81-3c68601dc18f@acm.org>
Date: Mon, 28 Sep 2026 10:29:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] block: Add post_release() operation
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Jan Kara <jack@suse.cz>, linux-block <linux-block@vger.kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Brian Foster
 <bfoster@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Hillf Danton <hdanton@sina.com>, Markus Elfring <Markus.Elfring@web.de>,
 Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
 rust-for-linux@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nilay Shroff <nilay@linux.ibm.com>, Tao Cui <cui.tao@linux.dev>
References: <69960302-1535-441a-be4e-d652766d65c2@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <69960302-1535-441a-be4e-d652766d65c2@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/26 10:09 PM, Tetsuo Handa wrote:
> Add post_release() block device operation which provides a hook for
> performing synchronous cleanup without disk->open_mutex held, which is
> needed by the loop devices.

Hi Jens,

This patch series fixes a longstanding race condition. I haven't seen
any objections to this patch series. There is at least one other patch
that conflicts with this patch series: "[PATCH v6] loop: defer the queue
limits clear to a workqueue". Please consider merging this patch series.

Thanks,

Bart.
