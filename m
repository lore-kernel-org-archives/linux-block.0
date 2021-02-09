Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B397EC433E0
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 07:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A2464E37
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 07:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhBIHwG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Feb 2021 02:52:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56396 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhBIHvx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Feb 2021 02:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612857024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AcVl74pqED+AYYvT76QkqstjS7GruGjGDfduxsOo1eA=;
        b=YkLv54i2GhMqXVLvi3vwJMpWYnbW+oii1IAn3Zym3F6qxcPO52oabj+MWZVP7/Fei1CXgg
        49ZpX3zzHWobycB9Mr9Dc8tzS+ByS42WR7kkjeeykkgaJhaVGwyv1RYJ8mqA6+Fir/Juge
        kdFlO5Ew6d4zUFZmGqKPUlP4C6hWiOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-daujD2nkObOKum4YGaK_8g-1; Tue, 09 Feb 2021 02:50:22 -0500
X-MC-Unique: daujD2nkObOKum4YGaK_8g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B369427C3;
        Tue,  9 Feb 2021 07:50:21 +0000 (UTC)
Received: from T590 (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE8BF5D6D7;
        Tue,  9 Feb 2021 07:50:05 +0000 (UTC)
Date:   Tue, 9 Feb 2021 15:50:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block <linux-block@vger.kernel.org>, axboe@kernel.dk,
        Rachel Sibley <rasibley@redhat.com>,
        Chaitanya.Kulkarni@wdc.com, CKI Project <cki-project@redhat.com>
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
Message-ID: <20210209075001.GA94287@T590>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <af1d7e9d-0170-82f6-30e1-01f045d73fc7@grimberg.me>
 <6147d452-a12e-c76c-22f1-5d9e7cb6b01d@grimberg.me>
 <20210209042103.GB63798@T590>
 <1ea82025-44b8-ac3a-2039-35cb8d36dac2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ea82025-44b8-ac3a-2039-35cb8d36dac2@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 08, 2021 at 11:21:53PM -0800, Sagi Grimberg wrote:
> 
> 
> On 2/8/21 8:21 PM, Ming Lei wrote:
> > On Mon, Feb 08, 2021 at 10:42:28AM -0800, Sagi Grimberg wrote:
> > > 
> > > > > Hi Sagi
> > > > > 
> > > > > On 2/8/21 5:46 PM, Sagi Grimberg wrote:
> > > > > > 
> > > > > > > Hello
> > > > > > > 
> > > > > > > We found this kernel NULL pointer issue with latest
> > > > > > > linux-block/for-next and it's 100% reproduced, let me know
> > > > > > > if you need more info/testing, thanks
> > > > > > > 
> > > > > > > Kernel repo:
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> > > > > > > Commit: 11f8b6fd0db9 - Merge branch 'for-5.12/io_uring' into for-next
> > > > > > > 
> > > > > > > Reproducer: blktests nvme-tcp/012
> > > > > > 
> > > > > > Thanks for reporting Ming, I've tried to reproduce this on my VM
> > > > > > but did not succeed. Given that you have it 100% reproducible,
> > > > > > can you try to revert commit:
> > > > > > 
> > > > > > 0dc9edaf80ea nvme-tcp: pass multipage bvec to request iov_iter
> > > > > > 
> > > > > 
> > > > > Revert this commit fixed the issue and I've attached the config. :)
> > > > 
> > > > Good to know,
> > > > 
> > > > I see some differences that I should probably change to hit this:
> > > > -- 
> > > > @@ -254,14 +256,15 @@ CONFIG_PERF_EVENTS=y
> > > >    # end of Kernel Performance Events And Counters
> > > > 
> > > >    CONFIG_VM_EVENT_COUNTERS=y
> > > > +CONFIG_SLUB_DEBUG=y
> > > >    # CONFIG_COMPAT_BRK is not set
> > > > -CONFIG_SLAB=y
> > > > -# CONFIG_SLUB is not set
> > > > -# CONFIG_SLOB is not set
> > > > -CONFIG_SLAB_MERGE_DEFAULT=y
> > > > -# CONFIG_SLAB_FREELIST_RANDOM is not set
> > > > +# CONFIG_SLAB is not set
> > > > +CONFIG_SLUB=y
> > > > +# CONFIG_SLAB_MERGE_DEFAULT is not set
> > > > +CONFIG_SLAB_FREELIST_RANDOM=y
> > > >    # CONFIG_SLAB_FREELIST_HARDENED is not set
> > > > -# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
> > > > +CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
> > > > +CONFIG_SLUB_CPU_PARTIAL=y
> > > >    CONFIG_SYSTEM_DATA_VERIFICATION=y
> > > >    CONFIG_PROFILING=y
> > > >    CONFIG_TRACEPOINTS=y
> > > > @@ -299,7 +302,8 @@ CONFIG_HAVE_INTEL_TXT=y
> > > >    CONFIG_X86_64_SMP=y
> > > >    CONFIG_ARCH_SUPPORTS_UPROBES=y
> > > >    CONFIG_FIX_EARLYCON_MEM=y
> > > > -CONFIG_PGTABLE_LEVELS=4
> > > > +CONFIG_DYNAMIC_PHYSICAL_MASK=y
> > > > +CONFIG_PGTABLE_LEVELS=5
> > > >    CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> > > > -- 
> > > > 
> > > > Probably CONFIG_SLUB and CONFIG_SLUB_DEBUG should be used.
> > > 
> > > Used your profile and this still does not happen :(
> > 
> > One obvious error is that nr_segments is computed wrong.
> > 
> > Yi, can you try the following patch?
> > 
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 881d28eb15e9..a393d99b74e1 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -239,9 +239,14 @@ static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
> >   		offset = 0;
> >   	} else {
> >   		struct bio *bio = req->curr_bio;
> > +		struct bio_vec bv;
> > +		struct bvec_iter iter;
> > +
> > +		nsegs = 0;
> > +		bio_for_each_bvec(bv, bio, iter)
> > +			nsegs++;
> >   		vec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
> > -		nsegs = bio_segments(bio);
> 
> This was exactly the patch that caused the issue.

What was the issue you are talking about? Any link or commit hash?

nvme-tcp builds iov_iter(BVEC) from __bvec_iter_bvec(), the segment
number has to be the actual bvec number. But bio_segment() just returns
number of the single-page segment, which is wrong for iov_iter.

Please see the same usage in lo_rw_aio().

-- 
Ming

