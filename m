Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25079C433DB
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 05:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C440C61935
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 05:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhC3F2r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 01:28:47 -0400
Received: from verein.lst.de ([213.95.11.211]:57103 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbhC3F2k (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 01:28:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 17BF868B05; Tue, 30 Mar 2021 07:28:38 +0200 (CEST)
Date:   Tue, 30 Mar 2021 07:28:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org
Subject: Re: remove ->revalidate_disk (resend)
Message-ID: <20210330052837.GA4726@lst.de>
References: <20210308074550.422714-1-hch@lst.de> <20210329055540.GA27177@lst.de> <465891ab-0633-2ee3-b51a-fe2e7be5f9ca@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <465891ab-0633-2ee3-b51a-fe2e7be5f9ca@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 29, 2021 at 07:01:54AM -0600, Jens Axboe wrote:
> On 3/28/21 11:55 PM, Christoph Hellwig wrote:
> > On Mon, Mar 08, 2021 at 08:45:47AM +0100, Christoph Hellwig wrote:
> >> Hi Jens,
> >>
> >> with the previously merged patches all real users of ->revalidate_disk
> >> are gone.  This series removes the two remaining not actually required
> >> instances and the method itself.
> > 
> > Jens,
> > 
> > can you consider this for the 5.13 tree?
> 
> Looks fine to me, we just need to drop the umem change as it was
> removed. And paride really should be as well... But in any case,

Last time asked around (for the blk-mq conversion) we still had people
actively using it.

> I'll queue up the other two or 5.13.

So this ended up on the drivers branch.  I do have a buch of core
changes pending that will depend on it.
