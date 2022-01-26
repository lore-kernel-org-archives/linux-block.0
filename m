Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE88C63682
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 07:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbiAZHVa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 02:21:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237704AbiAZHV1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 02:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643181685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ChzXGjDq+n0o2fu8dy3EjJHxjjUhkcJ57NGo6xi+9ws=;
        b=YrKx6W0pHryI62mqiRjQJvlELp0YptKDqKJecq0mAVQEAZlFCBCpV1+xVpn3nAhMzW/6uw
        X2jVqvicdpMz2lCuNKFUpt+mkQVKxlqcICFV4iObPk7Y9UmvTkr46yxdw4EZ/ojM/ww0Ha
        +2a3nxsaXMOiPBa7FkWA1a+fvfuPmnc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-2_DijEOSOzidwZtTm4ux6Q-1; Wed, 26 Jan 2022 02:21:22 -0500
X-MC-Unique: 2_DijEOSOzidwZtTm4ux6Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3647A18C89DD;
        Wed, 26 Jan 2022 07:21:21 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECBB410589BC;
        Wed, 26 Jan 2022 07:21:09 +0000 (UTC)
Date:   Wed, 26 Jan 2022 15:21:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 05/13] block: only account passthrough IO from
 userspace
Message-ID: <YfD2YNRf+lhe5BcU@T590>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-6-ming.lei@redhat.com>
 <20220124130555.GD27269@lst.de>
 <Ye8xleeYZfmwA3D7@T590>
 <20220125061634.GA26495@lst.de>
 <20220125071906.GA27674@lst.de>
 <Ye++VmBkg0I8Lq8+@T590>
 <20220126055003.GA21089@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126055003.GA21089@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 26, 2022 at 06:50:03AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 25, 2022 at 05:09:42PM +0800, Ming Lei wrote:
> > Follows another simple way by accounting all request with bio attached,
> > except for requests with kernel buffer.
> 
> > -	else if (rq->q->disk)
> > +	else if (rq->q->disk && rq->bio)
> >  		rq->part = rq->q->disk->part0;
> 
> Most passthrough requests will have a bio, so you'll still use e.g.
> the sd gendisk for sg request here.
> 
> I think the right way would be to just remove this branch entirely.
> This means we only account bios with a block_device, which implies
> they have a gendisk.

That will not account userspace IO, and people may complain.

We can just account passthrough request from userspace by the patch
in my last email.


Thanks, 
Ming

