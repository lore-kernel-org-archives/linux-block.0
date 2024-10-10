Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E701C68B2;
	Thu, 10 Oct 2024 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564014; cv=none; b=D9Pr+f/80eonxYd9tdtPy3nuOBybSmV5j/GC8Xl1cenCgg3OmoVp3by3X6+pUTnHC+aN5PJIp3R2tkg9itQrL+GknGOmtB0tnm9q7btr0myibhzsCO4sNI3XmMwY6MV8QV1DKq7jucr4bBNrDHwRF36h0+U25fvBlf6UNGbKDII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564014; c=relaxed/simple;
	bh=68I1lwYU/+wJ4dnGG2TL+FT7xhZy5zqqb4ROoSUvlIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+3+N+ItQRObQ2GelwcouS7NgzARKWmH5pUSnL8igT8zF4UTkJM4A8JQ/F8jc4Hh/imTcT6dqlzgdIvoyFMfHt0b+htP37hnYzD0FUtQNI39bEKc7151pBuswlW1/iXW/4RNYGruHF860YT1NJRNmRmVGG/zbWiqVYbkdZRUsH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me; spf=pass smtp.mailfrom=bjorling.me; dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b=E3MkTl43; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B4dHZQCE; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bjorling.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b="E3MkTl43";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B4dHZQCE"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 95F36114026F;
	Thu, 10 Oct 2024 08:40:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 10 Oct 2024 08:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728564011;
	 x=1728650411; bh=Y4deuAV5jZ+rAUYMVlMbFoNe/5E0fsyGDwmlrSxU7dA=; b=
	E3MkTl43mlmTpBpIYZpMWXm9GFW5kdDPRrUHzjH3IyDbk/XzJ5aCGXRe3cQHAeRn
	sWXwgfFG6e1p/wew3IXozNZlZaOp0rY3VW8ql+exd0FnDmy0CvkVWMhUyg+R0PLj
	LWmpQ2AAD8Z1WiJLm5jlXK66S6Yr4f3LAMVsZWPK5Mi2njKPxoSnmh0t6F+bvpIY
	u+hnZ9aWoygbFOQhc6owsKWkw5hVPxneFqijvgK1gu+6rrqQGgW9BSEeXoDfqR2z
	MJESWkGAagMs5thcX2Ib4cdoQd92raUnOPlg2o1OKHQs+0Jr9WKhm9/zma3NkPiB
	iuzISBaOzPChq1jyFEcMYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728564011; x=
	1728650411; bh=Y4deuAV5jZ+rAUYMVlMbFoNe/5E0fsyGDwmlrSxU7dA=; b=B
	4dHZQCEzcipYAHYFqDbWsXVuj8udK6MdvvKNfPzJ//dWgwyOg47kB1Wv1AtsHC2e
	5GmlWZtAQsT0ag0L15PgVZt5gplB2HVPsPNqydWwko5gyOMji2EGQf6btTgX1ap9
	Tl/iR2oN9XAKZELMpCdSFf4qK+veVbm4S6tJdRd3v3OWCfKbq5KFTM+9xb+fYa6l
	UpE2cT70NbOqdf6ofkXRFUlPR0zLlUsixYvWeK7iVPem+ckSPTfXmg7t7T3b6BWH
	v9B0XTlo5kCxcJq2b22s1odNVBbEZyq/9TAEGWIYzDsNu9iApYTanrpHNd5MCfZg
	Zlxg25KwAkFzp/WyilFvQ==
X-ME-Sender: <xms:K8sHZ19pUw9Zg_a1LJrZj2bU0MDq7txKeoqjM7lF4YeRZm_tCLiE6Q>
    <xme:K8sHZ5tTuURjVYusuKJvxH-MhttnVpXiMhlkNpsMnZPVKQY3ChA6rytt0EooWlTjk
    fO4zvBlcpSw3QxifTo>
X-ME-Received: <xmr:K8sHZzAzSjiNouVrRpy4PDsFur2ScH-5Af4xrZxO6O0cNTYyVciSfNnf4hJcg9E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrthhirghsuceujhpprhhl
    ihhnghcuoehmsegsjhhorhhlihhnghdrmhgvqeenucggtffrrghtthgvrhhnpeffkeegvd
    fggeefgfffteeghfetteetudeiteejgfevudeifeelffeuiedvueelheenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsegsjhhorhhlihhngh
    drmhgvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhtghhsehlshhtrd
    guvgdprhgtphhtthhopegulhgvmhhorghlsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegtrghsshgvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhvmh
    gvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidq
    sghlohgtkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifrghnghih
    uhhguhhisegvudeiqdhtvggthhdrtghomhdprhgtphhtthhopehmrghrthhinhdrphgvth
    gvrhhsvghnsehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:K8sHZ5dXuLbeWFCWC9FMMfga3Hn8PiAXwZcppClF8Ue6UlMXYJPMCA>
    <xmx:K8sHZ6O5plh9MtqX3urKr-IFGpH6-P3OtmXkXTuG4xhoS_5nQsR1gQ>
    <xmx:K8sHZ7kY8IZYFfCzYmUwxi4dMMFntMnblDA52e8p0KoFBS4wjd0hcg>
    <xmx:K8sHZ0tOmtUEqGgfrVNWiA-o_nW2ZBU2C7ir0m8P5kQX6g0MdM2NWg>
    <xmx:K8sHZ7nLkfXXZU-00hoTb6fK5h_w58FZmPd2gaqb2FVtt-sBxa0C37PA>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 08:40:10 -0400 (EDT)
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
Subject: [PATCH 2/3 v2] nvme: add rotational support
Date: Thu, 10 Oct 2024 14:39:50 +0200
Message-ID: <20241010123951.1226105-3-m@bjorling.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241010123951.1226105-1-m@bjorling.me>
References: <20241010123951.1226105-1-m@bjorling.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Wang Yugui <wangyugui@e16-tech.com>

Rotational devices, such as hard-drives, can be detected using
the rotational bit in the namespace independent identify namespace
data structure. Make the bit visible to the block layer through the
rotational queue setting.

Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
Reviewed-by: Matias Bjørling <matias.bjorling@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>

larlar
---
 drivers/nvme/host/core.c | 6 ++++++
 drivers/nvme/host/nvme.h | 1 +
 include/linux/nvme.h     | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9cbef6342c39..a83cf54c5861 100644
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
+		lim.features |= BLK_FEAT_ROTATIONAL;
+
 	/*
 	 * Register a metadata profile for PI, or the plain non-integrity NVMe
 	 * metadata masquerading as Type 0 if supported, otherwise reject block
@@ -3619,6 +3624,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->ns_id = info->nsid;
 	head->ids = info->ids;
 	head->shared = info->is_shared;
+	head->rotational = info->is_rotational;
 	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
 	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
 	kref_init(&head->ref);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index da57947130cc..3a36548d5c05 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -469,6 +469,7 @@ struct nvme_ns_head {
 	struct list_head	entry;
 	struct kref		ref;
 	bool			shared;
+	bool			rotational;
 	bool			passthru_err_log_enabled;
 	struct nvme_effects_log *effects;
 	u64			nuse;
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

