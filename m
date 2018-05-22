Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41699 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEVJBb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 May 2018 05:01:31 -0400
Subject: Re: [PATCH v2] lib/crc64.c: add license information
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20180522085400.66980-1-colyli@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From: Coly Li <colyli@suse.de>
Message-ID: <abea841e-5dd8-bade-829c-993dfd273f62@suse.de>
Date: Tue, 22 May 2018 17:01:25 +0800
MIME-Version: 1.0
In-Reply-To: <20180522085400.66980-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018/5/22 4:54 PM, Coly Li wrote:
> This patch adds MODULE_LICENSE("GPL") to remove a kernel build warning
> information. Also as Andy Shevchenko suggested, adds a SPDX header into
> lib/crc64.c file.
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi Andy,

Could you please to offer a Reviewed-by or Acked-by ? We have an
agreement that every patch should have a peer reviewer, at this moment
we are lack of code reviewer but I still want to keep this rule as much
as I can.

Thanks in advance.

Coly Li

> ---
>  lib/crc64.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/crc64.c b/lib/crc64.c
> index ed0ffac7b26a..30d1bb58dd5c 100644
> --- a/lib/crc64.c
> +++ b/lib/crc64.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Portions Copyright (c) 1996-2001, PostgreSQL Global Development Group (Any
>   * use permitted, subject to terms of PostgreSQL license; see.)
> @@ -135,3 +136,4 @@ uint64_t crc64(const void *data, size_t len)
>  EXPORT_SYMBOL_GPL(crc64);
>  
>  MODULE_DESCRIPTION("CRC64 calculations");
> +MODULE_LICENSE("GPL");
> 
