Return-Path: <SRS0=Dkg2=TO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16D8C04AB4
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 14:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA65721473
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 14:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfENO1e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 May 2019 10:27:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfENO1a (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 May 2019 10:27:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1FD373079B94;
        Tue, 14 May 2019 14:27:30 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 078935C3FD;
        Tue, 14 May 2019 14:27:23 +0000 (UTC)
Date:   Tue, 14 May 2019 22:27:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@fb.com, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 01/10] block: don't decrement nr_phys_segments for
 physically contigous segments
Message-ID: <20190514142716.GB25519@ming.t460p>
References: <20190513063754.1520-1-hch@lst.de>
 <20190513063754.1520-2-hch@lst.de>
 <20190513094544.GA30381@ming.t460p>
 <20190513120344.GA22993@lst.de>
 <20190514043642.GB10824@ming.t460p>
 <20190514051441.GA6294@lst.de>
 <20190514090544.GC20468@ming.t460p>
 <20190514135141.GA13683@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514135141.GA13683@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 14 May 2019 14:27:30 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 14, 2019 at 03:51:42PM +0200, Christoph Hellwig wrote:
> On Tue, May 14, 2019 at 05:05:45PM +0800, Ming Lei wrote:
> > However we still may make it better, for example, the attached patch can
> > save 10~20% time when running 'mkfs.ntfs -s 512 /dev/vda', lots of small
> > request(63KB) can be merged to big IO(1MB).
> 
> And we could save even more time by making the block dev buffered I/O
> path not do stupid things to start with.

I am wondering if it can be done easily, given mkfs is userspace
which only calls write syscall on block device. Or could you share
something about how to fix the stupid things?

> 
> > > With the gap devices we have unlimited segment size, see my next patch
> > > to actually enforce that.  Which is much more efficient than using
> > 
> > But this patch does effect on non-gap device, and actually most of
> > device are non-gap type.
> 
> Yes, but only for request merges, and only if merging the requests
> goes over max_requests.  The upside is that we actually get a
> nr_phys_segments that mirrors what is in the request, fixing bugs
> in a few drivers, and allowing for follow on patches that significantly
> simplify our I/O path.

non-gap device still has max segment size limit, and I guess it still
needs to be respected.


Thanks,
Ming
