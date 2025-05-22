Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4671EB5D9
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747944269; cv=none; b=MN9sM0Y1ll93rbPyV6mjjaO7jqYZiVG0FDZeG6qpixgyxKeUmH1uwAGkCwmEuMuVxTblKQJrlLbJ1gy40KoZwi7JdY55E5WMf/bhivClotjJb/vkEiojGVHntl0StGX7acGkRc2Q78c0uHb6TdGiomkDjtxwrPUGfo6BvWKhPbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747944269; c=relaxed/simple;
	bh=ujPvrlK6afswZBMUhFP2/Msh5uLTbbmYZGDthbnXzYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maDIVhZ3RWWoVtjcynoK7O4CcMgHzgEeT5a0knGC88s9h+MfK+V+wRpkkRR5H/d4wB+NqIpqungpwfEt8AMpAceTp0e0Px2Vk7fI1bDYeaVZMPDH3cIVBZCMZT0RN/6X9f1unMtSQ6ICgVWaL8QQDyMIsotZp0USEbWPOkdDspY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYIRLkA3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYIRLkA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1310AC4CEED;
	Thu, 22 May 2025 20:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747944268;
	bh=ujPvrlK6afswZBMUhFP2/Msh5uLTbbmYZGDthbnXzYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MYIRLkA3ofWRtgwBneRk/csi4yx0dAaY06a0TTBv2S0V0uc0Zg3ptWD02PXTZ8QkP
	 ZgEFO0b4P8S4tjY2E9a4JIGRUC75N9ohwxfXohquA5nXNUC9keF4rZMkfZZeeObF+4
	 Q9Q5KLS5hcNeEE9Y8Zrp+PpCM/oW4IZf3Zh4L8D7YUGd9zGCzAYRN48ZMD0J/Mx+xE
	 pDTkHAK9TwW3OScoirx3t5R+xYiwO8QN/trp7CoomgDcH/CwSzOkSsTrNXNOu1sp1C
	 +uprQyOUqdL1Te8Tf+Iz3W1cGhoCLDV5RRz77wobPGVQINfGKbn5672q3I/PU/1C49
	 soniJOr1zqauA==
Date: Thu, 22 May 2025 14:04:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/5] block: new sector copy api
Message-ID: <aC-DSTUfgBjNH28H@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
 <468be217-40d5-4674-891e-d11cc96b1c2a@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <468be217-40d5-4674-891e-d11cc96b1c2a@acm.org>

On Thu, May 22, 2025 at 12:22:22PM -0700, Bart Van Assche wrote:
> 
> Is avoiding code duplication still a goal in the Linux kernel project?

I feel like that's a generic goal of software development in general.

> If so, should the above code be consolidated with kcopyd into a single
> implementation?

This patch provides a synchronous interface, similar to other services
in blk-lib's APIs, like blkdev_issue_zeroout().  kcopyd, on the other
hand, is an asynchronous interface with its own zero-out implementation
(dm_kcopyd_zero). It's not like unifying these operations for different
use cases was a priority; the implementations don't have much in common,
so its not really duplicated code anyway.

Now, if we are able to settle on the REQ_OP_COPY implementation, then it
wouldn't be a big deal to have kcopyd use it too.
