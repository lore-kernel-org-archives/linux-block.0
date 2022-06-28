Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3123EC43334
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 05:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244760AbiF1FMS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 01:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244765AbiF1FL4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 01:11:56 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D7526579
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 22:11:43 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8443F68AA6; Tue, 28 Jun 2022 07:11:39 +0200 (CEST)
Date:   Tue, 28 Jun 2022 07:11:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org
Subject: Re: fully tear down the queue in del_gendisk
Message-ID: <20220628051139.GA22701@lst.de>
References: <20220619060552.1850436-1-hch@lst.de> <67dd8d1c-658c-8833-9630-79ade736b348@kernel.dk> <20220620060948.GA10485@lst.de> <1e3f054e-eec6-be87-7039-e2b4260addc2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e3f054e-eec6-be87-7039-e2b4260addc2@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 20, 2022 at 05:16:03AM -0600, Jens Axboe wrote:
> On 6/20/22 12:09 AM, Christoph Hellwig wrote:
> > On Sun, Jun 19, 2022 at 04:21:39PM -0600, Jens Axboe wrote:
> >> On 6/19/22 12:05 AM, Christoph Hellwig wrote:
> >>> Note that while intended or 5.20, this series is generated against the
> >>> block-5.19 branch as that contains fixes in this area that haven't
> >>> made it to the for-5.10/block branch yet.
> >>
> >> Side note - I rebased on -rc3 anyway because of the series that went
> >> into -rc2, so we should be fine there.
> > 
> > It depends on elevator/debugfs teardown series that has not made it
> > into -rc3.
> 
> Guess we'll rebase for -rc4 again...

As you'd done that, can you consider this series now?
