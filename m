Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AE9C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 13:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4D820652
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 13:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfDXNSp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:18:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfDXNSp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 09:18:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 56F067880A;
        Wed, 24 Apr 2019 13:18:45 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4341D5D9C8;
        Wed, 24 Apr 2019 13:18:39 +0000 (UTC)
Date:   Wed, 24 Apr 2019 21:18:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] block: integrity: enable multi-page bvec for bio
 integrity
Message-ID: <20190424131834.GA19829@ming.t460p>
References: <20190423071550.20806-1-ming.lei@redhat.com>
 <20190423071550.20806-2-ming.lei@redhat.com>
 <yq1ftq78s03.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1ftq78s03.fsf@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 24 Apr 2019 13:18:45 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 24, 2019 at 09:14:36AM -0400, Martin K. Petersen wrote:
> 
> Ming,
> 
> I'm traveling today and probably won't be able to take a closer look
> until tomorrow. But from a quick glance this looks OK.
> 
> > The integrity buffer can't be very big, for example, the max sectors
> > for one bio is 2560, one sector may take at most 8bytes for integrity
> > info, so the max size of integrity buffer is just 20k(<=5 pages).
> 
> Just a comment on your rationale about 5 pages.
> 
> buffer_head submissions have traditionally been small, and depending on
> your choice of allocator, new allocations would grow backwards in
> memory. So there were several common I/O patterns that produced a
> single, non-mergeable 8 byte integrity metadata allocation for every 512
> bytes of data in the I/O. It's a pathological corner case. Just make
> sure it's something you handle when you muck with this. ext[23] and dd
> to the block device used to be able to reproduce this scenario easily.

Yeah, you are right.

I have realized that 5 pages aren't correct, and it should be one
protection data segment for each bio usually.

Thanks,
Ming
