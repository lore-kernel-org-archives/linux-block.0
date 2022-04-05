Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B23C433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Apr 2022 06:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiDEGam (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Apr 2022 02:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiDEGal (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Apr 2022 02:30:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE356205CA
        for <linux-block@vger.kernel.org>; Mon,  4 Apr 2022 23:28:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E830C68AFE; Tue,  5 Apr 2022 08:28:38 +0200 (CEST)
Date:   Tue, 5 Apr 2022 08:28:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: Re: yet another approach to fix the loop lock order inversions v6
Message-ID: <20220405062838.GA24373@lst.de>
References: <20220330052917.2566582-1-hch@lst.de> <20220404074235.GA1046@lst.de> <499de381-c81e-4bd0-b5f7-1ee6be45821d@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <499de381-c81e-4bd0-b5f7-1ee6be45821d@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 04, 2022 at 06:39:31PM +0900, Tetsuo Handa wrote:
> Two bugs which Jan has found in /bin/mount might not be yet fixed in
> versions developers/users are using. Thus, let's wait for a while
> before committing to linux.git.

Jan, which loop bugs might be relevant here?
