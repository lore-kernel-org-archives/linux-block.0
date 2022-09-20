Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E091C54EE9
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 17:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiITRrq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 13:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiITRrc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 13:47:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668FF6E88B
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 10:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663696050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KyujvkjYAJnd5W1QNZcbNs03OiVmQxNpHF8mlVuTXMI=;
        b=ZwKjOszWkq6QxXNyCkf65KmNkCP+dx8YYlErGRf+1bqcsvEBelnGdIQK8IkuJxwtIColWU
        bI0QpCfoMNj/VdC2Lg6sAVONVDnnTaCRPJEMEb51Cog1iahrhbJccJJU8URe3Sqi+jp1Gl
        QVmsNSFfHTwGLa10W2zaHchO1eE0EOY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-F9dQSlcpMlOFX3ZokXaPQw-1; Tue, 20 Sep 2022 13:47:27 -0400
X-MC-Unique: F9dQSlcpMlOFX3ZokXaPQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A32138041C2;
        Tue, 20 Sep 2022 17:47:27 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28C3D2166B29;
        Tue, 20 Sep 2022 17:47:27 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 28KHlRS5025532;
        Tue, 20 Sep 2022 13:47:27 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 28KHlR3D025528;
        Tue, 20 Sep 2022 13:47:27 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 20 Sep 2022 13:47:27 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Christoph Hellwig <hch@infradead.org>
cc:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 3/4] brd: enable discard
In-Reply-To: <YyluKtwOaLSPvNmI@infradead.org>
Message-ID: <alpine.LRH.2.02.2209201309270.22306@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2209151604410.13231@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2209160459470.543@file01.intranet.prod.int.rdu2.redhat.com> <YyluKtwOaLSPvNmI@infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Tue, 20 Sep 2022, Christoph Hellwig wrote:

> > @@ -289,6 +308,23 @@ static void brd_submit_bio(struct bio *b
> >  	struct bio_vec bvec;
> >  	struct bvec_iter iter;
> >  
> > +	if (bio_op(bio) == REQ_OP_DISCARD) {
> > +		sector_t len = bio_sectors(bio);
> > +		sector_t front_pad = -sector & (PAGE_SECTORS - 1);
> > +		sector += front_pad;
> > +		if (unlikely(len <= front_pad))
> > +			goto endio;
> > +		len -= front_pad;
> > +		len = round_down(len, PAGE_SECTORS);
> > +		while (len) {
> > +			brd_free_page(brd, sector);
> > +			sector += PAGE_SECTORS;
> > +			len -= PAGE_SECTORS;
> > +			cond_resched();
> > +		}
> > +		goto endio;
> > +	}
> > +
> >  	bio_for_each_segment(bvec, bio, iter) {
> 
> Please add separate helpers to each type of IO and just make the
> main submit_bio method a dispatch on the types instead of this
> spaghetti code.
> 
> > +	disk->queue->limits.discard_granularity = PAGE_SIZE;
> > +	blk_queue_max_discard_sectors(disk->queue, UINT_MAX);
> 
> We'll probably want an opt in for this new feature.

OK. I addressed these concerns and I'll send a second version of the patch 
set.

Mikulas

