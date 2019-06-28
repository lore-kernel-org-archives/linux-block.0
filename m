Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05EAC4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 08:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB472063F
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 08:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfF1IDt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:03:49 -0400
Received: from verein.lst.de ([213.95.11.210]:46185 "EHLO newverein.lst.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbfF1IDs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 04:03:48 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 05A1E68C4E; Fri, 28 Jun 2019 10:03:46 +0200 (CEST)
Date:   Fri, 28 Jun 2019 10:03:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V5 2/3] sd_zbc: Fix report zones buffer allocation
Message-ID: <20190628080345.GA29985@lst.de>
References: <20190627092944.20957-1-damien.lemoal@wdc.com> <20190627092944.20957-3-damien.lemoal@wdc.com> <20190627140900.GB6209@lst.de> <BYAPR04MB581641F8E665ECD324B6C397E7FC0@BYAPR04MB5816.namprd04.prod.outlook.com> <20190628074450.GA29550@lst.de> <BYAPR04MB58162BAF677D0DD658B41ADFE7FC0@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB58162BAF677D0DD658B41ADFE7FC0@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 28, 2019 at 07:57:38AM +0000, Damien Le Moal wrote:
> However, doing everything in this patch will make the patch quite big as
> nullblk and dm also need changes. Should I kill the gfp_mask argument in
> a separate patch before this one ?

Sounds good to me.
