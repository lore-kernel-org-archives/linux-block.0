Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0564CC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Jan 2021 17:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6EEF2253A
	for <linux-block@archiver.kernel.org>; Mon, 18 Jan 2021 17:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407147AbhARRvP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jan 2021 12:51:15 -0500
Received: from verein.lst.de ([213.95.11.211]:48989 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407169AbhARRuI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jan 2021 12:50:08 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1409E6736F; Mon, 18 Jan 2021 18:49:14 +0100 (CET)
Date:   Mon, 18 Jan 2021 18:49:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chao Leng <lengchao@huawei.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de,
        linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v2 4/6] nvme-rdma: avoid IO error and repeated request
 completion
Message-ID: <20210118174913.GA8700@lst.de>
References: <20210107033149.15701-1-lengchao@huawei.com> <20210107033149.15701-5-lengchao@huawei.com> <07e41b4f-914a-11e8-5638-e2d6408feb3f@grimberg.me> <7b12be41-0fcd-5a22-0e01-8cd4ac9cde5b@huawei.com> <a3404c7d-ccc8-0d55-d4a8-fc15107c90e6@grimberg.me> <695b6839-5333-c342-2189-d7aaeba797a7@huawei.com> <4ff22d33-12fa-1f70-3606-54821f314c45@grimberg.me> <0b5c8e31-8dc2-994a-1710-1b1be07549c9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b5c8e31-8dc2-994a-1710-1b1be07549c9@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 18, 2021 at 11:22:16AM +0800, Chao Leng wrote:
>> Well, certainly this one-shot always return 0 and complete the command
>> with HOST_PATH error is not a good approach IMO
> So what's the better option? Just complete the request with host path
> error for non-ENOMEM and EAGAIN returned by the HBA driver?

what HBA driver?
