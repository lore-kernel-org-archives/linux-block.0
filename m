Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.204.27.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794277987;
	b=4cRrR0oOwmFYtR1j4LWoWfJcmNZIenOxON+4OFrjVBD175ETfHr6BCjwAncSSNRNzZAf
	 i0T3MjK0ETVPvpj7wHlb5iytAEhlPCb/8j0lFDlw+pZ4xiH0JMKp4MzVdDxFXhwp2/5X5
	 Nu+soUyJrROn7Y/ZeRfya3BeGRA+330op+ycUQynEz3qeEtx/OFxYMRspKoZzZzFb8X5p
	 1k0FMdQFkQifmqqCcbmZATrDXC40rKXia4NGDlAcYqtUBqMwltmG4kBw4EMzSzxAbWPPr
	 Z5D+AidMBI+m9gnsbsEcEICwtAg7DXW2OQ2Xlr+tZ1UtYxoKndaBRuz51JJmFPNAdPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277987;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=9dgmceogV8A29X7A/g9/D+jZBOgcl/3xennCOoQQw9A=;
	b=ccBcHNZIhL4SelRdefIIDmH0i/eOXDkE4AC2nmzfTPaCTk/qibxe5gnXSN1BJPH2mJrs
	 y8PA//6Ykr+6wuRezaxWEX4pPhTYxRCs95o2qMIIXWZCfnKgMQHhpDM8dS8CHmju7nAdf
	 L8QFGOo7xYUmDr+sxZJH+oRlCClpsSDQ2lcUeQXdfBWdR0LKwhZGO84ydgxnvmB6QGpBc
	 eBpJX3Tus/K66M/QRjIGfH6onfwzcsV2Ql49+xgoEeCDtl41lVZn5zFBnr8Vxd6EHNjCI
	 jDH771UaSViO7oGSXLWhyfbuJvfvt/NhM7a1WnaUHK/uz2DqMY9+IkgZyjudjfbJGqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hygon.cn;
	spf=pass smtp.mailfrom=hygon.cn;
	arc=none smtp.remote-ip=101.204.27.37
Received: from spam01.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6F4606A32E;
	Tue, 10 Nov 2026 02:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB6F4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jNrKY4YTyz9j2Jw;
	Tue, 10 Nov 2026 10:32:49 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by spam01.hygon.cn (Postfix) with ESMTP id 4jNrKX11Lwz9j2Jw;
	Tue, 10 Nov 2026 10:32:48 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 48EDEDC08;
	Tue, 10 Nov 2026 10:32:44 +0800 (CST)
Received: from hsj-2U-Workstation (172.19.24.226) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 10 Nov
 2026 10:32:46 +0800
Date: Tue, 10 Nov 2026 10:32:44 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: Jan Kara <jack@suse.cz>
CC: <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<agruenba@redhat.com>, <mic@digikod.net>, <gnoack@google.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<aleksa@amutable.com>, <legion@kernel.org>, <david@kernel.org>,
	<sandeen@redhat.com>, <ebiggers@kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<gfs2@lists.linux.dev>, <linux-security-module@vger.kernel.org>,
	<sunjunchao@bytedance.com>
Subject: Re: [PATCH 1/3] vfs: add inode iteration method super_iter_inodes
Message-ID: <avKCTDUKe3DucSY4@hsj-2U-Workstation>
References: <20261015093854.2082600-1-huangsj@hygon.cn>
 <20261015093854.2082600-2-huangsj@hygon.cn>
 <wepk7b6hw44k7aodwmk24mt4ied25jl5zzdyd5dfx3pjop6omq@bvld6lyzbetm>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wepk7b6hw44k7aodwmk24mt4ied25jl5zzdyd5dfx3pjop6omq@bvld6lyzbetm>
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

在 Mon, Nov 09, 2026 at 10:58:43AM +0100，Jan Kara 写道：
> > +int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
> > +		      void *private_data, int flags)
> > +{
> > +	if (flags & INO_ITER_F_UNSAFE)
> > +		return generic_iter_inodes_unsafe(sb, iter_fn, private_data);
> 
> Since unsafe iteration is a separate function anyway and we advertise it as
> an "internal VFS" function (which I agree with), I'd just have
No problem.

I will change it in next version.

> super_iter_inodes() for the normal iteration and super_iter_inodes_unsafe()
> for the unsafe iteration which won't be exported to modules (so we really
> get the message across this should be VFS internal function). 
> 
> > +
> > +	return generic_iter_inodes(sb, iter_fn, private_data, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(super_iter_inodes);
> > +
> 
> ...
> > +/* Inode iteration callback return values */
> > +#define INO_ITER_RET_DONE		0
> 
> Maybe INO_ITER_RET_NEXT? DONE looks too much like the loop should finish.
okay.

Thanks
Huang Shijie

