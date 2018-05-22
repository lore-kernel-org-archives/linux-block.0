Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:24711 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbeEVInk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 May 2018 04:43:40 -0400
Message-ID: <6e9bdb5464689cc3ade4c09683e38f9f0104948b.camel@linux.intel.com>
Subject: Re: [PATCH] lib/crc64.c: add MODULE_LICENSE("GPL")
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
Date: Tue, 22 May 2018 11:43:38 +0300
In-Reply-To: <20180522084058.66520-1-colyli@suse.de>
References: <20180522084058.66520-1-colyli@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2018-05-22 at 16:40 +0800, Coly Li wrote:
> This patch adds MODULE_LICENSE("GPL") to lib/crc64.c to remove a
> compiling
> warninng.

I have no opinion about this. Code has a top description from which it
has been taken / derived, so, I dunno if GPL is what it really is.

In any case it's probably worth to add SPDX header as well. 

> 
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/crc64.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/crc64.c b/lib/crc64.c
> index ed0ffac7b26a..586e46684ee8 100644
> --- a/lib/crc64.c
> +++ b/lib/crc64.c
> @@ -135,3 +135,4 @@ uint64_t crc64(const void *data, size_t len)
>  EXPORT_SYMBOL_GPL(crc64);
>  
>  MODULE_DESCRIPTION("CRC64 calculations");
> +MODULE_LICENSE("GPL");

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
