Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976C2C433FE
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 15:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiJQPbM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Oct 2022 11:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiJQPbL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 11:31:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E76A13F1F
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 08:31:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5514B68C4E; Mon, 17 Oct 2022 17:31:05 +0200 (CEST)
Date:   Mon, 17 Oct 2022 17:31:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        sagi@grimberg.me, kbusch@kernel.org, ming.lei@redhat.com,
        axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221017153105.GA32509@lst.de>
References: <20221013094450.5947-1-lengchao@huawei.com> <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de> <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 17, 2022 at 08:21:36AM -0700, Paul E. McKenney wrote:
> The main reason for having multiple srcu_struct structures is to
> prevent the readers from one from holding up the updaters from another.
> Except that by waiting for the multiple grace periods, you are losing
> that property anyway, correct?  Or is this code waiting on only a small
> fraction of the srcu_struct structures associated with blk_queue?

There are a few places that do this.  SCSI and MMC could probably switch
to this scheme or at least and open coded version of it (if we move
to a per_tagsect srcu_struct open coding it might be a better idea
anyway).

del_gendisk is one where we have to go one queue at a time, and
that might actually matter for a device removal.  elevator_switch
is another one, there is a variant for it that works on the whole
tagset, but also those that don't.
