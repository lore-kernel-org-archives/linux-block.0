Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D30C433FE
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 01:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC1FC224F9
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 01:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgLDBrZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 20:47:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgLDBrY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Dec 2020 20:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607046358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SpZ8UcfCtuAKihMNdHOU/aX4EJdGR+g2B+0zTM66XCo=;
        b=dTXu+pvrICsmf9F13mT9BBg4dp8gxBiQGOHIi9zjtcTXmXGjF5UytWV7nNv/Ie5GrEHMkA
        blKan0UmEYvWJLK1uIKs9d2+TD4AaMsykhYeSZng+lUcHKiQ6t6yl5Qw75s81wsnQrVIsH
        jYO1bPESfiqOikARi6W1A3ofPyoPnMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-d1D4BCJhP0qiwtb-qj0ZCg-1; Thu, 03 Dec 2020 20:45:56 -0500
X-MC-Unique: d1D4BCJhP0qiwtb-qj0ZCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF98A800D53;
        Fri,  4 Dec 2020 01:45:55 +0000 (UTC)
Received: from T590 (ovpn-12-155.pek2.redhat.com [10.72.12.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A24D1A890;
        Fri,  4 Dec 2020 01:45:40 +0000 (UTC)
Date:   Fri, 4 Dec 2020 09:45:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Mike Snitzer <snitzer@redhat.com>, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com, jdorminy@redhat.com, bjohnsto@redhat.com
Subject: Re: [PATCH v2] block: use gcd() to fix chunk_sectors limit stacking
Message-ID: <20201204014535.GC661914@T590>
References: <20201130171805.77712-1-snitzer@redhat.com>
 <20201201160709.31748-1-snitzer@redhat.com>
 <20201203032608.GD540033@T590>
 <20201203143359.GA29261@redhat.com>
 <20201203162738.GA3404013@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203162738.GA3404013@dhcp-10-100-145-180.wdc.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 03, 2020 at 08:27:38AM -0800, Keith Busch wrote:
> On Thu, Dec 03, 2020 at 09:33:59AM -0500, Mike Snitzer wrote:
> > On Wed, Dec 02 2020 at 10:26pm -0500,
> > Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > > I understand it isn't related with correctness, because the underlying
> > > queue can split by its own chunk_sectors limit further. So is the issue
> > > too many further-splitting on queue with chunk_sectors 8? then CPU
> > > utilization is increased? Or other issue?
> > 
> > No, this is all about correctness.
> > 
> > Seems you're confining the definition of the possible stacking so that
> > the top-level device isn't allowed to have its own hard requirements on
> > IO sizes it sends to its internal implementation.  Just because the
> > underlying device can split further doesn't mean that the top-level
> > virtual driver can service larger IO sizes (not if the chunk_sectors
> > stacking throws away the hint the virtual driver provided because it
> > used lcm_not_zero).
> 
> I may be missing something obvious here, but if the lower layers split
> to their desired boundary already, why does this limit need to stack?
> Won't it also work if each layer sets their desired chunk_sectors
> without considering their lower layers? The commit that initially
> stacked chunk_sectors doesn't provide any explanation.

There could be several reasons:

1) some limits have to be stacking, such as logical block size, because
lower layering may not handle un-aligned IO

2) performance reason, if every limits are stacked on topmost layer, in
theory IO just needs to be splitted in top layer, and not need to be
splitted further from all lower layer at all. But there should be exceptions
in unusual case, such as, lowering queue's limit changed after the stacking
limits are setup.

3) history reason, bio splitting is much younger than stacking queue
limits.

Maybe others?


Thanks,
Ming

