Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DAEC4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 07:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45157206E0
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 07:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfF1Hox (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:44:53 -0400
Received: from verein.lst.de ([213.95.11.210]:46037 "EHLO newverein.lst.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726385AbfF1Hox (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 03:44:53 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8613F68D04; Fri, 28 Jun 2019 09:44:50 +0200 (CEST)
Date:   Fri, 28 Jun 2019 09:44:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V5 2/3] sd_zbc: Fix report zones buffer allocation
Message-ID: <20190628074450.GA29550@lst.de>
References: <20190627092944.20957-1-damien.lemoal@wdc.com> <20190627092944.20957-3-damien.lemoal@wdc.com> <20190627140900.GB6209@lst.de> <BYAPR04MB581641F8E665ECD324B6C397E7FC0@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB581641F8E665ECD324B6C397E7FC0@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 28, 2019 at 07:30:49AM +0000, Damien Le Moal wrote:
> 
> Yes, indeed. However, removing the gfp_flags from report_zones method
> would limit possibilities to only GFP_NOIO or GFP_KERNEL (default
> vmalloc). What if the caller is an FS and needs GFP_NOFS, or any other
> reclaim flags ? Handling all possibilities does not seem reasonable.
> Handling only GFP_KERNEL and GFP_IO is easy, but that would mean that
> the caller of blkdev_report_zones would need to do itself calls to
> whatever  memalloc_noXX_save/restore() it needs. Is that OK ?

I think it is ok.  The only real possibily is noio anyway as far as
I can tell.

> 
> Currently, blkdev_report_zones() uses only either GFP_KERNEL (general
> case, fs, dm and user ioctl), or GFP_NOIO for revalidate, disk scan and
> dm-zoned error path. So removing the flag from the report zones method
> while keeping it in the block layer API to distinguished these cases is
> simple, but I am not sure if that will not pause problems for some
> users. Thoughts ?

I'd kill it from the block layer API and require the caller to set
the per-task flag.  If I understood the mm maintainers correctly the
long term plan is to kill of GFP_NOFS and GFP_NOIO flowly and just rely
on the contexts.
