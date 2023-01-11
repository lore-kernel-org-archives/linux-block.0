Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AA3C46467
	for <linux-block@archiver.kernel.org>; Wed, 11 Jan 2023 05:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjAKFp1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Jan 2023 00:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjAKFpZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2023 00:45:25 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DA9127;
        Tue, 10 Jan 2023 21:45:25 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B11B968BEB; Wed, 11 Jan 2023 06:45:20 +0100 (CET)
Date:   Wed, 11 Jan 2023 06:45:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
Subject: Re: [PATCH v3 07/14] blk-mq: make blk_mq_commit_rqs a general
 function for all commits
Message-ID: <20230111054520.GA17158@lst.de>
References: <20230111130159.3741753-1-shikemeng@huaweicloud.com> <20230111130159.3741753-8-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111130159.3741753-8-shikemeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 11, 2023 at 09:01:52PM +0800, Kemeng Shi wrote:
> 1. rename orignal blk_mq_commit_rqs to blk_mq_plug_commit_rqs as
> trace_block_unplug is only needed when we dispatch request from plug list.

Why?  I think always having the trace even for the commit case seems
very useful for making the traces useful.

> +/* blk_mq_commit_rqs and blk_mq_plug_commit_rqs notify driver using
> + * bd->last that there is no more requests. (See comment in struct

This is not the normal kernel comment style.

> +static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int queued)
> +{
> +	if (hctx->queue->mq_ops->commit_rqs && queued) {
> +		hctx->queue->mq_ops->commit_rqs(hctx);
> +	}

No need for the braces.
