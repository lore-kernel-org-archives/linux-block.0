Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F73AC433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 07:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiDFH0s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 03:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1576243AbiDFGqH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 02:46:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0E5474A37
        for <linux-block@vger.kernel.org>; Tue,  5 Apr 2022 22:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CT9E1WyFV78lNGbgBTxuNPDqR29ylS3lVr+dNAQX09g=; b=lv6KXqr9v6E+H897+r+bibfh6z
        2VctEoqicC7uA4zxq4DFvgDDPsmsbDKXlsQrIsnKflXPMuNBvRsIrLNhsUC46hsSKLPI/4Of5ZWZj
        JVe5SHSnQ0Ivef0aCrUbRBkS+A+KYYj2zz5YL4jRL50Lolvep2QFlv6HlvuHz15tfcMzkvK20JNnM
        n7jqLGOaP+wBhoqdDi1z9ArDU0juyg29qIynpgs11yo9Z/5cJjXTzpCl+/nHrnpk4+ZwiM/9UEEPI
        Gm0PYMgjniX3BG0Y4K0K3honl671KG3jzPYLg44ClLKeaDmDo4/h5sd5bXKU783CMrr6jlS9Vbphx
        nYg0slPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbxmP-003mxi-Ub; Wed, 06 Apr 2022 05:00:29 +0000
Date:   Tue, 5 Apr 2022 22:00:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com, dongli.zhang@oracle.com,
        hch@infradead.org, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v5 1/2] virtio-blk: support polling I/O
Message-ID: <Yk0ebS3cl95XtOuj@infradead.org>
References: <20220405150924.147021-1-suwan.kim027@gmail.com>
 <20220405150924.147021-2-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405150924.147021-2-suwan.kim027@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 06, 2022 at 12:09:23AM +0900, Suwan Kim wrote:
> +        for (i = 0; i < num_vqs - num_poll_vqs; i++) {
> +                callbacks[i] = virtblk_done;
> +                snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
> +                names[i] = vblk->vqs[i].name;
> +        }
> +
> +        for (; i < num_vqs; i++) {
> +                callbacks[i] = NULL;
> +                snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
> +                names[i] = vblk->vqs[i].name;
> +        }

This uses spaces for indentation.

> +		/*
> +		 * Regular queues have interrupts and hence CPU affinity is
> +		 * defined by the core virtio code, but polling queues have
> +		 * no interrupts so we let the block layer assign CPU affinity.
> +		 */
> +		if (i != HCTX_TYPE_POLL)
> +			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);
> +		else
> +			blk_mq_map_queues(&set->map[i]);

Nit, but I would have just done a "positive" check here as that is ab it
easier to read:

		if (i == HCTX_TYPE_POLL)
			blk_mq_map_queues(&set->map[i]);
		else
			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
