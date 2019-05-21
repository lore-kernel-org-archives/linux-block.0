Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E353C04AAC
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 01:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA2B2173C
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 01:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfEUBRL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 May 2019 21:17:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfEUBRK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 May 2019 21:17:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D207D308421A;
        Tue, 21 May 2019 01:17:10 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E7BB1001DE7;
        Tue, 21 May 2019 01:17:05 +0000 (UTC)
Date:   Tue, 21 May 2019 09:17:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@fb.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: fix nr_phys_segments vs iterators accounting v2
Message-ID: <20190521011700.GC14268@ming.t460p>
References: <20190516084058.20678-1-hch@lst.de>
 <20190520111714.GA5369@lst.de>
 <8ccb3744-53e3-71b0-cdec-6f703b2bd5c8@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ccb3744-53e3-71b0-cdec-6f703b2bd5c8@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 21 May 2019 01:17:10 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 21, 2019 at 01:09:39AM +0000, Jens Axboe wrote:
> On 5/20/19 5:17 AM, Christoph Hellwig wrote:
> > Jens,
> > 
> > is this ok for 5.2?  If not we need to hack around the sector
> > accounting in nvme, and possibly virtio.
> 
> I'd rather do it right in 5.2, especially if we can get something
> acceptable cobbled together this week.

If this patchset will be merged to 5.2, please remove the following
two lines from patch 1:

Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")


Because the patch 1 doesn't fix them actually.

Thanks,
Ming
