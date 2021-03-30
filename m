Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3EEC433C1
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 23:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 530ED619CF
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 23:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhC3XaF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232589AbhC3X3v (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 19:29:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC9B3619B9;
        Tue, 30 Mar 2021 23:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617146991;
        bh=pFv56VvafOhxhfjfYu4/MQ1cLcgzzN0jhy6Oq7chMBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNjyX8UgayeJPVIoMPEy/8EHfKuqS25d0xcGMlgoHcWN+gjm4WjdkGfGhgZWI9vdj
         mRuanoNg6CUQM/qlxRYqzpQcEQJJD2qUZbmRENGRJgz5vQvBybljIkYtxwjZgZf+23
         bp3ac/CaXNLuvRoj82swXuPkDPb+dxdVJCc8z3GW02qRmR6lDm6tobNIIkehyA8LKM
         8ixSVtXOoT2q5Vd/1pjgDyUIqud6Tc1bCojrNdKEofkeiDBX6bvi0Lk4Q+sSPBUpyz
         3yvBu+D0zO4t8c7sX+11Co58jJcHoVTs3FuEm4g/WHRz9l8j8vPj6LVnuUzNfzKM5E
         XQvbSWLo5ezhA==
Date:   Tue, 30 Mar 2021 16:29:46 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jian Cai <jiancai@google.com>
Cc:     cjdb@google.com, manojgupta@google.com, llozano@google.com,
        clang-built-linux@googlegroups.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: fix alignment mismatch.
Message-ID: <20210330232946.m5p7426macyjduzm@archlinux-ax161>
References: <20210330230249.709221-1-jiancai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330230249.709221-1-jiancai@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jian,

On Tue, Mar 30, 2021 at 04:02:49PM -0700, Jian Cai wrote:
> This fixes the mismatch of alignments between csd and its use as an
> argument to smp_call_function_single_async, which causes build failure
> when -Walign-mismatch in Clang is used.
> 
> Link:
> http://crrev.com/c/1193732
> 
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Jian Cai <jiancai@google.com>

Thanks for the patch. This is effectively a revert of commit
4ccafe032005 ("block: unalign call_single_data in struct request"),
which I had brought up in this thread:

https://lore.kernel.org/r/20210310182307.zzcbi5w5jrmveld4@archlinux-ax161/

This is obviously a correct fix, I am not just sure what the impact to
'struct request' will be.

Cheers,
Nathan

> ---
>  include/linux/blkdev.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index bc6bc8383b43..3b92330d95ad 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -231,7 +231,7 @@ struct request {
>  	unsigned long deadline;
>  
>  	union {
> -		struct __call_single_data csd;
> +		call_single_data_t csd;
>  		u64 fifo_time;
>  	};
>  
> -- 
> 2.31.0.291.g576ba9dcdaf-goog
> 
