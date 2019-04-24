Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B19C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 15:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9801B21900
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 15:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ekkeg6jk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="jyQtSjH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbfDXPt5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:49:57 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36020 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730625AbfDXPt4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 11:49:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E26808EE0CC;
        Wed, 24 Apr 2019 08:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1556120994;
        bh=CI45K2qhxG3dzOoPvggE5tLTbmFq+daAESU03zqD1SI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ekkeg6jk5QJ5LRAg6aQMPPxHlWdHmtVnzNk7aEr0PIvdK2c6IvjV8gcwgUZGepq4u
         zy6cXn2UQ6hmr3YlrmRRLS7k/QVGFmEp6p874Q5Ad61ro9/+HuTg7nQMFQ0o7aSN16
         c8hhzm9h6UZUB0Iq6fakTmqtjdRU9mQB/PwJFxY0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zDipnyIluNOH; Wed, 24 Apr 2019 08:49:54 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 509EE8EE0BA;
        Wed, 24 Apr 2019 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1556120993;
        bh=CI45K2qhxG3dzOoPvggE5tLTbmFq+daAESU03zqD1SI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jyQtSjH9lFd9uv4D0/rf6NVz/D0YSdWLOn4yKrshgS26A66IgQIMe5ByUbiHwjnyd
         kqC3V8qvYZEnqj1UI+P0hMbOXUgkSKrDGlrVjVJfxgCTgUVuDP4k7lhKcLL/EzbTXl
         5wJI4OphMXZgF5t2G/U94/1AabQb/lAFbVZJ8cZo=
Message-ID: <1556120991.3043.20.camel@HansenPartnership.com>
Subject: Re: [PATCH 2/2] scsi: core: avoid to pre-allocate big chunk for sg
 list
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Date:   Wed, 24 Apr 2019 08:49:51 -0700
In-Reply-To: <1556119951.161891.126.camel@acm.org>
References: <20190423103240.29864-1-ming.lei@redhat.com>
         <20190423103240.29864-3-ming.lei@redhat.com>
         <1556033835.161891.123.camel@acm.org> <20190424075233.GA32345@ming.t460p>
         <1556119450.3043.8.camel@HansenPartnership.com>
         <1556119951.161891.126.camel@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-04-24 at 08:32 -0700, Bart Van Assche wrote:
> On Wed, 2019-04-24 at 08:24 -0700, James Bottomley wrote:
> > On Wed, 2019-04-24 at 15:52 +0800, Ming Lei wrote:
> > > On Tue, Apr 23, 2019 at 08:37:15AM -0700, Bart Van Assche wrote:
> > > > On Tue, 2019-04-23 at 18:32 +0800, Ming Lei wrote:
> > > > >  #define  SCSI_INLINE_PROT_SG_CNT  1
> > > > >  
> > > > > +#define  SCSI_INLINE_SG_CNT  2
> > > > 
> > > > So this patch inserts one kmalloc() and one kfree() call in the
> > > > hot path for every SCSI request with more than two elements in
> > > > its scatterlist? Isn't
> > > 
> > > Slab or its variants are designed for fast path, and NVMe PCI
> > > uses slab for allocating sg list in fast path too.
> > 
> > Actually, that's not really true  base kmalloc can do all sorts of
> > things including kick off reclaim so it's not really something we
> > like using in the fast path.  The only fast and safe kmalloc you
> > can rely on  in the fast path is GFP_ATOMIC which will fail quickly
> > if no memory can easily be found.  *However* the sg_table
> > allocation functions are all pool backed (lib/sg_pool.c), so they
> > use the lightweight GFP_ATOMIC mechanism for kmalloc initially
> > coupled with a backing pool in case of failure to ensure forward
> > progress.
> > 
> > So, I think you're both right: you shouldn't simply use kmalloc,
> > but this implementation doesn't, it uses the sg_table allocation
> > functions which correctly control kmalloc to be lightweight and
> > efficient and able to make forward progress.
> 
> Another concern is whether this change can cause a livelock. If the
> system is running out of memory and the page cache submits a write
> request with a scatterlist with more than two elements, if the
> kmalloc() for the scatterlist fails, will that prevent the page cache
> from making any progress with writeback?

It's pool backed, as I said.  Is the concern there isn't enough depth
in the pools for a large write?

James

