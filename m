Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB3D1B6D18;
	Fri, 15 Nov 2024 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731673482; cv=none; b=fTbRWUTroiivTVc2oAJm79ndEQqSrFVEXD3KObIVhLD/pevn4XJmjPUJk5AdVaul5UGriz8NoNd56oXyfG48uRPWjpOQ2AtrF2RbHBBcW0WZlGUNNtLlZHoTHxbWWP+0Njlp12sM5iJRgxH4Mr58CKLcM5BnE0JonRk9X+dX6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731673482; c=relaxed/simple;
	bh=OOkg96nDarw17pu4SZExLC/B13lq1ft66bUs7PctR8E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JHeYuFH0DoUnohjhj/ejKhvo8wg7AF54gPHYpB9DQw2VsgotWPSzRFhJcO5aoN5Dz1F+yjLxkPSeDHukqk7j5uEXMpD7DiCCTd0mIE/XH5bsTdjEXMJLozPcvpOYOnjd9uU/eM5R88fnyPZisMzh6B5ScUpdhRJGhrrvgwJhO5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=enqXA1Vr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qeqm4aYn; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="enqXA1Vr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qeqm4aYn"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6FB0F254015C;
	Fri, 15 Nov 2024 07:24:39 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 15 Nov 2024 07:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731673479;
	 x=1731759879; bh=Vr7zlDxyaRus0hI2CWgnS1PT2A4IeVrO5WwxB/xoYsw=; b=
	enqXA1Vrzlg3/EG0FkE7n7hIc/nJCt8GSxytRbesFASzTHuh5+9KtiorJDnsc7LZ
	RaT/TocszavZqBWocXIW79dNo5LgAUVKppr7n+vGuEwG9EOlbZXW6/FMEUIy7a/Y
	zmhcPu4u4vWeR01uy1QSlMMT9qwnXMNZaVgMqVgrSlvFEHATbvfmlM3yp0pepH4k
	6yz2Xt0N64KDUiSGZ+Mi0/742AbbFSTV3pazoOKNgdHCL+po2Si8z7nCwq4xY+kP
	NU27Fd+wqXcmGDOsYKRBV08d7Hw9awwuxAYLVm1KumI4Vcmbn89pRzDjfy5qBgfa
	GgcU1zk5IAopZAmyaQDDXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731673479; x=
	1731759879; bh=Vr7zlDxyaRus0hI2CWgnS1PT2A4IeVrO5WwxB/xoYsw=; b=Q
	eqm4aYn+1muJOq/4d0x7FT3poHrztpAbvJIj3pvp6OiQP/Rd+F7QCRjtMMNHfVQl
	kK5MDXWkrb3skzEMxnCg/s9PL9qiF+jR6CSfWNaN2caPRpd0BLINIaa7r60TUmrd
	n3MIMiQjERFlA+RuIXP+vyXBFB/tSR0d/O6vPp/r3BWY9Wkuc6n40TCIDjNw2GpF
	vYwDhBGUiX/GCm3Zmf7GmdEOiPpMqT3Tb4KlbKDmiLXEGQSgf+PTl1i2pmazMZbV
	IDvTGdg/TOcEQSnx8IU2yQFh847IYtUU40Na4PHi/S4tXkVEMhL0xdJMPBRa1s1h
	Z9HpuKJuH18g9jdbJG13A==
X-ME-Sender: <xms:hj03Z06Ux4JuFD8N7DZPhZR6nE-Fa7XM2qFQKbbD8jkvwLsgUKhokA>
    <xme:hj03Z15VFqLhi45ibarfnuI2V-gWm5qTq_W_RE7TUp99rpBJaaAH4XDB6KOyCqe7w
    2yQ_zapZUyMsRvgn1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeggdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeek
    leffjeetvedvgefhhfeihfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhn
    uggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehnrghrvghshhdrkhgr
    mhgsohhjuheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhkfhhtqdhtrhhirghgvg
    eslhhishhtshdrlhhinhgrrhhordhorhhgpdhrtghpthhtoheprhgvghhrvghsshhiohhn
    sheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehhtghhsehlshhtrdguvg
    dprhgtphhtthhopehlihhnuhigqdgslhhotghksehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhthhhumhhshhhirhhnseifuggtrdgtohhm
X-ME-Proxy: <xmx:hj03ZzclPUL28JtHrQmJUysdOJUWGljeLUx4mDiqfTCc25ELFg3GJA>
    <xmx:hj03Z5KuD2k0Xw7gmvZOsW5iJFx7CMCVsVwHVOmvscDDjakO0P_q0w>
    <xmx:hj03Z4JEYJkisSxjAVfotoQrrSQ9joYrgxTS2zau2ME9mBqZGntaJA>
    <xmx:hj03Z6yTSDCqXAf1xhRADNauZ7jKIuXJ8ljsd--kw7J216Je76_umA>
    <xmx:hz03ZxrzVzW1nqLxIbI5_fUOq6TgF3WXATTZWEE_hCyhLvdKd05N4uFL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A191E2220071; Fri, 15 Nov 2024 07:24:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 15 Nov 2024 13:24:08 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>
Cc: "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
 "Johannes Thumshirn" <johannes.thumshirn@wdc.com>
Message-Id: <08be7d36-96b0-4334-96dd-b5069bf1eb40@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYtPQ=L8g5i=3vzBOW4dPSPYviKGR0xP-gR=2Ta_FZFBPQ@mail.gmail.com>
References: 
 <CA+G9fYtPQ=L8g5i=3vzBOW4dPSPYviKGR0xP-gR=2Ta_FZFBPQ@mail.gmail.com>
Subject: Re: Tinyconfig: include/linux/blkdev.h:1692:17: error: field has incomplete
 type 'struct rq_list'
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 15, 2024, at 13:19, Naresh Kamboju wrote:
> The tinyconfig builds failed with clang-19 and gcc-13 on the Linux
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Build log:
> ---------
> In file included from init/main.c:85:
> include/linux/blkdev.h:1692:17: error: field has incomplete type
> 'struct rq_list'
>  1692 |         struct rq_list req_list;
>       |                        ^
> include/linux/blkdev.h:1692:9: note: forward declaration of 'struct rq_list'
>  1692 |         struct rq_list req_list;
>       |                ^

Nathan already sent a patch, see

https://lore.kernel.org/all/20241114201103.GA2036469@thelio-3990X/

     Arnd
