Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97903C433F5
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 07:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiC2Heq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 03:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiC2Hem (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 03:34:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10440240BA;
        Tue, 29 Mar 2022 00:32:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A08D168AFE; Tue, 29 Mar 2022 09:32:54 +0200 (CEST)
Date:   Tue, 29 Mar 2022 09:32:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Philipp Reisner <philipp.reisner@linbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: state of drbd in mainline
Message-ID: <20220329073254.GA20691@lst.de>
References: <20220329070618.GA20396@lst.de> <CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 29, 2022 at 09:22:26AM +0200, Philipp Reisner wrote:
> Hi Christoph,
> 
> what do you expect for the DRBD changes? Usually, they fall into the
> category: yes, obviously. When you are changing the block layer in this
> way, then that is necessary for the in-tree DRBD code.
> 
> Regarding users: Yes, there are users of the in-tree DRBD code. Very big
> corporations. And, yes, we see pressure building up that we get our act
> together and re-sync the in-tree DRBD with the out-of tree DRBD.

The complete lack of bug reports and maintainer interaction usually
suggests low to no use and heavy bitrot.  If that is not the case
here that's fine, just asking..

