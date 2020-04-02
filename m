Return-Path: <SRS0=2u2q=5S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CDCC43331
	for <linux-block@archiver.kernel.org>; Thu,  2 Apr 2020 07:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322A52078E
	for <linux-block@archiver.kernel.org>; Thu,  2 Apr 2020 07:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgDBHwE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:52:04 -0400
Received: from verein.lst.de ([213.95.11.211]:47202 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgDBHwE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Apr 2020 03:52:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 343CA68C4E; Thu,  2 Apr 2020 09:52:01 +0200 (CEST)
Date:   Thu, 2 Apr 2020 09:52:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: inherit stable pages constraint in the mpath
 stack device
Message-ID: <20200402075200.GA15551@lst.de>
References: <20200401060625.10293-1-sagi@grimberg.me> <20200401090542.GB31980@lst.de> <469eb075-2a6f-3386-f843-90525590fcba@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469eb075-2a6f-3386-f843-90525590fcba@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 01, 2020 at 12:11:09PM -0700, Sagi Grimberg wrote:
>> I think this needs to go into blk_queue_stack_limits instead, otherwise
>> we have the same problem with other stacking drivers.
>
> I thought about this, but the stack_limits has different variants 
> (blk_stack_limits, bdev_stack_limits) but only the first takes a
> request_queue...
>
> I see that dm-table does roughly the same thing, drbd ignores it.
> In general, dm is doing a whole bunch of stacking limits/capabilities
> related stuff that are not involved in blk_stack_limits...
>
> I could theoretically add a flag to queue_limits to mirror this, is
> that what you are suggesting?

I guess we'll just go with your v4 patch for now and I'll see if I
can refactor this mess later..
