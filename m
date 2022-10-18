Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD3DC4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 05:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJRFUD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 01:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJRFUC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 01:20:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EC823EA7
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 22:20:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0F39B68C4E; Tue, 18 Oct 2022 07:19:56 +0200 (CEST)
Date:   Tue, 18 Oct 2022 07:19:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        sagi@grimberg.me, kbusch@kernel.org, ming.lei@redhat.com,
        axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221018051956.GA18802@lst.de>
References: <20221013094450.5947-1-lengchao@huawei.com> <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de> <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1> <20221017153105.GA32509@lst.de> <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 17, 2022 at 03:41:15PM -0700, Paul E. McKenney wrote:
> Then the big question is "how long do the SRCU readers run?"
> 
> If all of the readers ran for exactly the same duration, there would be
> little point in having more than one srcu_struct.

The SRCU readers are the I/O dispatch, which will have quite similar
runtimes for the different queues.

> If the kernel knew up front how long the SRCU readers for a given entry
> would run, it could provide an srcu_struct structure for each duration.
> For a (fanciful) example, you could have one srcu_struct structure for
> SSDs, another for rotating rust, a third for LAN-attached storage, and
> a fourth for WAN-attached storage.  Maybe a fifth for lunar-based storage.

All the different request_queues in a tag_set are for the same device.
There might be some corner cases like storare arrays where they have
different latencies.  But we're not even waiting for the I/O completion
here, this just protects the submission.

> Does that help, or am I off in the weeds here?

I think this was very helpful, and at least to be moving the srcu_struct
to the tag_set sounds like a good idea to explore.

Ming, anything I might have missed?
