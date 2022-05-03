Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8014DC433FE
	for <linux-block@archiver.kernel.org>; Tue,  3 May 2022 20:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbiECURa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 May 2022 16:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242655AbiECURV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 May 2022 16:17:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8532408D;
        Tue,  3 May 2022 13:13:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6468167373; Tue,  3 May 2022 22:13:34 +0200 (CEST)
Date:   Tue, 3 May 2022 22:13:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-spdx@vger.kernel.org
Subject: Re: SPDX tag and top of file comment cleanups for the loop driver
Message-ID: <20220503201334.GA7325@lst.de>
References: <20220419063303.583106-1-hch@lst.de> <YnGLRAuS8QGaSADK@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnGLRAuS8QGaSADK@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 03, 2022 at 04:06:28PM -0400, Theodore Ts'o wrote:
> > Ted, does the SPDX tag match your original licensing decision back then,
> > or do we need to correct it?  Does the auto-converted tag on the loop.h
> > SPDX header (GPL1.0 or later with syscall exception) make sense, or
> > should that have been GPL2 only with syscall exception?
> 
> I think you've removed the loop.h in the patch series, so it shouldn't
> matter what the tag would be for loop.h, right?  In any case, GPLv2
> only was certainly the intent at the time.

Well, there were two loop.h files - drivers/block/loop.h gets removed
in this series, but include/uapi/linux/loop.h stays.
