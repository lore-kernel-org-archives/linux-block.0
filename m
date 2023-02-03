Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A518C636CC
	for <linux-block@archiver.kernel.org>; Fri,  3 Feb 2023 08:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjBCIJ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Feb 2023 03:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjBCIIz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Feb 2023 03:08:55 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F2295D33;
        Fri,  3 Feb 2023 00:06:50 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB00C67373; Fri,  3 Feb 2023 09:06:46 +0100 (CET)
Date:   Fri, 3 Feb 2023 09:06:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: Re: [PATCH 07/19] blk-cgroup: store a gendisk to throttle in
 struct task_struct
Message-ID: <20230203080646.GB28639@lst.de>
References: <20230201134123.2656505-1-hch@lst.de> <20230201134123.2656505-8-hch@lst.de> <Y9xSs0Gf8Qcr9R7w@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9xSs0Gf8Qcr9R7w@slm.duckdns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 02, 2023 at 02:17:55PM -1000, Tejun Heo wrote:
> The change looks fine to me but can you please separate out the dead disk
> test change to its own patch and explain why?

I'll just drop it.  All these dead checks got added only accidentally
due to how blk_get_queues worked, and I'm really not interested enough
to discuss the fine details of it.
