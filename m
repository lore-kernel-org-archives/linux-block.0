Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27081427A
	for <linux-block@vger.kernel.org>; Mon,  2 Feb 2026 01:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769996780; cv=none; b=kunwWftgCUS2dUDDYZ6ZiYqKXa1YJYN40brd8WJlbg9tBDfGIJ1M15bRKCZztnFGSLMqJ525HvCdqVAKnDvKKnZggY020WTlcTiBp3QnlLwT1/mIlFhF7AlHqhAwre+6QULiznsthuOIkQJpBkShm1mBYYGKRgWYc2PVC8gqoUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769996780; c=relaxed/simple;
	bh=mEtcjx/Rh9K5sMQHHB2eXHLBQKobn1llQUzLZc/8KzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ODfA32awO8HW5qJSA9Bdx0p+hBu6u17ne34Hfw+K9MVKBYP2+dTpvHP8DocT9GT2mSIx8J6NdjRZdzqzIp1HPHbqKa/Qefm8tq6s5Yu7bAXnBJ0jc9dgVRl0Dl2lzZjfmGWFU0NHtzKdq1Re5bd8wYw6su6f7ozRuN+c8LlhdYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBnwNml1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBnwNml1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C243CC4CEF7;
	Mon,  2 Feb 2026 01:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769996780;
	bh=mEtcjx/Rh9K5sMQHHB2eXHLBQKobn1llQUzLZc/8KzI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=EBnwNml1FTyPW4lDYiuSrsPBx3e0caCyJcmPRXRw3IAl1BsxBvOsoXLZAP/U+rXQx
	 WCAhNjjDnmtb24gjSFYpYZZRbVWteCXWNBQvc7p6YiQ2UYTPcP4oDahTvvbjnkDf5q
	 0CfsAyko5Aa+YiCCc7VtzRbrGA7SKYdJDs/JfDTYdp2gRImPHPbhr6A9PwO2bvRR1v
	 V558wPm3Tfk2eXc5mXxwBxAtizAuas+pj2sG5bzp+G3n41wR4pOoAsny0d+Ueh48+Q
	 d4Mr+gOkzcW3sBbYuSbU23VJU4wownDwGyVJv1tgm4KewqbBMYCRm2952H7wahelou
	 +pr7Vb0iz7F4Q==
Message-ID: <7ec5f552-197f-48be-9898-9cc4233783fc@kernel.org>
Date: Mon, 2 Feb 2026 10:46:18 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM?BFP TOPIC] Block-layer device resets
To: Hannes Reinecke <hare@suse.de>, lsf-pc
 <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/26 02:06, Hannes Reinecke wrote:
> Hi all,
> 
> We are currently working on implementing cross-controller resets for
> NVMe, which requires to send a command to the target which then should
> terminate all commands on a given controller.
> While we could easily terminate the controller, the specification
> also requires us to terminate all outstanding commands.
> Which then recurses into my all-time favourite topic on how to
> abort outstanding commands from the fs/bio layer.
> 
> However, here we don't have to dissect/match to individual commands,
> but rather have to abort everything, which seems rather easier.s
> 
> So I would like to fathom whether such a thing is feasible/reasonable
> (I think so, obviously, and can think of several other use-cases, too,
> qemu springs to mind here ...) and discuss possible implementations
> (set 'req->deadline' to zero for all pending commands?).
> Or maybe we can do such a thing already and I'm just not aware of it...

Hmmm... Command timeouts ? E.g. if a controller is slow to respond (send
completions), the block layer timeout timer may trigger, which will call into
the low level device driver to force a reset. But before the reset actually
happens, completions may actually come back, and we do handle that race
correctly, well at least for scsi/ata.

Your scenario sound very similar to this: once you reset the controller,
whatever was pending will be silent and can be aborted or retried. So it does
sound like that should not be too difficult, no ? Generalize the timeout
processing or do something similar ?


-- 
Damien Le Moal
Western Digital Research
