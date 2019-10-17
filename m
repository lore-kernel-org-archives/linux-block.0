Return-Path: <SRS0=WMYH=YK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01802ECE58E
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 17:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D270421925
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 17:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437396AbfJQRx1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:53:27 -0400
Received: from vsmx011.vodafonemail.xion.oxcs.net ([153.92.174.89]:17955 "EHLO
        vsmx011.vodafonemail.xion.oxcs.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437206AbfJQRx0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Oct 2019 13:53:26 -0400
Received: from vsmx003.vodafonemail.xion.oxcs.net (unknown [192.168.75.197])
        by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id 27ADA59DAE0;
        Thu, 17 Oct 2019 17:53:23 +0000 (UTC)
Received: from lazy.lzy (unknown [93.212.126.195])
        by mta-7-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 7C51A5399ED;
        Thu, 17 Oct 2019 17:53:08 +0000 (UTC)
Received: from lazy.lzy (localhost [127.0.0.1])
        by lazy.lzy (8.15.2/8.14.5) with ESMTPS id x9HHr7x3003086
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 17 Oct 2019 19:53:07 +0200
Received: (from red@localhost)
        by lazy.lzy (8.15.2/8.15.2/Submit) id x9HHr6gB003085;
        Thu, 17 Oct 2019 19:53:06 +0200
Date:   Thu, 17 Oct 2019 19:53:06 +0200
From:   Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        USB list <linux-usb@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: reeze while write on external usb 3.0 hard disk [Bug 204095]
Message-ID: <20191017175306.GA3014@lazy.lzy>
References: <20191013181116.GA3858@lazy.lzy>
 <Pine.LNX.4.44L0.1910161258081.1304-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1910161258081.1304-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-VADE-STATUS: LEGIT
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 16, 2019 at 01:01:20PM -0400, Alan Stern wrote:
> On Sun, 13 Oct 2019, Piergiorgio Sartor wrote:
> 
> > On Mon, Sep 30, 2019 at 08:25:01PM +0200, Piergiorgio Sartor wrote:
> > > On Sun, Sep 29, 2019 at 09:01:48PM -0400, Alan Stern wrote:
> > > > On Sun, 29 Sep 2019, Piergiorgio Sartor wrote:
> > > > 
> > > > > On Wed, Sep 25, 2019 at 02:31:58PM -0400, Alan Stern wrote:
> > > > > > On Wed, 25 Sep 2019, Piergiorgio Sartor wrote:
> > > > > > 
> > > > > > > On Mon, Aug 26, 2019 at 07:38:33PM +0200, Piergiorgio Sartor wrote:
> > > > > > > > On Tue, Aug 20, 2019 at 06:37:22PM +0200, Piergiorgio Sartor wrote:
> > > > > > > > > On Tue, Aug 20, 2019 at 09:23:26AM +0200, Christoph Hellwig wrote:
> > > > > > > > > > On Mon, Aug 19, 2019 at 10:14:25AM -0400, Alan Stern wrote:
> > > > > > > > > > > Let's bring this to the attention of some more people.
> > > > > > > > > > > 
> > > > > > > > > > > It looks like the bug that was supposed to be fixed by commit
> > > > > > > > > > > d74ffae8b8dd ("usb-storage: Add a limitation for
> > > > > > > > > > > blk_queue_max_hw_sectors()"), which is part of 5.2.5, but apparently
> > > > > > > > > > > the bug still occurs.
> > > > > > > > > > 
> > > > > > > > > > Piergiorgio,
> > > > > > > > > > 
> > > > > > > > > > can you dump the content of max_hw_sectors_kb file for your USB storage
> > > > > > > > > > device and send that to this thread?
> > > > > > > > > 
> > > > > > > > > Hi all,
> > > > > > > > > 
> > > > > > > > > for both kernels, 5.1.20 (working) and 5.2.8 (not working),
> > > > > > > > > the content of /sys/dev/x:y/queue/max_hw_sectors_kb is 512
> > > > > > > > > for USB storage devices (2.0 and 3.0).
> > > > > > > > > 
> > > > > > > > > This is for the PC showing the issue.
> > > > > > > > > 
> > > > > > > > > In an other PC, which does not show the issus at the moment,
> > > > > > > > > the values are 120, for USB2.0, and 256, for USB3.0.
> > > > 
> > > > > > One thing you can try is git bisect from 5.1.20 (or maybe just 5.1.0)  
> > > > > > to 5.2.8.  If you can identify a particular commit which caused the
> > > > > > problem to start, that would help.
> > > > > 
> > > > > OK, I tried a bisect (2 days compilations...).
> > > > > Assuming I've done everything correctly (how to
> > > > > test this? How to remove the guilty patch?), this
> > > > > was the result:
> > > > > 
> > > > > 09324d32d2a0843e66652a087da6f77924358e62 is the first bad commit
> > > > > commit 09324d32d2a0843e66652a087da6f77924358e62
> > > > > Author: Christoph Hellwig <hch@lst.de>
> > > > > Date:   Tue May 21 09:01:41 2019 +0200
> > > > > 
> > > > >     block: force an unlimited segment size on queues with a virt boundary
> > > > > 
> > > > >     We currently fail to update the front/back segment size in the bio when
> > > > >     deciding to allow an otherwise gappy segement to a device with a
> > > > >     virt boundary.  The reason why this did not cause problems is that
> > > > >     devices with a virt boundary fundamentally don't use segments as we
> > > > >     know it and thus don't care.  Make that assumption formal by forcing
> > > > >     an unlimited segement size in this case.
> > > > > 
> > > > >     Fixes: f6970f83ef79 ("block: don't check if adjacent bvecs in one bio can be mergeable")
> > > > >     Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > >     Reviewed-by: Ming Lei <ming.lei@redhat.com>
> > > > >     Reviewed-by: Hannes Reinecke <hare@suse.com>
> > > > >     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > > > > 
> > > > > :040000 040000 57ba04a02f948022c0f6ba24bfa36f3b565b2440 8c925f71ce75042529c001bf244b30565d19ebf3 M      block
> > > > > 
> > > > > What to do now?
> > > > 
> > > > Here's how to verify that the bisection got a correct result.  First, 
> > > > do a git checkout of commit 09324d32d2a0, build the kernel, and make 
> > > > sure that it exhibits the problem.
> > > > 
> > > > Next, have git write out the contents of that commit in the form of a
> > > > patch (git show commit-id >patchfile), and revert it (git apply -R
> > > > patchfile).  Build the kernel from that tree, and make sure that it
> > > > does not exhibit the problem.  If it doesn't, you have definitely shown
> > > > that this commit is the cause (or at least, is _one_ of the causes).
> > > 
> > > I tried as suggested, i.e. jumping to commit
> > > 09324d32d2a0843e66652a087da6f77924358e62, testing,
> > > removing the patch, testing.
> > > The result was as expected.
> > > I was able to reproduce the issue with the commit,
> > > I was not able to reproduce it without.
> > > It seems this patch / commit is causing the problem.
> > > Directly or indirectly.
> > > 
> > > What are the next steps?
> > 
> > Hi all,
> > 
> > I tested kernel 5.3.5 (Fedora kernel-5.3.5-200.fc30.x86_64),
> > with same problematic results.
> > 
> > Again, what should be done now?
> > Could you please revert the patch?
> > 
> > Or is there something else to check?
> 
> Here is one more thing you can try.  I have no idea whether it will 
> make any difference, but the Changelog entry for the patch you 
> identified suggests that it might help.
> 
> Alan Stern
> 
> 
> 
> Index: usb-devel/drivers/usb/storage/scsiglue.c
> ===================================================================
> --- usb-devel.orig/drivers/usb/storage/scsiglue.c
> +++ usb-devel/drivers/usb/storage/scsiglue.c
> @@ -68,7 +68,6 @@ static const char* host_info(struct Scsi
>  static int slave_alloc (struct scsi_device *sdev)
>  {
>  	struct us_data *us = host_to_us(sdev->host);
> -	int maxp;
>  
>  	/*
>  	 * Set the INQUIRY transfer length to 36.  We don't use any of
> @@ -78,15 +77,6 @@ static int slave_alloc (struct scsi_devi
>  	sdev->inquiry_len = 36;
>  
>  	/*
> -	 * USB has unusual scatter-gather requirements: the length of each
> -	 * scatterlist element except the last must be divisible by the
> -	 * Bulk maxpacket value.  Fortunately this value is always a
> -	 * power of 2.  Inform the block layer about this requirement.
> -	 */
> -	maxp = usb_maxpacket(us->pusb_dev, us->recv_bulk_pipe, 0);
> -	blk_queue_virt_boundary(sdev->request_queue, maxp - 1);
> -
> -	/*
>  	 * Some host controllers may have alignment requirements.
>  	 * We'll play it safe by requiring 512-byte alignment always.
>  	 */

Hi,

I tested the patch.

Assumming I did everything properly, add patch,
test, issue not showing up, remove patch, re-test,
issue present.

It seems this patch you provide solves the issue.

Thanks a lot for the support and the solution.

I guess now this patch will be integrated into
mainline sometimes.
Please let me know, in this thread or directly, in
which kernel it will be available.

Thanks again, it would be for me impossible to
solve without your support,

bye,

-- 

piergiorgio
