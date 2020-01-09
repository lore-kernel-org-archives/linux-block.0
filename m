Return-Path: <SRS0=+EVs=26=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BC6C33CA2
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 02:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F368A20720
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 02:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HeX6QzRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgAICD4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 21:03:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40728 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727417AbgAICD4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 21:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578535434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wJvAZExMrgUjEzDNvGL67pkIOKCUnAl+V3gYJFRACyY=;
        b=HeX6QzRd7gDhF3sAOK2VmduOXglXjxSjus8MPSExa4jBvp/dvWlw7CjSIEO+mj9+jAQP2w
        p4RvmcIU/u8vLt7eIOl6lku8caBxcBgsSlzPtToXFQRvc1FHd4D61iuLJ4aP8hiQ6tuRCm
        H8eib+HPDq1wHF2r9hDuaqr1Vh1/Efg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-mkV8QeEjPaivxHdSIOf6Kg-1; Wed, 08 Jan 2020 21:03:51 -0500
X-MC-Unique: mkV8QeEjPaivxHdSIOf6Kg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90ECC801E6C;
        Thu,  9 Jan 2020 02:03:50 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2447E10027A6;
        Thu,  9 Jan 2020 02:03:45 +0000 (UTC)
Date:   Thu, 9 Jan 2020 10:03:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix splitting segments
Message-ID: <20200109020341.GC9655@ming.t460p>
References: <20191229023230.28940-1-ming.lei@redhat.com>
 <20200108140248.GA2896@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108140248.GA2896@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 08, 2020 at 06:02:48AM -0800, Christoph Hellwig wrote:
> > +static inline unsigned get_max_segment_size(const struct request_queue *q,
> > +					    const struct page *start_page,
> > +					    unsigned long offset)
> >  {
> >  	unsigned long mask = queue_segment_boundary(q);
> >  
> > -	/* default segment boundary mask means no boundary limit */
> > -	if (mask == BLK_SEG_BOUNDARY_MASK)
> > -		return queue_max_segment_size(q);
> > -
> > -	return min_t(unsigned long, mask - (mask & offset) + 1,
> > +	offset = mask & (page_to_phys(start_page) + offset);
> 
> This looks weird and potentionaly incorrect - once you add the offset
> to page_phys it really isn't an offset anymore and should be in a
> variable named paddr or similar.  And that needs to use a phys_addr_t

It can be thought as offset from viewpoint of segment boundary.

> as we can have 32-bit architectures that use 64-bit physical addresses.
> 
> I'd also pass in the actual phys_addr_t instead of the page and offset.
> 

It has been addressed in:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-5.5&id=ecd255974caa45901d0b8fab03626e0a18fbc81a

Thanks,
Ming

