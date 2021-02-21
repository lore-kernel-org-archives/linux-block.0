Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC22CC433E0
	for <linux-block@archiver.kernel.org>; Sun, 21 Feb 2021 22:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78CCE655E6
	for <linux-block@archiver.kernel.org>; Sun, 21 Feb 2021 22:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhBUW7P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Feb 2021 17:59:15 -0500
Received: from elvis.franken.de ([193.175.24.41]:44611 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232152AbhBUW7H (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Feb 2021 17:59:07 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lDxgF-0001Gf-00; Sun, 21 Feb 2021 23:58:23 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 11DD2C05CE; Sun, 21 Feb 2021 23:39:29 +0100 (CET)
Date:   Sun, 21 Feb 2021 23:39:29 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Lauri Kasanen <cand@gmx.com>
Cc:     linux-mips@vger.kernel.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v11] block: Add n64 cart driver
Message-ID: <20210221223928.GA8374@alpha.franken.de>
References: <20210123095327.58e5ab6c05f38e9080a79bd3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123095327.58e5ab6c05f38e9080a79bd3@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jan 23, 2021 at 09:53:27AM +0200, Lauri Kasanen wrote:
> This adds support for the Nintendo 64 console's carts. Carts are a
> read-only media ranging from 8mb to 64mb.
> 
> Only one cart can be connected at once, and switching it requires a
> reboot.
> 
> No module support to save RAM, as the target has 8mb RAM.
> 
> Signed-off-by: Lauri Kasanen <cand@gmx.com>
> ---
>  drivers/block/Kconfig   |   6 ++
>  drivers/block/Makefile  |   1 +
>  drivers/block/n64cart.c | 189 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 196 insertions(+)
>  create mode 100644 drivers/block/n64cart.c

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
