Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00460C636D4
	for <linux-block@archiver.kernel.org>; Mon, 13 Feb 2023 08:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBMImV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 03:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBMImU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 03:42:20 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B8B4C0A
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 00:42:20 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CFAD268BFE; Mon, 13 Feb 2023 09:42:16 +0100 (CET)
Date:   Mon, 13 Feb 2023 09:42:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-cgroup: delay calling blkcg_exit_disk until
 disk_release
Message-ID: <20230213084216.GA18385@lst.de>
References: <20230208063514.171485-1-hch@lst.de> <Y+XQh3zMHMIX2+jr@T590> <Y+n2tX4fVuRrQLuN@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+n2tX4fVuRrQLuN@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 13, 2023 at 04:37:09PM +0800, Ming Lei wrote:
> This issue is a bit serious, both blkg & disk & request_queue are leaked by
> commit c43332fe028c ("blk-cgroup: delay calling blkcg_exit_disk until disk_release").
> 
> Can we solve it before merging for-6.3/block into v6.3-rc1?

Yes.  I'm testing a fix at the moment.
