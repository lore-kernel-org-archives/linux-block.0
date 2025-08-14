Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7022E7659;
	Thu, 14 Aug 2025 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162235; cv=none; b=Vs1MEJTHAcx5mjGhBqCH/+YYe6pdXQQofXI/9w57A89Aycv7lH27vL887zWU1sVIrVJhpp3GCIHgA6/xfYGNoN2JCNiohah8ZZVd7Sebce0qfG2hQh3gUB1TDmuRbS63xZBE5w+FeR0wcrX7X3mErdU/tjVNyB2UIOUsddXGf1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162235; c=relaxed/simple;
	bh=e2qQbRBaFDNvV40/R1RQd1nVKyDREqVwNZLAVjRA3ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNbIc4tIzc6iNtRmq8uIqG/4M4ekqcdSrJkaqNUdPMcsGAkPKt9bKvZ1MxqdaApETQF91N8vqh1s7e30oAER32yQnmun/crOwgO0XQ9SSnhXDAfs6xBnNlWcmYNSUVWMZLzmwtSlv6Wb5dkupSADyYmvYfw1YDs2KbmhcAQRGqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SQ0N564n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SQ0N564n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933EAC4CEED;
	Thu, 14 Aug 2025 09:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755162235;
	bh=e2qQbRBaFDNvV40/R1RQd1nVKyDREqVwNZLAVjRA3ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SQ0N564ncfEBKq80YfoU6NDnrtlP+g+lazVUhMhY3X83HbKptYK5/EXo3Z9SJPJyE
	 cDZwLGlIZqpDdVtI9kwpX9Gu+YIJ44Y+drzuIReWAEXVH0XTrprIOdwbQ2zgFR/y/K
	 3uO6vy63iD2fF1jt6KeL0FeCHj/t5VIVQhB7k69A=
Date: Thu, 14 Aug 2025 11:03:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardeep Sharma <quic_hardshar@quicinc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y v2 1/1] block: Fix bounce check logic in
 blk_queue_may_bounce()
Message-ID: <2025081450-pacifist-laxative-bb4c@gregkh>
References: <20250814063655.1902688-1-quic_hardshar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250814063655.1902688-1-quic_hardshar@quicinc.com>

On Thu, Aug 14, 2025 at 12:06:55PM +0530, Hardeep Sharma wrote:
> Buffer bouncing is needed only when memory exists above the lowmem region,
> i.e., when max_low_pfn < max_pfn. The previous check (max_low_pfn >=
> max_pfn) was inverted and prevented bouncing when it could actually be
> required.
> 
> Note that bouncing depends on CONFIG_HIGHMEM, which is typically enabled
> on 32-bit ARM where not all memory is permanently mapped into the kernel’s
> lowmem region.
> 
> Branch-Specific Note:
> 
> This fix is specific to this branch (6.6.y) only.
> In the upstream “tip” kernel, bounce buffer support for highmem pages
> was completely removed after kernel version 6.12. Therefore, this
> modification is not possible or relevant in the tip branch.
> 
> Fixes: 9bb33f24abbd0 ("block: refactor the bounce buffering code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hardeep Sharma <quic_hardshar@quicinc.com>

Why do you say this is only for 6.6.y, yet your Fixes: line is older
than that?

And why wasn't this ever found or noticed before?

Also, why can't we just remove all of the bounce buffering code in this
older kernel tree?  What is wrong with doing that instead?

And finally, how was this tested?

thanks,

greg k-h
