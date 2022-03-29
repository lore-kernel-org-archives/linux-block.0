Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ACCC433F5
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 13:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiC2N0x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 09:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbiC2N0w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 09:26:52 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E82154683
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 06:25:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C293368AFE; Tue, 29 Mar 2022 15:25:02 +0200 (CEST)
Date:   Tue, 29 Mar 2022 15:25:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: Re: [PATCH 13/14] loop: remove lo_refcount and avoid lo_mutex in
 ->open / ->release
Message-ID: <20220329132502.GA2024@lst.de>
References: <20220325063929.1773899-1-hch@lst.de> <20220325063929.1773899-14-hch@lst.de> <03628e13-ca56-4ed0-da5a-ee698c83f48d@I-love.SAKURA.ne.jp> <20220329065234.GA20006@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329065234.GA20006@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thinking a bit more, I really don't think the existing any refcount
check protects us against a different tread modififying the backing
file.  When a process has a file descriptor to a loop device open
and is multithreaded (or forks) we can still have multiple threads
manipulating the loop state.

That being said I do not think we really need that refcount check
at all - once loop_clr_fd set lo->lo_state to Lo_rundown under the
global lock we know that loop_validate_file will error out on it
due to the lo_state != Lo_bound check.
