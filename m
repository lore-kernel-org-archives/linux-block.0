Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FD6369D5C
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780343212; cv=none; b=STDcEZHp03l2vuUvoPat93rdArg6JLGxk/VUasxG+yVbeM01xwD1wOjCK9cVCPUExKu4l4edarheFNHmjYI91pBiPJttncMV24hbdcpnPpkfZPuIQWrEWKSBnOg7/VFmFvB3zuFM1h1ff0Lgq/wtbjvm5KOKFnb0xLjCBEnuli0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780343212; c=relaxed/simple;
	bh=ZhxiZwrotOxEJ7t0L653k8+sTNmu4D2db8Vy6TIebik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5dOfmgQ2XaV8CLXKlsZvn1GgLNbPG+VRc5qf05dRFt0N02k52Ni2bLR333V2m9V6KE5MMMHsiO+380eJTCdQyUNaQiRTSMi5GYlrjwJxeQL6U4dhGrCwLq8S5ttCMfcaKsB7Ebo1KCyL3GJl9TTV20c+UlitNgTXCuv0m2n69E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=tFdS2L+b; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="tFdS2L+b"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gTkxQ6KFMz1XM0nk;
	Mon,  1 Jun 2026 19:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780343207; x=1782935208; bh=yWtOcs1sk2TvF+5AO7CeP6+5
	2Ddwe/83ss4QYREJdLM=; b=tFdS2L+bUR0I67zVaI2NjYO+w2jljjtJ/4tqPkDq
	iPm8Ux7QZDBAn0YZRClCvvdVYLJXYLvkQT3QM6+DK74j4w9/a1/0YFgZg4ojYGR3
	jQPeJtMdlosZ+WiyCyslfHK8ZFc8/FN0u5cFsWl2G2GFXyCBvXi7VG1TAaqMey5l
	d5IHxQsx9E10wn2+Oij5bmUCgwitBsIEOW1aAAfDPFFFGcnKhi1hgFYC0v6b1B6x
	nKueontxubOfykx9B9rigRmi5b6M206VfzJePkITarB28SeG4dHkdXYNU+Ct4Luy
	6OgPND0/ecfSYJ60+mt1qhllQ4md4CVl9yU/91TZc4ESbQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1GfnrTjlh-Mc; Mon,  1 Jun 2026 19:46:47 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gTkxK4v6Nz1XM5kY;
	Mon,  1 Jun 2026 19:46:45 +0000 (UTC)
Message-ID: <83f56919-a496-4662-a203-a7bbc5ae0d81@acm.org>
Date: Mon, 1 Jun 2026 12:46:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] block/blk-iocost: Add lock context annotations
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Marco Elver <elver@google.com>
References: <20260601073220.GD7799@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260601073220.GD7799@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/1/26 12:32 AM, Christoph Hellwig wrote:
> On Thu, May 28, 2026 at 12:45:45PM -0700, Bart Van Assche wrote:
>> Since iocg_lock() and iocg_unlock() both use conditional locking,
>> annotate both with __no_context_analysis and use token_context_lock() to
>> introduce a new lock context.
> 
> Both of these are only called from two funtions.  Have you looked into
> merging the locking logic into these helpers to see if this improves
> the situation?  __no_context_analysis just seems like a big hammer
> for something relatively simple like this.
This will require splitting ioc_rqos_throttle(). I will look into this.

Bart.
