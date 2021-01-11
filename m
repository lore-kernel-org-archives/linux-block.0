Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE07C433E0
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 05:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F14C225A9
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 05:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbhAKFPQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 00:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbhAKFPP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 00:15:15 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DF7C061786;
        Sun, 10 Jan 2021 21:14:35 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id r9so16576986ioo.7;
        Sun, 10 Jan 2021 21:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y6lvCdEIpkiMVJxjJGOjKpTSuStrIqmoYLqlHURBnTc=;
        b=M0q755SyxkmvlrYPMO4S+to7rGldxMlOyHWTYnI/Ki2C2xjwemOpxnsRPnCTYtSHyt
         2B43OJ28LJ/6PYRF4bkuf1TzEbdA8Y53e75VMQdNcpbi/HfNUXkvZ5qw6kmkumW49wz1
         PPrhmmTD+BHnL1TmHEBkc7/gw0bEuurM8wKEf77Tw3uO1WJ40XiftG6hL+YxV8Hp34Kf
         kiBSRWjpb1n/kcFmB4++HRqaP7it1/Eo81BUMm2VUDG0aFCZ24YTrVOG0xwuPfPVefFm
         J9xiZmCtuQYAtC7aHBwImwNB+0gHhs/9TY/DVnnNb+EErQocs8q8Z+BafBYyAWW5t8lm
         mjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y6lvCdEIpkiMVJxjJGOjKpTSuStrIqmoYLqlHURBnTc=;
        b=l+QMbQLmz9JRVuDytPOkvoZCTKoWbMbylUkvhUCR9H44iStNzLsXFwQDlrbTZpAwi+
         Q6692nm/H8UOxX7Cvw3ETD+b2UySjRr6RQTNVMxPqwv+HB3BQOlMpX6hjpSH5xVdTcrW
         GheLgCLfDvozxXF0O/JI6vSo2yZ43cpgJCKaUOmDTngEnqecT9Cbl75L6SHhYTc6+j5h
         czjRqILdstjIeBYxhlu7Tm5bfv+87CJqqQxEGskvGzpN+YP+2yS6BUfVJ04zwcKAXzKX
         rZ6AJALE7eDrNVDn3082CWAj7UK9G5/C/dCxKX3LZWixm3pWkA7/g3OvJk3FcWTrffr/
         TzDQ==
X-Gm-Message-State: AOAM532jTbUyQLpUOLxBEzQRO8DnqKe3fqpsUbsiNh4CbNy4x5StWh71
        S1q3dVFr0WwBEMh+9g2SFotB4CzEQhw=
X-Google-Smtp-Source: ABdhPJxEjICcUmCd2sM7eoWwbKLNsG0UyXPYNGRf0gCEJFweug4Tf0kfhJTXAevOL0Qr77jy7G0H8w==
X-Received: by 2002:a5e:a916:: with SMTP id c22mr13188457iod.144.1610342074901;
        Sun, 10 Jan 2021 21:14:34 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id p10sm5318659ilg.68.2021.01.10.21.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 21:14:33 -0800 (PST)
Date:   Sun, 10 Jan 2021 22:14:31 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     trix@redhat.com
Cc:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        axboe@kernel.dk, ndesaulniers@google.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] block/rnbd-clt: improve find_or_create_sess() return
 check
Message-ID: <20210111051431.GA4167786@ubuntu-m3-large-x86>
References: <20210110215726.861269-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210110215726.861269-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jan 10, 2021 at 01:57:26PM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis reports this problem
> 
> rnbd-clt.c:1212:11: warning: Branch condition evaluates to a
>   garbage value
>         else if (!first)
>                  ^~~~~~

Ah, is it complaining that the 'if (IS_ERR(sess)) {' section in
find_or_create_sess() does not initialize first even though that will be
caught by the 'if (sess == ERR_PTR(-ENOMEM))' in
find_and_get_or_create_sess() because alloc_sess() only returns an
-ENOMEM error pointer?

> This is triggered in the find_and_get_or_create_sess() call
> because the variable first is not initialized and the
> earlier check is specifically for
> 
> 	if (sess == ERR_PTR(-ENOMEM))
> 
> This is false positive.
> 
> But the if-check can be reduced by initializing first to
> false and then returning if the call to find_or_creat_sess()
> does not set it to true.  When it remains false, either
> sess will be valid or not.  The not case is caught by
> find_and_get_or_create_sess()'s caller rnbd_clt_map_device()
> 
> 	sess = find_and_get_or_create_sess(...);
> 	if (IS_ERR(sess))
> 		return ERR_CAST(sess);
> 
> Since find_and_get_or_create_sess() initializes first to false
> setting it in find_or_create_sess() is not needed.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Every maintainer has their preference for where and how stuff gets
initialized but this makes sense to me. I am not sure the commit above
find_or_create_sess() is needed but again, personal preference.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/block/rnbd/rnbd-clt.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index 96e3f9fe8241..251f747cf10d 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -919,6 +919,7 @@ static struct rnbd_clt_session *__find_and_get_sess(const char *sessname)
>  	return NULL;
>  }
>  
> +/* caller is responsible for initializing 'first' to false */
>  static struct
>  rnbd_clt_session *find_or_create_sess(const char *sessname, bool *first)
>  {
> @@ -934,8 +935,7 @@ rnbd_clt_session *find_or_create_sess(const char *sessname, bool *first)
>  		}
>  		list_add(&sess->list, &sess_list);
>  		*first = true;
> -	} else
> -		*first = false;
> +	}
>  	mutex_unlock(&sess_lock);
>  
>  	return sess;
> @@ -1203,13 +1203,11 @@ find_and_get_or_create_sess(const char *sessname,
>  	struct rnbd_clt_session *sess;
>  	struct rtrs_attrs attrs;
>  	int err;
> -	bool first;
> +	bool first = false;
>  	struct rtrs_clt_ops rtrs_ops;
>  
>  	sess = find_or_create_sess(sessname, &first);
> -	if (sess == ERR_PTR(-ENOMEM))
> -		return ERR_PTR(-ENOMEM);
> -	else if (!first)
> +	if (!first)
>  		return sess;
>  
>  	if (!path_cnt) {
> -- 
> 2.27.0
> 
