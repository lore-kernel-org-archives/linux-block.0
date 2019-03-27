Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92097C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 14:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EAC2075E
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 14:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfC0OWH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:22:07 -0400
Received: from verein.lst.de ([213.95.11.211]:42052 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfC0OWG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 10:22:06 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DE0D168C4E; Wed, 27 Mar 2019 15:21:57 +0100 (CET)
Date:   Wed, 27 Mar 2019 15:21:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 06/15] nvme-pci: remove nvme_init_iod
Message-ID: <20190327142157.GD26200@lst.de>
References: <20190321231037.25104-1-hch@lst.de> <20190321231037.25104-7-hch@lst.de> <SN6PR04MB45279F1612542CB815A5E3DA865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB45279F1612542CB815A5E3DA865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 25, 2019 at 05:19:34AM +0000, Chaitanya Kulkarni wrote:
> > @@ -913,9 +902,14 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
> >   	struct nvme_queue *nvmeq = hctx->driver_data;
> >   	struct nvme_dev *dev = nvmeq->dev;
> >   	struct request *req = bd->rq;
> > +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> >   	struct nvme_command cmnd;
> >   	blk_status_t ret;
> >   
> > +	iod->aborted = 0;
> > +	iod->npages = -1;
> > +	iod->nents = 0;
> > +
> Maybe add an inline helper for above default IOD initialization ?

Why?  It is a few lines of code and we only ever do it here.
