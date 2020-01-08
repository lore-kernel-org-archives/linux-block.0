Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4785C33C99
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 02:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919172070E
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 02:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6JoN7EN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgAHCih (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:38:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51417 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAHCih (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 21:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578451116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oAzUz4rZd1GpICP9wIY1W4fOzuCVcGaHvJb57+icYfI=;
        b=e6JoN7ENv3WBIK8250fzQQXz+bPKidILioArqhYZE6IvqqdhOHzEGM0W2Ihb1gEgp0Uia6
        6DuIQQzIV4Uu0kyRT7b4mCq0OU9TbKwoNvsh9JO5PrP5o3pfaabT9Z1fWbzGdiT0zCMjiO
        9Tpuj/YwHbGLG0FPQN3ieu5PpEzK7RE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-SpiJmwOsPpCl-seNh2r3oQ-1; Tue, 07 Jan 2020 21:38:32 -0500
X-MC-Unique: SpiJmwOsPpCl-seNh2r3oQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 860AD180746B;
        Wed,  8 Jan 2020 02:38:31 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A92C560FC4;
        Wed,  8 Jan 2020 02:38:26 +0000 (UTC)
Date:   Wed, 8 Jan 2020 10:38:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] block: fix get_max_segment_size() overflow on 32bit arch
Message-ID: <20200108023822.GB28075@ming.t460p>
References: <20200108012526.26731-1-ming.lei@redhat.com>
 <BYAPR04MB581614236B3088415240723AE73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB581614236B3088415240723AE73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 08, 2020 at 02:06:25AM +0000, Damien Le Moal wrote:
> On 2020/01/08 10:25, Ming Lei wrote:
> > Commit 429120f3df2d starts to take account of segment's start dma address
> > when computing max segment size, and data type of 'unsigned long'
> > is used to do that. However, the segment mask may be 0xffffffff, so
> > the figured out segment size may be overflowed because DMA address can
> > be 64bit on 32bit arch.
> > 
> > Fixes the issue by using 'unsigned long long' to compute max segment
> > size.
> > 
> > Fixes: 429120f3df2d ("block: fix splitting segments on boundary masks")
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Tested-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-merge.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > index 347782a24a35..b0fcc72594cb 100644
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -159,12 +159,12 @@ static inline unsigned get_max_io_size(struct request_queue *q,
> >  
> >  static inline unsigned get_max_segment_size(const struct request_queue *q,
> >  					    struct page *start_page,
> > -					    unsigned long offset)
> > +					    unsigned long long offset)
> >  {
> >  	unsigned long mask = queue_segment_boundary(q);
> >  
> >  	offset = mask & (page_to_phys(start_page) + offset);
> 
> Shouldn't mask be an unsigned long long too for this to give the
> expected correct result ?

queue_segment_boundary() always returns 'unsigned long', so far not
see issue related with that.


Thanks,
Ming

