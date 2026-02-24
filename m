Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFBE339B34
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 20:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771964920; cv=none; b=n8yQuW3RPaLmcEDerFhU67ccTWywNQMESh/S9GX+xWbxO+1I+8RqTIdLyie8FVKRJUF2XfyVDtRbKTMG6Fbyk/rSRa65pq3haCRi8xxQuUhiqYX7+jlztajGWfO4GnVMf5+a/h8NQeYVswHzwEbuaLAf1tGb6i9W+hXT0nGNN9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771964920; c=relaxed/simple;
	bh=wJkQVPreb+YZ+xZVhzXE8cnAmb88TLKI1yd0QHf+lnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayJluRhmySyR0byjuLgqcvcWz6RbfxomhZWLac1u0pWkOqc6cqc0WJtBudG07nc2N5LXSiHhSSk743I60Z+zO7yf9+j5FMoR37tCf+UWPx8y3g+C7lVeOGMS4jKkP5y2EQlF/EX3+2LZsVQrD7jZSHxM9HOycNyJf1cfzDqDScc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUQ2tr66; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUQ2tr66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8C7C116D0;
	Tue, 24 Feb 2026 20:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771964920;
	bh=wJkQVPreb+YZ+xZVhzXE8cnAmb88TLKI1yd0QHf+lnE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rUQ2tr66QXW48Odlu8dbOqGexxHX/1mStIkjpkXYyFQpIAtt47lL/L8GPFvOP9Fd1
	 SH6Xqk4VQawEVPRD2xW+m8l66uQ9bqGFRCmKz25ZHQRsBp0iog9XA0pX0jTlvdsf3A
	 ll1xlzvDXXPQzxE6Jn+t5g/W+L03UvkIFstlXEYGiS4uMnyWGu7R/y7u3cQbfbXiV9
	 ZKGV80Ta4u+b6Y5hTQ0mJCHA0z2Q/NmUrhhu3pJu6EvGENj0WKdB3Uh5TO+JesGyIn
	 ctdxOgdpOyK7TAQ6/djAGrQcLkyNO/0VW2rGtDpXWD+nWr3oVfpVX9IHAKZyrk5xqy
	 dLQ+jHrg+1gVQ==
Message-ID: <1ecd27a1-085e-49f4-95c5-f522b6f0ef87@kernel.org>
Date: Wed, 25 Feb 2026 05:28:38 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] zloop: advertise a volatile write cache
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20260224142153.368472-1-hch@lst.de>
 <20260224142153.368472-2-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260224142153.368472-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/26 23:21, Christoph Hellwig wrote:
> Zloop is file system backed and thus needs to sync the underlying file
> system to persist data.  Set BLK_FEAT_WRITE_CACHE so that the block
> layer actually send flush commands, and fix the flush implementation
> as sync_filesystem requires s_umount to be held and the code currently
> misses that.
> 
> Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for fixing this.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
