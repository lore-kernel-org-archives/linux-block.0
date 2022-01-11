Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E4CC433EF
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 02:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbiAKC03 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jan 2022 21:26:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48670 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244189AbiAKC03 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jan 2022 21:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641867988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M8HnLb4bCMWOo7/1RRqrJsne0IV8nAxRCT99sgLcNb8=;
        b=SS8BDlzPnRrQMZkIdqgm2BV+Pf7HwxvuvlYoVpUiP5XUTdBaUAo/8txpQVt6mGj0DA28bf
        TOUL/WnCJX3O0wu5z2w/W9L0t5JkHNIVBNhSNzzPxgyP45IDIh+J3TaqGzcyqp6EIJLJ11
        J7WP+oxUlutnik8+RCT6qJS6LoINz1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-prkQVVAkP1uZG_VbiVv7GA-1; Mon, 10 Jan 2022 21:26:25 -0500
X-MC-Unique: prkQVVAkP1uZG_VbiVv7GA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAEF15229;
        Tue, 11 Jan 2022 02:26:23 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C5E1519A2;
        Tue, 11 Jan 2022 02:26:14 +0000 (UTC)
Date:   Tue, 11 Jan 2022 10:26:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, lining <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH 1/2] block: add resubmit_bio_noacct()
Message-ID: <Ydzqwc7F4N1TTJ0O@T590>
References: <20220110075141.389532-1-ming.lei@redhat.com>
 <20220110075141.389532-2-ming.lei@redhat.com>
 <YdxuWlZAPJkPyr3h@infradead.org>
 <YdyC9KpQ7yC3l7RZ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdyC9KpQ7yC3l7RZ@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 10, 2022 at 02:03:16PM -0500, Mike Snitzer wrote:
> On Mon, Jan 10 2022 at 12:35P -0500,
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Mon, Jan 10, 2022 at 03:51:40PM +0800, Ming Lei wrote:
> > > Add block layer API of resubmit_bio_noacct() for handling blk-throttle
> > > iops limit correctly. Typical use case is that bio split, and it isn't
> > > good to export blk_throtl_charge_bio_split() for drivers, so add new API
> > > for serving such purpose.
> > 
> > Umm, submit_bio_noacct is meant exactly for this case of resubmitting
> > a bio.  We should not need another API for that.
> > 
> 
> Ming is lifting code out of __blk_queue_split() for reuse (by DM in
> this instance, because it has its own bio_split+bio_chain).
> 
> Are you saying submit_bio_noacct() should be made to call
> blk_throtl_charge_bio_split() and blk_throtl_charge_bio_split() simply
> return if not a split bio? (not sure bio has enough context to know,

DM or MD may submit split bio to underlying queue directly, so we can't
do that simply. Also some FS may call bio_split() too.

Or we simply let blk_throtl_bio cover everything? That is basically
what V1 did, and the only issue is that we can't run the account
in case that submit_bio_noacct() is called from blk_throtl_dispatch_work_fn().

> other than looking at some side-effect change from bio_chain)
> 
> But Ming: your __blk_queue_split() change seems wrong.
> Prior to your patch __blk_queue_split() did:
> 
> bio_chain(split, *bio);
> submit_bio_noacct(*bio);
> *bio = split;
> blk_throtl_charge_bio_split(*bio);
> 
> After your patch (effectively):
> 
> bio_chain(split, *bio);
> submit_bio_noacct(*bio);
> blk_throtl_charge_bio_split(bio);
> *bio = split;
> 
> Maybe that was intended? (or maybe it doesn't matter because bio_split
> copies fields with bio_clone_fast())?  Regardless, it is subtle.

It doesn't matter, blk_throtl_charge_bio_split() just accounts bio
number, here the split bio is submitted to the same queue.

> 
> Should blk_throtl_charge_bio_split() just be pushed down to
> bio_split()?

It is fragile, will the bio allocated from bio_split() always
submitted finally? or submitted to same queue?

> 
> In general, such narrow hacks for how to properly resubmit split bios
> are asking for further trouble.

I don't think it is hacks, it is one approach which has been verified as
workable in blk-mq.

> As is, I'm having to triage new
> reports of bio-based accounting issues (which has called into question
> my hack/fix commit a1e1cb72d9649 ("dm: fix redundant IO accounting for
> bios that need splitting") that papered over this bigger issue of
> needing proper split IO accounting, so likely needs to be revisited).

Here the issue is just about bio number accounting.

BTW, maybe you can follow blk-mq's way: just account after io is split,
such as, move start_io_acct() to the end of __split_and_process_non_flush(),
then you can just account io start once.


Thanks, 
Ming

