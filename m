Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E558C433FE
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 06:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC44461132
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 06:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhIIGlr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 02:41:47 -0400
Received: from verein.lst.de ([213.95.11.211]:41440 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbhIIGlr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Sep 2021 02:41:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0B88D67373; Thu,  9 Sep 2021 08:40:36 +0200 (CEST)
Date:   Thu, 9 Sep 2021 08:40:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH v2 3/3] nbd: fix race between nbd_alloc_config() and
 module removal
Message-ID: <20210909064035.GA26290@lst.de>
References: <20210904122519.1963983-1-houtao1@huawei.com> <20210904122519.1963983-4-houtao1@huawei.com> <20210906093051.GC30790@lst.de> <ce3e1ea8-ebda-4372-42ce-e8a4b2d12514@huawei.com> <20210906102521.GA3082@lst.de> <730dae5e-5af8-3554-18bf-e22ff576e2b1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <730dae5e-5af8-3554-18bf-e22ff576e2b1@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 07, 2021 at 11:04:16AM +0800, Hou Tao wrote:
> Let me explain first. The reason it works is due to genl_lock_all() in netlink code.

Btw, please properly format your mail.  These overly long lines are really
hard to read.

> If the module removal happens before calling try_module_get(), nbd_cleanup() will
> 
> call genl_unregister_family() first, and then genl_lock_all(). genl_lock_all() will
> 
> prevent ops in nbd_connect_genl_ops() from being called, because the calling
> 
> of nbd ops happens in genl_rcv() which needs to acquire cb_lock first.

Good.

> I have checked multiple genl_ops, it seems that the reason why these genl_ops
> 
> don't need try_module_get() is that these ops don't create new object through
> 
> genl_ops and just control it. However genl_family_rcv_msg_dumpit() will try to
> 
> call try_module_get(), but according to the history (6dc878a8ca39 "netlink: add reference of module in netlink_dump_start"),
> 
> it is because inet_diag_handler_cmd() will call __netlink_dump_start().

And now taking a step back:  Why do we even need this extra module
reference?  For the case where nbd_alloc_config is called from nbd_open
we obviously don't need it.  In the case where it is called from
nbd_genl_connect that prevents unloading nbd when there is a configured
but not actually nbd device.  Which isn't reallyed need and counter to
how other drivers work.

Did you try just removing the extra module refcounting?
