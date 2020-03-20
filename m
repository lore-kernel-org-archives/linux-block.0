Return-Path: <SRS0=+z0d=5F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E5EC4332D
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 20:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4474C20409
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 20:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="fsv3bV6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgCTUEb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:04:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45994 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgCTUEb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Mar 2020 16:04:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id j10so3831415pfi.12
        for <linux-block@vger.kernel.org>; Fri, 20 Mar 2020 13:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2PfZNQdcCrRJCc1NY91xXMxcopNTo0ey1k+HCFLVmzQ=;
        b=fsv3bV6xwQ874+HoQtH0zyCeZVfCh/Eht3xha5muEabKqzYFeGskhS4FEUM2UIsfgY
         Ty3mI23odoRpKXsXU3ZZ3ovfPtw8GwKYa6sHBx/l1nvtBfAZcGTQhekyvhWReYs9OkME
         N+78gbOyk7y0IOTXxdpzcN1cBDTB5+GzoviZNFBNxrKn8GgZUEPIJtH44LJ2Y8+SqlMR
         Idp7yVv2oWBuT/tKY6JxNKfF6Iojn1l0fGB3PSHcquTjjK5hmfUDQDoslh6vPusYAbqz
         +AO30ORl2/3vniacfERa6zr4PfdNE0AQxZC2mXraIlwZqDSk1LF5j00E4ePL/RqEPDyb
         BKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2PfZNQdcCrRJCc1NY91xXMxcopNTo0ey1k+HCFLVmzQ=;
        b=CMYp8efaB2ek8saXxr5ryLQnMz8IkxfS3XxXNehGM0SeMtqE3m7nw0z+EgqYlkxY/X
         2u0W4s32boUC7KsqF7sZt0MB1/cYBoVdNfHXuEXMd+azT063DVPQa+Wh20viVBLZdhup
         Wf0b4iE7nVddrtXTZldPZjG5P4lnfIvxdsJJBik1/cFL34iCZenOZTYq2poeyz6BLs7j
         du3FbBWPtyVkW0rTAGP3uvvCSAJ90ghMeUs9BkLtSgPgMZRqs5lu666/KmdH3Q5DMLY3
         gqnBCbA9/UfsDseO+GqQyfSz9A7i6D1JoRR8PN/hdvVyLFYde4d/YHHIYTn6ec0lDia/
         nNdw==
X-Gm-Message-State: ANhLgQ0QgL+pGQSekwAysFvAWSr3oS8JLFlFvRgdH3jq+jHDBa74oQKP
        wNLNapyw8jTc1qi7FVZ1dunVcQ==
X-Google-Smtp-Source: ADFU+vtzOn3uSW+IHv+wVFpw8FfrlZyOsl5h/uQoMrFO0GjTD/YWjtp8xc0AyVvOEuPioVCWdcgLHQ==
X-Received: by 2002:a63:e70d:: with SMTP id b13mr10236950pgi.8.1584734668314;
        Fri, 20 Mar 2020 13:04:28 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:c783])
        by smtp.gmail.com with ESMTPSA id o15sm10387pjp.41.2020.03.20.13.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 13:04:27 -0700 (PDT)
Date:   Fri, 20 Mar 2020 13:04:26 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH blktests v2 1/4] Make _exit_null_blk remove all null_blk
 device instances
Message-ID: <20200320200426.GB32817@vader>
References: <20200315221320.613-1-bvanassche@acm.org>
 <20200315221320.613-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315221320.613-2-bvanassche@acm.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 15, 2020 at 03:13:17PM -0700, Bart Van Assche wrote:
> Instead of making every test remove null_blk device instances before calling
> _exit_null_blk(), move the null_blk device instance removal code into
> _exit_null_blk().
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  common/null_blk | 12 ++++++++----
>  tests/block/022 |  3 ---
>  tests/block/029 |  1 -
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/common/null_blk b/common/null_blk
> index 2e300c20bbc7..6a5f99aaae9d 100644
> --- a/common/null_blk
> +++ b/common/null_blk
> @@ -8,11 +8,14 @@ _have_null_blk() {
>  	_have_modules null_blk
>  }
>  
> +_remove_null_blk_devices() {
> +	local d
> +
> +	for d in /sys/kernel/config/nullb/*; do [ -d "$d" ] && rmdir "$d"; done

I'd prefer to keep the deletion code using find from _init_null_blk.

> +}
> +
>  _init_null_blk() {
> -	if [[ -d /sys/kernel/config/nullb ]]; then
> -		find /sys/kernel/config/nullb -mindepth 1 -maxdepth 1 \
> -		     -type d -delete
> -	fi
> +	_remove_null_blk_devices
>  
>  	local zoned=""
>  	if (( RUN_FOR_ZONED )); then zoned="zoned=1"; fi
> @@ -27,5 +30,6 @@ _init_null_blk() {
>  
>  _exit_null_blk() {
>  	udevadm settle
> +	_remove_null_blk_devices

This needs to happen before the udevadm settle.
