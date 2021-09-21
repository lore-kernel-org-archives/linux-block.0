Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0F2C433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 06:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9169A61166
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 06:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhIUGdl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 02:33:41 -0400
Received: from verein.lst.de ([213.95.11.211]:55122 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhIUGdk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 02:33:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5C95C67373; Tue, 21 Sep 2021 08:32:09 +0200 (CEST)
Date:   Tue, 21 Sep 2021 08:32:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-block@vger.kernel.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Subject: Re: [PATCH 3/3] block: warn if ->groups is set when calling
 add_disk
Message-ID: <20210921063209.GA23736@lst.de>
References: <20210920072726.1159572-1-hch@lst.de> <20210920072726.1159572-4-hch@lst.de> <CAPcyv4iVL7bevm_MeFnkRK12SkwO4k5aR3-4KOAGMxThmJwOuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iVL7bevm_MeFnkRK12SkwO4k5aR3-4KOAGMxThmJwOuA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 20, 2021 at 04:50:03PM -0700, Dan Williams wrote:
> >
> >         ddev->parent = parent;
> > -       ddev->groups = groups;
> > +       if (!WARN_ON_ONCE(ddev->groups))
> > +               ddev->groups = groups;
> 
> That feels too compact to me, and dev_WARN_ONCE() might save someone a
> git blame to look up the reason for the warning:
> 
>     dev_WARN_ONCE(parent, ddev->groups, "unexpected pre-populated
> attribute group\n");
>     if (!ddev->groups)
>         ddev->groups = groups;
> 
> ...but not a deal breaker. Either way you can add:
> 

I'd rather keep it simple and optmize for the normal case..
