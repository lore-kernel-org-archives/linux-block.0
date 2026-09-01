Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C68F486BA2;
	Tue,  1 Sep 2026 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283764; cv=none; b=Mp/cjq3tZbZm9zPwGHVRfWN808+c1Xw1mSjCIRPcvw5qxB2DGI8oQykXqXWFdd8EHx3UdjMwGUE/vglsPshU9QXfaBAVJrdURwnPbABfseAAc8Aubxb+jqbIg9UF4nrTpnKtGcvvMHKMKgQ361caiTjdcHg2zqXzxZzdaBuLMgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283764; c=relaxed/simple;
	bh=2kqZ7ju4j0PZiHOGGlH+diJ80i1T3wNQs/VSU995US0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UED8gfYd2zPoNVnn+dAtsk9vhLEG9HQuAHMZmRhJKFqkRIUFo8v4UEe1oXVBSMFlDtff/IWwohFQFRquej4IIMdrALBg3WSNWvjZLVm9HhVPqoPJD1ckbBoo0eXaYk/ZieMGnGxD1hy2HXpSsRUNiIF3wFUBsYGMD6NYdxtvV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=bCXUPAmW; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="bCXUPAmW"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hZCXD2SdLzlfq9R;
	Tue,  1 Sep 2026 17:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1788283752; x=1790875753; bh=8rfzsBpZ1OCOYWm2MClkFIZJ
	JrLROY6MYyebwnDPAAs=; b=bCXUPAmWgUhvy09LvxviQaRYKrk+aoSadxCXjeoV
	dptcQqYIl4MS0NDC+H3NJZL0L/MPEv+c/kUFdDjrjuWlCXlqWOtkSNXIfP+U4B3i
	nEW5s4dNwPTF+kLqqTD0mEU4y+/5Ul70YtbYR7fOmD3AawF12ujp8QoafkZhfqdk
	vwoBS3QDtRSwYhpGGbsCe9LLhZg5Neb0MD5NL8nCNe9SgZ7jKGucZ24stKi2Ps87
	dgVWr9SVNmkafgQE2BvrOSE4yRml7Z93t/5j9r87WwFuU/So92ECwl7Ml8CriuLV
	i5Qzl8+3PyzRSdZTgqt/3UoXwdZojXkz3sNOuqBAq08+cw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ycnNiPafx6ab; Tue,  1 Sep 2026 17:29:12 +0000 (UTC)
Received: from [100.80.227.50] (unknown [104.135.182.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hZCX62WhSzlfq9P;
	Tue,  1 Sep 2026 17:29:10 +0000 (UTC)
Message-ID: <8948d38e-690d-4078-ae6d-b538421fc4b8@acm.org>
Date: Tue, 1 Sep 2026 10:29:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: defer the queue limits clear to a workqueue
To: Tao Cui <cui.tao@linux.dev>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20260828072004.273519-1-cui.tao@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260828072004.273519-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/26 12:20 AM, Tao Cui wrote:
> loop_clear_limits() calls queue_limits_commit_update() directly from
> the loop workqueue that processes the request.  That does a
> non-atomic struct assignment to q->limits without freezing the queue,
> which races with lockless readers of q->limits on other CPUs - bio
> splitting reads max_hw_sectors, the discard path reads
> max_hw_discard_sectors - and can let them observe torn values.  The
> trigger is a discard or write-zeroes request on a loop device whose
> backing file does not support the corresponding fallocate operation.
> 
> The code already has an XXX comment saying this should move to a
> workqueue.  Do that: schedule a work item on the system workqueue,
> where it is safe to freeze the queue and update the limits using
> queue_limits_commit_update_frozen().  Accumulate pending modes in
> lo->clear_limits_mode so that failures between scheduling and
> execution of the work item are not lost, and cancel the work item
> before the device is freed.  If the device is reconfigured to a
> backing file that does support the operation in that window, the
> stale clear takes effect and discard is disabled until the next
> reconfiguration.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

