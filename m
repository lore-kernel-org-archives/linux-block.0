Return-Path: <SRS0=0UXK=Q7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2697C43381
	for <linux-block@archiver.kernel.org>; Sun, 24 Feb 2019 21:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757322084D
	for <linux-block@archiver.kernel.org>; Sun, 24 Feb 2019 21:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfBXVgy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Feb 2019 16:36:54 -0500
Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:15065 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbfBXVgy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Feb 2019 16:36:54 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl6.internode.on.net with ESMTP; 25 Feb 2019 08:06:52 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gy1S5-00048l-Mn; Mon, 25 Feb 2019 08:36:49 +1100
Date:   Mon, 25 Feb 2019 08:36:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Carlos Maiolino <cmaiolino@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] fs: fix guard_bio_eod to check for real EOD errors
Message-ID: <20190224213649.GA1522@dastard>
References: <20190222141311.24694-1-cmaiolino@redhat.com>
 <CACVXFVOBqTxXrMhqEAvQ8nMe9aYdrevj372_67aiZhXUFxjcgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVOBqTxXrMhqEAvQ8nMe9aYdrevj372_67aiZhXUFxjcgQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 23, 2019 at 07:33:21AM +0800, Ming Lei wrote:
> Hi Carlos,
> 
> Cc block list given it is related with interface between fs and block layer.
> 
> On Fri, Feb 22, 2019 at 10:14 PM Carlos Maiolino <cmaiolino@redhat.com> wrote:
> >
> > guard_bio_eod() can truncate a segment in bio to allow it to do IO on
> > odd last sectors of a device.
> >
> > It already checks if the IO starts past EOD, but it does not consider
> > the possibility of an IO request starting within device boundaries can
> > contain more than one segment past EOD.
> >
> > In such cases, truncated_bytes can be bigger than PAGE_SIZE, and will
> > underflow bvec->bv_len.
> 
> It can cause memory corruption even for < PAGE_SIZE, also it can be correct
> to see > PAGE_SIZE truncated_bytes:
> 
> - xfs is going to support big block size which may be 64k

FYI, this isn't an XFS problem and never will be - XFS doesn't use
bufferheads and mpage_readpages() anymore, it goes down the
iomap_readpages() path which does not need this whacky
guard_bio_eod() thingy.

> - suppose fs block size is 4k, bio sector is 1022 and size is 4k, and
> disk size is
> 1024,

XFS won't do that, either - it checks at mount time if it can read
the very last sector of the filesystem via uncached IO (see
xfs_check_sizes() and xfs_rtmount_init()). If any of the EOD reads
fail, it won't mount.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
