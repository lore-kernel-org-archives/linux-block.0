Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4FD1E4B2;
	Tue,  8 Oct 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399326; cv=none; b=gXB7hGNWV0WK9JuSZzn0pVEQkKZWD5srMZ57yzRq7vWeUhHalFeoPAlYcHPp4SK2nzXnVTAZomiQLzl2/2GaLx/e0Dv2hhfor8UxP41fn5gzpV+3mqsVTA0YXrRteTI7Gly/2nthurKQ/9rH6ClMQ9VmR7XMek0zDpvM/o7/qNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399326; c=relaxed/simple;
	bh=KjCh9TiB71GCKtR9M/0flwzyy5d+37QXAkq6HOcgcOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WI7oaWOwdPTsjnMPdd1PE6ZlCoCPF1fMYMpQ+AM31t14EhG7cELauB3pyFm6VKqwfYxmZjwkU2S+LNjASF/Bga7St25aorwQ5S/VjHHvHFNSqstCLF6VDCgmfl25aoVyA7wb4m7zCAFyvNjFskoZhz+26CwWCN7OWKekeFmo9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me; spf=pass smtp.mailfrom=bjorling.me; dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b=DcMx4pbY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rsj04EuS; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bjorling.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bjorling.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bjorling.me header.i=@bjorling.me header.b="DcMx4pbY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rsj04EuS"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 703EC1140217;
	Tue,  8 Oct 2024 10:55:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 08 Oct 2024 10:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728399323;
	 x=1728485723; bh=xHIs0lcNCSIzydBGO9Xs3o6nAYW19CDkOevo4gGwYu4=; b=
	DcMx4pbYDXNfOI0ZNkGk7yyVOvkXptjzUiZddcLMvwZBXoDp6/DHirz20+d1p9ck
	QEvkp4iEUQJW+AliN2YiGMGvq2NHdivjgRt2f7ZNqV8F/HYUPjQoAZ0hlD3P94lL
	toLGxIOHsQkQ78MovQ5YBByEXUtC28KD+kSfG+kX/AmVZxYRrbDXnz7C1GlALG1u
	tCt9B2R+okfYHjDLdAtEfq+FqS4m2FiA1Qi2GgcyS4lGNTCnGlsf2bf9x2nt/spI
	BxBA7EE8VeJiNYGd7YW2Kn1NaM7wtQ7JhU7JpQlmUT7O7Pn8OJGZPm0iqD3xeheO
	o+QYvGWKFf1e7OiAt3solQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728399323; x=
	1728485723; bh=xHIs0lcNCSIzydBGO9Xs3o6nAYW19CDkOevo4gGwYu4=; b=R
	sj04EuSilxF4HwEnKRv8M6CqdhPLjPTwghmuHwpxOz97ozIYsoB6Q8T3gpz+jSti
	FfbJ41wFC05p6x8QNBMMxrjFDDn3dW6ZUSXQ/k+Gn+HMZKOBYDoZxRTbpjEuZf0M
	SmRmi1wk21iuE1xR6cyfXUG/DEeNfeh3K2RRBmaXCVj9PyN9IPUsRKn1gqoECeZ9
	tCYj7M/zKCzOGP17MWovcT8wnp7w6VgCeCnu56167RT+NQsjVYyPh+pZXmPPz0vD
	Mc7RRXaW00g+eh9mD178q9xIMuBVhwf0w5ZTCBfBB6/0mxkad+cRxYAEL/2VdAa+
	osVnL6n5MQJptvJn1OkLQ==
X-ME-Sender: <xms:20cFZwaQEgMg-FcX18HN9mZLIlzVnU6TnSlizgRqLb1vIVvWYvwOog>
    <xme:20cFZ7bSyj1Q290_U5KLM_jtCikLvgYYGH7qiXnnokYbHLif3bJcjS_Ch3WVFr2xA
    3vMGPIOqz8g8gweITg>
X-ME-Received: <xmr:20cFZ6-T05No7OR9czaK2sKyu_SaPBS1AnUjjob1VwwJwHcV_NcZNjbG95rm3gs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgkeefucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:20cFZ6qH_DMbH48go3xnu06DmikC4k1JCpyxlwJ1AnV6VSvuq0K0sQ>
    <xmx:20cFZ7pDZL0KvAIMM8Afrr6-bonvkoGLO3S2VdiiuM5dC4DJunVhyg>
    <xmx:20cFZ4SO6PRPqodqTEuK7hlmYQhpRXr1IMUwYMgyAbVbn86bIxgjpQ>
    <xmx:20cFZ7rXXIPHbRAxSekveVXgpaQ6xc4so_VqDWY7v_RV7ePpxeA8eg>
    <xmx:20cFZ_fF2vI4_uHsDFbwKWHyNkiIdcZzzmiIFSlxo1nN8O-H8HwdDl2Q>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 10:55:22 -0400 (EDT)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: kbusch@kernel.org,
	hch@lst.de,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Subject: [PATCH 1/2] nvme: make independent ns identify default
Date: Tue,  8 Oct 2024 16:55:02 +0200
Message-ID: <20241008145503.987195-2-m@bjorling.me>
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

The NVMe 2.0 specification adds an independent identify namespace
data structure that contains generic attributes that apply to all
namespace types. Some attributes carry over from the NVM command set
identify namespace data structure, and others are new.

Currently, the data structure only considered when CRIMS is enabled or
when the namespace type is key-value.

However, the independent namespace data structure
is mandatory for devices that implement features from the 2.0+
specification. Therefore, we can check this data structure first. If
unavailable, retrieve the generic attributes from the NVM command set
identify namespace data structure.

Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
---
 drivers/nvme/host/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0dc8bcc664f2..9cbef6342c39 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3999,7 +3999,7 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns_info info = { .nsid = nsid };
 	struct nvme_ns *ns;
-	int ret;
+	int ret = 1;
 
 	if (nvme_identify_ns_descs(ctrl, &info))
 		return;
@@ -4015,10 +4015,9 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	 * data structure to find all the generic information that is needed to
 	 * set up a namespace.  If not fall back to the legacy version.
 	 */
-	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) ||
-	    (info.ids.csi != NVME_CSI_NVM && info.ids.csi != NVME_CSI_ZNS))
+	if (!nvme_ctrl_limited_cns(ctrl))
 		ret = nvme_ns_info_from_id_cs_indep(ctrl, &info);
-	else
+	if (ret > 0)
 		ret = nvme_ns_info_from_identify(ctrl, &info);
 
 	if (info.is_removed)
-- 
2.46.0

