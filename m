Return-Path: <SRS0=+z0d=5F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A2CC4332B
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 20:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A572072C
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 20:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="O4b9x+wm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCTUQx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:16:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41828 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTUQx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Mar 2020 16:16:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id z65so3852589pfz.8
        for <linux-block@vger.kernel.org>; Fri, 20 Mar 2020 13:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jVvsjqfQjiB8U330KJsXKUrRnnY4vMTYnFfHrDtkn9g=;
        b=O4b9x+wmBDtfxMp22Rcduc1YaiOLES1L5oDturFOMMf0LQfTrzDWTLI08DEWVusPB8
         Yx/mKpAXhdmQ02XIzrnzpKLgGg0wghCDl2GhXQfMnwGT6ZQXOPiEvma6zh0kOLwJRqLu
         3fFDBocGuCr5IoCv0Ehppas0caCtZQMebfGEZQnroFmjAC9MGv6ry23wedQN+9V8c733
         4gxTKes25D4t3FqXpe6mKB6AOMdpT0L9kQYcPK9VmxWLjpOvhrR8UfVdfbBzGOHxYO8t
         o3WpPU+VnaviOCsnb9UPyO0aFKs2lMl4HY8ssKFFYMP2eKJawjzDB6HklCZTecmFv8J+
         t70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jVvsjqfQjiB8U330KJsXKUrRnnY4vMTYnFfHrDtkn9g=;
        b=g570ayr2DFx97FBAOR/7984T85xW2hzPW9fpX4SZlpME4H+vp6To+BmhOzaSt/iH7K
         Fd/KH6SiENfpaTf6zDlVsU4OxYTug5cu2sMpwDqjzqDVmeMW9qJ1pCwjogt0ymq+dVp/
         kznN7mba4EISwyLrzCGcSh86ZeilyJ6lb/nXaA7AxHqDmNUWMek7a6/ht96MRLHjcQHN
         r27bnUJSDxVadzhjRsKPW70b/2pGEOGwafecLIJBdYeAwPXOYqXdMK1zDdwm7D2xpALJ
         m1AhRuq1ccozzFFdrKsQQR3mr6PRsiERzHVxYIG6l6wZJfVS6kC8D7neHegqoYiuHtlY
         g8bQ==
X-Gm-Message-State: ANhLgQ3iLy59LUeYmxC0q7MYNDWFKJxHcLftt+KiEanHuANcCY+Gd+gR
        LNMJ/AZh7Q+S5wsh9vCurw0r+Q==
X-Google-Smtp-Source: ADFU+vsPy7ik1YsefiBUgKDlBDLpOb5EFQvLhfcChgc7BNp7kHaP+veqpfBL/e7hplocb9hQe83aow==
X-Received: by 2002:a63:2cce:: with SMTP id s197mr10650878pgs.184.1584735410643;
        Fri, 20 Mar 2020 13:16:50 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:c783])
        by smtp.gmail.com with ESMTPSA id o33sm5449775pje.19.2020.03.20.13.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 13:16:50 -0700 (PDT)
Date:   Fri, 20 Mar 2020 13:16:48 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH blktests v2 3/4] Introduce the function
 _configure_null_blk()
Message-ID: <20200320201648.GC32817@vader>
References: <20200315221320.613-1-bvanassche@acm.org>
 <20200315221320.613-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315221320.613-4-bvanassche@acm.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 15, 2020 at 03:13:19PM -0700, Bart Van Assche wrote:
> Introduce a function for creating a null_blk device instance through
> configfs.
> 
> Suggested-by: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  common/multipath-over-rdma | 17 +++++------------
>  common/null_blk            | 14 ++++++++++++++
>  tests/block/029            | 16 ++--------------
>  3 files changed, 21 insertions(+), 26 deletions(-)
> 
> diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
> index a56e7a8269db..7e610a0ccbbb 100644
> --- a/common/multipath-over-rdma
> +++ b/common/multipath-over-rdma
> @@ -620,18 +620,11 @@ run_fio() {
>  configure_null_blk() {
>  	local i
>  
> -	(
> -		cd /sys/kernel/config/nullb || return $?
> -		for i in nullb0 nullb1; do (
> -			{ mkdir -p $i &&
> -				  cd $i &&
> -				  echo 0 > completion_nsec &&
> -				  echo 512 > blocksize &&
> -				  echo $((ramdisk_size>>20)) > size &&
> -				  echo 1 > memory_backed &&
> -				  echo 1 > power; } || exit $?
> -		) done
> -	)
> +	for i in nullb0 nullb1; do
> +		_configure_null_blk nullb$i completion_nsec=0 blocksize=512 \
> +				    size=$((ramdisk_size>>20)) memory_backed=1 \
> +				    power=1 || return $?
> +	done
>  	ls -l /dev/nullb* &>>"$FULL"
>  }
>  
> diff --git a/common/null_blk b/common/null_blk
> index 6a5f99aaae9d..3c31db1ed4ac 100644
> --- a/common/null_blk
> +++ b/common/null_blk
> @@ -28,6 +28,20 @@ _init_null_blk() {
>  	return 0
>  }
>  
> +# Configure one null_blk instance with name $1 and parameters $2..${$#}.
> +_configure_null_blk() {
> +	local nullb=/sys/kernel/config/nullb/$1 param val
> +
> +	shift
> +	mkdir "$nullb" &&

Just make this mkdir "$nullb" || return $?

> +		while [ -n "$1" ]; do

The intention is clearer with while [[ $# > 0 ]]

> +			param="${1//=*}"
> +			val="${1#${param}=}"

These are all arcane bash incantations, but the following seem slighly
clearer to me:

param="${1%%=*}"
val="${1#*=}"

I.e., for param we remove the equal sign and everything after it, and
for val we remove everything up to the equal sign.

> +			shift
> +			echo "$val" > "$nullb/$param" || return $?
> +		done
> +}
> +
