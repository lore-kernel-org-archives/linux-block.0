Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26229369D4A;
	Tue,  1 Sep 2026 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274153; cv=none; b=ArsfSn76V/+LnrXN1DVbOcqXRpofNYdrVQPSOqweDXIJc2C/ZYn1Uq1VzCIa7w3+vxjZfPCUiDBoFLsOQfLMVm4/IgFR++rotnSAgh0RV7J3BRPVGRJxEITDcDjhxAKQhCm0mb4OtDuWvz9T1GxIOsoQt0m0WM3ACGfbro9BDg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274153; c=relaxed/simple;
	bh=C6LeNxYDNF1a5qzQgPHBcAQJ0aYoWhQBGHUKshrjXZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eN+kHnwsN+Zq1uNANpYkZctaDUAgs6TQMOpbstJx/z436mvSRmd2BSMQ2CFZVhWVsCDB7JwtQe/R3whDX7xfEj74KWknQrF93kFgjEBTz0JjQ7C6xDBh0cP2SXIhX+oG4ia1u6fz4bdftAPBqLJR9hCLe3mn0pZceOYZfEime38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eo1/L/M8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eo1/L/M8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4571F000E9;
	Tue,  1 Sep 2026 14:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788274152;
	bh=zpqOPcvuHlgdPD47fDAFr122WgJc/Qxe0tUnoEkGGXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Eo1/L/M8i7NrAaL2plgSeMPZDhol765kNFRJGoV3Ptm+ezVy2rnaqaU2m3+ze6vQH
	 rs3nn4P6agKCjHIMlpVX5UcjKDVY112eRoCX7HodMv1EcGK5qrCwloSwYHRlrdZErO
	 1bw69odwZDeBe97KAalW43VULRYvaxTMx/KwQq1SYtZ+ykCgO8szvvERAAxuQNcS+w
	 by+i0Xe0X3JMiBZ3kl4d1bLbGUvxYPNbe3rMxsW5Yk6YkXn5bHy31Z/IM7yN74bJBb
	 bWCbhTQcxX6roERN1i/7lq4Y7xIrD5XRyA75OrHa/PX7D/LCUehwui/wTSYtlaKZuY
	 h6BpXt+X9MePw==
Date: Tue, 1 Sep 2026 08:49:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: syzbot <syzbot+f4353e96f7004ae5a09e@syzkaller.appspotmail.com>,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [syzbot] [block?] BUG: corrupted list in
 blk_mq_request_bypass_insert
Message-ID: <apbl5hqGl6l4uAM7@kbusch-mbp>
References: <6a926eaf.1d9ded08.62e62.0102.GAE@google.com>
 <2cf45e85-176a-4209-86ad-8f389a9a4282@acm.org>
 <apWWsVUm5ri7b4oR@kbusch-mbp>
 <164f232c-45ed-4b77-84f8-c36987c891e5@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164f232c-45ed-4b77-84f8-c36987c891e5@acm.org>

On Mon, Aug 31, 2026 at 01:55:37PM -0700, Bart Van Assche wrote:
> On 8/31/26 7:58 AM, Keith Busch wrote:
> > We want to be able to retry eligible commands that were caught in the
> > crossfire of a controller reset.
> 
> Got it. Is my understanding correct that the NVMe driver may trigger the
> following call chain for a request that is already on the hctx dispatch
> list?
> 
> nvme_cancel_tagset()
>   blk_mq_tagset_busy_iter()
>     nvme_cancel_request()
>       nvme_pci_complete_rq()
>         nvme_complete_rq()
>           nvme_retry_req()
>             blk_mq_requeue_request()
>               spin_lock_irqsave(&q->requeue_lock, flags);
>               list_add_tail(&rq->queuelist, &q->requeue_list);
>               spin_unlock_irqrestore(&q->requeue_lock, flags);
> 
> Can this scenario trigger the list corruption reported by syzbot?

The list corruption is from inserting the same element into the list
twice, right? It could happen if the cancel request's completion raced
with a natural completion with a retryable error. We don't cancel until
bus master and interrupts are disabled on the device though, so it
shouldn't be possible for a completion to be posted after that. The bug
report indicates there may be a gap here.
