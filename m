Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5314C433EF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 10:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbiA0K2S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 05:28:18 -0500
Received: from verein.lst.de ([213.95.11.211]:43621 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbiA0K2S (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 05:28:18 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B8E0468AA6; Thu, 27 Jan 2022 11:28:14 +0100 (CET)
Date:   Thu, 27 Jan 2022 11:28:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 4/8] loop: only take lo_mutex for the last reference in
 lo_release
Message-ID: <20220127102814.GA15593@lst.de>
References: <20220126155040.1190842-1-hch@lst.de> <20220126155040.1190842-5-hch@lst.de> <20220127094813.ra7nslwycdcaw2gi@quack3.lan> <20220127101957.3t4zdq7hizgu3myn@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127101957.3t4zdq7hizgu3myn@quack3.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 27, 2022 at 11:19:57AM +0100, Jan Kara wrote:
> Just after writing this I have realized that the above sequence is not
> actually possible due to disk->open_mutex protecting us and serializing
> lo_release() with lo_open() but it needs at least a comment to explain that
> we rely on disk->open_mutex to avoid races with lo_open().

The commit message already notes this.  Not sure we really need a comment
in the code itself, but if you want I can add it.
