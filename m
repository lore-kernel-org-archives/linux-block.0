Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB39EB64DC
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 13:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjGUNrs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 09:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGUNrr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 09:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245572130
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 06:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689947216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jrmvpbo5jzm7locUwS0anXw0yhipWh8XXv2ESQ2gQFA=;
        b=eU2N84C1kDCjcdocQw4PCrRo0vSM7el0NsD6TASYqULHGSMZcr0ZYw5/SUOA7cyp61tGwF
        Qmj4ketYUQNakhawOOH5A9q2cQLzS1QDXkCZ40gbnN5IpVnU9xZyUhy4J8hLxHFW6cChXO
        ZDVy9FtNJrnXKxCUue9aI2QvIvCpiDE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-nEV_GhjaNYy2KTZMEPzyPA-1; Fri, 21 Jul 2023 09:46:50 -0400
X-MC-Unique: nEV_GhjaNYy2KTZMEPzyPA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E7838F184C;
        Fri, 21 Jul 2023 13:46:50 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FD4A2166B25;
        Fri, 21 Jul 2023 13:46:50 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 6940230C0457; Fri, 21 Jul 2023 13:46:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 66E1D3FB76;
        Fri, 21 Jul 2023 15:46:50 +0200 (CEST)
Date:   Fri, 21 Jul 2023 15:46:50 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Li Nan <linan666@huaweicloud.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>
Subject: Re: [dm-devel] [PATCH 3/3] brd: implement write zeroes
In-Reply-To: <a38eaa35-efc9-48e2-7aaf-9eed83589103@nvidia.com>
Message-ID: <244e8f58-15b9-447b-a280-56dd15467f7e@redhat.com>
References: <73c46137-c06e-348f-3d37-8c305ad4c4f3@redhat.com> <a38eaa35-efc9-48e2-7aaf-9eed83589103@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Thu, 20 Jul 2023, Chaitanya Kulkarni wrote:

> > Index: linux-2.6/drivers/block/brd.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/block/brd.c
> > +++ linux-2.6/drivers/block/brd.c
> > @@ -272,7 +272,8 @@ out:
> >   
> >   void brd_do_discard(struct brd_device *brd, struct bio *bio)
> >   {
> > -	sector_t sector, len, front_pad;
> > +	bool zero_padding = bio_op(bio) == REQ_OP_WRITE_ZEROES;
> > +	sector_t sector, len, front_pad, end_pad;
> >   
> >   	if (unlikely(!discard)) {
> >   		bio->bi_status = BLK_STS_NOTSUPP;
> > @@ -282,11 +283,22 @@ void brd_do_discard(struct brd_device *b
> >   	sector = bio->bi_iter.bi_sector;
> >   	len = bio_sectors(bio);
> >   	front_pad = -sector & (PAGE_SECTORS - 1);
> > +
> > +	if (zero_padding && unlikely(front_pad != 0))
> > +		copy_to_brd(brd, page_address(ZERO_PAGE(0)),
> > +			    sector, min(len, front_pad) << SECTOR_SHIFT);
> > +
> 
> Is it possible to create different interface for discard and write
> zeroes ? I think it is a lot of logic adding on one function if everyone
> else is okay please discard my comment ..

Copying code is anti-pattern - it increases code size and it makes it 
harder to modify code in the future.

Discard and write-zeroes perform almost the same operation, the only 
difference is that write-zeroes needs to zero trailing and leading parts 
of boundary pages.

Therefore I think that making one function that performs both discard and 
write zeroes is ok.

> > -	if (bio_op(bio) == REQ_OP_DISCARD) {
> > +	if (bio_op(bio) == REQ_OP_DISCARD ||
> > +	    bio_op(bio) == REQ_OP_WRITE_ZEROES) {
> >   		brd_do_discard(brd, bio);
> >   		goto endio;
> >   	}
> 
> can we please use switch ? unless there is a strong need for if
> which I failed to understand ...

Yes, I can do this change.

> > @@ -355,7 +368,7 @@ MODULE_PARM_DESC(max_part, "Num Minors t
> >   
> >   static bool discard = false;
> >   module_param(discard, bool, 0444);
> > -MODULE_PARM_DESC(discard, "Support discard");
> > +MODULE_PARM_DESC(discard, "Support discard and write zeroes");
> >  
> 
> write-zeroes and discards are both different req_op and they should have
> a separate module parameter ...
> 
> above should be moved to new module parameter write_zeroes, unless there
> is a reason to use one module parameter for both req_op...

Is there some reason why the user might want discard and not want 
write-zeroes or vice versa?

What do Christoph and Jens think? Do you think that there should be two 
separate parameters too?

Mikulas

