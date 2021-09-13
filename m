Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C86CC433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 15:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B876108B
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 15:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbhIMP1W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:27:22 -0400
Received: from verein.lst.de ([213.95.11.211]:55765 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhIMP1S (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 11:27:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7281F67357; Mon, 13 Sep 2021 17:25:58 +0200 (CEST)
Date:   Mon, 13 Sep 2021 17:25:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH v2 3/3] nbd: fix race between nbd_alloc_config() and
 module removal
Message-ID: <20210913152558.GA3998@lst.de>
References: <20210904122519.1963983-1-houtao1@huawei.com> <20210904122519.1963983-4-houtao1@huawei.com> <20210906093051.GC30790@lst.de> <ce3e1ea8-ebda-4372-42ce-e8a4b2d12514@huawei.com> <20210906102521.GA3082@lst.de> <730dae5e-5af8-3554-18bf-e22ff576e2b1@huawei.com> <20210909064035.GA26290@lst.de> <6434d4e8-984d-97df-34e5-b86a0e69cf58@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6434d4e8-984d-97df-34e5-b86a0e69cf58@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 13, 2021 at 12:32:37PM +0800, Hou Tao wrote:
> > Did you try just removing the extra module refcounting?
> Yes, removing the module refcounting in nbd_alloc_config() and cleaning
> the nbd_config in nbd_cleanup() also work, but not sure whether or not
> it will break some nbd user-case which depends on the extra module
> reference count. I prefer to keep the extra module refcounting considering
> that loop driver does it as well, so what is your suggestion ?

Can you respin the patch with a comment explaining this in detail
so that the next person tripping over it doesn't have to do the research
again?
