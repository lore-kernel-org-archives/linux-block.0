Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FDBC04AB4
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 09:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257CB2146F
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 09:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfEMJp4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 May 2019 05:45:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbfEMJp4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 05:45:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1612610C6E;
        Mon, 13 May 2019 09:45:56 +0000 (UTC)
Received: from ming.t460p (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03B436A96C;
        Mon, 13 May 2019 09:45:50 +0000 (UTC)
Date:   Mon, 13 May 2019 17:45:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@fb.com, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 01/10] block: don't decrement nr_phys_segments for
 physically contigous segments
Message-ID: <20190513094544.GA30381@ming.t460p>
References: <20190513063754.1520-1-hch@lst.de>
 <20190513063754.1520-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513063754.1520-2-hch@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 13 May 2019 09:45:56 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 13, 2019 at 08:37:45AM +0200, Christoph Hellwig wrote:
> Currently ll_merge_requests_fn, unlike all other merge functions,
> reduces nr_phys_segments by one if the last segment of the previous,
> and the first segment of the next segement are contigous.  While this
> seems like a nice solution to avoid building smaller than possible

Some workloads need this optimization, please see 729204ef49ec00b
("block: relax check on sg gap"):

    If the last bvec of the 1st bio and the 1st bvec of the next
    bio are physically contigious, and the latter can be merged
    to last segment of the 1st bio, we should think they don't
    violate sg gap(or virt boundary) limit.

    Both Vitaly and Dexuan reported lots of unmergeable small bios
    are observed when running mkfs on Hyper-V virtual storage, and
    performance becomes quite low. This patch fixes that performance
    issue.

It can be observed that thousands of 512byte bios in one request when
running mkfs related workloads.

> requests it causes a mismatch between the segments actually present
> in the request and those iterated over by the bvec iterators, including
> __rq_for_each_bio.  This could cause overwrites of too small kmalloc

Request based drivers usually shouldn't iterate bio any more.


Thanks,
Ming
