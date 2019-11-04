Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B85CA9ECF
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 08:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D055721744
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 08:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfKDIIu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 03:08:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:40784 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726441AbfKDIIu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Nov 2019 03:08:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B38B7AD8C;
        Mon,  4 Nov 2019 08:08:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F38F61E4809; Mon,  4 Nov 2019 09:08:47 +0100 (CET)
Date:   Mon, 4 Nov 2019 09:08:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] bdev: Refresh bdev size for disks without
 partitioning
Message-ID: <20191104080847.GA22379@quack2.suse.cz>
References: <20191021083132.5351-1-jack@suse.cz>
 <bdc9f71e-09ea-9a4c-08fd-d5b60263f11d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdc9f71e-09ea-9a4c-08fd-d5b60263f11d@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun 03-11-19 07:53:10, Jens Axboe wrote:
> On 10/21/19 2:37 AM, Jan Kara wrote:
> > Hello,
> > 
> > I've been debugging for quite a long time strange issues with encrypted DVDs
> > not being readable on Linux (bko#194965). In the end I've tracked down the
> > problem to the fact that block device size is not updated when the media is
> > inserted in case the DVD device is already open. This is IMO a bug in block
> > device code as the size gets properly update in case the device has partition
> > scanning enabled.  The following series fixes the problem by refreshing disk
> > size on each open even for devices with partition scanning disabled.
> 
> It's really confusing to have different behavior for partition vs whole device.
> This series looks good to me, the size change code is really hard to follow.
> 
> I don't see any serious objections here, I'm going to queue this up for
> 5.4.

Thanks Jens! I'll look into refactoring the size change / revalidation code
so that it's easier to understand what's going on...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
