Return-Path: <SRS0=Dkg2=TO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6726C04AB4
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 04:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CAF20843
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 04:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfENEgx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 May 2019 00:36:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfENEgx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 May 2019 00:36:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 707C930820EA;
        Tue, 14 May 2019 04:36:53 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0748D5ED27;
        Tue, 14 May 2019 04:36:47 +0000 (UTC)
Date:   Tue, 14 May 2019 12:36:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@fb.com, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 01/10] block: don't decrement nr_phys_segments for
 physically contigous segments
Message-ID: <20190514043642.GB10824@ming.t460p>
References: <20190513063754.1520-1-hch@lst.de>
 <20190513063754.1520-2-hch@lst.de>
 <20190513094544.GA30381@ming.t460p>
 <20190513120344.GA22993@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513120344.GA22993@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 14 May 2019 04:36:53 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 13, 2019 at 02:03:44PM +0200, Christoph Hellwig wrote:
> On Mon, May 13, 2019 at 05:45:45PM +0800, Ming Lei wrote:
> > On Mon, May 13, 2019 at 08:37:45AM +0200, Christoph Hellwig wrote:
> > > Currently ll_merge_requests_fn, unlike all other merge functions,
> > > reduces nr_phys_segments by one if the last segment of the previous,
> > > and the first segment of the next segement are contigous.  While this
> > > seems like a nice solution to avoid building smaller than possible
> > 
> > Some workloads need this optimization, please see 729204ef49ec00b
> > ("block: relax check on sg gap"):
> 
> And we still allow to merge the segments with this patch.  The only
> difference is that these merges do get accounted as extra segments.

It is easy for .nr_phys_segments to reach the max segment limit by this
way, then no new bio can be merged any more.

We don't consider segment merge between two bios in ll_new_hw_segment(),
in my mkfs test over virtio-blk, request size can be increased to ~1M(several
segments) from 63k(126 bios/segments) easily if the segment merge between
two bios is considered.

> 
> > > requests it causes a mismatch between the segments actually present
> > > in the request and those iterated over by the bvec iterators, including
> > > __rq_for_each_bio.  This could cause overwrites of too small kmalloc
> > 
> > Request based drivers usually shouldn't iterate bio any more.
> 
> We do that in a couple of places.  For one the nvme single segment
> optimization that triggered this bug.  Also for range discard support
> in nvme and virtio.  Then we have loop that  iterate the segments, but
> doesn't use the nr_phys_segments count, and plenty of others that
> iterate over pages at the moment but should be iterating bvecs,
> e.g. ubd or aoe.

Seems discard segment doesn't consider bios merge for nvme and virtio,
so it should be fine in this way. Will take a close look at nvme/virtio
discard segment merge later.


Thanks,
Ming
