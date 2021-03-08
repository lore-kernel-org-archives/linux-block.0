Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C5EC433E6
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 18:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 486756518A
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 18:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCHSiE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:38:04 -0500
Received: from verein.lst.de ([213.95.11.211]:57001 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhCHShy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Mar 2021 13:37:54 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5D6C768B02; Mon,  8 Mar 2021 19:37:51 +0100 (CET)
Date:   Mon, 8 Mar 2021 19:37:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Martin Wilck <mwilck@suse.com>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: Suppress uevent for hidden device when removed
Message-ID: <20210308183751.GA17380@lst.de>
References: <20210303171201.8432-1-dwagner@suse.de> <66a9b7ff4958ab990f58a3dad8152d00c59775ce.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66a9b7ff4958ab990f58a3dad8152d00c59775ce.camel@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 03, 2021 at 06:30:34PM +0100, Martin Wilck wrote:
> I wonder if it wouldn't be wiser to remove this code
> 
>         if (disk->flags & GENHD_FL_HIDDEN) {
>                 dev_set_uevent_suppress(ddev, 0);
>                 return;
>         }
> 
> from register_disk(). The way you did it now, we would receive neither
> "add" nor "remove" events in user space, but there might be change
> events in between ?

Well, we'll need to keep the return.  That being said keepign the
uevents supressed entirely might be a good idea.
