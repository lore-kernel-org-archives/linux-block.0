Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BBAC43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A5F2084A
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbeLPQRr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:17:47 -0500
Received: from verein.lst.de ([213.95.11.211]:57804 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbeLPQRq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 11:17:46 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 17C7568DD3; Sun, 16 Dec 2018 17:17:45 +0100 (CET)
Date:   Sun, 16 Dec 2018 17:17:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/4] blk-mq-debugfs: export hctx->type
Message-ID: <20181216161744.GE9957@lst.de>
References: <20181216022517.26650-1-ming.lei@redhat.com> <20181216022517.26650-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216022517.26650-5-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 16, 2018 at 10:25:17AM +0800, Ming Lei wrote:
> Now we only export hctx->type via sysfs, and there isn't such info
> in hctx entry under debugfs. We often use debugfs only to diagnose
> queue mapping issue, so add the support in debugfs.
> 
> Queue mapping becomes a bit more complicated after multiple queue
> mapping is supported, we may write blktest to verify if queue mapping
> is valid based on blk-mq-debug.

I'll let Jens decide if we really want to double export information
like this (or maybe even move it to debugfs only?)

> +static int hctx_type_show(void *data, struct seq_file *m)
> +{
> +	struct blk_mq_hw_ctx *hctx = data;
> +
> +	seq_printf(m, "%u\n", hctx->type);
> +	return 0;

But if we export it we should probably export it as a text, just
like we do for sysfs now.
