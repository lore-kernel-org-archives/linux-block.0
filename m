Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3C0C4167B
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 13:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiJUNaN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 09:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiJUNaK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 09:30:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518A3A0319
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 06:29:53 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0F04968B05; Fri, 21 Oct 2022 15:29:51 +0200 (CEST)
Date:   Fri, 21 Oct 2022 15:29:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 7/8] nvme: remove nvme_set_queue_dying
Message-ID: <20221021132950.GF22327@lst.de>
References: <20221020105608.1581940-1-hch@lst.de> <20221020105608.1581940-8-hch@lst.de> <55dfcd8e-c2f5-d064-bd4f-770383fc5305@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55dfcd8e-c2f5-d064-bd4f-770383fc5305@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 20, 2022 at 04:10:47PM +0300, Sagi Grimberg wrote:
> I have to say that I always found nvme_kill_queues interface somewhat
> odd.

It is..

> its a core function that unquiesces the admin/io queues
> assuming that they were stopped at some point by the driver.
>
> If now there is no dependency between unquiesce and blk_mark_disk_dead,
> maybe it would be a good idea to move the unquiescing to the drivers
> which can pair with the quiesce itself, and rename it to
> nvme_mark_namespaces_dead() or something?

Yes, something like that is probably a good idea.  This entire area
is a bit of a mess to say it mildly, so maybe we need to sort that
out first.
