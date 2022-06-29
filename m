Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1913C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 00:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiF2Atm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 20:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiF2Atm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 20:49:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB1DB1F2F5
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 17:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656463779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hJJvsP38uCAhkJVo5eAyle5Qy06Hh20XjQIP/E5HpUc=;
        b=PA/ejDSiwuhRGY8iI008Q1hstxf0Gn7cUGAqHAvSEmSC8mP3FpvCrYm3zxSA1H+LzOdKgN
        ocC3H/vgExTeS5apVc3VdpFiOjK+PFs0aPV1d2yjYRFl1xFdbh3Bln5bsaBEdpy/hBhoBT
        xrIfsyC6C9lfvq0DraqJ4KStuoWreGw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-MkFEz1IoNGW7_yrtRWIwCQ-1; Tue, 28 Jun 2022 20:49:36 -0400
X-MC-Unique: MkFEz1IoNGW7_yrtRWIwCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CE08811E75;
        Wed, 29 Jun 2022 00:49:36 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F064E1415108;
        Wed, 29 Jun 2022 00:49:29 +0000 (UTC)
Date:   Wed, 29 Jun 2022 08:49:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <YruhlPDqZMorCFip@T590>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
 <20220626201458.ytn4mrix2pobm2mb@moria.home.lan>
 <Yrld9rLPY6L3MhlZ@T590>
 <20220628042016.wd65amvhbjuduqou@moria.home.lan>
 <3ad782c3-4425-9ae6-e61b-9f62f76ce9f4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ad782c3-4425-9ae6-e61b-9f62f76ce9f4@kernel.dk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 28, 2022 at 12:13:06PM -0600, Jens Axboe wrote:
> On 6/27/22 10:20 PM, Kent Overstreet wrote:
> > On Mon, Jun 27, 2022 at 03:36:22PM +0800, Ming Lei wrote:
> >> On Sun, Jun 26, 2022 at 04:14:58PM -0400, Kent Overstreet wrote:
> >>> On Fri, Jun 24, 2022 at 10:12:52PM +0800, Ming Lei wrote:
> >>>> Commit 7759eb23fd98 ("block: remove bio_rewind_iter()") removes
> >>>> the similar API because the following reasons:
> >>>>
> >>>>     ```
> >>>>     It is pointed that bio_rewind_iter() is one very bad API[1]:
> >>>>
> >>>>     1) bio size may not be restored after rewinding
> >>>>
> >>>>     2) it causes some bogus change, such as 5151842b9d8732 (block: reset
> >>>>     bi_iter.bi_done after splitting bio)
> >>>>
> >>>>     3) rewinding really makes things complicated wrt. bio splitting
> >>>>
> >>>>     4) unnecessary updating of .bi_done in fast path
> >>>>
> >>>>     [1] https://marc.info/?t=153549924200005&r=1&w=2
> >>>>
> >>>>     So this patch takes Kent's suggestion to restore one bio into its original
> >>>>     state via saving bio iterator(struct bvec_iter) in bio_integrity_prep(),
> >>>>     given now bio_rewind_iter() is only used by bio integrity code.
> >>>>     ```
> >>>>
> >>>> However, it isn't easy to restore bio by saving 32 bytes bio->bi_iter, and saving
> >>>> it only can't restore crypto and integrity info.
> >>>>
> >>>> Add bio_rewind() back for some use cases which may not be same with
> >>>> previous generic case:
> >>>>
> >>>> 1) most of bio has fixed end sector since bio split is done from front of the bio,
> >>>> if driver just records how many sectors between current bio's start sector and
> >>>> the bio's end sector, the original position can be restored
> >>>>
> >>>> 2) if one bio's end sector won't change, usually bio_trim() isn't called, user can
> >>>> restore original position by storing sectors from current ->bi_iter.bi_sector to
> >>>> bio's end sector; together by saving bio size, 8 bytes can restore to
> >>>> original bio.
> >>>>
> >>>> 3) dm's requeue use case: when BLK_STS_DM_REQUEUE happens, dm core needs to
> >>>> restore to the original bio which represents current dm io to be requeued.
> >>>> By storing sectors to the bio's end sector and dm io's size,
> >>>> bio_rewind() can restore such original bio, then dm core code needn't to
> >>>> allocate one bio beforehand just for handling BLK_STS_DM_REQUEUE which
> >>>> is actually one unusual event.
> >>>>
> >>>> 4) Not like original rewind API, this one needn't to add .bi_done, and no any
> >>>> effect on fast path
> >>>
> >>> It seems like perhaps the real issue here is that we need a real bio_iter,
> >>> separate from bvec_iter, that also encapsulates iterating over integrity &
> >>> fscrypt. 
> >>
> >> Not mention bio_iter, bvec_iter has been 32 bytes, which is too big to
> >> hold in per-io data structure. With this patch, 8bytes is enough
> >> to rewind one bio if the end sector is fixed.
> > 
> > Hold on though, does that check out? Why is that too big for per IO data
> > structures?
> > 
> > By definition these structures are only for IOs in flight, and we don't _want_
> > there to ever be very many of these or we're going to run into latency issues
> > due to queue depth.
> 
> It's much less about using whatever amount of memory for inflight IO,
> and much more about not bloating fast path structures (of which the bio
> is certainly one). All of this gunk has to be initialized for each IO,
> and that's the real issue.

Can't agree more, especially the initialization is just for the unusual
DM_REQUEUE event(bio rewind is needed).


Thanks,
Ming

