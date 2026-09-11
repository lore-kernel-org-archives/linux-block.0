Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A9E582BBC;
	Fri, 11 Sep 2026 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789157060; cv=none; b=gDj4KUiuJeUqInHOxMO8DEWlbJTiiYI8M5ezn2loWzqJij0r1ZiuJPDCTA/ui4HaW1uTT+i8Tgs/EfXRLyYh4Ee0Lofb5hZN3nmuXey/9FRyz2XgGGM6umtSvbzZJAHPSx3Qdn2w5L+zuzNNfsDx5Nu9q+vI/a6w6Sxm/Bo6Ihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789157060; c=relaxed/simple;
	bh=HIDPV2uNIewrth5OQ3+QaUHHaMD41l/JEGJnxqFl78o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+ImskXlTSY5skYpJ4eEfRX2PPclQk040LA1lcjY91uwHFwlwo6JfkXnRcsJXvqpEj2WlaULrrzvi1/3ZMiILTS7rYlhkCBhJ1n5ZPmtmq6gZxLhfWeCcvH0UutpTBVSqMWDEs8Nzlrg9d7uNr5KKv00dYpWw2Xwdz0bZ8zR/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=q62fyD0k; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="q62fyD0k"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hhQVL5v3nzlfwHS;
	Fri, 11 Sep 2026 20:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1789157044; x=1791749045; bh=9V6y/LA3PpCkJiAhn6rEdd4W
	zhdjTn5sjQoVNJe2/7A=; b=q62fyD0k/RJXnCNNOoFiWEoCbk0Rws5wUDMBYfML
	ckwzq81OtjcsvJmV4plmcFGelGfLUR4QwmQQHxn5mMl8gMPDVT9/xLuvgIzMW3mZ
	GcZkt4oDs/s3Yd/DpzXzrnVx0tGq9g3NKWayER+0ZHqLPBHteqzG3husPe9S/aQ+
	XuSMqgyT+JNJlLPVPpOrrXYRZWvbSbMcAK7W/ZHc3i20BQW1GM8aJ2qwmuOICJoF
	AaMFd2AHfkmszuVqqWxMsmYU8lESN2xOPz7paJP7m68TS7X/fIo45d6RbgCe3Pdm
	byIqrrmBpNGXQS/BQB16j1iK9+dxq2fh2CB6PVW/KW/RqQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id RwW8F8ojH23T; Fri, 11 Sep 2026 20:04:04 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hhQV81dQkzlfvqM;
	Fri, 11 Sep 2026 20:03:59 +0000 (UTC)
Message-ID: <d89aa722-2d13-4733-b5c1-f0194bf4b342@acm.org>
Date: Fri, 11 Sep 2026 13:03:59 -0700
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <08b0057a-280d-4e55-8e94-e510ec1a371f@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/26 2:44 AM, Tetsuo Handa wrote:
> On 2026/09/10 4:33, Bart Van Assche wrote:
>> __loop_clr_fd() is queued from the lo_post_release() callback and hence
>> may be called concurrently with or after another thread has called
>> bdev_open(). Hence, lo->lo->state should be checked instead of assuming
>> that it equals Lo_rundown.
> 
> No, __loop_clr_fd() is queued from the lo_release() callback.

Yes, it is *queued* from the lo_release() callback function but there is
no guarantee that __loop_clr_fd() has started before bdev_open() is
called again.

Thanks,

Bart.
