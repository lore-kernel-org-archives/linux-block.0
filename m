Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702A3C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 22:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E522075B
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 22:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="KZiEdcxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E522075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732057AbeKVIic (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 03:38:32 -0500
Received: from imap.thunk.org ([74.207.234.97]:38444 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730599AbeKVIic (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 03:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AKJRjyS10+2JRsVl0V00LPyvPFCfrf/0JSXZPMDrewM=; b=KZiEdcxmEPa9SlCcqrNV/jatxM
        HvJ24o7Lk/7HUtn2VsbyExalIaSwEd/oEVCVoi1Ashjmmw0vxPJGu+mLKmqZ7h9nD7tVqLMPhydmc
        Ztgpu4GQyO/ZRwkAlxRwZuiAY+Nv9CUnP2/zWo+nyFOMLi2toqUnWXrUq0UUiJJHkLmA=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gPaZZ-0001eA-TA; Wed, 21 Nov 2018 22:02:13 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2E7D17A3680; Wed, 21 Nov 2018 17:02:13 -0500 (EST)
Date:   Wed, 21 Nov 2018 17:02:13 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Andrew Jones <drjones@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        "jianchao . wang" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V2] SCSI: fix queue cleanup race before queue
 initialization is done
Message-ID: <20181121220213.GK26006@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        "jianchao . wang" <jianchao.w.wang@oracle.com>
References: <20181114082551.12141-1-ming.lei@redhat.com>
 <63c063ad-7d74-4268-bfd4-2de89908949e@kernel.dk>
 <4e24ace9-c83f-5311-5419-18f4a0fb5148@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e24ace9-c83f-5311-5419-18f4a0fb5148@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 21, 2018 at 02:47:35PM -0700, Jens Axboe wrote:
> > Thanks applied, this bug was elusive but ever present in recent
> > testing that we did internally, it's been a huge pain in the butt.
> > The symptoms were usually a crash in blk_mq_get_driver_tag() with
> > hctx->tags == NULL, or a crash inside deadline request insert off
> > requeue.
> 
> I'm still hitting some weird crashes even with this applied, like
> this one:

FYI, there are a number of Ubuntu users running 4.19, 4.19.1, and
4.19.2 which have been reporting file system corruption problems.
They have a fix of configurations, but one of the things which is seem
to be a common factor is they all have CONFIG_SCSI_MQ_DEFAULT
disabled.  (Which also happens to be how I happen to be running my
laptop, and I've noticed no problems.)

	https://bugzilla.kernel.org/show_bug.cgi?id=201685

One user in particular reported that 4.19 worked fine, and 4.19.1 had
fs corruptions (and there are no storage-related changes between 4.19
and 4.19.1) --- but the one thing those two kernels had in common was
his 4.19 build had SCSI_MQ_DEFAULT disabled, and his 4.19.1 build did
*not* have SCSI_MQ_DEFAULT enabled.  This same user tried 4.19.3, and
after two hours of heavy I/O, he's not seen a repeat, and
interestingly, 4.19.3 has the backport mentioned on this thread.

The weird thing is that it looked like the problem that was fixed by
this commit would only show up at queue setup and teardown time.  Is
that correct?  Is it possible that the bug fixed here would manifest
as data corruptions on disk?  Or would only manifest as kernel
BUG_ON's and/or crashes?

One more thing.  I tried building a 4.20-rc2 based kernel with
CONFIG_SCSI_MQ_DEFAULT=y, and I tried running gce-xfstests (which uses
virtio-scsi) and I saw no failures.  So I don't have a clean repro of
Kernel Bugzilla #201685, and at the moment I'm too chicken to enable
CONFIG_SCSI_MQ_DEFAULT on my primary development laptop...

Any thoughts/suggestions appreciated.

						- Ted
