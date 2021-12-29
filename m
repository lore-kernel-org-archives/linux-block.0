Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932EBC433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Dec 2021 20:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhL2U5n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Dec 2021 15:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhL2U5n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Dec 2021 15:57:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C4DC061574
        for <linux-block@vger.kernel.org>; Wed, 29 Dec 2021 12:57:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25896B81840
        for <linux-block@vger.kernel.org>; Wed, 29 Dec 2021 20:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F3FC36AE9;
        Wed, 29 Dec 2021 20:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640811460;
        bh=4Gv+LCK+fMVJjuW25xEsAB9tl9EA1s4k1jK9ak/wXpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BG3cQEzjAct0X4iM5BS0oy9Vw/omFNHcfKGV7JlvA9uVOU7baTgOBrQGvMDt9+/5W
         6Ui/XGAlhci7PggZ9hg4n02odT91aeCX4BKrbHdEPYrTyf0E1FmHo0d8CPlGm0twC6
         5b4dM0eM9a2vTRSTvDnxKB8k2GSeUbQDilp4SqAwVCwWyFHsuQN5ZdNRRf9qP2uTGn
         9NWfsnmLDI6UNmCCBLJVQiDqk9MVh/ynOTncz8R0ed2AzDHB8PZGcHdiMBhbs/L0mG
         kXFdZxFOsNLrTNVvOHCndbKkzuXaAyDmZPnLOVCN4Gzf4AKy2S9Jqoji+r9kkgz1NV
         fBE4KGenjkAZA==
Date:   Wed, 29 Dec 2021 12:57:38 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, sagi@grimberg.me
Subject: Re: [PATCHv2 1/3] block: introduce rq_list_for_each_safe macro
Message-ID: <20211229205738.GA2493133@dhcp-10-100-145-180.wdc.com>
References: <20211227164138.2488066-1-kbusch@kernel.org>
 <20211229173902.GA28058@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229173902.GA28058@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 29, 2021 at 06:39:02PM +0100, Christoph Hellwig wrote:
> (except for the fact that it, just like the other rq_list helpers
> really should go into blk-mq.h, where all request related bits moved
> early in this cycle)

Agreed, I just put it here because it's where the other macros live. But
'struct request' doesn't exist in this header, so it does seem out of
place.  For v3, I'll add a preceding patch to move them all to blk-mq.h.
