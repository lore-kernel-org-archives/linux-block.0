Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097B6C88CB2
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 17:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbjFLRr3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 13:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjFLRr3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 13:47:29 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEE2FB
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 10:47:27 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35CHl1lV018047
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 13:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686592023; bh=k5/mHoM4TKtwuRzijsuJUvOl+RgFkywa2qtXQ3b9Dqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=lF0Da9dBYHdFjBZwXhrM/yTEBIMSSnD44OE2GDG/1eZqwdpKGecGfQyKQwJ5ZKr+I
         mLe9HOMFzcQKASATbj0M/4P81ls5rg/slbVop7JCoLOqGz+AFlVdyPLyIAmNMvDtIz
         x9VRsOfDyBZJRiLoKXFwR9XLoTF4LFp2AenkjvPWA3wf3lXzRSzLkqOoNpfVk8CrFU
         zWW7VXtAzgvrPQ/wu3IqU/bix1gMsvTvf1OfZP4KGQMwHGMfc1OfXl8wcYnveI7S44
         gf4D02ajuDr6QFALUHSt01hD2vXZSlz7IP9dTIAduCWawOYWA3nXVlv/oCm7yIcb2C
         6ek0sBxatUi/Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3D31815C00B0; Mon, 12 Jun 2023 13:47:01 -0400 (EDT)
Date:   Mon, 12 Jun 2023 13:47:01 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        yebin <yebin@huaweicloud.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <20230612174701.GC1500045@mit.edu>
References: <20230612161614.10302-1-jack@suse.cz>
 <20230612162545.frpr3oqlqydsksle@quack3>
 <2f629dc3-fe39-624f-a2fe-d29eee1d2b82@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f629dc3-fe39-624f-a2fe-d29eee1d2b82@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 12, 2023 at 10:39:51AM -0700, Bart Van Assche wrote:
> > > Writing to mounted devices is dangerous and can lead to filesystem
> > > corruption as well as crashes. Furthermore syzbot comes with more and
> > > more involved examples how to corrupt block device under a mounted
> > > filesystem leading to kernel crashes and reports we can do nothing
> > > about. Add config option to disallow writing to mounted (exclusively
> > > open) block devices. Syzbot can use this option to avoid uninteresting
> > > crashes. Also users whose userspace setup does not need writing to
> > > mounted block devices can set this config option for hardening.
> 
> Have alternatives been configured to making this functionality
> configurable at build time only? How about a kernel command line
> parameter instead of a config option?

I could imagine wanting a config option which changes the default, as
well as a way of setting the parameter on the command line so that
users of distro kernel can change the parameter value.  That's
especially since it might be useful for more than just reining in
syzbot reports.

						- Ted
