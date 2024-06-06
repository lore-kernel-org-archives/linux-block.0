Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15D4197A7A;
	Thu,  6 Jun 2024 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688906; cv=none; b=l9ptWnlza/UlsFoPSEVtv5sUbyAEEnAUITXhHE/DKQ7k+DZ/agyK88iTPF4l+fdnXby72iRAYLYsQfh5/Xi/7N6nfiTktBmbBOC3WLeZuYU9Q3zMx/YPMCCCpJZOxUoQKqed7/GE0Jg7lyU/71UxzLLbPAHK+wjZ+HbCmQNL2Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688906; c=relaxed/simple;
	bh=kGvrhh9vt44tqgRnyfCTTCQ/16e7yxQoW2Mu3o2AbYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ux87UNtfeliywWfbOHJ/Cl8VGPAJIeDlVpa90fKC+MbJft2f85UvHmgA/x53rNpe7j37nnSo63WyZ/lrRjkK3rUjxcxfAJ14fOUfzQKmnlSK1FSTHVDwcQ5G5+c5tV8vO8iOPl6NHTPvyfYUisZc2FR2zsGriXeMyAHdSFcT2tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+oln5bP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+oln5bP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B11C32782;
	Thu,  6 Jun 2024 15:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717688906;
	bh=kGvrhh9vt44tqgRnyfCTTCQ/16e7yxQoW2Mu3o2AbYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+oln5bPyjfE9gzBCUilSGSHPhrea1mfNoB4si8c39KE9ty439swsXFFpTAmyDg9+
	 5OhGgHE0tvjwNtyYXMFOqOnBMKywDw/LZP6LWpgLyDlMONlHDbjpvP5HtYoONMVCx5
	 RGCU6H0dvjp0P+1KQmOJM1FGrSw789VvJTmPARa4Br1xtby86ZuOG4fN4zpyOGowpO
	 jpvi67lnTuAgcLVbqCNgidg3XIUcwm3J2UYa7L8Gmhhvq3v+uLwLa+o70RYZQI+9K3
	 R2Mf/fT1o6LGwnGflSYTT2hLuhadoA/w+muao30xHh2VksaJyT4JTaX/pzzg9i+92u
	 t9xkRemDBbVUA==
Date: Thu, 6 Jun 2024 09:48:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>, yebin <yebin@huaweicloud.com>,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ye Bin <yebin10@huawei.com>,
	Zhang Yi <yizhan@redhat.com>, "Ewan D. Milne" <emilne@redhat.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: bio-integrity: fix potential null-ptr-deref in
 bio_integrity_free
Message-ID: <ZmHaR07LgUEhr_zX@kbusch-mbp.dhcp.thefacebook.com>
References: <20240606062655.2185006-1-yebin@huaweicloud.com>
 <ZmFatW3BEzTPgR7S@infradead.org>
 <66619EB6.4040002@huaweicloud.com>
 <ZmHH7mW0M80RaPlj@fedora>
 <ZmHNQ56C6Ee01Kcv@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmHNQ56C6Ee01Kcv@infradead.org>

On Thu, Jun 06, 2024 at 07:52:51AM -0700, Christoph Hellwig wrote:
> On Thu, Jun 06, 2024 at 10:30:06PM +0800, Ming Lei wrote:
> > Yeah, that is one area queue freezing can't cover logical block size
> > change, but I'd suggest to put the logical bs check into submit_bio() or
> > slow path of __bio_queue_enter() at least.
> 
> We really need an alignment check in submit_bio anyway, so doing it
> under the freeze protection would also help with this.
> 
> > My concern is that nvme format is started without draining IO, and
> > IO can be submitted to hardware when nvme FW is handling formatting.
> > I am not sure if nvme FW can deal with this situation correctly.
> > Ewan suggested to run 'nvme format' with exclusive nvme disk open, which
> > needs nvme-cli change.
> 
> .. and doesn't protect against someone using a different tool anyway.

It also doesn't work if format is sent from a different host. If you
have a shared namespace, anyone could change the format without
coordinating with anyone else.

That's just an unfixable gap with the current spec. The driver tries to
react to the Namespace Notice AEN for this, but that can be too late or
not even enabled.

> That beeing said, nvme_passthru_start actually freezes all queues
> based on the commands supported an affects log, and
> nvme_init_known_nvm_effects should force this even for controllers
> not supporting the log or reporting bogus information.  So in general
> the queue should be frozen during the actual format.

Just for single host consideration, the our current nvme freeze does
ensure IO is drained before dispatching the format, and should work for
most format changes.
