Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D816BEB64D9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 15:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345032AbjFOPQf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 11:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344075AbjFOPQb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 11:16:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ADF2121
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 08:16:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A382060B07
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 15:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEEFC433CA;
        Thu, 15 Jun 2023 15:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686842190;
        bh=nAC5zeGhdYFS1W8CVDlzAjEFJncaZcted9h/zd5JG/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M5Wd1Jx2Geq4SbpC02tQ/u5EdWW/GKinzit97hMbCDjVRAYPLeMkHPyjzxkRNhc99
         hT71SlriC1gisSTaibd34/b81Zu78oWusjHI1jYFqjdDo5d6qRBCzOVajGKXnYhLA+
         ghJW8M0Od3Cs5XdoYpY/MO8XaLtUc8jT5jmCfO/nJzjjZzVJtXSceiPeT1Zbu6mmUu
         18/8fgRorVtYt3ilh5PbsNfMOELUW5LP9jDgKBDmSlq+4uWQNHPnMdQyMUZYc+ivho
         NaamZB4hCEKWuwNnZm9tD3BsP/PMwdg7Gk2X0vTbbQWjOgqZFJfMbZxDAfobY9Z/9C
         6E0Z92aDPE8wg==
Date:   Thu, 15 Jun 2023 09:16:27 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 1/4] blk-mq: add API of blk_mq_unfreeze_queue_force
Message-ID: <ZIsrSyEqWMw8/ikq@kbusch-mbp.dhcp.thefacebook.com>
References: <20230615143236.297456-1-ming.lei@redhat.com>
 <20230615143236.297456-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615143236.297456-2-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 15, 2023 at 10:32:33PM +0800, Ming Lei wrote:
> NVMe calls freeze/unfreeze in different contexts, and controller removal
> may break in-progress error recovery, then leave queues in frozen state.
> So cause IO hang in del_gendisk() because pending writeback IOs are
> still waited in bio_queue_enter().

Shouldn't those writebacks be unblocked by the existing check in
bio_queue_enter, test_bit(GD_DEAD, &disk->state))? Or are we missing a
disk state update or wakeup on this condition?
