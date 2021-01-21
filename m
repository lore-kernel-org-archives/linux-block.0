Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1358C433DB
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 08:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567AB239A4
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 08:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbhAUInV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 03:43:21 -0500
Received: from verein.lst.de ([213.95.11.211]:59638 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbhAUIm6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 03:42:58 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 58AFE67373; Thu, 21 Jan 2021 09:41:50 +0100 (CET)
Date:   Thu, 21 Jan 2021 09:41:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chao Leng <lengchao@huawei.com>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        axboe@kernel.dk
Subject: Re: [PATCH v3 2/5] nvme-core: introduce complete failed request
Message-ID: <20210121084150.GB25963@lst.de>
References: <20210121070330.19701-1-lengchao@huawei.com> <20210121070330.19701-3-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121070330.19701-3-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static inline void nvme_complete_failed_req(struct request *req)

I think the name is too generic, and the function also needs a little
comment, especially as it forces a specific error code.

> +{
> +	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
> +	blk_mq_set_request_complete(req);
> +	nvme_complete_rq(req);
> +}

Also no need to mark this as an inline function.
