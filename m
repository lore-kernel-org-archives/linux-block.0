Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D5DC4332F
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 07:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiJSHci (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 03:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJSHci (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 03:32:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324EA78BFB
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 00:32:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4B40468C4E; Wed, 19 Oct 2022 09:32:31 +0200 (CEST)
Date:   Wed, 19 Oct 2022 09:32:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221019073231.GA12035@lst.de>
References: <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de> <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1> <20221017153105.GA32509@lst.de> <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1> <20221018051956.GA18802@lst.de> <Y09GROYqk3FMM21W@T590> <9da048fc-71ee-cc38-a861-59acc96671fe@grimberg.me> <20221019072535.GA11402@lst.de> <974a750a-4d18-f559-0247-3d3aa62e620e@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <974a750a-4d18-f559-0247-3d3aa62e620e@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 19, 2022 at 10:30:44AM +0300, Sagi Grimberg wrote:
> iscsi defers network sends to a workqueue anyways, and no scsi lld sets
> BLK_MQ_F_BLOCKING.

Yes, but Mike had a series to implement a similar fast path as nvme-tcp
as while ago that included supporting BLK_MQ_F_BLOCKING in the scsi
midlayer.  We'll also need it to convert the paride drivers to libata,
but those are single request_queue per tag_set as far as I know.
