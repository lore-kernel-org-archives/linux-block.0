Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3089F748E
	for <linux-block@vger.kernel.org>; Wed, 20 Mar 2024 02:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710901185; cv=none; b=g8mglr/IbjDhhnIgmcj0wFa1BFGBexVqYQR8cMlqFIkErRgcd5HYGW4zwuTeLMYIC6rmy9/ZLklG14TaKmzjgnStNyEnZlBVbR9l5ZN0h9FOpCguzWyXcXOsnX640FUdkLSaiIWz9kPDldrDumN5beUxgCeRDMspygBFQb4Rm/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710901185; c=relaxed/simple;
	bh=rsRgISGNPi2VQUArx9ait8eSf6AkqrbqDhCMMy0gu4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBiLGAjx9oqHq+4lk5R3kVqbkvBGBwVbTG8Bn0tDXgPRo4p6y/LUxvys+bsm9DObd/OU6dFjrpeY+5t/r2s4R6tpH88GjlSQxgjZqp/TXovQWIClvdy9nzyP4EaCb8mqHHhxhxs4uj/12x0erJoxRt+0cMwDthCKfYDA0t4GPT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0snTMUuw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0snTMUuw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uAWBFsJk1J8OX0oSrh67rMlS66oFHBxcTn5ZwY0IMX4=; b=0snTMUuwW1NgpOgcQONLw/1ZIn
	TEa3/3QA/kKL2vNN5HzXoWiKjZmqiMEcjAt4D4ylV4wHitUGtuLMNqRlQiWNFM98zHIEoznlsxwlx
	UEkUAikWkB6/t7Ylh9yHdlCxQCuiHQH87SziRx3IUp9L1FNYfE6iy6p+nIlbxfsBfX94cyLIe93Mx
	HCaaWjSCi+WtTSzIVnEsXyosuGhXzv5/clTA8Ok0doD/v/3glPgQMzxYKLH+0SY++LuhKb0xVjFer
	nKuBUSSTfNmzrCx1+78dc8E0CtpaBb3kesdDzUaWjjDScpm870qRZhvoBKp7PR7NQoEGI/9Ku8mqJ
	w3L3ZJMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmlYN-0000000F2g2-0yqH;
	Wed, 20 Mar 2024 02:19:43 +0000
Date: Tue, 19 Mar 2024 19:19:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
	axboe@fb.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Gregory Joyce <gjoyce@ibm.com>
Subject: Re: [Bug Report] nvme-cli fails re-formatting NVMe namespace
Message-ID: <ZfpHvyjT6kbQKrPF@infradead.org>
References: <7a3b35dd-7365-4427-95a0-929b28c64e73@linux.ibm.com>
 <Zfekbf0V5Dpsk_nf@infradead.org>
 <1a37aea5-616c-445c-a166-e2dc6fa5b8f5@linux.ibm.com>
 <ZfjLyfptPVT7wa0_@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfjLyfptPVT7wa0_@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Can you try this patch instead?

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 00864a63447099..4bac54d4e0015b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2204,6 +2204,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	}
 
 	if (!ret && nvme_ns_head_multipath(ns->head)) {
+		struct queue_limits *ns_lim = &ns->disk->queue->limits;
 		struct queue_limits lim;
 
 		blk_mq_freeze_queue(ns->head->disk->queue);
@@ -2215,7 +2216,26 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
 		nvme_mpath_revalidate_paths(ns);
 
+		/*
+		 * queue_limits mixes values that are the hardware limitations
+		 * for bio splitting with what is the device configuration.
+		 *
+		 * For NVMe the device configuration can change after e.g. a
+		 * Format command, and we really want to pick up the new format
+		 * value here.  But we must still stack the queue limits to the
+		 * least common denominator for multipathing to split the bios
+		 * properly.
+		 *
+		 * To work around this, we explicitly set the device
+		 * configuration to those that we just queried, but only stack
+		 * the splitting limits in to make sure we still obey possibly
+		 * lower limitations of other controllers.
+		 */
 		lim = queue_limits_start_update(ns->head->disk->queue);
+		lim.logical_block_size = ns_lim->logical_block_size;
+		lim.physical_block_size = ns_lim->physical_block_size;
+		lim.io_min = ns_lim->io_min;
+		lim.io_opt = ns_lim->io_opt;
 		queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
 					ns->head->disk->disk_name);
 		ret = queue_limits_commit_update(ns->head->disk->queue, &lim);
