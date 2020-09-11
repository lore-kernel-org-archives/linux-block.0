Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84743C2BC11
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 17:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593F5221E7
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 17:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIKRJN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:09:13 -0400
Received: from verein.lst.de ([213.95.11.211]:36970 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgIKO6o (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 10:58:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0972668B02; Fri, 11 Sep 2020 16:58:38 +0200 (CEST)
Date:   Fri, 11 Sep 2020 16:58:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dmitriy Gorokh <degifted@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix locking in bdev_del_partition
Message-ID: <20200911145837.GA22414@lst.de>
References: <CANYdAbJVvNB+5Kyqgu3aoh8ug6C2DVkys8JWrY-nQvtPLEgeOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANYdAbJVvNB+5Kyqgu3aoh8ug6C2DVkys8JWrY-nQvtPLEgeOw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 11, 2020 at 05:56:42PM +0300, Dmitriy Gorokh wrote:
> Hi Christoph,
> 
> Unfortunately this fix (Upstream commit
> 08fc1ab6d748ab1a690fd483f41e2938984ce353) breaks compatibility with
> some userspace tools, specifically mdadm, who expect ENXIO errno as a
> result of BLKPG_DEL_PARTITION operation to test if the block device is
> a whole-disk or a partition. With the recent 5.8 kernel it now returns
> ENOMEM on an existing block device which seems inconsistent.

https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.9&id=88ce2a530cc9865a894454b2e40eba5957a60e1a
