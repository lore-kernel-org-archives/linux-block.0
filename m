Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8622F7AB8
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769759142; cv=none; b=U/cyvMaoVKbLXYyG9WfH0FkMjKFWHYs7hNvbzxxc/JlC96dAt37HHo3nL57H+HjPg2ZDNKM69l7uAJT0UgcEE1Ef8YELXpjwxhg4dMV7O2E5Jl0325lq/B3VQFNfcpLsl4A0Tms0PDvAQ0Fe2jque2bdW3w6QmA2ePqpkzF6Qos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769759142; c=relaxed/simple;
	bh=X6vHrrPDnneDb/mj83cQG1vUQkzk3LGeqywjcYM57k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nn+jMAzPFgAaSa/xIVhxLFg91YDY03Sg5r56pFe2luVN81dpVmru8awkUtqg4jfJY0CdFvNHBeDEnj4qzkwbojXCwq7oiMybOEgiuDWGPUS8mWuf8zEJ6CMKrwcwKtHA8Y5JyixyKn3usNA+/1JzZBy1C0Ub1qI6RlG/f4GeyuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2+S9U7M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2+S9U7M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769759139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uh32/EDIQFDFOnj8fdFERKIKqaaMmN6sE/HYcKgTjVw=;
	b=C2+S9U7MaQHsQ5fEDMEdFMpkublUryG23MM8zlbl++JtO9ULSkMzD2eYVdLQFE6nMzi+NJ
	aFRhnZATUPnJQZQyVNl/pxnbyEhhT13XeeF7enhcFxRjoKsVE9ePsRDV6drvqHyGqDMeIa
	rzqkZ6FppqyUQ0edc75792Ej2wA0a7Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-10YjuT3uPGq_m-7LVpifxA-1; Fri,
 30 Jan 2026 02:45:35 -0500
X-MC-Unique: 10YjuT3uPGq_m-7LVpifxA-1
X-Mimecast-MFC-AGG-ID: 10YjuT3uPGq_m-7LVpifxA_1769759134
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C6D719560B5;
	Fri, 30 Jan 2026 07:45:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.182])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D09AE180086E;
	Fri, 30 Jan 2026 07:45:27 +0000 (UTC)
Date: Fri, 30 Jan 2026 15:45:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, justintee8345@gmail.com,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [bug report] kmemleak observed during blktests nvme/fc
Message-ID: <aXxhkUXXOlrRw1sG@fedora>
References: <CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj2M_e1-GdQOkRy=DsBB1w@mail.gmail.com>
 <262c8ac1-e625-4e4c-8b3c-85f842aba6fe@gmail.com>
 <7d718bc8-64b6-4e8f-bad7-7e1615c577ca@nvidia.com>
 <CAHj4cs9gBTHLB_7JrFpZnJ-imc7jmqnhZpqkemaRVQYLn9j_rQ@mail.gmail.com>
 <CAHj4cs-84wsWQKeBS2wkd-_Y4Xe7wcTPqzutisNbXtpcAdh8yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs-84wsWQKeBS2wkd-_Y4Xe7wcTPqzutisNbXtpcAdh8yw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Jan 15, 2026 at 05:24:58PM +0800, Yi Zhang wrote:
> Hi Justin and Chaitanya
> 
> It turns out that the kmemleak was caused by nvme-loop. It was
> observed during the stress nvme loop/tcp/fc[1] test, but the kmemleak
> log was reported during the nvme/fc test. That's why I didn't
> reproduce it with the stress nvme/fc test before.
> 
> [1]
> nvme_trtype=loop ./check nvme/
> nvme_trtype=tcp ./check nvme/
> nvme_trtype=fc ./check nvme/
> 
> unreferenced object 0xffff8881295fd000 (size 1024):
>   comm "nvme", pid 101335, jiffies 4299282670
>   hex dump (first 32 bytes):
>     00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
>     ff ff ff ff ff ff ff ff e0 3c 57 af ff ff ff ff  .........<W.....
>   backtrace (crc 414bcfcd):
>     __kmalloc_cache_node_noprof+0x5f9/0x840
>     blk_mq_alloc_hctx+0x52/0x810
>     blk_mq_alloc_and_init_hctx+0x5b9/0x840
>     __blk_mq_realloc_hw_ctxs+0x20a/0x610
>     blk_mq_init_allocated_queue+0x2e9/0x1210
>     blk_mq_alloc_queue+0x17f/0x230
>     nvme_alloc_admin_tag_set+0x352/0x670 [nvme_core]
>     nvme_loop_configure_admin_queue+0xdf/0x2d0 [nvme_loop]
>     nvme_loop_create_ctrl+0x428/0xb13 [nvme_loop]
>     nvmf_create_ctrl+0x2ec/0x620 [nvme_fabrics]
>     nvmf_dev_write+0xd5/0x180 [nvme_fabrics]
>     vfs_write+0x1d0/0xfd0
>     ksys_write+0xf9/0x1d0
>     do_syscall_64+0x95/0x520
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e

It seems regression from 03b3bcd319b3 ("nvme: fix admin request_queue
lifetime"), can you try the following fix?


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 19b67cf5d550..64db8e3d8fd8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4848,6 +4848,15 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	struct queue_limits lim = {};
 	int ret;
 
+	/*
+	 * If a previous admin queue exists (e.g., from before a reset),
+	 * put it now before allocating a new one to avoid orphaning it.
+	 */
+	if (ctrl->admin_q) {
+		blk_put_queue(ctrl->admin_q);
+		ctrl->admin_q = NULL;
+	}
+
 	memset(set, 0, sizeof(*set));
 	set->ops = ops;
 	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;




Thanks,
Ming

