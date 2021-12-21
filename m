Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5317BC433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 09:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbhLUJnO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 04:43:14 -0500
Received: from relay037.a.hostedemail.com ([64.99.140.37]:6731 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231744AbhLUJnO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 04:43:14 -0500
X-Greylist: delayed 608 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Dec 2021 04:43:14 EST
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 9EF95221EE;
        Tue, 21 Dec 2021 09:33:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 6ACA72000E;
        Tue, 21 Dec 2021 09:32:57 +0000 (UTC)
Message-ID: <b71570d5bc14181c656f8dd7ba69a397fd775495.camel@perches.com>
Subject: Re: [PATCH v2 1/2] zram: zram_drv: add SPDX license identifiers
From:   Joe Perches <joe@perches.com>
To:     Miko Larsson <mikoxyzzz@gmail.com>, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     hch@infradead.org
Date:   Tue, 21 Dec 2021 01:33:00 -0800
In-Reply-To: <20211217063224.3474-2-mikoxyzzz@gmail.com>
References: <20211217063224.3474-1-mikoxyzzz@gmail.com>
         <20211217063224.3474-2-mikoxyzzz@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xghxrfynbxtywuk5yfuxjo55arppk9gg
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 6ACA72000E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX194+gRph/lCIo+3NsrWZgT6X0FHyRuXw9Y=
X-HE-Tag: 1640079177-862073
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2021-12-17 at 07:32 +0100, Miko Larsson wrote:
> zram_drv lacks an SPDX license identifier in both its source and in its
> header, so we should add license identifiers based on the copyright info
> provided by the initial comment block.
> 
> Signed-off-by: Miko Larsson <mikoxyzzz@gmail.com>
> ---
>  drivers/block/zram/zram_drv.c | 9 ++-------
>  drivers/block/zram/zram_drv.h | 9 ++-------
>  2 files changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
[]
> @@ -1,15 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause

GPL v2 is a permissive license and this SPDX tag should probably be

// SPDX-License-Identifier: GPL-2.0-or-later or BSD-3-Clause

> +
>  /*
>   * Compressed RAM block device
>   *
>   * Copyright (C) 2008, 2009, 2010  Nitin Gupta
>   *               2012, 2013 Minchan Kim
> - *
> - * This code is released using a dual license strategy: BSD/GPL
> - * You can choose the licence that better fits your requirements.
> - *
> - * Released under the terms of 3-clause BSD License
> - * Released under the terms of GNU General Public License Version 2.0



