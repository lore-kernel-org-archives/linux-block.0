Return-Path: <SRS0=/LTC=27=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5331C33C99
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 06:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971C620721
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 06:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHNKPo7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbgAJGiA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jan 2020 01:38:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35059 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731455AbgAJGiA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jan 2020 01:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578638278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LGRyf6i6v6wuhGrorQf6gigct7/2vl5sjRVfUea5cJs=;
        b=CHNKPo7h/X15qJmNV5uVDydzrMK9ys3lh9xZYoyJIX5YsSERmo0NZ3yS6zvbjpnU3zs/EA
        oA1Ipp7DMlq//iKwThan1MOCVICt0tDAMv82RVnOwVcRfsL/GuM9yKsS8lMjLhFGDiX6Fj
        J03lh/+/PlJ2UC27UB+p0q9p+DGwd38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-pLKv9cDLOtiFwlNcKT12pg-1; Fri, 10 Jan 2020 01:37:55 -0500
X-MC-Unique: pLKv9cDLOtiFwlNcKT12pg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B92E801E7E;
        Fri, 10 Jan 2020 06:37:54 +0000 (UTC)
Received: from ming.t460p (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5761A7FB5C;
        Fri, 10 Jan 2020 06:37:48 +0000 (UTC)
Date:   Fri, 10 Jan 2020 14:37:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix splitting segments
Message-ID: <20200110063744.GA16724@ming.t460p>
References: <20191229023230.28940-1-ming.lei@redhat.com>
 <20200108140248.GA2896@infradead.org>
 <20200109020341.GC9655@ming.t460p>
 <20200109071616.GA32217@infradead.org>
 <cd3f3aa8-4880-f06b-7ac5-1982b890ca53@kernel.dk>
 <20200110025801.GC4501@ming.t460p>
 <20200110030006.GD4501@ming.t460p>
 <0c25bc64-d249-0b83-1d5d-6f7226293fb6@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c25bc64-d249-0b83-1d5d-6f7226293fb6@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 09, 2020 at 09:10:24PM -0800, Guenter Roeck wrote:
> On 1/9/20 7:00 PM, Ming Lei wrote:
> > On Fri, Jan 10, 2020 at 10:58:01AM +0800, Ming Lei wrote:
> > > On Thu, Jan 09, 2020 at 08:18:04AM -0700, Jens Axboe wrote:
> > > > On 1/9/20 12:16 AM, Christoph Hellwig wrote:
> > > > > On Thu, Jan 09, 2020 at 10:03:41AM +0800, Ming Lei wrote:
> > > > > > It has been addressed in:
> > > > > > 
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.5&id=ecd255974caa45901d0b8fab03626e0a18fbc81a
> > > > > 
> > > > > That is probably correct, but still highly suboptimal for most 32-bit
> > > > > architectures where physical addresses are 32 bits wide.  To fix that
> > > > > the proper phys_addr_t type should be used.
> > > > 
> > > > I'll swap it for phys_addr_t - we used to use dma_address_t or something
> > > > like that, but I missed this type.
> > > 
> > > Guenter mentioned that 'page_to_phys(start_page) as well as offset are
> > > sometimes 0'[1].
> > > 
> > > If that(zero page physical address) can happen when phys_addr_t is 32bit,
> > > I guess phys_addr_t may not work too.
> > > 
> > > Guener, could you test the patch in link[2] again?
> > > 
> > > 
> > > [1] https://lore.kernel.org/linux-block/20200108023822.GB28075@ming.t460p/T/#m5862216b960454fc41a85204defbb887983bfd75
> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.5&id=b6a89c4a9590663f80486662fe9a9c1f4cee31f4
> > 
> > Loop Guener in.
> > 
> 
> The patch at [2] doesn't work.
> 
> My understanding is that the page in question is not mapped when
> get_max_segment_size() is called (after all, the operation is the
> result of a page fault). This is why page_to_phys() returns 0.

page_to_phys() supposes to return page's physical address, which
should just depend on this machine's physical address space,
not related with page mapping.

I understand physical address 0 might be valid, such as the 1st
page frame of ram.

> 
> You'll either need a local u64 variable, or use some other means
> to handle that situation. Something like
> 
>     phys_addr_t paddr = page_to_phys(start_page);
> 
>     if (paddr == 0)
> 	return queue_max_segment_size(q);
> 
> at the beginning of the function might do, though there might
> still be a problem when the page is later assigned and crosses
> a segment boundary (if that is possible).

IMO, zero physical address case is the only corner case not
covered by using 'phys_addr_t'. If phys_addr_t is 32bit, sum of
page_to_phys(start_page) and offset shouldn't be >= 4G.


Thanks,
Ming

