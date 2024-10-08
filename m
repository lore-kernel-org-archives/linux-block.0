Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B32DDDC;
	Tue,  8 Oct 2024 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399326; cv=none; b=QdNuoTXS3yYsFeNeYh+Mb7DTWGyfRkHXiVGWG4m0VKO+MVkIHw4C0MVELIIMpbSxeoCfiClAtLXWqnDjRBa/Gnuv+hzUR2YcaILgSqTnvbbjdAdJEHdh13n7rhLFG5S5jvY03gyx9Pw7tvPCFHxzzvFa20OvW2CVttq7IzxBKFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399326; c=relaxed/simple;
	bh=W8eQq9YG4NkByNJtvfoEFHbRrapq4cTYFRvOGYOeNeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CaIcFxYeAMW7tIzMXga1wc1ON8rpydlwVDXLWBjUmbCxhmPvI+Upd0dnzQ+8PTXulCK+uHXefkxLotc/GBCl/mjQ/zDYL2u4fatdDhOYIg6cNRValhxfakxFgJJK9D55i86+WiiOYE7kk5zTa8+qOoma5IGNdIov5FBLt+Hluvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me; spf=pass smtp.mailfrom=bjorling.me; dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b=JVU5R0lk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mKRnuW+u; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bjorling.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b="JVU5R0lk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mKRnuW+u"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 02024138039A;
	Tue,  8 Oct 2024 10:55:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 08 Oct 2024 10:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1728399321; x=1728485721; bh=s/
	lymXYoCV742fut5rNz1QdRGMwe+LLRB8FhDplNi34=; b=JVU5R0lkKv4f13g/Sz
	RGl3h9EkgbQk1nfZ155I1Sgv1x5HpD9msMhkOjubfYf0/gZG/tW40L7Dzl8oVUQH
	/SnzhZbvE9PAoVRWyI0Q7dryZsNLzKSBKPbdx8ek0fWI75DwcDAEH2YbmOiqHQRb
	Euq1evAttlT/2Bo6ZIbLVbkGgvT4ct5IhktsP5t0xPKkoNLliLh1elUFE2OBtCiT
	6E/qW/fHeIhbMny2OVXiU6LotTACtnQ5R2I6gCyjgDl69Nmsu8AF1Pv4qjTP3LHT
	N7C2R+kZ/ZjJl06yl4l8EzchvPkhhgyAk4zv2qWM86mcfqnTa+uVxWGH1eO5Tqn9
	SblQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1728399321; x=1728485721; bh=s/lymXYoCV742
	fut5rNz1QdRGMwe+LLRB8FhDplNi34=; b=mKRnuW+uEpbNkYDIK23CLu9PItby3
	1vWzvpIBtygGsZSOTReMScbdI8hZCtGVKfa11QndljNUqxRThUg+TQDpNdmz+85S
	mC3LDpP24dahey9N3pGNForHobzK+BP0zD3xDDapTNSW1rnCx/e/8yc50dOhzpkB
	xgOqqWQiNRKBdCuUglLt2JsSITF+lxAYxXDB+ePGziWx66UKjeOrYRo0/pXPqOHC
	9TsT0jg6NuCpHhfAmLCp4UQGfMbwbGciMjV6oVZatckfjFPBigOhhW877duQWlrv
	yyodiaHvRFJUpnQRIFLdfwCk57CbsFvkWaZuVCT2ji8ydh7nB+qLH1s1g==
X-ME-Sender: <xms:2UcFZzQo14R-qk98LZwhAe_IC_XEYSDmAcZ11LyY9UDZr_EN4_CoQQ>
    <xme:2UcFZ0zyoE3cyaxwVKcnib_HuAFsf5naV_RjH9yXmr12HPPDo4fUWR03CNytKFeC3
    kGKO7zk1DdtSVz0D_s>
X-ME-Received: <xmr:2UcFZ43Kp-Q3TXNSZFmqp71nz-F0arODMYbjS5vpprBEfxVVzphwlLafgv78X9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomhepofgrthhirghsuceujhpprhhlihhn
    ghcuoehmsegsjhhorhhlihhnghdrmhgvqeenucggtffrrghtthgvrhhnpedugeffkeehge
    ehvdfgfeelvddugeffgeeuudelfeekvedtfeejgfduhfdtveefudenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsegsjhhorhhlihhnghdrmh
    gvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehk
    sghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggvpd
    hrtghpthhtohepughlvghmohgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggr
    shhsvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnvhhmvgeslh
    hishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgslhho
    tghksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrthhirghsrdgs
    jhhorhhlihhnghesfigutgdrtghomh
X-ME-Proxy: <xmx:2UcFZzBYS2DP7xV_zRjZ9-Q1XvdbCb6jBRorYfVE1H_l7FlYvx0ftA>
    <xmx:2UcFZ8hw09kA2A4Aua9-mwgSFD55KD1mdNQ0vEahy4N7IoTL1JT0uw>
    <xmx:2UcFZ3pRoZ-mHlX8K6Xbp_2IApF_Kf1ixjLlYb9UX6UGzv0Dn79Okw>
    <xmx:2UcFZ3je-EGBIFCB6804HHLQjJGrMLxf4lNEey0rTsbOypzj7rAGNA>
    <xmx:2UcFZ1Vwwj086ME2qaOkAcynZJ_7gCpDd8ZGPgO6TKdHPu21TqLXDd2x>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 10:55:20 -0400 (EDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: kbusch@kernel.org,
	hch@lst.de,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Subject: [PATCH 0/2] nvme: add rotational support
Date: Tue,  8 Oct 2024 16:55:01 +0200
Message-ID: <20241008145503.987195-1-m@bjorling.me>
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

Thanks to Keith, Damien, and Niklas for their feedback on the patchset.

Matias Bjørling (2):
  nvme: make independent ns identify default
  nvme: add rotational support

 drivers/nvme/host/core.c | 12 ++++++++----
 include/linux/nvme.h     |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.46.0

