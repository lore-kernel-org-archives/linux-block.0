Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDA3C433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 10:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB5FB60F92
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 10:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhIFK03 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Sep 2021 06:26:29 -0400
Received: from verein.lst.de ([213.95.11.211]:60942 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231739AbhIFK02 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Sep 2021 06:26:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 16A5F67373; Mon,  6 Sep 2021 12:25:22 +0200 (CEST)
Date:   Mon, 6 Sep 2021 12:25:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH v2 3/3] nbd: fix race between nbd_alloc_config() and
 module removal
Message-ID: <20210906102521.GA3082@lst.de>
References: <20210904122519.1963983-1-houtao1@huawei.com> <20210904122519.1963983-4-houtao1@huawei.com> <20210906093051.GC30790@lst.de> <ce3e1ea8-ebda-4372-42ce-e8a4b2d12514@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce3e1ea8-ebda-4372-42ce-e8a4b2d12514@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 06, 2021 at 06:08:54PM +0800, Hou Tao wrote:
> >> +	if (!try_module_get(THIS_MODULE))
> >> +		return ERR_PTR(-ENODEV);
> > try_module_get(THIS_MODULE) is an indicator for an unsafe pattern.  If
> > we don't already have a reference it could never close the race.
> >
> > Looking at the callers:
> >
> >  - nbd_open like all block device operations must have a reference
> >    already.
> Yes. nbd_open() has already taken a reference in dentry_open().
> >  - for nbd_genl_connect I'm not an expert, but given that struct
> >    nbd_genl_family has a module member I suspect the networkinh
> >    code already takes a reference.
> 
> That was my original though, but the fact is netlink code doesn't take a module reference
> 
> in genl_family_rcv_msg_doit() and netlink uses genl_lock_all() to serialize between module removal
> 
> and nbd_connect_genl_ops calling, so I think use try_module_get() is OK here.

How it this going to work?  If there was a race you just shortened it,
but it can still happen before you call try_module_get.  So I think we
need to look into how the netlink calling conventions are supposed to
look and understand the issues there first.
