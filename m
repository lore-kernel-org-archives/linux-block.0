Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA6DC53210
	for <linux-block@archiver.kernel.org>; Sun,  8 Jan 2023 17:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjAHRCs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Jan 2023 12:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjAHRCr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Jan 2023 12:02:47 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18413A6;
        Sun,  8 Jan 2023 09:02:44 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9222E68AA6; Sun,  8 Jan 2023 18:02:40 +0100 (CET)
Date:   Sun, 8 Jan 2023 18:02:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] blkcg: Drop unnecessary RCU read [un]locks from
 blkg_conf_prep/finish()
Message-ID: <20230108170240.GA19165@lst.de>
References: <20230105212432.289569-1-tj@kernel.org> <20230105212432.289569-2-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105212432.289569-2-tj@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 05, 2023 at 11:24:29AM -1000, Tejun Heo wrote:
> Holding the queue lock now implies RCU read lock, so no need to use
> rcu_read_[un]lock() explicitly. This shouldn't cause any behavior changes.

How so?

> While at it, drop __acquires() annotation on the queue lock too. The
> __acquires() part was already out of sync and it doesn't catch anything that
> lockdep can't.

This makes sparse even more unhappy than it was before.  For now
please keep the annotation.
