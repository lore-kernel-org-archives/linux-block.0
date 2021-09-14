Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A6EC433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 06:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDD3A6113E
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 06:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbhINGVa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Sep 2021 02:21:30 -0400
Received: from verein.lst.de ([213.95.11.211]:58626 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239868AbhINGV1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 02:21:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5A7FD67357; Tue, 14 Sep 2021 08:20:08 +0200 (CEST)
Date:   Tue, 14 Sep 2021 08:20:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     koulihong <koulihong@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe <axboe@kernel.dk>,
        kbusch <kbusch@kernel.org>, sagi <sagi@grimberg.me>,
        linux-block <linux-block@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] block: nvme: fix the NULL ptr bug in
 bio_integrity_verify_fn
Message-ID: <20210914062008.GA27421@lst.de>
References: <20210913061303.GA4324@lst.de> <ad51e8bf2bf04e9f9b1ff9ab36718935@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad51e8bf2bf04e9f9b1ff9ab36718935@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 14, 2021 at 06:15:19AM +0000, koulihong wrote:
> If we move the the conditional judgment to blk_integrity_unregister, we should do some
> cleanup work in md and nvme modules.  I will
> send the v3 patches two weeks later. I’m on a
> holiday, I have tow weeks off.

If you're fine with it I'll take over the series so that we can get
it queued up.
