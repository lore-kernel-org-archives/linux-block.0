Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40057C43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 18:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBA120657
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 18:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfCKSkh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:40:37 -0400
Received: from verein.lst.de ([213.95.11.211]:42882 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbfCKSkh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 14:40:37 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C1B3F68C7B; Mon, 11 Mar 2019 19:40:31 +0100 (CET)
Date:   Mon, 11 Mar 2019 19:40:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 5/5] nvme/pci: Remove queue IO flushing hack
Message-ID: <20190311184031.GA11707@lst.de>
References: <20190308174006.5032-1-keith.busch@intel.com> <20190308174006.5032-5-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308174006.5032-5-keith.busch@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From a quick look the code seems reasonably sensible here,
but any chance we could have this in common code?

> +static bool nvme_fail_queue_request(struct request *req, void *data, bool reserved)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct nvme_queue *nvmeq = iod->nvmeq;
> +
> +	if (!test_bit(NVMEQ_ENABLED, &nvmeq->flags))
> +		blk_mq_end_request(req, BLK_STS_IOERR);
> +	return true;
> +}

The only thing not purely block layer here is the enabled flag.
So if we had a per-hctx enabled flag we could lift this out of nvme,
and hopefully start reusing it in other drivers.

