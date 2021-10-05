Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C74C433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 19:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5DFE6141B
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 19:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbhJEUBU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Oct 2021 16:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbhJEUBU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Oct 2021 16:01:20 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F11C06174E
        for <linux-block@vger.kernel.org>; Tue,  5 Oct 2021 12:59:29 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id a73so423135pge.0
        for <linux-block@vger.kernel.org>; Tue, 05 Oct 2021 12:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BLskmJGo49ZaTs/IEwf4eelOY6LUBobTHpbH6xAX+XU=;
        b=C4oz6O22VwbnCqeRwIEzTyWG4IJlAggJctWXP59hSluxvHEkhwFYAAPxg1l2UNqpxF
         38kkSkTr5PDSeErTWpzs5MbF9PswqncYXBaid/dxnMcz+kzIN6EBQlKGfI2DlXNk1tMe
         Cb6VqRU8XlsDiW2tphrLc4oKWMb2XjuQRjPdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BLskmJGo49ZaTs/IEwf4eelOY6LUBobTHpbH6xAX+XU=;
        b=T73nN6tyg475EUDh8gk2V1PgJRhi21g9KfztbWVI18FPGsWvtPPA0CfrV8/DU+zsyd
         /VTuxDHDWqh1eFuBH+gFyo+KML3dmJ7Rhws80QxkolCoVxvOHozjDodq14g0ZeRoB4bU
         GipmfQE+7qrPS1K6nHBb3Jo4Bh0vS2P4Ed7aBoflPJf06LMMFdAWeLSB78VCMn47zK6W
         gRJdb6jrifrkE8iRTjWlADHDKqwFZLKJok2jx0m7U7XCr4X+3i0zMOgeFxgHFVfE+DPp
         VMqGe4eoSFvmxauppTwOVogsWCLhJz2gIN+aSMVoWad+9iaWTIjx6Mj+iJU8rYPCf1NW
         H2tA==
X-Gm-Message-State: AOAM532mahvfTs9R6B3eGSU5ua1ijn2xU9aevVbWXTmk+AkOt1Dard8I
        s3FqWscvkugMEeRie+EPlEQgPg==
X-Google-Smtp-Source: ABdhPJwdgsDyx3NnPDfhmE8VO584mG7R66yp0PUsB2CyUiSP+UhWnJZHpKQTQjAnxYVzb5C9o3n37w==
X-Received: by 2002:a62:5297:0:b0:3f4:263a:b078 with SMTP id g145-20020a625297000000b003f4263ab078mr32448286pfb.20.1633463968778;
        Tue, 05 Oct 2021 12:59:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k13sm8757894pfc.197.2021.10.05.12.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 12:59:28 -0700 (PDT)
Date:   Tue, 5 Oct 2021 12:59:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 07/12] fs/kernfs/symlink.c: replace S_IRWXUGO with
 0777 on kernfs_create_link()
Message-ID: <202110051259.8DE82F3@keescook>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-8-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927163805.808907-8-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 27, 2021 at 09:38:00AM -0700, Luis Chamberlain wrote:
> If one ends up extending this line checkpatch will complain about the
> use of S_IRWXUGO suggesting it is not preferred and that 0777
> should be used instead. Take the tip from checkpatch and do that
> change before we do our subsequent changes.
> 
> This makes no functional changes.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  fs/kernfs/symlink.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
> index c8f8e41b8411..19a6c71c6ff5 100644
> --- a/fs/kernfs/symlink.c
> +++ b/fs/kernfs/symlink.c
> @@ -36,8 +36,7 @@ struct kernfs_node *kernfs_create_link(struct kernfs_node *parent,
>  		gid = target->iattr->ia_gid;
>  	}
>  
> -	kn = kernfs_new_node(parent, name, S_IFLNK|S_IRWXUGO, uid, gid,
> -			     KERNFS_LINK);
> +	kn = kernfs_new_node(parent, name, S_IFLNK|0777, uid, gid, KERNFS_LINK);
>  	if (!kn)
>  		return ERR_PTR(-ENOMEM);
>  
> -- 
> 2.30.2
> 

-- 
Kees Cook
