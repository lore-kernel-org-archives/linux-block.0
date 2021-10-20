Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B16C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 21:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A5896112D
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 21:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhJTVm2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 17:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJTVm1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 17:42:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9596BC06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 14:40:12 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 186-20020a1c01c3000000b0030d8315b593so4102701wmb.5
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 14:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UpO309fXSTwzkl8qrqu4bmFEIolqDPkiRMPsPMvUs/g=;
        b=Vdknqqlvi/V//e5LmUDUctrenJWpu35jzIb585mzbN0VKAN/dd9lYwAsyjryxaovKd
         ROq0pIPOis8ismCe4lYDyxWdF19gCY6/1qeSdhgspunj7TLz8Rdpkcgprdb+tO8JYpyH
         /VoJFVGyvkIjR0EPFy9qhn6RP7A8bQhqpSx450bwyuhOEq0tvke89ruPLlIDtyc5lrJ4
         ZZ7RZMCn8F/ZsR+GZ6PwXsxsaHuSHGeptvEVNNE0V9W29L4pTaxdhU0BZwPxd9cxBUyq
         h+O8EoUiIWHXB/TS1yFWrPiYIGZNMvRW/MiRfNpT9xcORrVNxMjctAx/YNnJm6LK9Cfq
         9gFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UpO309fXSTwzkl8qrqu4bmFEIolqDPkiRMPsPMvUs/g=;
        b=OozApyaeThZqWEM1mH067uL2kNug2+wGzOFwi1MWDOoXCScocMmjeQQM3XJZusMbvu
         k+oh9jHlTJYNelwp5w8hU6Cm7v7al6Xeo9TtkGWKDPev4v53USKpWDmkcTfdJY/OUIkz
         7Eydr9vyJrRuXT2SUPIsGB0709N/V+KIieX8wTr6/Na9CF3r0P9JHDhDVis0rcrR7gdW
         nsII1NVgyc1YIyuBPckInpkvrHYaPRItexEy7UOAza7MbdN4yuOx6xE8uIxdfMdnCAel
         zceey8iBGppAq802WqbcYloTvn46plA9pdn3lQ76WRljxqSjrVmaWTuiUBITpwBqb3ut
         LSrw==
X-Gm-Message-State: AOAM530RcsAOpIGriCbVUp6TM6zIFw+lLBx6K3wrqQEdMVkB8LpDVYpo
        XUvfNfxm1WTofWRZ/xYtIm0MHw==
X-Google-Smtp-Source: ABdhPJyo6dTi7KwZD7qbuLqJ93CISs0jumsLwJHekArXhPozO4/UP+twpLVK8rCaX/OeUsUGfJU1+A==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr16820132wmh.57.1634766011143;
        Wed, 20 Oct 2021 14:40:11 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id f3sm5867731wmb.12.2021.10.20.14.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:40:10 -0700 (PDT)
Date:   Wed, 20 Oct 2021 22:40:08 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     luo penghao <cgel.zte@gmail.com>
Cc:     linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, linux-block@vger.kernel.org
Subject: Re: [PATCH linux-next] cdrom: Remove redundant variable and its
 assignment.
Message-ID: <YXCMuDrt0hG1HDXo@equinox>
References: <20211020024229.1036219-1-luo.penghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020024229.1036219-1-luo.penghao@zte.com.cn>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 20, 2021 at 02:42:29AM +0000, luo penghao wrote:
> Variable is not used in functions, and its assignment is redundant too.
> So it should be deleted. Also the inner-most set of parentheses is no
> longer needed.
> 
> The clang_analyzer complains as follows:
> 
> drivers/cdrom/cdrom.c:877: warning:
> 
> Although the value stored to 'ret' is used in the enclosing expression,
> the value is never actually read from 'ret'.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
> ---
>  drivers/cdrom/cdrom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index feb827e..40970b8 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -864,7 +864,7 @@ static void cdrom_mmc3_profile(struct cdrom_device_info *cdi)
>  {
>  	struct packet_command cgc;
>  	char buffer[32];
> -	int ret, mmc3_profile;
> +	int mmc3_profile;
>  
>  	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
>  
> @@ -874,7 +874,7 @@ static void cdrom_mmc3_profile(struct cdrom_device_info *cdi)
>  	cgc.cmd[8] = sizeof(buffer);		/* Allocation Length */
>  	cgc.quiet = 1;
>  
> -	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
> +	if (cdi->ops->generic_packet(cdi, &cgc))
>  		mmc3_profile = 0xffff;
>  	else
>  		mmc3_profile = (buffer[6] << 8) | buffer[7];
> -- 
> 2.15.2
> 
> 

Looks good. I will send through to Jens Axboe in the morning (UK time),
as we are at rc6 now so merge window will be open shortly I'd imagine.
Many thanks for your contribution.

Regards,
Phil
