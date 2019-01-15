Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBB5C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 14:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934E620675
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 14:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfAOOfp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:35:45 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:45614 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfAOOfo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 09:35:44 -0500
Received: by mail-qt1-f179.google.com with SMTP id e5so3104394qtr.12;
        Tue, 15 Jan 2019 06:35:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWRFtZkcH9JFJmxVx3cZwqnRG2ypK1SAv++2yeo1fH4=;
        b=tOYiicIZwmBoE3XZIfwXaJdlXMKrn2uzFAlEDlkcPNq0F+MGBbIRLzr5rI4MRcD7Ax
         yIv1Wxmb8VRpiXf8R277RawR78qdS0rgX4TWK5A0zHHNfPaw8QxZhp4uuhlJNKBIqHBp
         3CAG2jJGRIPEtItGG1qMTSwxHC2OznlbJS5ckdZ1Anukdx+duffJm4NMk7uHFJ7dXkLR
         7d8w7IzGsQMMweNihQnuCf7OjJAEZaCVZJ5pNyI4YkWOhlk1+mqlXoxB2nHXF21/whbu
         s1dCjFyyZVDyWrU4ioUF3iJ3B3I0riXjRKi9Nz5DyDjzMwoAOFqnQuNpLLVLYxEPfkA2
         8kHg==
X-Gm-Message-State: AJcUukejribNR/1DcUHTa4xFwZdy4bghNFBGb0jpd4ky3PGzV8Nb3ngk
        6FzNJ8keq2W0sy7z0KPv+zCZAhxd
X-Google-Smtp-Source: ALg8bN46uZ7TgiZhwTXfjz1tXnZcWdI2ErmiVE4eYo/yLLRNT5F7jmE1z614WoEdBCb1TA13Oki9+Q==
X-Received: by 2002:ac8:c42:: with SMTP id l2mr3187439qti.68.1547562943314;
        Tue, 15 Jan 2019 06:35:43 -0800 (PST)
Received: from [172.16.1.73] (pool-74-108-133-250.nycmny.fios.verizon.net. [74.108.133.250])
        by smtp.googlemail.com with ESMTPSA id a17sm53546932qtk.82.2019.01.15.06.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 06:35:42 -0800 (PST)
Message-ID: <1547562941.20294.196.camel@intricatesoftware.com>
Subject: Re: Block device flush ordering
From:   Kurt Miller <kurt@intricatesoftware.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org
Date:   Tue, 15 Jan 2019 09:35:41 -0500
In-Reply-To: <20190114164549.GA26523@infradead.org>
References: <1547130601.20294.152.camel@intricatesoftware.com>
         <20190113224244.GC4205@dastard> <20190114164549.GA26523@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-01-14 at 08:45 -0800, Christoph Hellwig wrote:
> On Mon, Jan 14, 2019 at 09:42:44AM +1100, Dave Chinner wrote:
> > 
> > On Thu, Jan 10, 2019 at 09:30:01AM -0500, Kurt Miller wrote:
> > > 
> > > For a well behaved block device that has a writeback cache,
> > > what is the proper behavior of flush when there are more
> > > then one outstanding flush operations? Is it;
> > > 
> > > Flush all writes seen since the last flush.
> > > or
> > > Flush all writes received prior to the flush including
> > > those before any prior flush.
> The requirement is that all write operations that have been completed
> before the flush was seen are on stable storage.  How that is
> implemented in detail is up to the device.  The typical implementation
> is simply to writeback the whole cache everytime a flush operation
> is received.
> 
> > 
> > > 
> > > 
> > > For example take the following order of requests presented
> > > to the block device:
> > > 
> > > 	writes 1-5
> > > 	flush 1
> > > 	write 6
> > > 	flush 2
> > > 
> > > Can flush 2 finish with success as soon as write 6 is flushed
> > > (which may be before flush 1 success)? Or must it wait for
> > > all prior write operations to flush (writes 1-6)?
> No.  For all the usual protocols as well as the linux kernel semantics
> there is no overall command ordering, especially as there is no way
> to even enforce that in a multi-queue environment.
> 
> > 
> > 
> >  * C1. At any given time, only one flush shall be in progress.  This makes
> >  *     double buffering sufficient.
> Very specific implementation detail inside the request layer.
> 
> > 
> > Then flush 1 does not guarantee any of the writes are on stable
> > storage. They *may* be on stable storage if the timing is right, but
> > it is not guaranteed by the OS code. Likewise, flush 2 only
> > guarantees writes 1, 3 and 5 are on stable storage becase they are
> > the only writes that have been signalled as complete when flush 2
> > was submitted.
> Exactly.

Thank you both for the detailed answers. They have been very helpful.
Also after spending an afternoon reading kernel code (xlog_sync though
blk_flush_complete_seq) I understand it better. The multiple concurrent
flush requests comment I made in another reply was a logging issue in
our nbd implementation where we were logging completions after replying
to the kernel. As a result our log messages were out of order and
misleading. With that corrected in our code we see only one flush at a
time.

Best,
-Kurt
