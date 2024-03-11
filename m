Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2EB3232
	for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 04:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710132101; cv=none; b=CyNSiYHFu4UhG/1DfHTUEbFkLJt8kCfVtKOIVgArDYVPZxKuwpGIEfnJzG1w0C95/MszvpRlRcjjdurcIu82PgP448bOoH3YlKrHfjWDn0WGiyCIBUgKAQVJoC5U4n9o729QnULA+hVuuS7xJQ4qryLlKlWixtPR3XxYAs5Pj38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710132101; c=relaxed/simple;
	bh=MUUHNLxC/A0fSUnFLFpiuifJJLsSSzmv2T6jsEdUnX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ix4PJ/wZTDHVn1hfXHjotbc/2LyHYo5mZVV5Q12OrOunNWQ6OCsILQber5IMzsK5pAHZ/zvU3quZk0azD6PuT2IMklFL9ZJ83O/agV712eOWxKyfkUPwfb0S/d9jg0RtWB9xdnNdgWXJdLkjlZdm+z+rpzRZYKP49fIq2D+Z/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zur+UW2x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zur+UW2x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7149BC433C7;
	Mon, 11 Mar 2024 04:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710132100;
	bh=MUUHNLxC/A0fSUnFLFpiuifJJLsSSzmv2T6jsEdUnX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zur+UW2xZFyHMcfm2De+mXDfGCoQqwUIxUAUqnyUdp7yR3QMBRjIk2hGBrSGVLMPJ
	 1Elr67FTn3ATN/hBpeAYWkzYNnw6fT/l1I0AmBNTy0Ww7DhIZue8byMQ7/A5unEUEK
	 CYpOUEuehazRIOpa437gh6Ms19OW1oW6rFA7YBr/ngWI8u896CgCq/OnTfn5c/tI2N
	 bvaNxQ7pHN49RrEw8N3jtp9VeZwRydT9DDRV4LXD07NTikBaK/R5bjwzJVjd1SMyBs
	 VWjmJZMywQh4vo9OiPWTfUFUdgpnpoYpba3fyeCHtnPcdK+to9aYnmF6YVKPN0xmPn
	 JfDAfkdk0O9BQ==
Date: Sun, 10 Mar 2024 22:41:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me, linux-block@vger.kernel.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH RESEND] nvme-pci: Fix EEH failure on ppc after subsystem
 reset
Message-ID: <Ze6LglWPqkHVFh-P@kbusch-mbp.mynextlight.net>
References: <20240209050342.406184-1-nilay@linux.ibm.com>
 <Zesxq81eJTnOGniB@kbusch-mbp>
 <039541c8-2e13-442e-bd5b-90a799a9851a@linux.ibm.com>
 <ZeyD6xh0LGZyRBfO@kbusch-mbp>
 <301b8f41-a146-497a-916f-97d91829d28c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <301b8f41-a146-497a-916f-97d91829d28c@linux.ibm.com>

On Sun, Mar 10, 2024 at 12:35:06AM +0530, Nilay Shroff wrote:
> On 3/9/24 21:14, Keith Busch wrote:
> > Your patch may observe a ctrl in "RESETTING" state from
> > error_detected(), then disable the controller, which quiesces the admin
> > queue. Meanwhile, reset_work may proceed to CONNECTING state and try
> > nvme_submit_sync_cmd(), which blocks forever because no one is going to
> > unquiesce that admin queue.
> > 
> OK I think I got your point. However, it seems that even without my patch
> the above mentioned deadlock could still be possible. 

I sure hope not. The current design should guarnatee forward progress on
initialization failed devices.

> Without my patch, if error_detcted() observe a ctrl in "RESETTING" state then 
> it still invokes nvme_dev_disable(). The only difference with my patch is that 
> error_detected() returns the PCI_ERS_RESULT_NEED_RESET instead of PCI_ERS_RESULT_DISCONNECT.

There's one more subtle difference: that condition disables with the
'shutdown' parameter set to 'true' which accomplishes a couple things:
all entered requests are flushed to their demise via the final
unquiesce, and all request_queue's are killed which forces error returns
for all new request allocations. No thread will be left waiting for
something that won't happen.
