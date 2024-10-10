Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24CD1C57AF;
	Thu, 10 Oct 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564012; cv=none; b=Pg59PLB2Rto+BdNtxmheKrPtttHun0EcQ7IHGCHdIOAGP1D6ZQWMACbpTXYt6egq7vcvjGbhiIZwDNEHJSszUfWo6tCVHZUlNL4J2YNjUHid9KmiGi9lbPnmTZLcd+q4DWrsdKv9LuoajVEY6s0A6vCFC6ykpfB2ZiSqA4YyDR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564012; c=relaxed/simple;
	bh=XxqUFwqWomDmCm0xl4ZQVEzQO/+Rbf1DpvA0yppqdZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jLJmkUB9jzd9oM04Inx1p14O+awxWAmlXyC54h3ItGSJ1GqtTxMq7nKGxuCeoX+YQQd+/kLRvpKbR/6hq1h0XQ6vcBsAIub1EFPnAhJLz8EFDxHqH3yELNTrtAp0nqNwr4j0iFup34ND+GfPYxL1wkuax+ak6WEg7KTBmNJAH5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me; spf=pass smtp.mailfrom=bjorling.me; dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b=Ju1QGgG0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bpA16suv; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bjorling.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b="Ju1QGgG0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bpA16suv"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 974511380586;
	Thu, 10 Oct 2024 08:40:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 10 Oct 2024 08:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1728564007; x=1728650407; bh=YQ
	YniaaT+oSMvL2AWNU5VQgVwDil0x/Rb6/p63nBWcU=; b=Ju1QGgG0eu6pIAMISZ
	5J3c0gHJqprLNHsAhK4bH01iO/qAsKb3ILMWJhLHDRbanM1x/3szN/ixnYZ92mFk
	KMQ11wpto/CEzJV1ROJydIjhU4ez0HUxACHTHfG+CYHfUaBFlfCACwCSx/Uf/dCm
	/+Mlludd8M+JIwwDOxPmlZh/EFDY2cpp+KQOlCq0TM2d0HorTEPm+hPPlu3/K5T1
	T4pX20Uqoi+j9rZHT0X6/XRxVcSg+etmhjiq3jjvkIOaBRXcKQpfNPumm6vodTP9
	/t2oSGHO9hfI9P3XeWhrRKC0BkynGztt3NNKlGlEy8P8SvUkXgyInpsOBHaHtPP2
	6kYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1728564007; x=1728650407; bh=YQYniaaT+oSMv
	L2AWNU5VQgVwDil0x/Rb6/p63nBWcU=; b=bpA16suviYLOu8JMPq7woCkUNGz6z
	NbHT+C6IDwnXp1MWcVSvefk361lX0DGyldVLk6PNkRD8olpf+LCHyGvu0YT/d5EY
	xrWhrNqsVzdYFbrPyIQOLRSZtpL3pUNHW+LVDVcxDvpJhT8htrhcr9sWoej3ktuf
	fxUN10OGIu/ED9icwdx1B3qXUvHPfzOgRJWx4gD6yoFDOwUiSGgusd5wD30jXmTl
	j9iw5Kb+LKFL1GoWKe0Ze4sdKYyEA17hF5Fuq5ML9CYXbYfDHiMAt8KbNJ6ELe5s
	LdVSKrkav2y93Evmj4COoAhx5QM8o3GKgA+FSSc0UCGXlEyu1BMt0Yuaw==
X-ME-Sender: <xms:JssHZ8uXPOhjLg22u2tTvZQ4-O7wUaTlVHWazSJFQAuhq2QFnE4xvQ>
    <xme:JssHZ5cfR5P5jIQfQjKjpExDzRkiTkwI7Iy_kjkD2FLBgEVtcz9Cc1BhCPmB6tYrF
    cGpI7YKd9AacFRCG6Y>
X-ME-Received: <xmr:JssHZ3x1PqQzWeW-sqTA2m8apkUrQceX-9-3sGOUZnWEHY9a8WJrFSCU_rAFZBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomhepofgrthhirghsuceujhpprhhlihhn
    ghcuoehmsegsjhhorhhlihhnghdrmhgvqeenucggtffrrghtthgvrhhnpedugeffkeehge
    ehvdfgfeelvddugeffgeeuudelfeekvedtfeejgfduhfdtveefudenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsegsjhhorhhlihhnghdrmh
    gvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    khgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhtghhsehlshhtrdguvg
    dprhgtphhtthhopegulhgvmhhorghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    rghsshgvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhvmhgvse
    hlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqsghl
    ohgtkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifrghnghihuhhg
    uhhisegvudeiqdhtvggthhdrtghomhdprhgtphhtthhopehmrghrthhinhdrphgvthgvrh
    hsvghnsehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:JssHZ_PZWCdWw1MnyirDgjLRqQijWsc_50CEYT_eijd07AO4Z2wbpQ>
    <xmx:JssHZ8_i7HasBcuitj_-ighBhbyJKhAsF5bjPR3M4V5ymqZJmXDH6A>
    <xmx:JssHZ3UoXZD_pYsii7c9-B6FB_-vp_d45EUmUlJAqjMo6jq70bqQ_Q>
    <xmx:JssHZ1fpfF5I1pLLbSBtXRoAKMB6pQz1RRG9Th1fUGzzx5KamsATnQ>
    <xmx:J8sHZ3VCktWc0Gw4LoFUZG4T2m4qsDnq5aV-vFMjCriXxPOgmUpQo59h>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 08:40:05 -0400 (EDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: kbusch@kernel.org,
	hch@lst.de,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangyugui@e16-tech.com,
	martin.petersen@oracle.com,
	hare@suse.de
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Subject: [PATCH 0/3 v2] nvme: add rotational support
Date: Thu, 10 Oct 2024 14:39:48 +0200
Message-ID: <20241010123951.1226105-1-m@bjorling.me>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Matias Bjørling <matias.bjorling@wdc.com>

Enable support for NVMe devices that identifies as rotational.

Changes since v1:

 - Removed random entropy addition.
 - Replaced the nvme rotational patch with the work of Wang Yugui.
 - Included Keith's nvmet test code.

Note: Please expect delay on v3 as I'll be out next week.

Keith Busch (1):
  nvmet: add rotational support

Matias Bjørling (1):
  nvme: make independent ns identify default

Wang Yugui (1):
  nvme: add rotational support

 drivers/nvme/host/core.c        | 13 +++++++++----
 drivers/nvme/host/nvme.h        |  1 +
 drivers/nvme/target/admin-cmd.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/nvme.h            |  1 +
 4 files changed, 43 insertions(+), 4 deletions(-)

-- 
2.46.0

