Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498B9C433E0
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 04:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FDDD64E4F
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 04:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBIEYi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Feb 2021 23:24:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52266 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230139AbhBIEXE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Feb 2021 23:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612844484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/eFer26DbD5JrI/cKhVP4gnabxdLf1Clq3I+VIutzqc=;
        b=ESRm6AkjAZV9avgdXcdmqsLoQxdopTYHTYvj3EEEymTh4uiet+uALW1x0zNHixrB5dguKe
        XZsVVQLvG4i8w0HW2twoBAXTPWjy9yHImrjxlV9jT3mPxyohO/3DGlHLLvmeXOmCFD9Vmo
        shsWfgvAZt9iG2MCnKHD35ii63tohac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-2-cxNutzMUG-vfdb2RmxEw-1; Mon, 08 Feb 2021 23:21:23 -0500
X-MC-Unique: 2-cxNutzMUG-vfdb2RmxEw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C32B9192D789;
        Tue,  9 Feb 2021 04:21:20 +0000 (UTC)
Received: from T590 (ovpn-13-86.pek2.redhat.com [10.72.13.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF37F10013D7;
        Tue,  9 Feb 2021 04:21:07 +0000 (UTC)
Date:   Tue, 9 Feb 2021 12:21:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block <linux-block@vger.kernel.org>, axboe@kernel.dk,
        Rachel Sibley <rasibley@redhat.com>,
        Chaitanya.Kulkarni@wdc.com, CKI Project <cki-project@redhat.com>
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
Message-ID: <20210209042103.GB63798@T590>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <af1d7e9d-0170-82f6-30e1-01f045d73fc7@grimberg.me>
 <6147d452-a12e-c76c-22f1-5d9e7cb6b01d@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6147d452-a12e-c76c-22f1-5d9e7cb6b01d@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 08, 2021 at 10:42:28AM -0800, Sagi Grimberg wrote:
> 
> > > Hi Sagi
> > > 
> > > On 2/8/21 5:46 PM, Sagi Grimberg wrote:
> > > > 
> > > > > Hello
> > > > > 
> > > > > We found this kernel NULL pointer issue with latest
> > > > > linux-block/for-next and it's 100% reproduced, let me know
> > > > > if you need more info/testing, thanks
> > > > > 
> > > > > Kernel repo:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> > > > > Commit: 11f8b6fd0db9 - Merge branch 'for-5.12/io_uring' into for-next
> > > > > 
> > > > > Reproducer: blktests nvme-tcp/012
> > > > 
> > > > Thanks for reporting Ming, I've tried to reproduce this on my VM
> > > > but did not succeed. Given that you have it 100% reproducible,
> > > > can you try to revert commit:
> > > > 
> > > > 0dc9edaf80ea nvme-tcp: pass multipage bvec to request iov_iter
> > > > 
> > > 
> > > Revert this commit fixed the issue and I've attached the config. :)
> > 
> > Good to know,
> > 
> > I see some differences that I should probably change to hit this:
> > -- 
> > @@ -254,14 +256,15 @@ CONFIG_PERF_EVENTS=y
> >   # end of Kernel Performance Events And Counters
> > 
> >   CONFIG_VM_EVENT_COUNTERS=y
> > +CONFIG_SLUB_DEBUG=y
> >   # CONFIG_COMPAT_BRK is not set
> > -CONFIG_SLAB=y
> > -# CONFIG_SLUB is not set
> > -# CONFIG_SLOB is not set
> > -CONFIG_SLAB_MERGE_DEFAULT=y
> > -# CONFIG_SLAB_FREELIST_RANDOM is not set
> > +# CONFIG_SLAB is not set
> > +CONFIG_SLUB=y
> > +# CONFIG_SLAB_MERGE_DEFAULT is not set
> > +CONFIG_SLAB_FREELIST_RANDOM=y
> >   # CONFIG_SLAB_FREELIST_HARDENED is not set
> > -# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
> > +CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
> > +CONFIG_SLUB_CPU_PARTIAL=y
> >   CONFIG_SYSTEM_DATA_VERIFICATION=y
> >   CONFIG_PROFILING=y
> >   CONFIG_TRACEPOINTS=y
> > @@ -299,7 +302,8 @@ CONFIG_HAVE_INTEL_TXT=y
> >   CONFIG_X86_64_SMP=y
> >   CONFIG_ARCH_SUPPORTS_UPROBES=y
> >   CONFIG_FIX_EARLYCON_MEM=y
> > -CONFIG_PGTABLE_LEVELS=4
> > +CONFIG_DYNAMIC_PHYSICAL_MASK=y
> > +CONFIG_PGTABLE_LEVELS=5
> >   CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> > -- 
> > 
> > Probably CONFIG_SLUB and CONFIG_SLUB_DEBUG should be used.
> 
> Used your profile and this still does not happen :(

One obvious error is that nr_segments is computed wrong.

Yi, can you try the following patch?

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 881d28eb15e9..a393d99b74e1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -239,9 +239,14 @@ static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
 		offset = 0;
 	} else {
 		struct bio *bio = req->curr_bio;
+		struct bio_vec bv;
+		struct bvec_iter iter;
+
+		nsegs = 0;
+		bio_for_each_bvec(bv, bio, iter)
+			nsegs++;
 
 		vec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
-		nsegs = bio_segments(bio);
 		size = bio->bi_iter.bi_size;
 		offset = bio->bi_iter.bi_bvec_done;
 	}

-- 
Ming

