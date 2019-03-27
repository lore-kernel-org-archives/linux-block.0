Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B06C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 08:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D13A2075D
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 08:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfC0IOF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:14:05 -0400
Received: from verein.lst.de ([213.95.11.211]:40396 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfC0IOF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 04:14:05 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D9ACF68B05; Wed, 27 Mar 2019 09:13:56 +0100 (CET)
Date:   Wed, 27 Mar 2019 09:13:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de,
        osandov@fb.com, ming.lei@redhat.com
Subject: Re: [PATCH] blk-mq: add trace block plug and unplug for multiple
 queues
Message-ID: <20190327081356.GD20525@lst.de>
References: <20190326131925.60255-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326131925.60255-1-yuyufen@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 26, 2019 at 09:19:25PM +0800, Yufen Yu wrote:
> For now, we just trace plug for single queue device or drivers
> provide .commit_rqs, and have not trace plug for multiple queues
> device. But, unplug events will be recorded when call
> blk_mq_flush_plug_list(). Then, trace events will be asymmetrical,
> just have unplug and without plug.
> 
> This patch add trace plug and unplug for multiple queues device in
> blk_mq_make_request(). After that, we can accurately trace plug and
> unplug for multiple queues.
> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
