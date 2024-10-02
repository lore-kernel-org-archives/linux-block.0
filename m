Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC526433A9;
	Wed,  2 Oct 2024 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727851847; cv=none; b=OTjjhP5XINmkpNmoEgF1CIsL1xHSXFA1CUopNl2lKmRIMkn/zEu37nCgp5/qXdP3XF2DtPcA8eJ7VGF0RoX2WV6TVvxVvabI5+ohLE1beEynNT0CbvXVJOjn4tD0ltSPM5ZWGfPTxp/rp2yKu0fSk+vIXykE6CPI4qIexAJIV44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727851847; c=relaxed/simple;
	bh=pe9TIUfOBz09aCk+wGE1jr2d3K4acd8qNm27bzgQx0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALDZAsqLvk8eBf4hncv71vHWl//Y5xlb5ZXkBHh/iQaRXwC3uPrBLNTPbU026gJoCJZPesfhevYgztLKXmcBWXlQnSl3k+MR4h5f8bUTTZRZv/WlKLDDRd1y6+kF5bURf174dglagRw16tvPHUGepkcaZPdA/48GlkQJeBftDB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Le/brAcA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Le/brAcA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9370C4CEC5;
	Wed,  2 Oct 2024 06:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727851846;
	bh=pe9TIUfOBz09aCk+wGE1jr2d3K4acd8qNm27bzgQx0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Le/brAcAIxeEmd/Y+RH6JCKDZjhjBruMl6kap/QHPEVRETlwFAJ67d0kwyAjo+6hY
	 JQPmSV58D3P0YZeRosE86Ae9ljwvzPZORHpqZBxSiareSQgBwT8tdgwV13dCmAdzZv
	 Xfn+MqY0A7ZC6IMv+gfNwFob60MUaALpkCLrBBFM=
Date: Wed, 2 Oct 2024 08:50:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chun-Yi Lee <joeyli.kernel@gmail.com>
Cc: Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Nicolai Stange <nstange@suse.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chun-Yi Lee <jlee@suse.com>
Subject: Re: [PATCH v3] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <2024100233-email-regalia-8b66@gregkh>
References: <20241002035458.24401-1-jlee@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002035458.24401-1-jlee@suse.com>

On Wed, Oct 02, 2024 at 11:54:58AM +0800, Chun-Yi Lee wrote:
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
> On the other hand, moving dev_put() to tx() causes that the refcnt of
> skb->dev be reduced to a negative value, because corresponding
> dev_hold() are not called in revalidate(), aoecmd_ata_rw(), resend(),
> probe(), and aoecmd_cfg_rsp(). This patch fixed this issue.
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
