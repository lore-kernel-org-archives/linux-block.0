Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4351E00AA;
	Tue,  8 Oct 2024 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399329; cv=none; b=A3XVddJoCqFRHEHrTDrkqRV823h2abEBnVdxEpEyuTFI7kQNK+U5OGSDkOSR/KtfhBYfYPTVZh9pvRJz336ZErPcyZ9v/SDp8DUXH7KpBgJQTjCaN+vug62GLV30chioJ48rqH1BUsh10wfE346WHhysdhyd8gs4nf79kasvKI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399329; c=relaxed/simple;
	bh=Bk7QM+rVFv2wXy/wHI+36XVT2XALN+uWLT7lljS6dPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ax4Y7dVtYT79hZZODAdX/Zk2fDK/PZ8tGzFq4CDoYLrnCHpVMVh8CZz9Iylv1HBB02fC3uXlhBomwC26PVBDoWn2pmS0qH+m0GDr6naOG3VqAYPQRiL2MC6Beo7bhmCQSV1OtclUWxgYiol8cOD4SnZ9M9D8E9kO1eCpXNoZwvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me; spf=pass smtp.mailfrom=bjorling.me; dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b=U/vQRSjy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jl2f0yGv; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bjorling.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b="U/vQRSjy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jl2f0yGv"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF83C114022E;
	Tue,  8 Oct 2024 10:55:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 08 Oct 2024 10:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728399324;
	 x=1728485724; bh=js32dkdye8YTfXqTgEmAVBWITQHNETUK2Lpip3icE50=; b=
	U/vQRSjy+i77DB0y59gXsJjy04HUktwLx1/zz/Uy3qdatQ2pVrIoo6h3lFeVyd21
	VJthMFWmKCdURq4rvawwAWj+10p+9W4xgYIymldvbyjxWgXjp9MjcbuHuKCVIGFZ
	mmNBoi8iaOI0IJ8Xe14InMdkwKwQ26BCBV6YavZG4jhf6mFiudNQQAjafQb4B995
	7WS7qXu2bHJ6jOIZEAQ8wqGQnqVye8LyahU9/Zx3YZpIp+uUxkBwNuFlL9qOnA7p
	KBaS9eoqpW8wfwNghej8kXljtxv4shJ81HFdNpd8u1koWELVPrtGhFM7q7Q7acyn
	UtRQmn2ZI7lJ9gatOHC6OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728399324; x=
	1728485724; bh=js32dkdye8YTfXqTgEmAVBWITQHNETUK2Lpip3icE50=; b=j
	l2f0yGv7QaJeZIMh0Wxb2CDHkn801m9dbgtu93nMIGmDk0RJcfXvbjm3vRktepTp
	PoaHBwb6Ny2tJJju4TVZ7TKb7yiFtIxiugJTOwjol4UiFJCrN9th5/Nnt/gZsSIp
	q3m0yIFNdEgNgB0WUkzJ8IKIEzAhgGDP/YRzsyP//gTqg7cOGJe9ykNb9fLCVH7k
	BvbKUPmEOjks/8vhQ1zVySI/9/OI3wNm/smdLCPAU4xAvxheUWmemtYtZU5ndHg4
	rJFLZlqvpXZvMyV45uHqbw8SAHIcm8rEJxb5CLjI6NWZFfgyhhfxalttTdNRsikw
	yjhskx3q2oeGib+lK2cqw==
X-ME-Sender: <xms:3EcFZ1jUxECZGujcz_LRrWC6Z9qe2DZF6sPbN3-0r1PmFh993CkwGQ>
    <xme:3EcFZ6CVq8Mjx0nDJKGx4U21CW_DewbDbbL-7JykEV6WgDRPXj-Ih1FXtvbSODbBJ
    Hnumn3shC27OeiYe3g>
X-ME-Received: <xmr:3EcFZ1HNXB8YzVR1oeku7IwgJy5PDShNQc94WSI9N2wGe1cofcpL-gAf8LZpmBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrthhirghsuceujhpprhhl
    ihhnghcuoehmsegsjhhorhhlihhnghdrmhgvqeenucggtffrrghtthgvrhhnpeffkeegvd
    fggeefgfffteeghfetteetudeiteejgfevudeifeelffeuiedvueelheenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsegsjhhorhhlihhngh
    drmhgvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgthheslhhsthdrug
    gvpdhrtghpthhtohepughlvghmohgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    tggrshhsvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnvhhmvg
    eslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgs
    lhhotghksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrthhirghs
    rdgsjhhorhhlihhnghesfigutgdrtghomh
X-ME-Proxy: <xmx:3EcFZ6SdiYQSvbNRzBIjwZ_59iz2r8quBIwOIFFYHTLW3jklb2AYkg>
    <xmx:3EcFZyw7rdmq9A23ed60GBkG3yPL4wYIDyKpUC9VoE7XpKOGaf4qTQ>
    <xmx:3EcFZw5WYocDuBFBoXWXU_A1GzLPe3L8BlyUoCX4ykCVBC1ar9E2PQ>
    <xmx:3EcFZ3zJtOk2tv7ETt7hEbFbu2yK6-_tHyVHeTtY93uDHlhpdZ_eSA>
    <xmx:3EcFZxmsjVBuOMVcIWPzxCaOQqtxDI2cdpieks5W2IZA7lit0MY-rLk7>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 10:55:23 -0400 (EDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: kbusch@kernel.org,
	hch@lst.de,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Subject: [PATCH 2/2] nvme: add rotational support
Date: Tue,  8 Oct 2024 16:55:03 +0200
Message-ID: <20241008145503.987195-3-m@bjorling.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241008145503.987195-1-m@bjorling.me>
References: <20241008145503.987195-1-m@bjorling.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Matias Bjørling <matias.bjorling@wdc.com>

Rotational devices, such as hard-drives, can be detected using
the rotational bit in the namespace independent identify namespace
data structure. Make the bit visible to the block layer through the
rotational queue setting.

Note that rotational devices typically can be used to generate random
entropy, the device is therefore also added as a block device that adds
entropy.

Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
---
 drivers/nvme/host/core.c | 5 +++++
 include/linux/nvme.h     | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9cbef6342c39..a445f13f5a28 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -41,6 +41,7 @@ struct nvme_ns_info {
 	bool is_readonly;
 	bool is_ready;
 	bool is_removed;
+	bool is_rotational;
 };
 
 unsigned int admin_timeout = 60;
@@ -1623,6 +1624,7 @@ static int nvme_ns_info_from_id_cs_indep(struct nvme_ctrl *ctrl,
 		info->is_shared = id->nmic & NVME_NS_NMIC_SHARED;
 		info->is_readonly = id->nsattr & NVME_NS_ATTR_RO;
 		info->is_ready = id->nstat & NVME_NSTAT_NRDY;
+		info->is_rotational = id->nsfeat & NVME_NS_ROTATIONAL;
 	}
 	kfree(id);
 	return ret;
@@ -2170,6 +2172,9 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	else
 		lim.features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA);
 
+	if (info->is_rotational)
+		lim.features |= BLK_FEAT_ROTATIONAL | BLK_FEAT_ADD_RANDOM;
+
 	/*
 	 * Register a metadata profile for PI, or the plain non-integrity NVMe
 	 * metadata masquerading as Type 0 if supported, otherwise reject block
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 7b2ae2e43544..6d0eebb57544 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -560,6 +560,7 @@ enum {
 	NVME_NS_FLBAS_LBA_SHIFT	= 1,
 	NVME_NS_FLBAS_META_EXT	= 0x10,
 	NVME_NS_NMIC_SHARED	= 1 << 0,
+	NVME_NS_ROTATIONAL	= 1 << 4,
 	NVME_LBAF_RP_BEST	= 0,
 	NVME_LBAF_RP_BETTER	= 1,
 	NVME_LBAF_RP_GOOD	= 2,
-- 
2.46.0

