Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F53DEE49AE
	for <linux-block@archiver.kernel.org>; Tue, 22 Aug 2023 23:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjHVXcF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Aug 2023 19:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjHVXcE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2023 19:32:04 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CE3CF
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2023 16:32:00 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34ca1aadce9so11206215ab.1
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2023 16:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692747119; x=1693351919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A48iafCxDBmdB76Di4OyxxThhIm7L7khUnw54MyTEFU=;
        b=ksx/HF/f/a2eZMuBu7vZlxniISHSGHTWZ3NhpeJBHu4fdyW+PRX5gax8XJWCaADBsM
         PMXd8DeQH/fGIpGZRMnQQlb9W7Vij+1gzPtZboZSFYaIiFpWV33u+geDoRS5d8OZo/nC
         n0QxnOGtWy6vjJ2jsDeqhk+joftSrpsZpTnbLukYcJHOXavj/8FyBJ5IM6oG7COJbSl9
         Z2GQMdkm2Qe4SqrhLeGmSZBu6STmyFuENp+iwl2DVLccb8xgGVWFFjUbeeULK5r3QPjA
         bXAo/myOLM0rF8zH2t+ZKXzSJYRh5Ncajl+86HDDhJjZOiEdnLRJMcq3jM4ovK/ui/aC
         Nqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692747119; x=1693351919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A48iafCxDBmdB76Di4OyxxThhIm7L7khUnw54MyTEFU=;
        b=HNbDE/Wcnp9MuhHjGIbJo9I6+8/ACuzre3zmuun2LjMNxwccOsLcAbOAmY+NKFY0Xv
         AdgB6zYq9clJEGd0y0GS5chN5zQU5daEJxw7mwkDQc1men458agOXvoMyZiGdpIUj2t3
         R/pcuZi2Wrfm5Wt5Wg1a/wyOoCrxXyqcZf1WDWmNxPbUUNOXcgWqTkybN7SiLiMB89BP
         3HUc3IjTHIDseL+Dqmbc5nxbQSCh3bPZH/LH8SB5YmO3q8tBnMsv3/w70vm/csIaXGKP
         yqFG1PpxBjvS+rWs0Au7ilaE0gul+mmSxm3GGoBb2C+GirhdSvxx25chcgVFLdUEkWCm
         bBHw==
X-Gm-Message-State: AOJu0YzKI1T9v6JOVdna8jdpTCqf8Z96bBbQTLfJBuUHSlhpxX/dYQNA
        mrq5NNrAvUh+e3TX6fLoJQAuow==
X-Google-Smtp-Source: AGHT+IEMzLwkafbmN9QvF2BymaJAsTcu9+7k4JbwNofcXLCDv2c04gQwl3bNbwnBz3PK9ju9DREnEQ==
X-Received: by 2002:a05:6e02:2189:b0:34b:ae9d:9b38 with SMTP id j9-20020a056e02218900b0034bae9d9b38mr1209194ila.30.1692747119508;
        Tue, 22 Aug 2023 16:31:59 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id s6-20020a92c5c6000000b0034b58dd5694sm3478307ilt.15.2023.08.22.16.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 16:31:58 -0700 (PDT)
Date:   Tue, 22 Aug 2023 23:31:56 +0000
From:   Justin Stitt <justinstitt@google.com>
To:     yang.yang29@zte.com.cn
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xu.panda@zte.com.cn,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH linux-next] block: use strscpy() to instead of strncpy()
Message-ID: <20230822233156.54ah7nf56y53astz@google.com>
References: <202212031422587503771@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212031422587503771@zte.com.cn>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Dec 03, 2022 at 02:22:58PM +0800, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
>
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL terminated strings.
>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Cc: linux-hardening@vger.kernel.org

> ---
>  block/partitions/cmdline.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
> index 1af610f0ba8c..c03bc105e575 100644
> --- a/block/partitions/cmdline.c
> +++ b/block/partitions/cmdline.c
> @@ -81,8 +81,7 @@ static int parse_subpart(struct cmdline_subpart **subpart, char *partdef)
>
>  		length = min_t(int, next - partdef,
>  			       sizeof(new_subpart->name) - 1);
> -		strncpy(new_subpart->name, partdef, length);
> -		new_subpart->name[length] = '\0';
> +		strscpy(new_subpart->name, partdef, length);
>
>  		partdef = ++next;
>  	} else
> @@ -140,8 +139,7 @@ static int parse_parts(struct cmdline_parts **parts, const char *bdevdef)
>  	}
>
>  	length = min_t(int, next - bdevdef, sizeof(newparts->name) - 1);
> -	strncpy(newparts->name, bdevdef, length);
> -	newparts->name[length] = '\0';
> +	strscpy(newparts->name, bdevdef, length);
>  	newparts->nr_subparts = 0;
>
>  	next_subpart = &newparts->subpart;
> @@ -153,8 +151,7 @@ static int parse_parts(struct cmdline_parts **parts, const char *bdevdef)
>  		length = (!next) ? (sizeof(buf) - 1) :
>  			min_t(int, next - bdevdef, sizeof(buf) - 1);
>
> -		strncpy(buf, bdevdef, length);
> -		buf[length] = '\0';
> +		strscpy(buf, bdevdef, length);
>
>  		ret = parse_subpart(next_subpart, buf);
>  		if (ret)
> @@ -267,8 +264,7 @@ static int add_part(int slot, struct cmdline_subpart *subpart,
>
>  	label_min = min_t(int, sizeof(info->volname) - 1,
>  			  sizeof(subpart->name));
> -	strncpy(info->volname, subpart->name, label_min);
> -	info->volname[label_min] = '\0';
> +	strscpy(info->volname, subpart->name, label_min);
>
>  	snprintf(tmp, sizeof(tmp), "(%s)", info->volname);
>  	strlcat(state->pp_buf, tmp, PAGE_SIZE);
> --
> 2.15.2
