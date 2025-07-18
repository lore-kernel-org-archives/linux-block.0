Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA998AD24
	for <linux-block@vger.kernel.org>; Fri, 18 Jul 2025 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752853033; cv=none; b=L0S7uazrDSYLqySx7z4oR32Zr2aVzcfCoe40C3GLrhY67iyDoS+1953KuagxMWSeNQq0IGeXCVxbSWsAJ/rYeVM9EdfyMorVozdRKwcpuuI4pf7a92xT1bsccIyB6wghhHk1MlYL4BGuExS7MwcM4cAx7gkfElZuZdxdkUpJDLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752853033; c=relaxed/simple;
	bh=yHxCjO92mAK9VeGfNUpnUMj+xof26+SxYtMHsWUcRok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwaZoTAGnFgyY+0ZKNx9SP5k/p+X80yriAiKujepwXCzOZ7/CHlMDqzT6ydDOjvMj8Y7T0v2pUM+H+dWRZz2sbRbj3q84b88a/coHmzVvpjbM/2rJu9JKcypCF4bYgrwY9clGeb9qiKagPDpRTs/mEAB1n2CiQbP6R+3ks58qY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4FjonPJF; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4FjonPJF"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bkDS652hMzlgqV0;
	Fri, 18 Jul 2025 15:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1752853029; x=1755445030; bh=t5JaEu8UDKzh7C7v57Kt/7UZ
	63BhGGs64unxPHichLo=; b=4FjonPJFAamK1LXKaQ15HUhrvhVf5RvFgeq3yGrg
	OOY/WBYk8IW2f2AZxFi0avyFhfe0vYaZtQsp+B7kruAP/XYhReNr64NDyDQ37JNu
	JkfhB3QUvWpMg6REkV+dhLGf3bWb+MbcGngIo9ChQwbIcK+BYneRTIDXHtF1hk+5
	1eNn05C6+7l6y/WMqS3FFtBShd9yLpU2Octu+hEa6PGc1NEFdonIhLvYh5WXXDS3
	9+Qdlxcu69RNspkinBRMVbx81j4v5Jxc9icrXzTActN/dzfvwHaD+dml0gPK4gAB
	8xxHckQ7pyZHh6UJ3xJ9BqbNq2wm5UL4u8O7clFgwAptFw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DLz-Odu9USMY; Fri, 18 Jul 2025 15:37:09 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bkDS257S8zlgqV4;
	Fri, 18 Jul 2025 15:37:05 +0000 (UTC)
Message-ID: <3d6e8317-7697-4bb4-8462-c67b5e6683b4@acm.org>
Date: Fri, 18 Jul 2025 08:37:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Fix bio splitting by the crypto fallback code
To: Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20250715201057.1176740-1-bvanassche@acm.org>
 <20250715214456.GA765749@google.com> <20250717044342.GA26995@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250717044342.GA26995@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/25 9:43 PM, Christoph Hellwig wrote:
> Getting back to this.  While the ton is a bit snarky, it brings up a good
> point.  Relying on the block layer to ensure that data is always
> encrypted seems like a bad idea, given that is really not what the block
> layer is about, and definitively not high on the mind of anyone touching
> the code.  So I would not want to rely on the block layer developers to
> ensure that data is encrypted properly through APIs not one believes part
> that mission.
> 
> So I think you'd indeed be much better off not handling the (non-inline)
> incryption in the block layer.
> 
> Doing that in fact sounds pretty easy - instead of calling the
> blk-crypto-fallback code from inside the block layer, call it from the
> callers instead of submit_bio when inline encryption is not actually
> supported, e.g.
> 
> 	if (!blk_crypto_config_supported(bdev, &crypto_cfg))
> 		blk_crypto_fallback_submit_bio(bio);
> 	else
> 		submit_bio(bio);
> 
> combined with checks in the low-level block code that we never get a
> crypto context into the low-level submission into ->submit_bio or
> ->queue_rq when not supported.
> 
> That approach not only is much easier to verify for correct encryption
> operation, but also makes things like bio splitting and the required
> memory allocation for it less fragile.

Has it ever been considered to merge the inline encryption code into
dm-crypt or convert the inline encryption fallback code into a new dm
driver? If user space code would insert a dm device between filesystems
and block devices if hardware encryption is not supported that would
have the following advantages:
* No filesystem implementations would have to be modified.
* It would make it easier to deal with bio splitting since dm drivers
   can set stacking limits in their .io_hints() callback.

Thanks,

Bart.
