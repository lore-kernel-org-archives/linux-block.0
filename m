Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0866C38A02
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 09:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJ3JSS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 05:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3JSS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 05:18:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08BFB490
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 02:18:17 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0BF7468AA6; Sun, 30 Oct 2022 10:18:15 +0100 (CET)
Date:   Sun, 30 Oct 2022 10:18:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 03/17] nvme-pci: don't warn about the lack of I/O
 queues for admin controllers
Message-ID: <20221030091814.GB5643@lst.de>
References: <20221025144020.260458-1-hch@lst.de> <20221025144020.260458-4-hch@lst.de> <c3b88277-b237-c89e-a63c-bd441615e6b2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3b88277-b237-c89e-a63c-bd441615e6b2@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 26, 2022 at 03:49:06PM +0300, Sagi Grimberg wrote:
> I have a feeling that we have quite a few other messages that are
> irrelevant for admin controllers. And I wander what device you have that
> presents an admin controller, but looks good,

Could be.  I don't actually have any administrative controller at hand,
I just noticed the warning while looking over this code.
