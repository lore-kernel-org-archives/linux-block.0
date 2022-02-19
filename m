Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14426C433EF
	for <linux-block@archiver.kernel.org>; Sat, 19 Feb 2022 03:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbiBSDLH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Feb 2022 22:11:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbiBSDLG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Feb 2022 22:11:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056DB24564D
        for <linux-block@vger.kernel.org>; Fri, 18 Feb 2022 19:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=jAlfkTJ1IaomE5yqtVtDaoNYND+LFGHdGgSBXtlpKDs=; b=ZVubL4/asjCq3ZcYWf3qIRvDLd
        GqpM/KvPeMRhewoT5DDeK2TjCeX0H2IJt2TgV5o4D/vSTs5SUODYhZdTB4/NUoblcQD/ojtJbQsYY
        ZPuErgOGYmCioG2VrWshQf2T4UjxNUWGvw5yfBKwo1BGKNzJOANdluO9MUTv/BM9YjW+BhncefbYL
        W95pUDBdb0IVU4zamqbpoJthfzvKZqBLquRlM0VPmYCoeok+OwDz9f7KgS2RflHsUKYg1HGW+shHu
        HFbC1OY8vCHfeOvyXZo1WWQb3711Bk1UPlkHfLNm/vxgUBzMj48N3AX2xQqFvCgu2ZV7ODlxB9oYI
        RD+Bfmqw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLG8u-00GC17-26; Sat, 19 Feb 2022 03:10:41 +0000
Date:   Fri, 18 Feb 2022 19:10:40 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org, Pankaj Raghav <pankydev8@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: block loopback driver possible regression since next-20220211
Message-ID: <YhBfsIqCNsi7D/st@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I noticed that since next-20220211 losetup fails at something stupid
simple:

losetup $LOOPDEV $DISK

I can't see how the changes on drivers/block/loop.c would cause this,
I even tried to revert what I thought would be the only commit which
would seem to do a functional change "loop: revert "make autoclear
operation asynchronous" but that didn't fix it.

I proceeded to bisecting... but I did this on today's linux-next,
and well today's linux-next is hosed even at boot. My bisection then
was completley inconclusive since linux-next is pure poop today.

Any ideas though?

Fortunately Linus' tree is fine.

I'm quit afraid that we wouldn't have caught this issue. Seems pretty
straight forward. It would seem we don't have such a basic thing on
blktests, so I'll go add that...

  Luis
