Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED95C04AAC
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 01:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9E321479
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 01:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfEUB3p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 May 2019 21:29:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbfEUB3p (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 May 2019 21:29:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7EEC8307D90D;
        Tue, 21 May 2019 01:29:45 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 093D67A43D;
        Tue, 21 May 2019 01:29:40 +0000 (UTC)
Date:   Tue, 21 May 2019 09:29:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: fix nr_phys_segments vs iterators accounting v2
Message-ID: <20190521012935.GE14268@ming.t460p>
References: <20190516084058.20678-1-hch@lst.de>
 <20190520111714.GA5369@lst.de>
 <8ccb3744-53e3-71b0-cdec-6f703b2bd5c8@fb.com>
 <20190521011700.GC14268@ming.t460p>
 <a5a08ee7-5bbf-3285-5f02-4f6544770340@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5a08ee7-5bbf-3285-5f02-4f6544770340@kernel.dk>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 21 May 2019 01:29:45 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 20, 2019 at 07:20:56PM -0600, Jens Axboe wrote:
> On 5/20/19 7:17 PM, Ming Lei wrote:
> > On Tue, May 21, 2019 at 01:09:39AM +0000, Jens Axboe wrote:
> >> On 5/20/19 5:17 AM, Christoph Hellwig wrote:
> >>> Jens,
> >>>
> >>> is this ok for 5.2?  If not we need to hack around the sector
> >>> accounting in nvme, and possibly virtio.
> >>
> >> I'd rather do it right in 5.2, especially if we can get something
> >> acceptable cobbled together this week.
> > 
> > If this patchset will be merged to 5.2, please remove the following
> > two lines from patch 1:
> > 
> > Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
> > Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
> > 
> > 
> > Because the patch 1 doesn't fix them actually.
> 
> I don't want to merge something unless you are happy with it as well.
> Are you fine with going this route?

I am fine with this route, and just try to make the commit log not
misleading.


Thanks,
Ming
