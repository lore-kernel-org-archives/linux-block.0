Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DA1C001DE
	for <linux-block@archiver.kernel.org>; Mon, 31 Jul 2023 14:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjGaOJj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jul 2023 10:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbjGaOJV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 10:09:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4341724;
        Mon, 31 Jul 2023 07:09:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0697267373; Mon, 31 Jul 2023 16:09:11 +0200 (CEST)
Date:   Mon, 31 Jul 2023 16:09:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chengming Zhou <chengming.zhou@linux.dev>
Cc:     Christoph Hellwig <hch@lst.de>, hare@suse.de, axboe@kernel.dk,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: Re: [PATCH v2 1/4] blk-flush: flush_rq should inherit first_rq's
 cmd_flags
Message-ID: <20230731140910.GA6835@lst.de>
References: <20230725130102.3030032-1-chengming.zhou@linux.dev> <20230725130102.3030032-2-chengming.zhou@linux.dev> <20230731060957.GA30409@lst.de> <0ee17228-4938-6ab7-3fc4-f83a81cbed8f@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ee17228-4938-6ab7-3fc4-f83a81cbed8f@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 31, 2023 at 10:02:39PM +0800, Chengming Zhou wrote:
> The commit 84fca1b0c461 ("block: pass failfast and driver-specific flags to
> flush requests") says:
> If flush requests are being sent to the device we need to inherit the
> failfast and driver-specific flags, too, otherwise I/O will fail.
> 
> 1) REQ_FAILFAST_MASK: agree, shouldn't set to the flush_rq I think?
> 2) REQ_DRV: I don't get why this flag not set would cause I/O fail?

I don't think it would fail I/O by it's own, but it will cause the
nvme driver to not do the correct handling of an error when a flush
is set to multipath setups.

