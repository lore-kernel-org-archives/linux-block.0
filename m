Return-Path: <linux-block-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34258 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbdFQEJr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Jun 2017 00:09:47 -0400
Date: Sat, 17 Jun 2017 05:09:44 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.com, hch@infradead.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-api@vger.kernel.org, akpm@linux-foundation.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/10] fs: Introduce RWF_NOWAIT and FMODE_AIO_NOWAIT
Message-ID: <20170617040944.GT31671@ZenIV.linux.org.uk>
References: <20170615160002.17233-1-rgoldwyn@suse.de>
 <20170615160002.17233-5-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170615160002.17233-5-rgoldwyn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 15, 2017 at 10:59:56AM -0500, Goldwyn Rodrigues wrote:
>  static inline int kiocb_set_rw_flags(struct kiocb *ki, int flags)
>  {
> -	if (unlikely(flags & ~(RWF_HIPRI | RWF_DSYNC | RWF_SYNC)))
> +	if (unlikely(flags & ~(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT)))

Minor nit: that calls for something like
	if (unlikely(flags & ~RWF_ALL)
>  		return -EOPNOTSUPP;

with corresponding definition.
