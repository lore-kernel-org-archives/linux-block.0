Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9E7C04AA7
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 12:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AEA20989
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 12:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfEMMEF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 May 2019 08:04:05 -0400
Received: from verein.lst.de ([213.95.11.211]:38860 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbfEMMEF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 08:04:05 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 45B6B68AFE; Mon, 13 May 2019 14:03:45 +0200 (CEST)
Date:   Mon, 13 May 2019 14:03:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@fb.com,
        Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org
Subject: Re: [PATCH 01/10] block: don't decrement nr_phys_segments for
 physically contigous segments
Message-ID: <20190513120344.GA22993@lst.de>
References: <20190513063754.1520-1-hch@lst.de> <20190513063754.1520-2-hch@lst.de> <20190513094544.GA30381@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513094544.GA30381@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 13, 2019 at 05:45:45PM +0800, Ming Lei wrote:
> On Mon, May 13, 2019 at 08:37:45AM +0200, Christoph Hellwig wrote:
> > Currently ll_merge_requests_fn, unlike all other merge functions,
> > reduces nr_phys_segments by one if the last segment of the previous,
> > and the first segment of the next segement are contigous.  While this
> > seems like a nice solution to avoid building smaller than possible
> 
> Some workloads need this optimization, please see 729204ef49ec00b
> ("block: relax check on sg gap"):

And we still allow to merge the segments with this patch.  The only
difference is that these merges do get accounted as extra segments.

> > requests it causes a mismatch between the segments actually present
> > in the request and those iterated over by the bvec iterators, including
> > __rq_for_each_bio.  This could cause overwrites of too small kmalloc
> 
> Request based drivers usually shouldn't iterate bio any more.

We do that in a couple of places.  For one the nvme single segment
optimization that triggered this bug.  Also for range discard support
in nvme and virtio.  Then we have loop that  iterate the segments, but
doesn't use the nr_phys_segments count, and plenty of others that
iterate over pages at the moment but should be iterating bvecs,
e.g. ubd or aoe.
