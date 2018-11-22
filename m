Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBDDC43441
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 03:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D26520671
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 03:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="GAsmOd+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D26520671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbeKVOUn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:20:43 -0500
Received: from imap.thunk.org ([74.207.234.97]:39842 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730284AbeKVOUn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 09:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lZZ5A3OVXMmU47TW3QABaQcyqNfBcinYVUWFEilN5YY=; b=GAsmOd+sd/CyxLTeDpEY7IDBmd
        maQGr8Y7hb64BgrcJPB6e9dlN/nFC0gsOqVTDeu0wdrPIGA5tQLI24qfHeIR2ZABkdawr+jQd5EXz
        SpwuXyiOgC0l+2L+56mafYouaD9zrX4nZMBate40ct+SvIaFvyvgodc0SyEzmQlzisLg=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gPftW-00044m-4V; Thu, 22 Nov 2018 03:43:10 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CE5097A3681; Wed, 21 Nov 2018 22:43:08 -0500 (EST)
Date:   Wed, 21 Nov 2018 22:43:08 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        "jianchao . wang" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V2] SCSI: fix queue cleanup race before queue
 initialization is done
Message-ID: <20181122034308.GA7843@thunk.org>
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
 <20181121220213.GK26006@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121220213.GK26006@thunk.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 21, 2018 at 05:02:13PM -0500, Theodore Y. Ts'o wrote:
> On Wed, Nov 21, 2018 at 02:47:35PM -0700, Jens Axboe wrote:
> > > Thanks applied, this bug was elusive but ever present in recent
> > > testing that we did internally, it's been a huge pain in the butt.
> > > The symptoms were usually a crash in blk_mq_get_driver_tag() with
> > > hctx->tags == NULL, or a crash inside deadline request insert off
> > > requeue.
> > 
> > I'm still hitting some weird crashes even with this applied, like
> > this one:
> 
> FYI, there are a number of Ubuntu users running 4.19, 4.19.1, and
> 4.19.2 which have been reporting file system corruption problems.
> They have a fix of configurations, but one of the things which is seem
> to be a common factor is they all have CONFIG_SCSI_MQ_DEFAULT
> disabled.  (Which also happens to be how I happen to be running my
> laptop, and I've noticed no problems.)

One correction to the above --- the people who are having the problem
have CONFIG_SCSI_MQ_DEFAULT *enabled* (at least for those who reported
the kernel configs --- not all of them did).

I have CONFIG_SCSI_MQ_DEFAULT *disabled*, and things are running just
fine on my laptop.  Although that may be a red herring, since as you
pointed out on the bug NVMe isn't affected by the SCSI_MQ_DEFAULT
setting (sorry, I'm still used to a world where SCSI controls the
whole world :-).  And my laptop is an XPS 13 with an NVMe-attached 1T
SSD.  Fortunately I've not seen any corruption (or at least nothing
visible yet).

Anyway, all of this is in the bug, and I'll see if I can find a way of
repro'ing corruption in a KVM or GCE crash-and-burn environment...

		  	     	      	 - Ted
