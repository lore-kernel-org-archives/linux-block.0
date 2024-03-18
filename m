Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B4C17547
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 02:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710728304; cv=none; b=tP1IdRkSLUpt95FKeoNi/W+mDMIwMQy7BG9e4qLRLLnYZr+sdcy75uV8RU+dInmk0k4DyblYN1IZx77LmHan2jyQTomm51ekVkmrzU4/GsAIlCng3qZ5eBM9QhPAbXkYQ7vU05hFiLIBCqC17KzeuMBEH9HoR9SQodeklyd2rI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710728304; c=relaxed/simple;
	bh=oZVsozu7jxsoMpL03TB6T3o7YkYMxMLbBsrTCZa95b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Je0L4jyp/+Ty3xuj8OTrONYBHNgb55B6hGuNGjnU2UQfNLMCDhCkq9qQAPIpAX9L8bv2HL9ghbm0coZYs3ItwQauK3Rub5egAVA9eqwL5rBVn6lJG6mjwysG9em6X5vt61QaC5HJbftmhn0QM3beiNW4duQb0LRHsJjh8GtxMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lo2Tq+t9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lo2Tq+t9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ie9Ap0Vg8rzZC4lIOYHUtldkDGU569+6gIelLh9GLyA=; b=Lo2Tq+t9TmA9pzy3UHmVNN5/gE
	bYayE5ei88cQNrpATshbGGci0TwNTzlygYlcXR4puH3SUzkCbX6wMjNni8tmP+PSQoItdQRrPVxkM
	4Oh/Whl8FmKmarHfAbRAxdw+XDBk9MXHCJj9UY8++SUjzFb0/vS9mS+ljBN2epFU/sCLAGVVsjYuU
	l2qG295ZSyss7wFcPR9IkErCasYGJEAce9BepS8QdvlVRBABBvX6IIj6mGraB8AojsVMDGkrQdeUD
	jhBXB/72ymeBF4pCW0lplwz8p8u9+2MMuavo5u1WFaaO7lYql2wjuclzFEGgLJpgQn+1IQj0Oazcb
	F5WeocVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm2Zx-000000071NT-3n7C;
	Mon, 18 Mar 2024 02:18:21 +0000
Date: Sun, 17 Mar 2024 19:18:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
	axboe@fb.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Gregory Joyce <gjoyce@ibm.com>
Subject: Re: [Bug Report] nvme-cli fails re-formatting NVMe namespace
Message-ID: <Zfekbf0V5Dpsk_nf@infradead.org>
References: <7a3b35dd-7365-4427-95a0-929b28c64e73@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a3b35dd-7365-4427-95a0-929b28c64e73@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Nilay,

thanks for the report!

I'm currently travelling without easy hardware access, but can you try
the patch below?  This simply rebuilds the limits from scratch.  It
probably wants a bit of a cleanup if it works, but this should be
fine for testing:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 00864a63447099..9ef41e65fc83bd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2215,10 +2215,13 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
 		nvme_mpath_revalidate_paths(ns);
 
-		lim = queue_limits_start_update(ns->head->disk->queue);
+		blk_set_stacking_limits(&lim);
+		lim.dma_alignment = 3;
+		if (info->ids.csi != NVME_CSI_ZNS)
+			lim.max_zone_append_sectors = 0;
 		queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
 					ns->head->disk->disk_name);
-		ret = queue_limits_commit_update(ns->head->disk->queue, &lim);
+		ret = queue_limits_set(ns->head->disk->queue, &lim);
 		blk_mq_unfreeze_queue(ns->head->disk->queue);
 	}
 
