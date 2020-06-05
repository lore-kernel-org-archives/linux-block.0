Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D500C433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 07:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D53206DC
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 07:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5A5YFDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgFEHbq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 03:31:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25337 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725280AbgFEHbp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Jun 2020 03:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591342304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hGfj0xACvt+aD8msBaBYURuw6XsINDRLgRfsY+KyXP8=;
        b=D5A5YFDmVdZtkVqmkmfH4PLw+f2IEJiw14/AY5uQt3gF4yVkqZaf8SYs9ivRJ2vqOxuRQr
        2R1OdOUwBJQFuj6EHUL8LyXQBZ1fHEAak5TJAfslrbqZe6kCOpAcDH4OfENjc2eW3/wPZV
        zIWLqXyH2Yk3AaxOx5MWnZJb0XMceAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-FL5RJ0lIMNKHGKdyTdEC2A-1; Fri, 05 Jun 2020 03:31:40 -0400
X-MC-Unique: FL5RJ0lIMNKHGKdyTdEC2A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9BD8800688;
        Fri,  5 Jun 2020 07:31:38 +0000 (UTC)
Received: from T590 (ovpn-12-164.pek2.redhat.com [10.72.12.164])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 58B176292E;
        Fri,  5 Jun 2020 07:31:31 +0000 (UTC)
Date:   Fri, 5 Jun 2020 15:31:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] blk-mq: don't fail driver tag allocation because of
 inactive hctx
Message-ID: <20200605073127.GA2378708@T590>
References: <6fbd3669-4358-6d9f-5c94-e1bc7acecb86@oracle.com>
 <b37b1f30-722b-4767-0627-103b94c7421c@huawei.com>
 <20200604112615.GA2336493@T590>
 <7291fd02-3c2c-f3f9-f3eb-725cd85d5523@huawei.com>
 <20200604120747.GB2336493@T590>
 <38b4c7a3-057f-c52c-993b-523660085e3c@huawei.com>
 <20200604130058.GC2336493@T590>
 <83c37a8f-abfa-c1d1-e9d6-ccfdd344edb3@huawei.com>
 <20200605005915.GA2368173@T590>
 <e7d97cfa-c0c3-180c-cfbd-976d90592ac1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7d97cfa-c0c3-180c-cfbd-976d90592ac1@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 05, 2020 at 08:24:50AM +0100, John Garry wrote:
> On 05/06/2020 01:59, Ming Lei wrote:
> > > 	hctx5: default 36 37 38 39
> > > 	hctx6: default 40 41 42 43
> > > 	hctx7: default 44 45 46 47
> > > 	hctx8: default 48 49 50 51
> > > 	hctx9: default 52 53 54 55
> > > 	hctx10: default 56 57 58 59
> > > 	hctx11: default 60 61 62 63
> > > 	hctx12: default 0 1 2 3
> > > 	hctx13: default 4 5 6 7
> > > 	hctx14: default 8 9 10 11
> > > 	hctx15: default 12 13 14 15
> > OK, the queue mapping is correct.
> > 
> > As I mentioned in another thread, the real hw tag may be set as wrong.
> > 
> 
> I doubt this.
> 
> And I think that you should also be able to add the same debug to
> blk_mq_hctx_notify_offline() to see that there may be still driver tags
> allocated to when all the scheduler tags are free'd for any test in your
> env.

No, that isn't possible, scheduler tag lifetime covers the whole request's
lifetime.

> 
> > You have to double check your cooked tag allocation algorithm and see if it
> > can work well when more requests than real hw queue depth are queued to hisi_sas,
> > and the correct way is to return SCSI_MLQUEUE_HOST_BUSY from .queuecommand().
> 
> Yeah, the LLDD would just reject requests in that scenario and we would know
> about it from logs etc.
> 
> Anyway, I'll continue to check.

The merged patch is much simpler than before, new request is prevented from being
allocated on the inactive hctx, then drain all in-flight requests on this hctx.

You need to check if the request is queued to hw correctly.

Thanks,
Ming

