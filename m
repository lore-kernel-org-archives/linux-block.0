Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1A5C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 15:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5C5218FD
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 15:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="VnY1yXMn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="VnY1yXMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfDXPYM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:24:12 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35316 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727995AbfDXPYM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 11:24:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D5E208EE0CC;
        Wed, 24 Apr 2019 08:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1556119451;
        bh=FmadjMhiIwGTK0KIrPwZOgA2xWXaCIXz8ZBkOFUTQCg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VnY1yXMnKMs32tsOnZ/W7GG6VEMv2YRyAH3K8O95Fdtk+7DKcCYBOsAzLT6NarCAw
         /Mn1xQrNQ5mQqZoC5kXUevDoBFn0HtshIftZ9LuEidQgMKBIs9nD7rHDpcRcSELWNj
         wBBJ+c8uMaZFI/c4s3l777qcVxeBpLnZCLUQh75k=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mX5JYLLvdOUh; Wed, 24 Apr 2019 08:24:11 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2AAF58EE0BA;
        Wed, 24 Apr 2019 08:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1556119451;
        bh=FmadjMhiIwGTK0KIrPwZOgA2xWXaCIXz8ZBkOFUTQCg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VnY1yXMnKMs32tsOnZ/W7GG6VEMv2YRyAH3K8O95Fdtk+7DKcCYBOsAzLT6NarCAw
         /Mn1xQrNQ5mQqZoC5kXUevDoBFn0HtshIftZ9LuEidQgMKBIs9nD7rHDpcRcSELWNj
         wBBJ+c8uMaZFI/c4s3l777qcVxeBpLnZCLUQh75k=
Message-ID: <1556119450.3043.8.camel@HansenPartnership.com>
Subject: Re: [PATCH 2/2] scsi: core: avoid to pre-allocate big chunk for sg
 list
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Date:   Wed, 24 Apr 2019 08:24:10 -0700
In-Reply-To: <20190424075233.GA32345@ming.t460p>
References: <20190423103240.29864-1-ming.lei@redhat.com>
         <20190423103240.29864-3-ming.lei@redhat.com>
         <1556033835.161891.123.camel@acm.org> <20190424075233.GA32345@ming.t460p>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-04-24 at 15:52 +0800, Ming Lei wrote:
> On Tue, Apr 23, 2019 at 08:37:15AM -0700, Bart Van Assche wrote:
> > On Tue, 2019-04-23 at 18:32 +0800, Ming Lei wrote:
> > >  #define  SCSI_INLINE_PROT_SG_CNT  1
> > >  
> > > +#define  SCSI_INLINE_SG_CNT  2
> > 
> > So this patch inserts one kmalloc() and one kfree() call in the hot
> > path for every SCSI request with more than two elements in its
> > scatterlist? Isn't
> 
> Slab or its variants are designed for fast path, and NVMe PCI uses
> slab for allocating sg list in fast path too.

Actually, that's not really true  base kmalloc can do all sorts of
things including kick off reclaim so it's not really something we like
using in the fast path.  The only fast and safe kmalloc you can rely on
 in the fast path is GFP_ATOMIC which will fail quickly if no memory
can easily be found.  *However* the sg_table allocation functions are
all pool backed (lib/sg_pool.c), so they use the lightweight GFP_ATOMIC
mechanism for kmalloc initially coupled with a backing pool in case of
failure to ensure forward progress.

So, I think you're both right: you shouldn't simply use kmalloc, but
this implementation doesn't, it uses the sg_table allocation functions
which correctly control kmalloc to be lightweight and efficient and
able to make forward progress.

James


