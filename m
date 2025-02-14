Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7916245002;
	Fri, 14 Feb 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548594; cv=none; b=W6SQ9iPdjPD+V98YQakHDYF8el+xcNxXOw3a2xb+svpXBqCPMjBGvF0NcVooD+TuizxUoX3B4bOoU4rMCfEPEy28063SJMSXuWqAqWVjV8NPazP7zK3AeR/D9bV1uSMRC6G6MrHg72yQLonBrdmKzK91Hll8XKjoUv8CZGoWdYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548594; c=relaxed/simple;
	bh=sJWLktPwg1h3G6VV5+ecqTqYYtdm9bToScdqv2kD09I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VwXU/vgE44klKG49NrSeeoGTe0mhXJPlZHv8ygsQWZdJft/5Ipvtsk4DWXdJcrNYVaI3ac+S+N/sg+zwyaajA0igK+ep89GxKlQVTxyK5+IriiVmwuABLPyi8eD/B7NDPEvdhHrfOzfHhoykGMjTRSt7BVVT3+l2bGQ2GjK8zMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=h9e4iHHv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qDO8ls/k; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="h9e4iHHv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qDO8ls/k"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A35411400DC;
	Fri, 14 Feb 2025 10:56:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 14 Feb 2025 10:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1739548590; x=
	1739634990; bh=MYcXSQKh0TuY+v6i2lcldICSMO0inJiOvhcsSMmQmgA=; b=h
	9e4iHHviRZVZa+R7xB7nz8lQLFi11jRJKFRzpdL4s9uRYIyeQtXqELoXsxhKSV6E
	Zuo/kvBtJ6n9falchGSifBHrFoN/r/sMfv3J5vW7MZQbPsrlfUTiFTsotOkubhtI
	gTI3kb81PwS1G9lZWFzD/2tGiUwPsbnLyQmxRUhAJeeRATqRmHChVPDsObzokooD
	U/ELqb69ltqTR8pfjkvQtpdumlmZLoPD+xU5EmPTzZ1MsA7CLNItTiMU6Ifyl4L+
	VRTVO8SOFm6gcxZxtHi0yNjZjlLqVB//ShZQkfK+eZ5FB0z+5XrdAOSMHSWizYmB
	FMuxUZHfFNL2/yX36u/JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739548590; x=1739634990; bh=MYcXSQKh0TuY+v6i2lcldICSMO0inJiOvhc
	sSMmQmgA=; b=qDO8ls/kcaegZK3AA5i9IkVD4yfFlKAai32VNQDFHaa+hR3joUZ
	x6rWY5jGzlfiY4r0vdLuLLgkqzK2mHwsGaP786zslOhnEm71jrQcoRSMnk/ERiAF
	Ou2pXBvsav7MmnuWszha7RPLF2S+PRyvUlBa3EpzygMXK6x78fWm0b7Y/KkQwjhN
	OlfQ54moXs3GS8qAajJe+Gl5tnLS20VXcwlvIiXjQcfj65IE9DVClRwdGQHJEFDh
	1F52qi+weSaLGWb2+uJ6Kn7zU1JBFK4ce/5h1HdVbsgDzw1SKpi6rT1Lv7wvLKJO
	tePvS8orhDbzhLLArtMfYyy6qOlMOpCVm8Q==
X-ME-Sender: <xms:rmevZz-gHQtE74qyX4i79oE5cIv072dlABjaj6mRc9OnAPVWc9KreA>
    <xme:rmevZ_vwn_12P0SwGe7XB2iG5hVv_AnIMbj4ekhly5VMSVmcYJcToBU5R3YqkOkCA
    ykyHAcJFBplVGUOrqQ>
X-ME-Received: <xmr:rmevZxB1X3hBrOGjI-9ukei9Rl_XqAd8WJd3F9hviEeyX2zEjvpvZ6UIQ4e5ya1ROu_uFhG2HPRylxCu--uG9B8LE3-cOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredt
    necuhfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrh
    drtghomheqnecuggftrfgrthhtvghrnhepudetjefhvdeujefhkefhteelffelheevtddu
    ueelkeeludevteekteekjeevvddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgs
    lhhotghksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqug
    hotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkohgtthelihesghhm
    rghilhdrtghomhdprhgtphhtthhopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpth
    htoheprhguuhhnlhgrphesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegtohhr
    sggvtheslhifnhdrnhgvth
X-ME-Proxy: <xmx:rmevZ_ejdBOhlcKAsgqBCZgiV2_MWx6MeZjQTeSoJ0G6bYrJrLcrew>
    <xmx:rmevZ4N-8akXwTpyLhSatqCQzmsrVcDr_gKnQfQ9wihtZBoSEcLVCg>
    <xmx:rmevZxksJw8ybNFxq3ruEaWOOvQl61EMcDJn20-fVUWpKNl8qDDrhQ>
    <xmx:rmevZyvO9WwSyag2aRtwQ6IB8AWZ3gM4Q2-xT6qPqWXhfqrvctSYXQ>
    <xmx:rmevZ_evo-nxu2mvPuAYkHfXPTSXxU3qOfETu8cSMuJfO7XoWbxeXz5_>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 10:56:28 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>,  Jens Axboe <axboe@kernel.dk>,
  Konstantin Khlebnikov <koct9i@gmail.com>,  linux-doc@vger.kernel.org,
  linux-block@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: iostats: Rewrite intro, remove outdated formats
In-Reply-To: <87frkgzfwg.fsf@trenco.lwn.net> (Jonathan Corbet's message of
	"Fri, 14 Feb 2025 08:48:15 -0700")
References: <0e8c8ead-423a-45f3-9e10-020334ef8907@infradead.org>
	<20250214051432.207630-1-me@davidreaver.com>
	<87frkgzfwg.fsf@trenco.lwn.net>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 14 Feb 2025 07:56:26 -0800
Message-ID: <86frkgy0yd.fsf@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Corbet <corbet@lwn.net> writes:

>
> As a separate thread is generally better; no need to resend, though, if
> there are no other changes.
>

Understood! Thanks.

> But ... I'm not quite sure what "mutually exclusive" means here.  That
> they don't conflict, or that they cannot both be applied...?

Sorry, bad wording :) This patch conflicts with the original patch since
I rewrote that whole paragraph, so I ignore the first patch I sent.

Thanks,
David Reaver
