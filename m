Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E01C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Dec 2021 17:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241043AbhL2RUI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Dec 2021 12:20:08 -0500
Received: from verein.lst.de ([213.95.11.211]:38248 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241034AbhL2RUH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Dec 2021 12:20:07 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 40CF468AFE; Wed, 29 Dec 2021 18:20:03 +0100 (CET)
Date:   Wed, 29 Dec 2021 18:20:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: fix loop autoclear for xfstets xfs/049
Message-ID: <20211229172002.GA27693@lst.de>
References: <20211223112509.1116461-1-hch@lst.de> <20211223134050.GD19129@quack2.suse.cz> <20211224060205.GB12234@lst.de> <6be20f77-ab25-0c74-09c4-22a46fed40a1@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6be20f77-ab25-0c74-09c4-22a46fed40a1@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Dec 26, 2021 at 04:09:18PM +0900, Tetsuo Handa wrote:
> Here is a simplified reproducer and a log. It was difficult to find a reproducer
> because /proc/lockdep zaps dependency chain when a dynamically created object is destroyed.

Can you send this for inclusion in blktests?  I think this is an
important enough thing to always have at hand.
