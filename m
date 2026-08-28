Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B362B9B7;
	Fri, 28 Aug 2026 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787934891; cv=none; b=EKox+6c98w9QiegRpJsi6A5bUEft6qGfAsrTAnINVq+FTdmqVItQb03viezxKx1JaC665LAyMwXl167Ckehs4nxms2D3jPlLAXXLPADw6AA941Fv6aL8xj96zsJVZt8Axpi+nNbGaOls2HSQ59uQb+/wzqK+x36QW+TiEovzJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787934891; c=relaxed/simple;
	bh=lYP/BWFIBMDB8Aw1stPd+cq247Yl2JyyTS9FHQl9JIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijKOWETQrO2cGgMhCOkY1bsYWYmRwmW01jJ7Z3Ih3Q2CZd2Z2jMnDN3W4zQHbs427Zh+asoAQ7bGuwpNbijgpR7YhEsj5I+4HGSfsEfWebqjWXGfp5pw1TOmdCzvkE8ITPUKCQokOI3fudAe5G2nE+C99KKYOVoEP26kCGVz0+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=w0Zph8PM; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="w0Zph8PM"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hWkWG041Vz1XM30n;
	Fri, 28 Aug 2026 16:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1787934886; x=1790526887; bh=j9O2TS4mxGfxLtl5fU3yn/UD
	/Vb4sm0UIQJiiVWYPzc=; b=w0Zph8PMa6CoH1M29cnPyv3+qqAsA+cr5r+aOTRy
	I/Mx7wznXg5rY9T2Slk/LZJuJqELhTgOX/AEcHG3spu/QldVbvdCQDm8kITb/qAi
	uxOeNKe7+idFLg7hy4Ys9j76X1J+tUZvvq1dHHGEN7u1tYsf6iNEmHLoNkfMfIU7
	0WpltU7RVNhCC9AWgdLXwAq1mO+e/bFBUwBuwfGaXs2Wd26xNG4Za1ENSDDa5fhw
	CXMD02qcbc6qIFsOcYt5YtpSF7Fwi95u25Ev0XlCjgudZjjt1D250y/9BoTVUgNe
	B868UZ/9+PTsKdh7ZTn7phznIfRK4AdKZDzliVQTgWdHoQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id pcXS_e1VcVfx; Fri, 28 Aug 2026 16:34:46 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:af43:61da:b9fc:bc3e] (unknown [104.135.182.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hWkW86VMJz1XM5kW;
	Fri, 28 Aug 2026 16:34:44 +0000 (UTC)
Message-ID: <638dd174-99ba-43d9-b379-5ade06982259@acm.org>
Date: Fri, 28 Aug 2026 09:34:43 -0700
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
 Tao Cui <cuitao@kylinos.cn>
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
Please help with reviewing this patch, which seems more complete to me
than this patch:
https://lore.kernel.org/linux-block/c2ab2547-63b3-48cf-87c1-fc53219e360a@I-love.SAKURA.ne.jp/

Thanks,

Bart.
