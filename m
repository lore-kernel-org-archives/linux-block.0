Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BBF1E527
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253810; cv=none; b=aaOwzzQb2jze4581dtcsvY+SRmUiQohAeGZSWoKMSWlUohYeJYCdc4bzl4zUTzfWwyo1VfrkQx7XWM60rjB9qMiwrCwxMfYxhCm3QdYU2TrsfzPmzh23BfyIuBxOZnDh3o8vg632RNWBwl1aEmV5whVE0Mnjcekm36jIB2ohlc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253810; c=relaxed/simple;
	bh=5ZRONL4SZlpcFHCp/QRQUWuu5UjWMRjepJDC44EFnbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTRKMJAcHcemwVYphFNNO+pE1/2Rk8W2sbogy3NPLDgPCjD49WbJJ6TWe50azONTWwvWsrCyDV8qUuGy7NA9Ah31MoFv/j8lvHyaGAgqg67ldx1htG99+fiUD6P+wSR5fVozurrB+JJBj11Ee0h/PBmavUlj00WNVFT3YT5CD/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqQT4erY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqQT4erY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CE9C3278E;
	Tue, 12 Mar 2024 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710253810;
	bh=5ZRONL4SZlpcFHCp/QRQUWuu5UjWMRjepJDC44EFnbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eqQT4erY+VvgRNM7cLdPyPLVPIdW53p7E0r6LGAoI2TN7EXUPWurLD8t9zkoHd742
	 yympcqKkyuiDC+ssxuOTX69i4v2QVB5Bfxh1tzh6kzFznyRLMT/gvHyqy9FGNtfs8y
	 QV57LBq5RW2uiQYMOd46qyK810vZVZJBVhqLlMk/2Qqef244ua2IKZq2SwuGkvUFKO
	 Es20B4F3XXxAh0hjNY/xSz7JOREqZfDF0J70YLmF9XA/eu+TUgQDnhcvOLq+d78P9K
	 YYdVmxe6MnNpR8T1dD0Ya1Nv7K6TM0e3cHtsBoQ2hDS9YjiYwz2GQPzPl/S8iyhVgS
	 zO7UVlRvcOyQA==
Date: Tue, 12 Mar 2024 08:30:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me, linux-block@vger.kernel.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH RESEND] nvme-pci: Fix EEH failure on ppc after subsystem
 reset
Message-ID: <ZfBm72xPozFN99GA@kbusch-mbp.mynextlight.net>
References: <20240209050342.406184-1-nilay@linux.ibm.com>
 <Zesxq81eJTnOGniB@kbusch-mbp>
 <039541c8-2e13-442e-bd5b-90a799a9851a@linux.ibm.com>
 <ZeyD6xh0LGZyRBfO@kbusch-mbp>
 <301b8f41-a146-497a-916f-97d91829d28c@linux.ibm.com>
 <Ze6LglWPqkHVFh-P@kbusch-mbp.mynextlight.net>
 <ac294adc-a7be-49af-88cd-e3aabd9f7c3f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac294adc-a7be-49af-88cd-e3aabd9f7c3f@linux.ibm.com>

On Mon, Mar 11, 2024 at 06:28:21PM +0530, Nilay Shroff wrote:
> @@ -3295,10 +3304,13 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
>         case pci_channel_io_frozen:
>                 dev_warn(dev->ctrl.device,
>                         "frozen state error detected, reset controller\n");
> -               if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
> -                       nvme_dev_disable(dev, true);
> -                       return PCI_ERS_RESULT_DISCONNECT;
> +               if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING) {
> +                       if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
> +                               nvme_dev_disable(dev, true);
> +                               return PCI_ERS_RESULT_DISCONNECT;
> +                       }
>                 }
> +               flush_work(&dev->ctrl.reset_work);

I was messing with a similar idea. I wasn't sure if EEH calls the error
handler inline with the error, in which case this would try to flush the
work within the same work, which obviously doesn't work. As long as its
called from a different thread, then this should be fine.

>                 nvme_dev_disable(dev, false);
>                 return PCI_ERS_RESULT_NEED_RESET;
>         case pci_channel_io_perm_failure:
> 
> The flush_work() would ensure that we don't disable the ctrl if reset_work 
> is running. If the rest_work is *not* running currently then flush_work() should
> return immediately. Moreover, if reset_work is scheduled or start running after
> flush_work() returns then reset_work should not be able to get upto the CONNECTING
> state because pci recovery is in progress and so it should fail early.
> 
> On the reset_work side other than detecting pci error recovery, I think we also 
> need one another change where in case the ctrl state is set to CONNECTING and we 
> detect the pci error recovery in progress then before returning from the reset_work
> we set the ctrl state to RESETTING so that error_detected() could forward progress.
> The changes should be something as below:
> 
> @@ -2776,6 +2776,16 @@ static void nvme_reset_work(struct work_struct *work)
>   out_unlock:
>         mutex_unlock(&dev->shutdown_lock);
>   out:
> +       /*
> +        * If PCI recovery is ongoing then let it finish first
> +        */
> +       if (pci_channel_offline(to_pci_dev(dev->dev))) {
> +               dev_warn(dev->ctrl.device, "PCI recovery is ongoing so let it finish\n");
> +               if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING)
> +                       WRITE_ONCE(dev->ctrl.state, NVME_CTRL_RESETTING);

This may break the state machine, like if the device was hot removed
during all this error handling. This will force the state back to
RESETTING when it should be DEAD.

I think what you need is just allow a controller to reset from a
connecting state. Have to be careful that wouldn't break any other
expectations, though.
