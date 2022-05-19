Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF7CC433F5
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 07:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbiESHnU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 03:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiESHnT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 03:43:19 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626873135B;
        Thu, 19 May 2022 00:43:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3F44768AFE; Thu, 19 May 2022 09:43:15 +0200 (CEST)
Date:   Thu, 19 May 2022 09:43:14 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@fb.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Kernel Team <Kernel-team@fb.com>, "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCHv2 0/3] direct io alignment relax
Message-ID: <20220519074314.GI22301@lst.de>
References: <20220518171131.3525293-1-kbusch@fb.com> <YoWAnDR/XOwegQNZ@gmail.com> <YoWUnTxag7TsCBwa@kbusch-mbp.dhcp.thefacebook.com> <f42c74b9-67fa-50fc-d97e-2a7f153f10e4@nvidia.com> <YoWlQxEjvlmACNRV@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoWlQxEjvlmACNRV@sol.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 18, 2022 at 07:02:43PM -0700, Eric Biggers wrote:
> If you're thinking about about BLKDISCARD and BLKZEROOUT, those are block device
> ioctls, so statx() doesn't seem like a great fit for them.  There is already a
> place to expose block device properties to userspace (/sys/block/$dev/).  Direct
> I/O is different because direct I/O is not just a feature of block devices but
> also of regular files, and it is affected by filesystem-level constraints.

Agreed.
