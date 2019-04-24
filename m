Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8891BC10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A93218FE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="b14BARLX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="hUDsPSHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfDXQR4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:17:56 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37048 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726611AbfDXQR4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 12:17:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1FB8E8EE14F;
        Wed, 24 Apr 2019 09:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1556122670;
        bh=v70rIDNW55sQmtocFeqphy6HXUVlqreOhz+bYZEgkbg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=b14BARLXBF8hZo2ZTsaQqBGn70qcAoCz3NIbvSKBEOIV6raTjBpUT/A2y2dztLTFP
         QcMBpQ8pgORp/Hy7Ttw9I32J0UAgayIwBY+z3Y3afsYk0qAIED2Dtfn9148b7VMpl1
         dXud6pRx1i+5Z0WFHwYnZoJnwMfQBg7TOHzRk45w=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 72tuoGfJnxho; Wed, 24 Apr 2019 09:17:44 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B712F8EE153;
        Wed, 24 Apr 2019 09:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1556122662;
        bh=v70rIDNW55sQmtocFeqphy6HXUVlqreOhz+bYZEgkbg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hUDsPSHGTJaGoh7FJVyP2+u8lCFvNfw11paXIQLigTyhVXzNUqV9uxWIvYAeZHba2
         CFl8PpxML79HMOwSRJ3CsjNrw+J/eNiFW4h9q7XrorklpsTqRS4Hu2TzCaQ1ko2eqf
         GrMQkrrrLn8+7Th29E61kgTp0QyFvUNs3McB1CBE=
Message-ID: <1556122643.3043.29.camel@HansenPartnership.com>
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
Date:   Wed, 24 Apr 2019 09:17:23 -0700
In-Reply-To: <1556122182.161891.135.camel@acm.org>
References: <20190423103240.29864-1-ming.lei@redhat.com>
         <20190423103240.29864-3-ming.lei@redhat.com>
         <1556033835.161891.123.camel@acm.org> <20190424075233.GA32345@ming.t460p>
         <1556119450.3043.8.camel@HansenPartnership.com>
         <1556119951.161891.126.camel@acm.org>
         <1556120991.3043.20.camel@HansenPartnership.com>
         <1556122182.161891.135.camel@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-04-24 at 09:09 -0700, Bart Van Assche wrote:
> On Wed, 2019-04-24 at 08:49 -0700, James Bottomley wrote:
> > On Wed, 2019-04-24 at 08:32 -0700, Bart Van Assche wrote:
> > > Another concern is whether this change can cause a livelock. If
> > > the system is running out of memory and the page cache submits a
> > > write request with a scatterlist with more than two elements, if
> > > the kmalloc() for the scatterlist fails, will that prevent the
> > > page cache from making any progress with writeback?
> > 
> > It's pool backed, as I said.  Is the concern there isn't enough
> > depth in the pools for a large write?
> 
> That memory pool is used by multiple drivers. Most but not all
> sg_alloc_table_chained() calls happen from inside .queue_rq()
> implementations. One sg_alloc_table_chained() call occurs in the NFS
> server code. I'm not sure whether it is guaranteed that an
> sg_alloc_table_chained() will succeed sooner or later under low
> memory conditions. Additionally, new sg_alloc_table_chained() could
> be added in drivers any time.

The number of users is irrelevant.  All we need is sequential forward
progress to guarantee freedom from memory allocation related live lock.
 Even if they make write progress one at a time (although the current
pool depth seems to be 2, so they make progress at least two at a
time), memory will be released by the write and reclaim will progress.

The guarantee required is ability to send or have outstanding at least
one write and also that that write will return eventually releasing
memory back to the pool for another write to proceed.

James


