Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55658C43334
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 06:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbiFTGJy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 02:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiFTGJw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 02:09:52 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9A0BCAE
        for <linux-block@vger.kernel.org>; Sun, 19 Jun 2022 23:09:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DEEA06732D; Mon, 20 Jun 2022 08:09:48 +0200 (CEST)
Date:   Mon, 20 Jun 2022 08:09:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org
Subject: Re: fully tear down the queue in del_gendisk
Message-ID: <20220620060948.GA10485@lst.de>
References: <20220619060552.1850436-1-hch@lst.de> <67dd8d1c-658c-8833-9630-79ade736b348@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67dd8d1c-658c-8833-9630-79ade736b348@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jun 19, 2022 at 04:21:39PM -0600, Jens Axboe wrote:
> On 6/19/22 12:05 AM, Christoph Hellwig wrote:
> > Note that while intended or 5.20, this series is generated against the
> > block-5.19 branch as that contains fixes in this area that haven't
> > made it to the for-5.10/block branch yet.
> 
> Side note - I rebased on -rc3 anyway because of the series that went
> into -rc2, so we should be fine there.

It depends on elevator/debugfs teardown series that has not made it
into -rc3.
