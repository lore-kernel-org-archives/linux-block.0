Received: from wflow4-smtp.messagingengine.com (wflow4-smtp.messagingengine.com [64.147.123.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3A81E4A9;
	Mon, 24 Jun 2024 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233151; cv=none; b=dxvdHlYFn0Fzitvk/yh5R2mXZEWfDWBvLe86K+3Up2rNPwhRkLw3VWxJnQXFyVcblcXv7cMGxLvVBlGQxXI/LNFyPdf32hSxa0iWy+VRL3vv99EXP6SaL6PS7vBU8oEWxd7GKtwHFK9eV4HQHe8oLpj8EyWnVoRqi8yz43VRHIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233151; c=relaxed/simple;
	bh=bHk7oVY4HJSJXdcXraPj+8uJig3F5xX26sfibOwI8eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gibUnF+4ayXkISZR7UR0xUNg2gJ7iM76stVn4YS7Y3Jx/VtYm2Us/xVssh6BztlfeY3PGB/yOipRT0z3g6YHZFgfvQYHvNDy5hQqMfIGyWg0yJCeydAOaIbnaM0jtUa0oapdketBdYgDNlNWXzqFoTA/1pmnqZL0FjLrkf9Vxoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=2S6rDUXA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=frRNYPVV; arc=none smtp.client-ip=64.147.123.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="2S6rDUXA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="frRNYPVV"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailflow.west.internal (Postfix) with ESMTP id D38FB2CC00FE;
	Mon, 24 Jun 2024 08:45:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Jun 2024 08:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1719233142;
	 x=1719240342; bh=VYXob4vhayXt3Bmdcst9br5mK/yayifQnerAn2TAL6o=; b=
	2S6rDUXAJzJNfiTEwjdnFBRJcsQiu7lpzuhnbS7SaKurMHzWXklj4gA/B2p5Vt3o
	XUM+C4KKErcyqF+a6+IXnKD3q4HdO/oxeRQwZr2DY+2V57pVArBnyuGbqrWfGtQH
	tJN5NbQs1ha9Pi9/ze/Ih+etMcljFpIgwNKt8EFECgqGkbd43++t5PakJrkAQD7c
	QOBLFaqLBCTwaGxVq5ndkSCI38twUpEpj16cv6ENKTTmar2mhf2NoOJjt3DP1npH
	1QmVuJ/wpEv3emEulsCuUZxswDhWuYIClxJYbZkMjMUe1+gD6E3ZIgDqDqQ8wNU7
	GbLw29QnQxVjTeBAUL8SKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719233142; x=
	1719240342; bh=VYXob4vhayXt3Bmdcst9br5mK/yayifQnerAn2TAL6o=; b=f
	rRNYPVV/EqGu77I3z4gxzgFZq2jcV99gSpQWSPmed1ICqRPfznUwiQ90Fm/rAeie
	LJEoiBluZSJ0Ts9EMzS42YaUzlXXr4lO7Du0tEgESRue86aY3kixa+hthEaSVjaW
	1lVGG+uUCU2HzhiYV0ebNWiCkFq7RvFU33EU7YVTUK71cr1B8OfWMWBQImXWmR4T
	1KcBlGWB8o/3o6CPEAXEMfZ4908oDQfB7WHvyx1TR5mVu/5RrKp8Aq0kKAYwIlns
	e3hfKUlSYN/q8AH/A4mG4LsjBpMB6/5tEv8mISyX5+IwgikXVxI+tUSvb/Z1mL9y
	f2cKGNzrR6lUaVW3T+Gsw==
X-ME-Sender: <xms:dmp5ZhDvel6ocBI6jPwwhS9zrM4QRjc74tRGKyoYfEcnAknrul8_fA>
    <xme:dmp5ZvhF1jfZ8IGlKHQt7nXLNddjZtpwPwBjCDcMdb06YGsxruheDBNFw64wkWDt3
    4Pwrh4zBHJNqA>
X-ME-Received: <xmr:dmp5ZsnyGNEng4qlOTsAxDpHXb-kZSYOkR-8solMDOPHHeyRJGkS_J1YLBTtRJKxQ9owKLe8lVqkQWNYZuEYoQ09voen-Bdg79wbkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeguddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelke
    ehjeejieehjedvteehjeevkedugeeuiefgfedufefgfffhfeetueeikedufeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:dmp5Zrxh79Ui8GtIN-vX5zQgPXmInzKsXaNl6zy_lCRG74tbsVcnRg>
    <xmx:dmp5ZmRJT4Y9h0XoySEBLUtCn_ueaR5LFl9M1WTrBO_X0rmfrvRYVA>
    <xmx:dmp5ZuazyEzbraA2iyHw1Sf-83siaKwmzLM2QVHObBUeL_iSvKY-7g>
    <xmx:dmp5ZnTOusHuWZP5Jp3LAWg4gCcd3OLt2kcwiSUHFlyWg1ItRMaHdw>
    <xmx:dmp5ZmJp-dg4Lw9dzogqq4oCJ9wEj-UYmf-V3nEA1KUZN5tGnZ5cKqMn>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jun 2024 08:45:41 -0400 (EDT)
Date: Mon, 24 Jun 2024 14:45:38 +0200
From: Greg KH <greg@kroah.com>
To: joeyli <jlee@suse.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-block@vger.kernel.org,
	Chun-Yi Lee <joeyli.kernel@gmail.com>, stable@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>,
	Kirill Korotaev <dev@openvz.org>, Nicolai Stange <nstange@suse.com>,
	Pavel Emelianov <xemul@openvz.org>
Subject: Re: [PATCH v2] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <2024062433-maximum-purplish-4ccc@gregkh>
References: <20240624064418.27043-1-jlee@suse.com>
 <b75a3e00-f3ec-4d06-8de8-6e93f74597e4@web.de>
 <20240624110137.GI7611@linux-l9pv.suse>
 <74d3454d-6141-462d-9de8-b11cf6ac814c@web.de>
 <20240624115445.GL7611@linux-l9pv.suse>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240624115445.GL7611@linux-l9pv.suse>

On Mon, Jun 24, 2024 at 07:54:45PM +0800, joeyli wrote:
> On Mon, Jun 24, 2024 at 01:43:25PM +0200, Markus Elfring wrote:
> > >>>                   … So they should also use dev_hold() to increase the
> > >>> refcnt of skb->dev.
> > >> …
> > >>
> > >>   reference counter of “skb->dev”?
> > >
> > > Yes, I will update my wording.
> > 
> > Would you like to improve such a change description also with imperative wordings?
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc4#n94
> > 
> > 
> > How do you think about the text “Prevent use-after-free issues at more places”
> > for a summary phrase?
> >
> 
> Thanks for your suggestion. I will update the wording in next version. 


Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
