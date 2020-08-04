Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876B9C433DF
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 21:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648382075A
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 21:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="NR9wqLbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgHDVNE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgHDVNC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 17:13:02 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81F6C06174A
        for <linux-block@vger.kernel.org>; Tue,  4 Aug 2020 14:13:01 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 17so1036405pfw.9
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2020 14:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YcWRW72y9rn3OaZzk8/kwrQZ9cD8Qzxvl9/btiTdukg=;
        b=NR9wqLbnfmXve+LKbHXITNOiiR8+HAFfbLrcohUPWgkkT+elrtCB5wp844v/ZSNQWY
         lPs8v8yIoOyVj4+hstKaqZnki54yyQQnd2lkK5mmyAGaPanJ1fZQG0QZM3LiM8MxLZYQ
         8jvVOv10a/bN99T8GDfJOJEAhsXJWA+Z5wkzY4vFEXZIMBp9Cng48y5nT/5zEH9lsC84
         l+bHJE5o/k1QxYup6GFy8pcRAIhV/R1E61ejqIvMrBS3XtLZye2Geje97xRDaO5SAqa4
         hib3a0H8tlWOHqF4G8pK4Oq9X4hTw/1lOMBU/U8xd4yJ9h8IeB/jAwdCqxuqQTRWjUUg
         JtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YcWRW72y9rn3OaZzk8/kwrQZ9cD8Qzxvl9/btiTdukg=;
        b=kExmuZ/WQp4S/kIwpSEEGYwmp2gKflh8vFSHca/679BP7YC8b0FrQOMTBNjV369woB
         +3OtR52d3piu1g02kENPUCANTYvKHBKzyLM4RxCkTYFCyavyhTUwpg7etdrZzeVs9OSo
         fm3Uh7JibZShnvSeLo3GPZlXmtOpO3L1CJbpQXqPm0dMstIbk/a3RCrna5yxXTPWB5+H
         h74Fe4gYjANuccx+zQUte7/7EhkjHOqsGYHBcPYDyss1Rqgw2v2U4Zr7I6GAgIf6cVNk
         V8/AP+4KqV77sOB+Gee5UqDDCHIZqpOOoE8nf2KVo7NzgXY8auZV9v3OqnZN6aBG4XBN
         4qng==
X-Gm-Message-State: AOAM530FnVd7aSSlWkCagISd5w6d2A7A2EihoG0qUSpPzioWP07Rao1F
        1klUItGGeSfkjF2sxdxYlWO0QQ==
X-Google-Smtp-Source: ABdhPJz/sMvYitJ8y/TvoDjKavxZRdU2Jdj5l+aG4WixCVjSnumuy0eeXyQ+cT4UtbsmJ9AZh2WFmg==
X-Received: by 2002:a63:201f:: with SMTP id g31mr291715pgg.186.1596575580411;
        Tue, 04 Aug 2020 14:13:00 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:1cba])
        by smtp.gmail.com with ESMTPSA id 144sm13962332pfu.114.2020.08.04.14.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 14:12:58 -0700 (PDT)
Date:   Tue, 4 Aug 2020 14:12:57 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-block@vger.kernel.org, Sebastian.Chlad@suse.com,
        daniel.wagner@suse.com, hare@suse.com
Subject: Re: [PATCH] common/multipath-over-rdma: make block scheduler
 directory optional
Message-ID: <20200804211257.GA8438@vader>
References: <20200729152113.1250-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729152113.1250-1-mcgrof@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 29, 2020 at 03:21:13PM +0000, Luis Chamberlain wrote:
> We currently fail if the following tests if the directory
> /lib/modules/$(uname -r)/kernel/block does not exist. Just make
> this optional. Older distributions won't have this directory.
> 
> srp/001
> srp/002
> srp/013
> srp/014
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  common/multipath-over-rdma | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
> index 676d283..f004124 100644
> --- a/common/multipath-over-rdma
> +++ b/common/multipath-over-rdma
> @@ -696,10 +696,13 @@ setup_test() {
>  
>  	# Load the I/O scheduler kernel modules
>  	(
> -		cd "/lib/modules/$(uname -r)/kernel/block" &&
> -			for m in *.ko; do
> -				[ -e "$m" ] && modprobe "${m%.ko}"
> -			done
> +		KERNEL_BLOCK="/lib/modules/$(uname -r)/kernel/block"
> +		if [ -d $KERNEL_BLOCK ]; then
> +			cd $KERNEL_BLOCK &&

This has a couple of shellcheck errors about unquoted variables. Fixed
those up and applied, thanks.

> +				for m in *.ko; do
> +					[ -e "$m" ] && modprobe "${m%.ko}"
> +				done
> +		fi
>  	)
>  
>  	if [ -d /sys/kernel/debug/dynamic_debug ]; then
> -- 
> 2.27.0
> 
