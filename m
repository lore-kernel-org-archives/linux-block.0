Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4611BC43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 18:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1536F20672
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 18:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="0+l4rs83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbeLSSed (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:34:33 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35946 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbeLSSed (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 13:34:33 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so9835063plo.3
        for <linux-block@vger.kernel.org>; Wed, 19 Dec 2018 10:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NMluk1dSaqOVHHQuIeq1XElkHO19xJV52Y8Bn6Z1Hug=;
        b=0+l4rs835VLEFaZwcKa62ve5kneEGVp731hXUQGMC1aufAjLg8Z+u2D+07RWrQ0SSB
         D0MwJF2bgJE7kZueJYdI8XLWIBvAwoL3GM7UUxF8Yfy37a6xc4TY++8RBQXTDR1SWrKH
         mxtxGr1DwX5AjA0REOE7i02uhZKaKoN7PCfx/OiOSykrpz09KHOob5gvuYgVoIY/8ZeK
         J4WUSsWkNI3O0LZw/GWQrJs+k9/HPh7x36wqQPP09ZsG7MGUDyIVnUm7FjDc4wm0xoHm
         PC4sncGB+ivsIZNaV7py/2rRe4qqArVP9zgHre0kxM/HHZ4x76DOkeA/o1K3juERZR2h
         xn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NMluk1dSaqOVHHQuIeq1XElkHO19xJV52Y8Bn6Z1Hug=;
        b=b9nNkj3IVVs0Ii9ZJ5W5M1CEVsEMoiUypcc1n0U7NsPMe/T7FUP2m8xTVJvtcaADKM
         KJAhM0UhIrYEL7VMwDxtoEm+RBCUa31uaz8Uf5LGm9ojWc8CF3f0+NF0Qc8U8GIyJH9D
         DF7fPrJCIvqox73lBZhfuvP5/1lZtmR+HywXH+ckOFLN/hQfYMyVgA6njFVZH0AkPu6P
         n+a/GH/fWL0Z/NtkjM0AhmtqCe7G8shHEbUo//7vSquZhT26WoxwBJZZot1FyuCrSLzp
         zypvKar5bNFOqZvyXlp9eiScvKNZ2hG0nAH7B5TfSZztv9AjM/bLGxOiDsj+VeO5adBW
         tJJA==
X-Gm-Message-State: AA+aEWYv/h5kt9Vfg1AarPDW11g8so+hHecR/6c7B5NKtS146x0LWahd
        C6oyYVNWwrw6m3oKuBBe1a4FRA==
X-Google-Smtp-Source: AFSGD/U5ADhQyfYegzyDCtylg+iKPd4somQAn/M7F0vuE4Og7a528mBg7pzQlHeimiescqTku2xalg==
X-Received: by 2002:a17:902:4025:: with SMTP id b34mr21520478pld.181.1545244472042;
        Wed, 19 Dec 2018 10:34:32 -0800 (PST)
Received: from vader ([2620:10d:c090:180::1:81e])
        by smtp.gmail.com with ESMTPSA id w5sm23402562pfn.89.2018.12.19.10.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 10:34:31 -0800 (PST)
Date:   Wed, 19 Dec 2018 10:34:30 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        kernel-team@fb.com, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests 1/2] blktests: split out cgroup2 controller and
 file check
Message-ID: <20181219183430.GA11852@vader>
References: <20181212230959.69975-1-dennis@kernel.org>
 <20181212230959.69975-2-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212230959.69975-2-dennis@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 12, 2018 at 06:09:58PM -0500, Dennis Zhou wrote:
> This is a prep patch for a new test that will race blkg association and
> request_queue cleanup. As blkg association is a underlying cgroup io
> controller feature, we need the ability to check if the controller is
> available.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>  common/cgroup | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/common/cgroup b/common/cgroup
> index d445093..3481458 100644
> --- a/common/cgroup
> +++ b/common/cgroup
> @@ -37,19 +37,27 @@ _have_cgroup2()
>  	return 0
>  }
>  
> -_have_cgroup2_controller_file()
> +_have_cgroup2_controller()
>  {
> -	_have_cgroup2 || return 1
> -
>  	local controller="$1"
> -	local file="$2"
> -	local dir
> +
> +	_have_cgroup2 || return 1
>  
>  	dir="$(_cgroup2_base_dir)"
> +
>  	if ! grep -q "$controller" "$dir/cgroup.controllers"; then
>  		SKIP_REASON="no support for $controller cgroup controller; if it is enabled, you may need to boot with cgroup_no_v1=$controller"
>  		return 1
>  	fi
> +}
> +
> +_have_cgroup2_controller_file()
> +{
> +	local controller="$1"
> +	local file="$2"
> +	local dir
> +
> +	_have_cgroup_2_controller "$controller" || return 1

This should be _have_cgroup2_controller. I'll fix it when I apply it.

>  
>  	mkdir "$dir/blktests"
>  	echo "+$controller" > "$dir/cgroup.subtree_control"
> -- 
> 2.17.1
> 
