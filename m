Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475DC15AF
	for <linux-block@vger.kernel.org>; Fri,  8 Mar 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912495; cv=none; b=PR0y4w6Z4NYJTRrXae6LyEZHArsB03FMnxDNz2h5vbF7KapmKgfJ6b5zi2qH+9JPvNng9/LpStjqCO05xAEJmJLeh6QEVDYpQM0WsYIAdn8lxxubkceOIhSuI5EUhUmW9p3f4y9mfihP64s19YG+MXXjDjP2iN+DLbFxgDsv+/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912495; c=relaxed/simple;
	bh=qgXTjEzUbSTzezT+CcIL+WmyphEt5BFFhf/YzdxcgqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2ae2lJRYfWS4aySD6PeZs0toyu2A5He6F27r+WFIoMJ0VSAu/mXGoLfTvKJLkD+CKiA0u1aaQOb+zYslGv0PGNQKhRdcHexyt85NDwOpLlOt4A5adkZqAFQZK15cjdsuzlk0CAFIzCpjdS8O7pFTqwZ2C5SX1okbv/4kjZFQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfHAwg2y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfHAwg2y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450B0C433F1;
	Fri,  8 Mar 2024 15:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709912494;
	bh=qgXTjEzUbSTzezT+CcIL+WmyphEt5BFFhf/YzdxcgqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hfHAwg2yH4N32Qj5Q2F+aPCXZiWcHTF46B79a6q9Yls/qI7a/I9caKdDaXn/ZomIO
	 n2iKAnFhXOYVOkhBktvLEw3eJ8MLa2DwOkFnHrY58IwJYIEqdZ5v6hlLaaiea0BN/9
	 yhDv3u0oSDKC2shoIyBKfTc2widgw5dLha7Bzzs1xaEyxleQk27aQilV2Uc/MKMipR
	 8mmaJ7Sswjj2oqiSWPXrp7MQITjI1cwsOq76eIF4liF3u/P0tDe9vM9guYASI7t0fh
	 JsoeNPtHgnTisBa6KGL9Ht9AZf0tkCWSoQwkKQ+lBe6BFDXhRrHY1W5r+0SeHtffM+
	 5DC+wCSGNoR9A==
Date: Fri, 8 Mar 2024 08:41:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH RESEND] nvme-pci: Fix EEH failure on ppc after subsystem
 reset
Message-ID: <Zesxq81eJTnOGniB@kbusch-mbp>
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
> @@ -2776,6 +2776,14 @@ static void nvme_reset_work(struct work_struct *work)
>   out_unlock:
>  	mutex_unlock(&dev->shutdown_lock);
>   out:
> +	/*
> +	 * If PCI recovery is ongoing then let it finish first
> +	 */
> +	if (pci_channel_offline(to_pci_dev(dev->dev))) {
> +		dev_warn(dev->ctrl.device, "PCI recovery is ongoing so let it finish\n");
> +		return;
> +	}
> +
>  	/*
>  	 * Set state to deleting now to avoid blocking nvme_wait_reset(), which
>  	 * may be holding this pci_dev's device lock.
> @@ -3295,9 +3303,11 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
>  	case pci_channel_io_frozen:
>  		dev_warn(dev->ctrl.device,
>  			"frozen state error detected, reset controller\n");
> -		if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
> -			nvme_dev_disable(dev, true);
> -			return PCI_ERS_RESULT_DISCONNECT;
> +		if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING) {
> +			if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
> +				nvme_dev_disable(dev, true);
> +				return PCI_ERS_RESULT_DISCONNECT;
> +			}
>  		}
>  		nvme_dev_disable(dev, false);
>  		return PCI_ERS_RESULT_NEED_RESET;

I get what you're trying to do, but it looks racy. The reset_work may
finish before pci sets channel offline, or the error handling work
happens to see RESETTING state, but then transitions to CONNECTING state
after and deadlocks on the '.resume()' side. You are counting on a very
specific sequence tied to the PCIe error handling module, and maybe you
are able to count on that sequence for your platform in this unique
scenario, but these link errors could happen anytime.

And nvme subsystem reset is just odd, it's not clear how it was intended
to be handled. It takes the links down so seems like it requires
re-enumeration from a pcie hotplug driver, and that's kind of how it was
expected to work here, but your platform has a special way to contain
the link event and bring things back up the way they were before. And
the fact you *require* IO to be in flight just so the timeout handler
can dispatch a non-posted transaction 30 seconds later to trigger EEH is
also odd. Why can't EEH just detect the link down event directly?

This driver unfortunately doesn't handle errors during a reset well.
Trying to handle that has been problematic, so the driver just bails if
anything goes wrong at this critical initialization point. Maybe we need
to address the reset/initialization failure handling more generically
and delegate the teardown or retry decision to something else. Messing
with that is pretty fragile right now, though.

Or you could just re-enumerate the slot.

I don't know, sorry my message is not really helping much to get this
fixed.
