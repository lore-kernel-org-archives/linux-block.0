Return-Path: <SRS0=WMYH=YK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1859EECE58D
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 19:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D725B20869
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 19:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503471AbfJQTXf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Oct 2019 15:23:35 -0400
Received: from netrider.rowland.org ([192.131.102.5]:51393 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2503469AbfJQTXf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Oct 2019 15:23:35 -0400
Received: (qmail 18603 invoked by uid 500); 17 Oct 2019 15:23:34 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Oct 2019 15:23:34 -0400
Date:   Thu, 17 Oct 2019 15:23:34 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        USB list <linux-usb@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: reeze while write on external usb 3.0 hard disk [Bug 204095]
In-Reply-To: <20191017175306.GA3014@lazy.lzy>
Message-ID: <Pine.LNX.4.44L0.1910171522200.18407-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 17 Oct 2019, Piergiorgio Sartor wrote:

> > Here is one more thing you can try.  I have no idea whether it will 
> > make any difference, but the Changelog entry for the patch you 
> > identified suggests that it might help.
> > 
> > Alan Stern
> > 
> > 
> > 
> > Index: usb-devel/drivers/usb/storage/scsiglue.c
> > ===================================================================
> > --- usb-devel.orig/drivers/usb/storage/scsiglue.c
> > +++ usb-devel/drivers/usb/storage/scsiglue.c
> > @@ -68,7 +68,6 @@ static const char* host_info(struct Scsi
> >  static int slave_alloc (struct scsi_device *sdev)
> >  {
> >  	struct us_data *us = host_to_us(sdev->host);
> > -	int maxp;
> >  
> >  	/*
> >  	 * Set the INQUIRY transfer length to 36.  We don't use any of
> > @@ -78,15 +77,6 @@ static int slave_alloc (struct scsi_devi
> >  	sdev->inquiry_len = 36;
> >  
> >  	/*
> > -	 * USB has unusual scatter-gather requirements: the length of each
> > -	 * scatterlist element except the last must be divisible by the
> > -	 * Bulk maxpacket value.  Fortunately this value is always a
> > -	 * power of 2.  Inform the block layer about this requirement.
> > -	 */
> > -	maxp = usb_maxpacket(us->pusb_dev, us->recv_bulk_pipe, 0);
> > -	blk_queue_virt_boundary(sdev->request_queue, maxp - 1);
> > -
> > -	/*
> >  	 * Some host controllers may have alignment requirements.
> >  	 * We'll play it safe by requiring 512-byte alignment always.
> >  	 */
> 
> Hi,
> 
> I tested the patch.
> 
> Assumming I did everything properly, add patch,
> test, issue not showing up, remove patch, re-test,
> issue present.
> 
> It seems this patch you provide solves the issue.
> 
> Thanks a lot for the support and the solution.
> 
> I guess now this patch will be integrated into
> mainline sometimes.
> Please let me know, in this thread or directly, in
> which kernel it will be available.

I'm busy for the next few days, but I will submit the patch next week.

> Thanks again, it would be for me impossible to
> solve without your support,

You're welcome.

Alan Stern

