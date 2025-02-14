Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BC42673B3;
	Fri, 14 Feb 2025 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554761; cv=none; b=QKnRbQcb6plGmAwaSbx2f0GA1QWGg9lOl597wHVtKlPykDDq+GdzEqcvnnUQ5QDgVcDfRva4wN6adhvs31nNSjIFwaQFTLqYmbNny3Y/Yk/MLKtSWLIQAnBjYVgNM262lqGk4SyZTrhy5IusgEnsaCsE73FOi+Duys2aZlaY304=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554761; c=relaxed/simple;
	bh=VVbsaroIMcVsVwkplFYBuNvffUjgWhb3WTdZRGkrHX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cd88si15rhu0ko37hqN//OC1IXNscbC+3szMGTgFcBxz0dVqHi8V5y0bQEOdrS6cilMFK7yIU9QKGvpxu64kjdeKH9TUY7hsODf91xUj3PEn4aPFwrTi2HF6DL5cCwmh+yQugf4a1k/fS1oo11D5j/PiM7QVtVarRogYJUGCSwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=ixenOA0f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AMvOS5tr; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="ixenOA0f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AMvOS5tr"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id D15AD138017E;
	Fri, 14 Feb 2025 12:39:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 14 Feb 2025 12:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1739554753; x=
	1739641153; bh=D0fHUbhWZ9YCEDMzybuAsk0F8BQCZl9wWHFz+BIcrQ8=; b=i
	xenOA0foL9+tXoilDHtnunbrp5EmJ+GwqGY6zWg7IGKtdtqPaJfjU7ugSaDIjelh
	xy6A91mEh+cmQRhD/QK/9fiQ1bmNHCg5/lgapESeGaCzhL/ikAQf4SARO6exMEbU
	hSZ+MfzomgOeaxjAZ6cu+2LPpIX1uMC//9EEZb0XoTHmtDqCT5gDcX7GJn6bTIJB
	161LeYT82a8rRL58+MeMFmySkaZLaDIdnIjV3Y/Hy/sr1cKg1q0lMYLU2yFwiR1h
	mPccxbFuj6T85+hfqQHZNoYbScK0KEDLdDjwoZpY6W8ti9AZqfy3wgcmOklnBAZi
	rRZNunaDAmHurwdSPK3UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739554753; x=1739641153; bh=D0fHUbhWZ9YCEDMzybuAsk0F8BQCZl9wWHF
	z+BIcrQ8=; b=AMvOS5trdLZcBf0VPgx/s/68ljqvc5R2LnsZowfgAS/o6jVbR+s
	u8jGGuPPWHHmIg7Bi8PXt7zbdN+CUeHw9/UAFZlSW4CR9MbuVYBkiQ7bnCuMRATl
	Yodt9pXBfvguCBK8Ufy8tIOx3/np2UDf1TRNMN//6fXipmWy6Upf6jaFyttAyAJs
	7gAqT1+ZEdjBobka4jXtjP3QugtNIGw76qlLXBK3xbjmZ1u3ZrGsT74aQJf89KXD
	7GQJim3E2Ir9H7nYe0o1xbo5VhyEhx0FGCVaDI+ae78YbdmPLxMlwF3t4hUpSumJ
	4F99sFGbarCtkJjZ2ALVLe88AI6FEcsPn1Q==
X-ME-Sender: <xms:wX-vZ4WjCKQfz3BIBaT7mvAHMtR61sjzLxoz-_tkJxcNDNPhFxPdjg>
    <xme:wX-vZ8k5Kfc_yFGXf0_nmcJpxls0tgh4_t8VMBM4lZGC3Ayb3PTpMeep8cco4eqXB
    dxGSXwQ-eaTLLPPS8E>
X-ME-Received: <xmr:wX-vZ8aIJNF0WRaAfzu6LFbwp2xI4PAoTc-KQ2pf6cDLyPJX5ZfIpeImpfzbC8_bYQrfvKlwKTuHUC5v3sxjwzlraxwAcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtddvjecutefuodetggdotefrod
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
    hotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrgigsohgvsehkvghr
    nhgvlhdrughkpdhrtghpthhtoheprhguuhhnlhgrphesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehkohgtthel
    ihesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:wX-vZ3WM2-4qCfHkxMMD0Qvxut6p3pJwUVXnxo9EhmLoQYI-6f4sVQ>
    <xmx:wX-vZymwyyHil0urOKwwBcx380FqFAtdyYRs4elcu9JUUj0BVKLCZg>
    <xmx:wX-vZ8dzsdiNK_98rd7FSdB6n0bS-1EsByFn6KdUbbH3clIw9a7keA>
    <xmx:wX-vZ0GnpHFLejMVNaWc2RayYRE4WwL5ZH4fLl-IswLzzQsvbf1q1w>
    <xmx:wX-vZ0XIaJWu-qOpWaNqu0Y1wXuB7ANC1k8YGYsdbFcr3zG-UTgg7tWM>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 12:39:12 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,  Randy Dunlap <rdunlap@infradead.org>,
  Jens Axboe <axboe@kernel.dk>,  linux-doc@vger.kernel.org,
  linux-block@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: iostats: Rewrite intro, remove outdated formats
In-Reply-To: <CALYGNiOU3vPAyvsNv4rt=qZRbZFVZ9iAe+kzPzGKkx6_L3wG5Q@mail.gmail.com>
	(Konstantin Khlebnikov's message of "Fri, 14 Feb 2025 18:00:21 +0100")
References: <0e8c8ead-423a-45f3-9e10-020334ef8907@infradead.org>
	<20250214051432.207630-1-me@davidreaver.com>
	<CALYGNiOU3vPAyvsNv4rt=qZRbZFVZ9iAe+kzPzGKkx6_L3wG5Q@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 14 Feb 2025 09:39:11 -0800
Message-ID: <864j0wxw74.fsf@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Konstantin Khlebnikov <koct9i@gmail.com> writes:

> Wraparounds here are slightly more complicated than simply 32-bit or 64-bit overflows.
>
> Internal time counters are 64-bit in nanoseconds.
>
> Values are converted into milliseconds for printing,
> also 32-bit architectures truncate printed values to 32-bit.
>
> So the common trick: delta = (long)(after - before) does not work,
> because the time counter wraps around UINT64_MAX/1000.
>

Thanks Konstantin. What do you think about just removing this entire
sentence? It is mostly tweaked from the old text that was rewritten, but
I'm not sure it is particularly insightful. That paragraph would look
like this:

  All fields are cumulative, monotonic counters that start at zero at
  boot, except for field 9, which resets to zero as I/Os complete. Other
  fields only increase unless they overflow and wrap. Wrapping may occur
  on long-running or high-load systems, so applications should handle this
  properly.

Thanks,
David Reaver
