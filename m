Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E44376;
	Mon, 24 Jun 2024 07:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719212756; cv=none; b=H77ib/vVDJeUB//NdLMqMeaW65u3rJNlyjWIFQwkuj1J4Aaq0Z21Jx8XFSl1sWJmRHqqVa5rwTpTIfu+4dHglGv6b83r8Lp4IM1h+kjyuT89Fxwe13eITsaMygEzA5UohRy2tLnIfw8jVlod8dk9fUn7wqrzl7DlIgvOlBrd95U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719212756; c=relaxed/simple;
	bh=afYDRNFVM8pcvIJP4tvmzkmT6QeFWMGtIsLSC0oDa1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAAkQAon0olbwddR+Fc37pZY7noTogVKfoZBYWGPi8y69QidXDgUd0BlvqR7o2dmPsgrjST9PxRycVjL7nV13Rvrv+KlUoLB9cq4EpFwsTrxVr42QvWr9joXoj0SlRkqUrUx5fzdGjYIG7HQKuDERiRGseB5NdIE+n8jzOHA3T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h7sqw2QW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h7sqw2QW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B821DC2BBFC;
	Mon, 24 Jun 2024 07:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719212756;
	bh=afYDRNFVM8pcvIJP4tvmzkmT6QeFWMGtIsLSC0oDa1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7sqw2QWEulxyaQ4IqxxFfF/rlrwaq6zfYShXcbuY5Av9xgQpjih/48A8cJFg80Bb
	 jXvg+iHotIalCcB5/yxMEwcz9I8uFVjUF1lGxHe9ITsnTazF3BBU+herdvfRs6GFF5
	 SbcFQ11FqvOSl4zHwtJUNCKkChyZI0oHrNeFptZs=
Date: Mon, 24 Jun 2024 09:05:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chun-Yi Lee <joeyli.kernel@gmail.com>
Cc: Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Nicolai Stange <nstange@suse.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Chun-Yi Lee <jlee@suse.com>
Subject: Re: [PATCH v2] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <2024062448-crushable-custody-dc7e@gregkh>
References: <20240624064418.27043-1-jlee@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624064418.27043-1-jlee@suse.com>

On Mon, Jun 24, 2024 at 02:44:18PM +0800, Chun-Yi Lee wrote:
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

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
