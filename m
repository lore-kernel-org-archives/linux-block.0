Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52984C433EF
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 17:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241336AbiCXROa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 13:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239179AbiCXROa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 13:14:30 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AAEB1889
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 10:12:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3A00368BEB; Thu, 24 Mar 2022 18:12:55 +0100 (CET)
Date:   Thu, 24 Mar 2022 18:12:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH 05/13] block: turn bdev->bd_openers into an atomic_t
Message-ID: <20220324171254.GB28007@lst.de>
References: <20220324075119.1556334-1-hch@lst.de> <20220324075119.1556334-6-hch@lst.de> <20220324133136.h6vimclhyhly7uyh@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324133136.h6vimclhyhly7uyh@quack3.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 24, 2022 at 02:31:36PM +0100, Jan Kara wrote:
> BTW I suspect that drivers/block/aoe/ could now use bd_openers instead of
> its driver specific mirror of it (->nopen). But that's certainly a separate
> cleanup for some other time.

Yes.  There actually are a lot of places that should drop their internal
number of openers counters.
