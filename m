Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B97C43334
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 07:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiGVHad (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 03:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVHac (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 03:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5A352AC65
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 00:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658475030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yl4cgmWTixnuyPnVrsmLdQpSe7MWXstQaWSZ2jLxH4I=;
        b=KBY4fWnzwZ/7do3aYYygx31xYyXDNsIn9+MAiVQv0MJw+QkYhnszi+BG/8oiRJMfjKuoBl
        2rvvOieP6LvQNe8AXz1dsyN0ev75CeEw1ngUqkN1+QTqkoGUduxsViQ+53toBJFrkEl4R3
        3+5t0697wSMPeyyaASK006sqUvcXNw0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-_fAvuH7UOR-OZHi4xS67wA-1; Fri, 22 Jul 2022 03:30:29 -0400
X-MC-Unique: _fAvuH7UOR-OZHi4xS67wA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7BFB800124;
        Fri, 22 Jul 2022 07:30:28 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 857BB1415118;
        Fri, 22 Jul 2022 07:30:23 +0000 (UTC)
Date:   Fri, 22 Jul 2022 15:30:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>, ming.lei@redhat.com
Subject: Re: [PATCH V2 2/2] ublk_drv: make sure that correct flags(features)
 returned to userspace
Message-ID: <YtpSCX5ZC3cnWakM@T590>
References: <20220722050930.611232-1-ming.lei@redhat.com>
 <20220722050930.611232-3-ming.lei@redhat.com>
 <Yto6s09YN1FK2Zi6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yto6s09YN1FK2Zi6@infradead.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 21, 2022 at 10:50:43PM -0700, Christoph Hellwig wrote:
> On Fri, Jul 22, 2022 at 01:09:30PM +0800, Ming Lei wrote:
> > +	unsigned long *map = (unsigned long *)&ub->dev_info.flags[0];
> > +
> > +	/* We are not ready to support zero copy */
> > +	ub->dev_info.flags[0] &= ~UBLK_F_SUPPORT_ZERO_COPY;
> > +
> > +	/*
> > +	 * 128bit flags will be copied back to userspace as feature
> > +	 * negotiation result, so have to clear flags which driver
> > +	 * doesn't support yet, then userspace can get correct flags
> > +	 * (features) to handle.
> > +	 */
> > +	bitmap_clear(map, __UBLK_F_NR_BITS, 128 - __UBLK_F_NR_BITS);
> 
> Please don't do the cast and bitmap ops.  In fact I think the current
> ABI is rather nasty.  To make everyones life easier just use a single
> u64 flags, an mark the second one reserved so that we can extent into
> it with extra flags or something else.  That way normal C operator
> leve bitops just work.

OK.

> 
> > +enum ublk_flag_bits {
> > +	__UBLK_F_SUPPORT_ZERO_COPY,
> > +	__UBLK_F_URING_CMD_COMP_IN_TASK,
> > +	__UBLK_F_NR_BITS,
> > +};
> 
> Please make these #defines so that userspace can detect if they
> exist in a header using #ifdef.

userspace is supposed to only use UBLK_F_* instead of __UBLK_F_*, one
benefit of using enum is that UBLK_F_NR_BITS can be figured out
automatically, otherwise how can we figure out the max bits?


thanks,
Ming

