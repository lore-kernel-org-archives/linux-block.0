Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCA8C433E6
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 10:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9AC64E66
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 10:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhBIKhC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Feb 2021 05:37:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230242AbhBIKe4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Feb 2021 05:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612866803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fAbk76FPd4KNKds84zkQyUhfWhmi/6ZeQyyWAWIOkNg=;
        b=GLDKBR2TXxdiZxDwdo4t+3F57nIgFJ2lxMtotAhq+xkDE1FGX5Xxz32XxGq5abXYXF/fxY
        hf8/9uiF9GvMqt7HSIjnm/ix/aD3tzvlAKdymbt0QzyGe36tVtt0kG+k0gPr559RVE3+Y4
        hb0i+/GQm6LB2RNq/zXyrDjbEkJr2XY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-sljgb6JtPUOJZedya_vNxQ-1; Tue, 09 Feb 2021 05:33:19 -0500
X-MC-Unique: sljgb6JtPUOJZedya_vNxQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52B7880196C;
        Tue,  9 Feb 2021 10:33:18 +0000 (UTC)
Received: from T590 (ovpn-12-152.pek2.redhat.com [10.72.12.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A75860CCF;
        Tue,  9 Feb 2021 10:33:05 +0000 (UTC)
Date:   Tue, 9 Feb 2021 18:33:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block <linux-block@vger.kernel.org>, axboe@kernel.dk,
        Rachel Sibley <rasibley@redhat.com>,
        Chaitanya.Kulkarni@wdc.com, CKI Project <cki-project@redhat.com>
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
Message-ID: <20210209103300.GA101814@T590>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <af1d7e9d-0170-82f6-30e1-01f045d73fc7@grimberg.me>
 <6147d452-a12e-c76c-22f1-5d9e7cb6b01d@grimberg.me>
 <20210209042103.GB63798@T590>
 <1ea82025-44b8-ac3a-2039-35cb8d36dac2@grimberg.me>
 <20210209075001.GA94287@T590>
 <d5e33680-5196-2873-332f-19191c60fd3b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5e33680-5196-2873-332f-19191c60fd3b@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 09, 2021 at 02:07:15AM -0800, Sagi Grimberg wrote:
> 
> > > > 
> > > > One obvious error is that nr_segments is computed wrong.
> > > > 
> > > > Yi, can you try the following patch?
> > > > 
> > > > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > > > index 881d28eb15e9..a393d99b74e1 100644
> > > > --- a/drivers/nvme/host/tcp.c
> > > > +++ b/drivers/nvme/host/tcp.c
> > > > @@ -239,9 +239,14 @@ static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
> > > >    		offset = 0;
> > > >    	} else {
> > > >    		struct bio *bio = req->curr_bio;
> > > > +		struct bio_vec bv;
> > > > +		struct bvec_iter iter;
> > > > +
> > > > +		nsegs = 0;
> > > > +		bio_for_each_bvec(bv, bio, iter)
> > > > +			nsegs++;
> > > >    		vec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
> > > > -		nsegs = bio_segments(bio);
> > > 
> > > This was exactly the patch that caused the issue.
> > 
> > What was the issue you are talking about? Any link or commit hash?
> 
> The commit that caused the crash is:
> 0dc9edaf80ea nvme-tcp: pass multipage bvec to request iov_iter

Not found this commit in linus tree, :-(

> 
> > 
> > nvme-tcp builds iov_iter(BVEC) from __bvec_iter_bvec(), the segment
> > number has to be the actual bvec number. But bio_segment() just returns
> > number of the single-page segment, which is wrong for iov_iter.
> 
> That is what I thought, but its causing a crash, and was fine with
> bio_segments. So I'm trying to understand why is that.

I tested this patch, and it works just fine.

> 
> > Please see the same usage in lo_rw_aio().
> 
> nvme-tcp works on the bio basis to avoid bvec allocation
> in the data path. Hence the iterator is fed directly by
> the bio bvec and will re-initialize on every bio that
> is spanned by the request.

Yeah, I know that. What I meant is that rq_for_each_bvec() is used
to figure out bvec number in loop, which may feed the bio bvec
directly to fs via iov_iter too, just similar with nvme-tcp.

The difference is that loop will switch to allocate a new bvec
table and copy bios's bvec to the new table in case of bios merge.

-- 
Ming

