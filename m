Return-Path: <SRS0=IUku=4S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1757BC3F2D1
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 21:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DA720CC7
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 21:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgCAVUe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Mar 2020 16:20:34 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:32100 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgCAVUd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 1 Mar 2020 16:20:33 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 021LKNLR011368;
        Sun, 1 Mar 2020 22:20:23 +0100
Date:   Sun, 1 Mar 2020 22:20:23 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Joe Perches <joe@perches.com>
Cc:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 0/6] floppy: make use of the local/global fdc explicit
Message-ID: <20200301212023.GA11317@1wt.eu>
References: <20200301195555.11154-1-w@1wt.eu>
 <03a2ea0b91ab61ba9a11230e82f1fb3bdf420a50.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03a2ea0b91ab61ba9a11230e82f1fb3bdf420a50.camel@perches.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 01, 2020 at 12:33:25PM -0800, Joe Perches wrote:
> On Sun, 2020-03-01 at 20:55 +0100, Willy Tarreau wrote:
> > This is an update to the first minimal cleanup of the floppy driver in
> > order to make use of the FDC number explicit so as to avoid bugs like
> > the one fixed by 2e90ca68 ("floppy: check FDC index for errors before
> > assigning it").
> 
> Thanks Willy.
> 
> trivia: you could style check the patches using checkpatch.

Oh yes, sorry about this, I did it in the first series but forgot to
do it again. What checkpatch complains about is essentially lines which
slightly exceed 80 characters due to the macro expansions, while I tried
to limit the changes to the strict minimum. I guess that's OK to keep
future fixes easier to backport.

Thanks,
Willy
