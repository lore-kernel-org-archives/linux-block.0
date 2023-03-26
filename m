Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9BCC74A5B
	for <linux-block@archiver.kernel.org>; Sun, 26 Mar 2023 23:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjCZXp5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Mar 2023 19:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCZXp5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Mar 2023 19:45:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3B949C1
        for <linux-block@vger.kernel.org>; Sun, 26 Mar 2023 16:45:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1C60968BEB; Mon, 27 Mar 2023 01:45:53 +0200 (CEST)
Date:   Mon, 27 Mar 2023 01:45:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Message-ID: <20230326234552.GC20017@lst.de>
References: <20230321055537.GA18035@lst.de> <100dfc73-d8f3-f08f-e091-3c08707e95f5@acm.org> <20230323082604.GC21977@lst.de> <acd13f8c-6cbe-a14d-e3b4-645d62811cec@opensource.wdc.com> <122cdca2-b0ae-ce74-664d-e268fe0699a8@acm.org> <7a795b9b-51dc-9166-1cf0-6c51db77b195@opensource.wdc.com> <1e65e542-e8e9-bd3f-6ff1-1bbd4716a8c3@acm.org> <e83d1111-1841-7b2a-973b-16bea2e789c6@opensource.wdc.com> <7f4463c1-fd02-8ac5-16d7-61ffe6279e07@acm.org> <5b450fee-714b-224e-69ae-497633e005ed@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b450fee-714b-224e-69ae-497633e005ed@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 26, 2023 at 10:45:08AM +0900, Damien Le Moal wrote:
> > Although the above sounds interesting to me, I think the following two 
> > scenarios are not handled by the above approach and can lead to reordering:
> > * The SCSI device reporting a unit attention.
> > * The SCSI device responding with the SCSI status "BUSY". The UFS 
> > standard explicitly allows this. From the UFS standard: "If the unit is 
> > not ready to accept a new command (e.g., still processing previous 
> > command) a STATUS response of BUSY will be returned."
> 
> Yes, that likely would be an issue for regular writes, but likely not for zone
> append emulation using regular writes though, since a "busy" return for a ZA
> emulated regular write can be resent later with a different aligned write location.

Exactly.  That's why ZONE_APPEND is the only really viable high-level
interface.
