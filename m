Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A7BC433E4
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 17:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4774C20702
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 17:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgGTRfc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:35:32 -0400
Received: from verein.lst.de ([213.95.11.211]:48416 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731652AbgGTRfc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 13:35:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 685336736F; Mon, 20 Jul 2020 19:35:30 +0200 (CEST)
Date:   Mon, 20 Jul 2020 19:35:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Damien.LeMoal@wdc.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: a fix and two cleanups around blk_stack_limits
Message-ID: <20200720173530.GA21442@lst.de>
References: <20200720061251.652457-1-hch@lst.de> <dfe56cf2-db3d-3461-9834-be314f4080ef@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfe56cf2-db3d-3461-9834-be314f4080ef@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 20, 2020 at 10:56:23AM -0600, Jens Axboe wrote:
> On 7/20/20 12:12 AM, Christoph Hellwig wrote:
> > Hi Jens,
> > 
> > this series ensures that the zoned device limitations are properly
> > inherited in blk_stack_limits, and then cleanups up two rather
> > pointless wrappers around it.
> 
> We should probably make this against for-5.9/drivers instead, to avoid
> an unnecessary conflict when merging.

Then we'd also need a merge as my next series depends on this, and it
clearly is core material.  Not sure which one is more important.
