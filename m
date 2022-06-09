Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B86BC433EF
	for <linux-block@archiver.kernel.org>; Thu,  9 Jun 2022 04:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiFIEL4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jun 2022 00:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiFIELz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jun 2022 00:11:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19904CD47
        for <linux-block@vger.kernel.org>; Wed,  8 Jun 2022 21:11:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 500E268AA6; Thu,  9 Jun 2022 06:11:49 +0200 (CEST)
Date:   Thu, 9 Jun 2022 06:11:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: fix and cleanup device mapper bioset initialization
Message-ID: <20220609041149.GA31649@lst.de>
References: <20220608063409.1280968-1-hch@lst.de> <YqDneqyp33PvkCLm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqDneqyp33PvkCLm@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 08, 2022 at 02:16:26PM -0400, Mike Snitzer wrote:
> All looks good to me.  Are you OK with me picking up the first 3 to
> send to Linus for 5.19-rc2 (given the integrity bioset fix)?
> 
> And hold patch 4 until 5.20 merge?

Sounds good to me.

> Or would you prefer that cleanup to land now too?

I don't think Linus would like that :)  In fact even patch 3 might be
5.20 material.
