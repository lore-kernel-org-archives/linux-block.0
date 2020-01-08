Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3786C282DD
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 15:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B94A2067D
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 15:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgAHPGP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:06:15 -0500
Received: from verein.lst.de ([213.95.11.211]:49700 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgAHPGP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Jan 2020 10:06:15 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 96E1868BFE; Wed,  8 Jan 2020 16:06:12 +0100 (CET)
Date:   Wed, 8 Jan 2020 16:06:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@kernel.dk, ssomesh@amazon.com, jejb@linux.ibm.com,
        hch@lst.de, mst@redhat.com, Chaitanya.Kulkarni@wdc.com
Subject: Re: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
Message-ID: <20200108150612.GD10975@lst.de>
References: <20200102075315.22652-1-sblbir@amazon.com> <20200102075315.22652-6-sblbir@amazon.com> <yq1blrg2agh.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1blrg2agh.fsf@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 06, 2020 at 10:48:30PM -0500, Martin K. Petersen wrote:
> 
> Balbir,
> 
> > diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> > index 5afb0046b12a..1a3be30b6b78 100644
> > --- a/drivers/scsi/sd.c
> > +++ b/drivers/scsi/sd.c
> > @@ -3184,7 +3184,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
> >  
> >  	sdkp->first_scan = 0;
> >  
> > -	set_capacity(disk, logical_to_sectors(sdp, sdkp->capacity));
> > +	disk_set_capacity(disk, logical_to_sectors(sdp, sdkp->capacity));
> >  	sd_config_write_same(sdkp);
> >  	kfree(buffer);
> 
> We already emit an SDEV_EVT_CAPACITY_CHANGE_REPORTED event if device
> capacity changes. However, this event does not automatically cause
> revalidation.

Who is looking at these sdev specific events?  (And who is looking
at the virtio/xenblk ones?)  It  makes a lot of sense to have one event
supported by all devices.  But don't ask me which one would be the best..
