Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B21C35280
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 01:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F306207DD
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 01:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCYVPHrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEHBys (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 21:54:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46081 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726636AbgEHBys (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 May 2020 21:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588902887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NBae3J3scS9WAJ2x3bLisb9Uru1E4B2kc1o6H0JEsT0=;
        b=KCYVPHrX2XBoE77FKuyWd+pL7CpJS5NyBYcQMsTB0yMazLaIqpPFTE63eHe5Q1JYpkAp+Y
        pse98SS/H98f81mPdHZ8dHErZIGwLa72h9DgOvRcybuhl+lHIFHdZq9TCqUViLCvmap0aK
        HL53NbYRZg/J4kqQ++LDWNf9WKNTYB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-RBaZfmpUO2OKKXO2ENM3EA-1; Thu, 07 May 2020 21:54:42 -0400
X-MC-Unique: RBaZfmpUO2OKKXO2ENM3EA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 478201005510;
        Fri,  8 May 2020 01:54:40 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 004E15C296;
        Fri,  8 May 2020 01:54:30 +0000 (UTC)
Date:   Fri, 8 May 2020 09:54:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yufen Yu <yuyufen@huawei.com>, Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH 1/4] block: fix use-after-free on cached last_lookup
 partition
Message-ID: <20200508015425.GB1360332@T590>
References: <20200507085239.1354854-1-ming.lei@redhat.com>
 <20200507085239.1354854-2-ming.lei@redhat.com>
 <20200507141626.GA11551@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507141626.GA11551@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 07, 2020 at 07:16:26AM -0700, Christoph Hellwig wrote:
> On Thu, May 07, 2020 at 04:52:36PM +0800, Ming Lei wrote:
> >  	for (i = 1; i < ptbl->len; i++) {
> >  		part = rcu_dereference(ptbl->part[i]);
> >  
> >  		if (part && sector_in_part(part, sector)) {
> > +			if (!hd_struct_try_get(part))
> > +				goto exit;
> 
> I think this needs the comment that was in blk_account_io_start to
> explain the logic.  Also no need for the goto, this can just be a break.

OK, not did it because I thought the logic is straightforward.

> 
> > -	rcu_assign_pointer(ptbl->last_lookup, NULL);
> >  	kobject_put(part->holder_dir);
> >  	device_del(part_to_dev(part));
> >  
> > @@ -393,6 +402,7 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
> >  	p->nr_sects = len;
> >  	p->partno = partno;
> >  	p->policy = get_disk_ro(disk);
> > +	p->disk = disk;
> 
> Do we really need this pointer?  Can't we use part_to_disk in the
> free path for some reason?

Looks I did miss this function, :-)

Thanks, 
Ming

