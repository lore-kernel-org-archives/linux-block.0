Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0466225788
	for <linux-block@vger.kernel.org>; Sat, 20 Jun 2026 03:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781927748; cv=none; b=PNDqR4u0u9NxjojmhzTzFEytwLX5G2WF52cvmQvRLlWJmfmKeXqGhJ96SYq9L2YLK/TX4PvhTf3f3qSZqo4wuQPaoUN6/ucyu1d/kwHuY3bNcIIKtN/5xw6FT+Q2fowrXqEQsSLQZ7KRngVkdEvXSL0S16HLjwyp4pWwmY60M7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781927748; c=relaxed/simple;
	bh=ZYjdoRuB3B/af9pNR87+q41G994up5PNH/7krU6fgNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ow/+moQ8EP8QKUyZ+e+2z9tfxfVP2QheilpPAjFRq7f/orjaKYMGLfkbDXCm6TFZit81CEIsW0B3uDtHDKkjdQwl9nrnie1lH4mTXLR3F2WXKNjAXubHsNDMUNpQNOZLkSXsSY4dm/Z5bNIJ4F24B9bL6ZRAJ9SWxQGsVJCgYpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=C4/nAMTu; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="C4/nAMTu"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gj0xG3454z1XM0vy;
	Sat, 20 Jun 2026 03:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781927744; x=1784519745; bh=ZYjdoRuB3B/af9pNR87+q41G
	994up5PNH/7krU6fgNc=; b=C4/nAMTuMXqce0nikp+HXmYGI7PizZoQtU2DMAYR
	vM5F5BiotPATpIIO0s7QhtFmUbo+JrHtXmMsxnv+pcrsat3HlB30asclwUwwssar
	mOsQNte8aSshCJapYa3eO0oCYi9rU7PAmvrgCxq2dAIM849pZlJoziNhBMBeX8Lo
	6UYGOKX6s28mZkwyxUbd6vDXMPznDTEncpkJ5vP5+y5RcttnP3iIaN6HvBS6GjQd
	/+ddMVpmhNJkwn3Zxe+JOaPJS15y3ZQAvUpZVdV0YOo/aX5ceo4R0tqr/s5I2bUo
	Og/cdY7OtgaQnfTevHyC9GszHkx+WeJaZmakmKWyU2cPYA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id o8hXxv0EteAF; Sat, 20 Jun 2026 03:55:44 +0000 (UTC)
Received: from [192.168.0.145] (178-117-58-162.access.telenet.be [178.117.58.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gj0x95vBxz1XM2FS;
	Sat, 20 Jun 2026 03:55:41 +0000 (UTC)
Message-ID: <d0432702-ac0b-410e-9586-2cb9be079033@acm.org>
Date: Sat, 20 Jun 2026 05:55:38 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] Fix _get_page_size()
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Jeff Moyer <jmoyer@redhat.com>
Cc: linux-block@vger.kernel.org, osandov@osandov.com, kch@nvidia.com
References: <x497bnvlxlc.fsf@segfault.usersys.redhat.com>
 <ajXmBu9lDZwgMG7_@shinmob>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ajXmBu9lDZwgMG7_@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/20/26 3:26 AM, Shin'ichiro Kawasaki wrote:
> This is a rather fundamental change, so I would like to ask opinions from
> other blktests users, especially Omar and Chaitanya. What do you think about
> the idea to add getconf to the requirement list?

CONFIG_PAGE_SHIFT was introduced in the Linux kernel in February 2024
(commit ba89f9c8ccba ("arch: consolidate existing CONFIG_PAGE_SIZE_*KB
definitions")). Older kernels had CONFIG_PAGE_SIZE_4KB,
CONFIG_PAGE_SIZE_16KB, etc. This means that it is possible to derive the
kernel page size from the kernel configuration file for all upstream and
distro kernels, isn't it?

Thanks,

Bart.
