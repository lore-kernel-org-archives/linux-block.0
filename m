Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:50002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbdFPGFN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2017 02:05:13 -0400
Date: Thu, 15 Jun 2017 23:04:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        viro@zeniv.linux.org.uk
Subject: Re: RFC: pwritev2 regression test for invalid flags
Message-ID: <20170616060459.GA5472@infradead.org>
References: <a5987ece-5351-346b-21fd-5a3e0092229e@linaro.org>
 <43631a74-8934-6940-3eaa-e562e49c5cb2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43631a74-8934-6940-3eaa-e562e49c5cb2@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 01, 2017 at 11:52:25AM -0600, Jon Derrick wrote:
> Can you apply the patch below to your kernel?

I've already sent this patch to Al twice (including a stable tag),
but it didn't seem to make it anywhere.

> diff --git a/fs/read_write.c b/fs/read_write.c
> index c4f88af..f77eb22 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1210,7 +1210,7 @@ static size_t compat_writev(struct file *file,
>         if (!(file->f_mode & FMODE_CAN_WRITE))
>                 goto out;
> 
> -       ret = compat_do_readv_writev(WRITE, file, vec, vlen, pos, 0);
> +       ret = compat_do_readv_writev(WRITE, file, vec, vlen, pos, flags);
> 
>  out:
>         if (ret > 0)
---end quoted text---
