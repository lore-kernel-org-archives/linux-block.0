Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C397DA81;
	Thu, 12 Sep 2024 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726138878; cv=none; b=AMLYQ487P6wS3NEH25h8sJghm15iDzPVYTp/fvtpL/7DOBKgRAdLNrll7gtp8GAnYFx84BtdvbXDfpD4lVoomoRJp+92dSGj039s9RdLba6ehOZM4ut1CFkZ0edLXe1rcGpMC8k90Ut31DqBi03of6msHRFdlT/rkR3wCJBV1Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726138878; c=relaxed/simple;
	bh=fXQcQtrV0+Va2dCrpxf845jeSK2LMbLalbklwUSo7Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foHyStYxhCC7CPwfRWTNYeQIyNxhq/Yc4A8NXJCKdo0v3gvfoCgZPCIycjhw+i58E2wnEnW4TiGK922SR33pAtbybNZRXOD4ffbXYmKx2r00FUmWjfsOWxkG4XP5LVffgT4rnTfCfnEwl2RQKoaXuzsesCAkKTexDY0pbp5r2XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vguxJ7Yf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vguxJ7Yf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EFCC4CEC3;
	Thu, 12 Sep 2024 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726138877;
	bh=fXQcQtrV0+Va2dCrpxf845jeSK2LMbLalbklwUSo7Tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vguxJ7YfhP6ntceJ2F89PLgmk976qLE7NK0UYdRiLaWmaT6u2u1WnC+MuaGJW6juJ
	 ibzIv3VtQMKns2MxjjNr1Bjw/4Mn9E6+oSWUQPqaf2hmhKgEO5ygdXnViKS7nRsq9g
	 /KP/0Zl2ynIAlOQSmxudQGwqbjRY2X2GhMfDZ7mY=
Date: Thu, 12 Sep 2024 13:01:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chun-Yi Lee <joeyli.kernel@gmail.com>
Cc: Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Nicolai Stange <nstange@suse.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chun-Yi Lee <jlee@suse.com>
Subject: Re: [PATCH v2] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <2024091202-frivolous-reimburse-3639@gregkh>
References: <20240912102935.31442-1-jlee@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912102935.31442-1-jlee@suse.com>

On Thu, Sep 12, 2024 at 06:29:35PM +0800, Chun-Yi Lee wrote:
> For fixing CVE-2023-6270, f98364e92662 ("aoe: fix the potential
> use-after-free problem in aoecmd_cfg_pkts") makes tx() calling dev_put()
> instead of doing in aoecmd_cfg_pkts(). It avoids that the tx() runs
> into use-after-free.
> 
> Then Nicolai Stange found more places in aoe have potential use-after-free
> problem with tx(). e.g. revalidate(), aoecmd_ata_rw(), resend(), probe()
> and aoecmd_cfg_rsp(). Those functions also use aoenet_xmit() to push
> packet to tx queue. So they should also use dev_hold() to increase the
> refcnt of skb->dev.
> 
> Link: https://nvd.nist.gov/vuln/detail/CVE-2023-6270
> Fixes: f98364e92662 ("aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts")
> Reported-by: Nicolai Stange <nstange@suse.com>
> Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> ---
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
