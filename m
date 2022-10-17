Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F32C433FE
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 13:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJQNsv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJQNsu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 09:48:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0528A5EDE7
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 06:48:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0FD9768BFE; Mon, 17 Oct 2022 15:48:44 +0200 (CEST)
Date:   Mon, 17 Oct 2022 15:48:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        ming.lei@redhat.com, axboe@kernel.dk
Subject: Re: [PATCH v2 2/2] nvme: use blk_mq_[un]quiesce_tagset
Message-ID: <20221017134843.GB24959@lst.de>
References: <20221013094450.5947-1-lengchao@huawei.com> <20221013094450.5947-3-lengchao@huawei.com> <0b28653b-b133-ec4b-b09e-54090f374086@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b28653b-b133-ec4b-b09e-54090f374086@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Something like this:

That definitively seems like a sensible prep patch.

In the long run NVME_CTRL_STOPPED probably needs to be integrated
with the controller state machine, and moving it from the ns to
the ctrl is a good step towards that.
