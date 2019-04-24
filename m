Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3FEC10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 07:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08EB2148D
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 07:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfDXHwr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:52:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbfDXHwq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 03:52:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A0F6307D861;
        Wed, 24 Apr 2019 07:52:46 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AC035D9C8;
        Wed, 24 Apr 2019 07:52:39 +0000 (UTC)
Date:   Wed, 24 Apr 2019 15:52:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 2/2] scsi: core: avoid to pre-allocate big chunk for sg
 list
Message-ID: <20190424075233.GA32345@ming.t460p>
References: <20190423103240.29864-1-ming.lei@redhat.com>
 <20190423103240.29864-3-ming.lei@redhat.com>
 <1556033835.161891.123.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556033835.161891.123.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 24 Apr 2019 07:52:46 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 23, 2019 at 08:37:15AM -0700, Bart Van Assche wrote:
> On Tue, 2019-04-23 at 18:32 +0800, Ming Lei wrote:
> >  #define  SCSI_INLINE_PROT_SG_CNT  1
> >  
> > +#define  SCSI_INLINE_SG_CNT  2
> 
> So this patch inserts one kmalloc() and one kfree() call in the hot path
> for every SCSI request with more than two elements in its scatterlist? Isn't

Slab or its variants are designed for fast path, and NVMe PCI uses slab
for allocating sg list in fast path too.

> "2" too low? Or in other words, what is the performance impact of this patch
> for a real-world workload?

2 is used by NVMe PCI for a while, and even recently it is reduced to 1.

I have run big BS(256k) fio test on scsi_debug(can_queue: 256, submit queues: 12 LUNs: 4,
delay: 0, io sched: none), not see obvious performance difference by this patch.

Thanks, 
Ming
