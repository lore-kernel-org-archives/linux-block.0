Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E045C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8002083D
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="nDm/dgy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfCYQT3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:19:29 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36248 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729182AbfCYQT3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 12:19:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2B2338EE0E0;
        Mon, 25 Mar 2019 09:19:28 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YaSfB_YKKZQI; Mon, 25 Mar 2019 09:19:27 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 496488EE0DF;
        Mon, 25 Mar 2019 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1553530767;
        bh=+3uWbRb3VNNt1gddenhaoH9K4l+ztpTwtY1m4yMYWjA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nDm/dgy8L5tykk8qxInC6Zx9Z56uXaCSkypB44YG8n9FRgXEi/91oKe9zo0VByP1L
         Jm6fLzWFykZqsAxsIty2vpk9tPDi2GbFD3AEnQRwMMjV98WIhJARtmeuN+vGgHa9XX
         Etz+mJ/1dt1OpIWCFEGBwS0QAnLYNxDuW9MMye/I=
Message-ID: <1553530766.2955.51.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/2] io_uring: fix big-endian compat signal mask handling
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Hannes Reinecke <hare@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 25 Mar 2019 09:19:26 -0700
In-Reply-To: <20190325143521.34928-1-arnd@arndb.de>
References: <20190325143521.34928-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-03-25 at 15:34 +0100, Arnd Bergmann wrote:
> On big-endian architectures, the signal masks are differnet
> between 32-bit and 64-bit tasks, so we have to use a different
> function for reading them from user space.
> 
> io_cqring_wait() initially got this wrong, and always interprets
> this as a native structure. This is ok on x86 and most arm64,
> but not on s390, ppc64be, mips64be, sparc64 and parisc.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/io_uring.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 6aaa30580a2b..8f48d29abf76 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -1968,7 +1968,15 @@ static int io_cqring_wait(struct io_ring_ctx
> *ctx, int min_events,
>  		return 0;
>  
>  	if (sig) {
> -		ret = set_user_sigmask(sig, &ksigmask, &sigsaved,
> sigsz);
> +#ifdef CONFIG_COMPAT
> +		if (in_compat_syscall())
> +			ret = set_compat_user_sigmask((const
> compat_sigset_t __user *)sig,
> +						      &ksigmask,
> &sigsaved, sigsz);
> +		else
> +#endif

This looks a bit suboptimal: shouldn't in_compat_syscall() be hard
coded to return 0 if CONFIG_COMPAT isn't defined?  That way the
compiler can do the correct optimization and we don't have to litter
#ifdefs and worry about undefined variables and other things.

James

