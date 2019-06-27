Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF17C48BD6
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 08:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB1A2082F
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 08:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfF0I0S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:26:18 -0400
Received: from verein.lst.de ([213.95.11.211]:50580 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfF0I0R (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 04:26:17 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E9ABA68B20; Thu, 27 Jun 2019 10:25:45 +0200 (CEST)
Date:   Thu, 27 Jun 2019 10:25:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V4 1/3] block: Allow mapping of vmalloc-ed buffers
Message-ID: <20190627082545.GB11043@lst.de>
References: <20190627024910.23987-1-damien.lemoal@wdc.com> <20190627024910.23987-2-damien.lemoal@wdc.com> <20190627072800.GA9949@lst.de> <BYAPR04MB581674B8668D6F3015C5C0C6E7FD0@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB581674B8668D6F3015C5C0C6E7FD0@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 27, 2019 at 08:14:56AM +0000, Damien Le Moal wrote:
> which I guessed is for the architectures that do not need the flush/invalidate
> vmap functions. I copied. Is there a better way ? The point was to avoid doing
> the loop on the bvec for the range length on architectures that have an empty
> definition of invalidate_kernel_vmap_range().

No, looks like what you did is right.  I blame my lack of attention
on the heat wave here and the resulting lack of sleep..
