Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062BAC10F14
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 00:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD76B20821
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 00:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfDQAs5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:48:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbfDQAs4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 20:48:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA00585A03;
        Wed, 17 Apr 2019 00:48:56 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79D991001E65;
        Wed, 17 Apr 2019 00:48:49 +0000 (UTC)
Date:   Wed, 17 Apr 2019 08:48:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] block: make sure that bvec length can't be overflowed
Message-ID: <20190417004842.GA12001@ming.t460p>
References: <20190416153847.8173-1-ming.lei@redhat.com>
 <20190416164658.GA4030@lst.de>
 <9d0f5255-c37a-1830-7632-6f4d7158b21b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d0f5255-c37a-1830-7632-6f4d7158b21b@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 17 Apr 2019 00:48:56 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 16, 2019 at 11:03:00AM -0600, Jens Axboe wrote:
> On 4/16/19 10:46 AM, Christoph Hellwig wrote:
> > s/overflowed/overflow/ in the subject.
> > 
> > Otherwise this looks good to me:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > 
> > Although this will create yet another conflict between Linus' tree
> > and the 5.2 block tree.
> > 
> > Although maybe Jens still reset the tree and move the merge past this..
> 
> That was my main worry too... But I'll probably just deal with it and
> redo the merge, I don't want to do two, and I don't want to have to
> deal with answering for why we get repeated conflicts in this area.

This one is a fix which should affect on loop and nvme-loop only in theory.

That is typical conflict between fix and feature(improvement).

Anyway, sorry for the a bit late fix.

> 
> For the patch, I do generally prefer doing an AND with PAGE_MASK
> rather than a modulo with PAGE_SIZE. I know the compiler will take
> care of it, but still, it's more prudent imho.

OK, do it in V2.


Thanks,
Ming
