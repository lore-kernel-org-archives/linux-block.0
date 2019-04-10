Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBEBC10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 14:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628152064A
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 14:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732875AbfDJOwh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:52:37 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:49950 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1732870AbfDJOwh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 10:52:37 -0400
Received: (qmail 4391 invoked by uid 2102); 10 Apr 2019 10:52:36 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Apr 2019 10:52:36 -0400
Date:   Wed, 10 Apr 2019 10:52:36 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Bollinger, Seth" <Seth.Bollinger@digi.com>
cc:     Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        USB list <linux-usb@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: Bug: VHCI + USB 3.0
In-Reply-To: <D5C0CBE7-AD66-4CF6-AD7D-2A0064FDA464@digi.com>
Message-ID: <Pine.LNX.4.44L0.1904101047230.1629-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 10 Apr 2019, Bollinger, Seth wrote:

> > On Apr 9, 2019, at 2:13 PM, Bollinger, Seth <Seth.Bollinger@digi.com<mailto:Seth.Bollinger@digi.com>> wrote:
> >
> > > Seth, you can try adding:
> > >
> > >  blk_queue_virt_boundary(sdev->request_queue, 1024 - 1)
> > >
> > > in drivers/usb/storage/scsiglue.c:slave_alloc(), just after the call to
> > > blk_queue_update_dma_alignment().  Perhaps that will help
> > >
> >
> > I will do that as a test.  However, I’m concerned that we’re solving only a specific case.  Won’t it fail in a similar way if a different subsystem does the same thing (USB modem or > video drivers, etc.)?
> 
> Just to follow up, this does seem to solve the specific problem.

Great!  Okay, here's an actual patch for you to try.  I have removed 
the blk_queue_update_dma_alignment() call because it doesn't seem to 
be necessary.  The starting location of each scatterlist element is 
unimportant; only the length matters.

If this works, I will submit it as a bugfix for the kernel.

Alan Stern


 drivers/usb/storage/scsiglue.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

Index: usb-4.x/drivers/usb/storage/scsiglue.c
===================================================================
--- usb-4.x.orig/drivers/usb/storage/scsiglue.c
+++ usb-4.x/drivers/usb/storage/scsiglue.c
@@ -65,6 +65,7 @@ static const char* host_info(struct Scsi
 static int slave_alloc (struct scsi_device *sdev)
 {
 	struct us_data *us = host_to_us(sdev->host);
+	int maxp;
 
 	/*
 	 * Set the INQUIRY transfer length to 36.  We don't use any of
@@ -74,22 +75,16 @@ static int slave_alloc (struct scsi_devi
 	sdev->inquiry_len = 36;
 
 	/*
-	 * USB has unusual DMA-alignment requirements: Although the
-	 * starting address of each scatter-gather element doesn't matter,
+	 * USB has unusual scatter-gather requirements: Although the
+	 * starting address of each scatterlist element doesn't matter,
 	 * the length of each element except the last must be divisible
-	 * by the Bulk maxpacket value.  There's currently no way to
-	 * express this by block-layer constraints, so we'll cop out
-	 * and simply require addresses to be aligned at 512-byte
-	 * boundaries.  This is okay since most block I/O involves
-	 * hardware sectors that are multiples of 512 bytes in length,
-	 * and since host controllers up through USB 2.0 have maxpacket
-	 * values no larger than 512.
+	 * by the Bulk maxpacket value.  Fortunately this value is always
+	 * a power of 2.
 	 *
-	 * But it doesn't suffice for Wireless USB, where Bulk maxpacket
-	 * values can be as large as 2048.  To make that work properly
-	 * will require changes to the block layer.
+	 * Inform the block layer about this requirement.
 	 */
-	blk_queue_update_dma_alignment(sdev->request_queue, (512 - 1));
+	maxp = usb_maxpacket(us->pusb_dev, us->recv_bulk_pipe, 0);
+	blk_queue_virt_boundary(sdev->request_queue, maxp - 1);
 
 	/* Tell the SCSI layer if we know there is more than one LUN */
 	if (us->protocol == USB_PR_BULK && us->max_lun > 0)

