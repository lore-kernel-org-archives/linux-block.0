Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19D4C43381
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 16:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE6E64F0D
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 16:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbhBXQqR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 11:46:17 -0500
Received: from verein.lst.de ([213.95.11.211]:38611 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234405AbhBXQqH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 11:46:07 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DD25468AFE; Wed, 24 Feb 2021 17:45:23 +0100 (CET)
Date:   Wed, 24 Feb 2021 17:45:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     javier@javigon.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        minwoo.im.dev@gmail.com
Subject: Re: [PATCH V5 2/2] nvme: allow open for nvme-generic char device
Message-ID: <20210224164523.GB11338@lst.de>
References: <20210222190107.8479-1-javier.gonz@samsung.com> <20210222190107.8479-3-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222190107.8479-3-javier.gonz@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 22, 2021 at 08:01:07PM +0100, javier@javigon.com wrote:
> @@ -1885,7 +1885,7 @@ static int nvme_ns_open(struct nvme_ns *ns)
>  {
>  #ifdef CONFIG_NVME_MULTIPATH
>  	/* should never be called due to GENHD_FL_HIDDEN */
> -	if (WARN_ON_ONCE(ns->head->disk))
> +	if (WARN_ON_ONCE(!nvme_ns_is_generic(ns) && ns->head->disk))
>  		goto fail;

Maybe just move the check into the block device caller instead?
