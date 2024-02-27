Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA65337E
	for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058559; cv=none; b=tBtFvPT0vZU7ceCVBlT8+T/YGovGHmFGkmo6pAw3fllixvAwhXNgt8cXdFJ6L6ltRvyTgYWo/UT49G+T/hJn4AOvKulaOOXlyyGx88C0q2XsDe+loIoiBQvB3Z9kFuBPib/XSXodWVmMKTWFm8V4+I3/ppKB9mTqcUrcYRRir3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058559; c=relaxed/simple;
	bh=3XymNxDkFbhY5R7fE/z627+i0nNxZtlgL9dicFODkrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqkoxG7C27mlg8hfctzRdshhzKweXLEghR/Vp6Wb/QUIIuJneq2KgNSY4Xp7VxoBrrCvaC1Toxc5FZpJYI3YVyd2F39GYhLO7/O4x7OgvyZQPoPEnQKHdzoQOasUBIEtxhyhJHTKqJoIYv6/OziCdC5LM31zZMa1mxGuUkyvQL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYLSD8ob; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYLSD8ob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC00C433C7;
	Tue, 27 Feb 2024 18:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709058559;
	bh=3XymNxDkFbhY5R7fE/z627+i0nNxZtlgL9dicFODkrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYLSD8obQjna/PAKYYmJFEHZXq6ST52AA7uANdkzub7wB1op0KcR3W+HP8Wp9VeEp
	 JcIjL3mZIbMBec9zvJ5RbQXQidAz9gkgbZBfgOKmhS5514bb+QFzGEOr2X+G/UrzSy
	 kW86NCGY6N5N8DjOt2NT+4vD2SXQLFKZz9eEmUL5xZxLcH9EDONg5ox40LhpoMV6Ji
	 TD6NsV6aVgoTnonAM21lPPUU7nPuVGZlIfciH2jHBbQUcEeeo0Dikd85rQ5gt8vNCl
	 +Kf+3liEJlv/r2Sl+nxc2L6mwPUKbiAQYiXEuXF5DB0oZGjOZLwF1w81ksg08UySVt
	 I85zq1SrsvJYg==
Date: Tue, 27 Feb 2024 11:29:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH RESEND] nvme-pci: Fix EEH failure on ppc after subsystem
 reset
Message-ID: <Zd4p_E8cPFpr1M--@kbusch-mbp>
References: <20240209050342.406184-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209050342.406184-1-nilay@linux.ibm.com>

On Fri, Feb 09, 2024 at 10:32:16AM +0530, Nilay Shroff wrote:
> If the nvme subsyetm reset causes the loss of communication to the nvme
> adapter then EEH could potnetially recover the adapter. The detection of
> comminication loss to the adapter only happens when the nvme driver
> attempts to read an MMIO register.
> 
> The nvme subsystem reset command writes 0x4E564D65 to NSSR register and
> schedule adapter reset.In the case nvme subsystem reset caused the loss
> of communication to the nvme adapter then either IO timeout event or
> adapter reset handler could detect it. If IO timeout even could detect
> loss of communication then EEH handler is able to recover the
> communication to the adapter. This change was implemented in 651438bb0af5
> (nvme-pci: Fix EEH failure on ppc). However if the adapter communication
> loss is detected in nvme reset work handler then EEH is unable to
> successfully finish the adapter recovery.
> 
> This patch ensures that,
> - nvme driver reset handler would observer pci channel was offline after
>   a failed MMIO read and avoids marking the controller state to DEAD and
>   thus gives a fair chance to EEH handler to recover the nvme adapter.
> 
> - if nvme controller is already in RESETTNG state and pci channel frozen
>   error is detected then  nvme driver pci-error-handler code sends the
>   correct error code (PCI_ERS_RESULT_NEED_RESET) back to the EEH handler
>   so that EEH handler could proceed with the pci slot reset.

A subsystem reset takes the link down. I'm pretty sure the proper way to
recover from it requires pcie hotplug support.
