Return-Path: <SRS0=jnOf=6P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39288C4724C
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 17:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E8624953
	for <linux-block@archiver.kernel.org>; Fri,  1 May 2020 17:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgEAR0k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 May 2020 13:26:40 -0400
Received: from verein.lst.de ([213.95.11.211]:47955 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbgEAR0h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 May 2020 13:26:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0A45C68C65; Fri,  1 May 2020 19:26:35 +0200 (CEST)
Date:   Fri, 1 May 2020 19:26:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Martijn Coenen <maco@android.com>, axboe@kernel.dk, hch@lst.de,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/10] loop: Factor out loop size validation
Message-ID: <20200501172634.GA22792@lst.de>
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-2-maco@android.com> <20200429141229.GE700644@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429141229.GE700644@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 10:12:29PM +0800, Ming Lei wrote:
> > +static int
> > +loop_validate_size(loff_t size)
> > +{
> > +	if ((loff_t)(sector_t)size != size)
> > +		return -EFBIG;
> > +
> > +	return 0;
> > +}
> > +
> 
> Now sector_t has been switched to u64 unconditionally, do we still need such
> validation?

Oops, completely forgot about that.  Yes, we can just kill the
checks.
