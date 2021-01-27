Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3430C433DB
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 16:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B07C164D9D
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 16:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhA0QmA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 11:42:00 -0500
Received: from verein.lst.de ([213.95.11.211]:53687 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232283AbhA0QlF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 11:41:05 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2C0EE68B02; Wed, 27 Jan 2021 17:40:21 +0100 (CET)
Date:   Wed, 27 Jan 2021 17:40:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chao Leng <lengchao@huawei.com>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        axboe@kernel.dk
Subject: Re: [PATCH v4 1/5] blk-mq: introduce blk_mq_set_request_complete
Message-ID: <20210127164020.GA23417@lst.de>
References: <20210126081539.13320-1-lengchao@huawei.com> <20210126081539.13320-2-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126081539.13320-2-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static inline void blk_mq_set_request_complete(struct request *rq)
> +{
> +	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
> +}

This function needs a detailed comment explaining the use case.
Otherwise we'll get lots of driver abuses.
