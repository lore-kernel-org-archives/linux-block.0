Return-Path: <SRS0=/LTC=27=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB41C33C99
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 07:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808772073A
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 07:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9BLdLiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgAJHQE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:16:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25650 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725853AbgAJHQD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jan 2020 02:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578640562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vLnpFr7jsP45hCMz6lcWA2t7c8lgornfScfqptePMAA=;
        b=H9BLdLiOuLqEOqPV9RBLeq5pkL7RsgJCK6Dhj1Sf77Ti1e0A14/njX+rWgn1tQ+fGkhSSV
        dk2gBL1Wh0JiTeLkWMqGU5NiLZesTgDQIyQTIgDKFP/9hEQ/E1qZO+9/CO7lMF8veGJrcX
        osk7uLVYIkv40PIkzK+lmNW9v4VI76Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-jLeurMQCPUeAZbt067BsEA-1; Fri, 10 Jan 2020 02:15:58 -0500
X-MC-Unique: jLeurMQCPUeAZbt067BsEA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C46F3107ACC5;
        Fri, 10 Jan 2020 07:15:57 +0000 (UTC)
Received: from ming.t460p (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0481760FA2;
        Fri, 10 Jan 2020 07:15:52 +0000 (UTC)
Date:   Fri, 10 Jan 2020 15:15:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix splitting segments
Message-ID: <20200110071548.GA23264@ming.t460p>
References: <20191229023230.28940-1-ming.lei@redhat.com>
 <20200108140248.GA2896@infradead.org>
 <20200109020341.GC9655@ming.t460p>
 <20200109071616.GA32217@infradead.org>
 <cd3f3aa8-4880-f06b-7ac5-1982b890ca53@kernel.dk>
 <20200110025801.GC4501@ming.t460p>
 <20200110030006.GD4501@ming.t460p>
 <0c25bc64-d249-0b83-1d5d-6f7226293fb6@roeck-us.net>
 <20200110063744.GA16724@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110063744.GA16724@ming.t460p>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 10, 2020 at 02:37:44PM +0800, Ming Lei wrote:
> On Thu, Jan 09, 2020 at 09:10:24PM -0800, Guenter Roeck wrote:
> > On 1/9/20 7:00 PM, Ming Lei wrote:
> > > On Fri, Jan 10, 2020 at 10:58:01AM +0800, Ming Lei wrote:
> > > > On Thu, Jan 09, 2020 at 08:18:04AM -0700, Jens Axboe wrote:
> > > > > On 1/9/20 12:16 AM, Christoph Hellwig wrote:
> > > > > > On Thu, Jan 09, 2020 at 10:03:41AM +0800, Ming Lei wrote:
> > > > > > > It has been addressed in:
> > > > > > > 
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.5&id=ecd255974caa45901d0b8fab03626e0a18fbc81a
> > > > > > 
> > > > > > That is probably correct, but still highly suboptimal for most 32-bit
> > > > > > architectures where physical addresses are 32 bits wide.  To fix that
> > > > > > the proper phys_addr_t type should be used.
> > > > > 
> > > > > I'll swap it for phys_addr_t - we used to use dma_address_t or something
> > > > > like that, but I missed this type.
> > > > 
> > > > Guenter mentioned that 'page_to_phys(start_page) as well as offset are
> > > > sometimes 0'[1].
> > > > 
> > > > If that(zero page physical address) can happen when phys_addr_t is 32bit,
> > > > I guess phys_addr_t may not work too.
> > > > 
> > > > Guener, could you test the patch in link[2] again?
> > > > 
> > > > 
> > > > [1] https://lore.kernel.org/linux-block/20200108023822.GB28075@ming.t460p/T/#m5862216b960454fc41a85204defbb887983bfd75
> > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.5&id=b6a89c4a9590663f80486662fe9a9c1f4cee31f4
> > > 
> > > Loop Guener in.
> > > 
> > 
> > The patch at [2] doesn't work.
> > 
> > My understanding is that the page in question is not mapped when
> > get_max_segment_size() is called (after all, the operation is the
> > result of a page fault). This is why page_to_phys() returns 0.
> 
> page_to_phys() supposes to return page's physical address, which
> should just depend on this machine's physical address space,
> not related with page mapping.
> 
> I understand physical address 0 might be valid, such as the 1st
> page frame of ram.
> 
> > 
> > You'll either need a local u64 variable, or use some other means
> > to handle that situation. Something like
> > 
> >     phys_addr_t paddr = page_to_phys(start_page);
> > 
> >     if (paddr == 0)
> > 	return queue_max_segment_size(q);
> > 
> > at the beginning of the function might do, though there might
> > still be a problem when the page is later assigned and crosses
> > a segment boundary (if that is possible).
> 
> IMO, zero physical address case is the only corner case not
> covered by using 'phys_addr_t'. If phys_addr_t is 32bit, sum of
> page_to_phys(start_page) and offset shouldn't be >= 4G.

Or could you test the following patch?

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 347782a24a35..d1bed8c382bf 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -164,8 +164,13 @@ static inline unsigned get_max_segment_size(const struct request_queue *q,
 	unsigned long mask = queue_segment_boundary(q);
 
 	offset = mask & (page_to_phys(start_page) + offset);
-	return min_t(unsigned long, mask - offset + 1,
-		     queue_max_segment_size(q));
+
+	/*
+	 * overflow may be triggered in case of zero page physical address
+	 * on 32bit arch, use queue's max segment size when that happens
+	 */
+	return min_not_zero(mask - offset + 1,
+			(unsigned long)queue_max_segment_size(q));
 }
 
 /**


Thanks,
Ming

