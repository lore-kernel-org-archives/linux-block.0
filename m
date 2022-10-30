Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBE9C38A02
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 09:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJ3JWm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 05:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJ3JWe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 05:22:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12807CE2D
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 02:22:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2C17168AA6; Sun, 30 Oct 2022 10:22:09 +0100 (CET)
Date:   Sun, 30 Oct 2022 10:22:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 04/17] nvme: don't call nvme_kill_queues from
 nvme_remove_namespaces
Message-ID: <20221030092208.GC5643@lst.de>
References: <20221025144020.260458-1-hch@lst.de> <20221025144020.260458-5-hch@lst.de> <Y1ggN68V/mbAw1q2@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ggN68V/mbAw1q2@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 25, 2022 at 11:43:19AM -0600, Keith Busch wrote:
> We still need the flush_work(scan_work) prior to killing the queues.

Yes.

> It
> looks like it could safely be moved to nvme_stop_ctrl(), which might
> make it easier on everyone if it were there.

Hmm.  As Sagi pointed out this could become a bit more complicated due
to multipath, but in general I'd love to bring some more regularity
into the teardown path.
