Return-Path: <SRS0=Zleb=OR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FD6C04EB8
	for <linux-block@archiver.kernel.org>; Sat,  8 Dec 2018 17:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFDE20673
	for <linux-block@archiver.kernel.org>; Sat,  8 Dec 2018 17:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFDE20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbeLHRvm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:51:42 -0500
Received: from verein.lst.de ([213.95.11.211]:41010 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbeLHRvm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 8 Dec 2018 12:51:42 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0729768AA6; Sat,  8 Dec 2018 18:51:41 +0100 (CET)
Date:   Sat, 8 Dec 2018 18:51:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 8/9] scsi: remove the use_clustering flag
Message-ID: <20181208175140.GA15754@lst.de>
References: <20181206155258.11465-1-hch@lst.de> <20181206155258.11465-9-hch@lst.de> <1544116404.185366.256.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544116404.185366.256.camel@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 06, 2018 at 09:13:24AM -0800, Bart Van Assche wrote:
> On Thu, 2018-12-06 at 07:52 -0800, Christoph Hellwig wrote:
> > The same effects can be archived by setting the dma_boundary to
>                           ^^^^^^^^
>                           achieved?
> > PAGE_SIZE - 1 and the max_segment_size to PAGE_SIZE, so shift those
> > settings into the drivers.  Note that in many cases the setting might
> > be bogus, but this keeps the status quo.
> [ ... ]
> >  Documentation/scsi/scsi_mid_low_api.txt |  2 --
> >  arch/ia64/hp/sim/simscsi.c              |  3 ++-
> >  drivers/scsi/a2091.c                    |  3 ++-
> >  drivers/scsi/advansys.c                 |  4 ++--
> >  drivers/scsi/aha152x.c                  |  3 ++-
> >  drivers/scsi/arm/acornscsi.c            |  3 ++-
> >  drivers/scsi/arm/arxescsi.c             |  3 ++-
> >  drivers/scsi/arm/cumana_1.c             |  3 ++-
> >  drivers/scsi/arm/cumana_2.c             |  3 ++-
> >  drivers/scsi/arm/eesox.c                |  3 ++-
> >  drivers/scsi/arm/oak.c                  |  3 ++-
> >  drivers/scsi/atari_scsi.c               |  3 ++-
> >  drivers/scsi/cxgbi/cxgb3i/cxgb3i.c      |  3 ++-
> >  drivers/scsi/cxgbi/cxgb4i/cxgb4i.c      |  3 ++-
> >  drivers/scsi/dc395x.c                   |  3 ++-
> >  drivers/scsi/dmx3191d.c                 |  3 ++-
> >  drivers/scsi/g_NCR5380.c                |  3 ++-
> >  drivers/scsi/gvp11.c                    |  3 ++-
> >  drivers/scsi/hosts.c                    |  1 -
> >  drivers/scsi/ips.c                      |  1 -
> >  drivers/scsi/iscsi_tcp.c                |  3 ++-
> >  drivers/scsi/mac_esp.c                  |  3 ++-
> >  drivers/scsi/mac_scsi.c                 |  3 ++-
> >  drivers/scsi/mvumi.c                    |  3 ++-
> >  drivers/scsi/nsp32.c                    |  3 ++-
> >  drivers/scsi/pcmcia/nsp_cs.c            |  3 ++-
> >  drivers/scsi/pcmcia/qlogic_stub.c       |  3 ++-
> >  drivers/scsi/qlogicfas.c                |  3 ++-
> >  drivers/scsi/scsi_debug.c               |  6 ++++--
> >  drivers/scsi/scsi_lib.c                 |  3 ---
> >  drivers/scsi/sgiwd93.c                  |  3 ++-
> >  drivers/scsi/stex.c                     |  3 ++-
> >  drivers/scsi/sun3_scsi.c                |  3 ++-
> >  drivers/scsi/ufs/ufshcd.c               |  3 ++-
> >  drivers/target/loopback/tcm_loop.c      |  3 ++-
> >  drivers/usb/storage/uas.c               |  3 ++-
> >  include/scsi/scsi_host.h                | 13 -------------
> >  37 files changed, 66 insertions(+), 54 deletions(-)
> 
> Please split this patch into two patches: one that affects SCSI LLD drivers
> and another patch that affects the SCSI core. That will make both reviewing
> and bisecting easier.

Just splitting it in two would not really help bisecting.  We could
split it into one per driver, but we rarely need to bisect which
driver is affected, as that usually is pretty obvious.
