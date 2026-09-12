Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EB44BEE57;
	Sat, 12 Sep 2026 01:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789174954; cv=none; b=jrE7F+FlD/m9AzRL9xcuGv0bd4tr3stuw/88tbMKsQ1kZcfFddxWs1mAkrvAVfCDYQgfSYnJvN1350CobQLOCrydU6HeCfZScDzR1F6+ZIOPwt41q5DtaowpwNNgIic/Z8UPriQ04c1cIrzr5xVZmgUda+FeBrqAJBCpm4JbACY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789174954; c=relaxed/simple;
	bh=u1eTiQ9zBNotIRkppK5XPv0COytQMNHcka5+5KQECLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIRcAvEOQegybQFtC6p3TYp/wEZv4eOWkxdKBdxaj9dxxsXKhBru6vZ6sMaX/E7D0ZHlCKF4/wCPv/n2kRHBXrVUxq83zbcJFnsLfN6blptn4R+lHz/jWInSL4fUYk1DIBt5fNkfNxJsY3i0UFv8Tt5KQSH9p8ctUz7VxVFhZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=i574A0Ih; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="i574A0Ih"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hhY6c0tj8zlfwJG;
	Sat, 12 Sep 2026 01:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1789174945; x=1791766946; bh=uIMFAxBmnIzXuncpLjTxvNQD
	samq4HP6KJSiAHKse1w=; b=i574A0Ih/1Rj2xU5MF8VNfqrLaDOVU9WVMg1jkhu
	wIbdpsEylp7GL6qtkcC9FDxazfaxUGGwpRUqP+Riqa5BSLtYw+YKDRXBp4MyVf8f
	r9aDDPslZEqFyLuUAD1Bpod5FBgqog/htlwN6utQBJY/dFaVK7/ZoDfSOp3TaWcU
	g/r2UF8GgXWITDYL9/iAgq14/ijc5vg0Zyn7Xn5ARFQhp/L8/tmxyclAWbGREy5Y
	FRppJ//prM1RFs+13AOG2YXDtvgJLx5xILJGIayrWEAugjBnuJTWFCHj5Y3WBG+f
	A0LSeHfpNd0mb+HQU4SdEjBj8U42oMULvVonX0x84E8LnA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id x1iCysEzyind; Sat, 12 Sep 2026 01:02:25 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hhY6N0nH7zlfwJB;
	Sat, 12 Sep 2026 01:02:19 +0000 (UTC)
Message-ID: <b700652d-ed63-444a-b879-ec2725affaa7@acm.org>
Date: Fri, 11 Sep 2026 18:02:18 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] loop: Perform __loop_clr_fd() after disk->open_mutex
 is dropped.
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Brian Foster
 <bfoster@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Hillf Danton <hdanton@sina.com>, Markus Elfring <Markus.Elfring@web.de>,
 Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
 linux-block <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org
References: <60bf7af2-b84e-4056-9195-a26ad51ada46@I-love.SAKURA.ne.jp>
 <9f1273a7-6dfe-46bb-966f-fe08876f4375@I-love.SAKURA.ne.jp>
 <3883b05e-0a34-43f7-b2a9-a46d2b0c5ffc@acm.org>
 <08b0057a-280d-4e55-8e94-e510ec1a371f@I-love.SAKURA.ne.jp>
 <d89aa722-2d13-4733-b5c1-f0194bf4b342@acm.org>
 <15037162-0e54-4722-ac7e-c9a863a8a2f7@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <15037162-0e54-4722-ac7e-c9a863a8a2f7@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/26 3:18 PM, Tetsuo Handa wrote:
> On 2026/09/12 5:03, Bart Van Assche wrote:
>> On 9/10/26 2:44 AM, Tetsuo Handa wrote:
>>> On 2026/09/10 4:33, Bart Van Assche wrote:
>>>> __loop_clr_fd() is queued from the lo_post_release() callback and hence
>>>> may be called concurrently with or after another thread has called
>>>> bdev_open(). Hence, lo->lo->state should be checked instead of assuming
>>>> that it equals Lo_rundown.
>>>
>>> No, __loop_clr_fd() is queued from the lo_release() callback.
>>
>> Yes, it is *queued* from the lo_release() callback function but there is
>> no guarantee that __loop_clr_fd() has started before bdev_open() is
>> called again.
> 
> Since lo->lo_state was set to Lo_rundown by lo_release(), lo_open() will return -ENXIO.
> What can go wrong if bdev_open() is called again before __loop_clr_fd() starts?

This breaks LO_FLAGS_AUTOCLEAR, isn't it?

Thanks,

Bart.
