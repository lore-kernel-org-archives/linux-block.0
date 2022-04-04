Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1B3C433EF
	for <linux-block@archiver.kernel.org>; Mon,  4 Apr 2022 07:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357125AbiDDHog (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Apr 2022 03:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352836AbiDDHof (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Apr 2022 03:44:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B297237D7
        for <linux-block@vger.kernel.org>; Mon,  4 Apr 2022 00:42:40 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 236FF68AFE; Mon,  4 Apr 2022 09:42:36 +0200 (CEST)
Date:   Mon, 4 Apr 2022 09:42:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: Re: yet another approach to fix the loop lock order inversions v6
Message-ID: <20220404074235.GA1046@lst.de>
References: <20220330052917.2566582-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330052917.2566582-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Any more comments?  It would be good to settle this saga for 5.18.
