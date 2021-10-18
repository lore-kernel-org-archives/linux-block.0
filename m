Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E91C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 23:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C9DD60F9D
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 23:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhJRXcD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 19:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJRXcC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 19:32:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E377DC06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 16:29:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e12so44227353wra.4
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 16:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=q2HqoAznjZz6Gt/PPPdORC0kvm0GuUIVTKfy6U+h6fw=;
        b=OiaeXwwgRkPHwFwf3hurVsuxhC+WgdaX4nGx9JjkPPFKlxGo/WB/A9lwrfd6yELoMa
         gFQyKaigAKjQYDTG6mMGD4hq0hqKswisLev1zvXqxA7R36ktSlK9MD5KGpt/cJAzRAMa
         b6RotCkjz7injUtTDKznVxT+vVln2C9YLJXLKDWIi+De2nyjMFP4r6xyax8Ehv+fG+hb
         iCAqvy9n/nE9sXxSI4YGtL56E76+iefkX4VytwHSxCTLc6Cda77pe6FWUw3rnnqqJTeH
         6240gKKXkvA9Y8GR0KHoVNzn+r0AgVurneW6e8mUhD498CE6wIUztVtnZ6z8xkAYD2zS
         OCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=q2HqoAznjZz6Gt/PPPdORC0kvm0GuUIVTKfy6U+h6fw=;
        b=LOTY9p+Yvrda33Ix1os+jO6Xv7YqBJiduG/Mq/qBlVblo/OLlf/lBIu74hyR11/wua
         bVHg317z70H1bkCng4vbAIux3CiSevl0wGKREfVnIPC1fEGFbx3hqnbAZtiI7HD4BHvS
         TDQIyLzgInbslhuJ02fmOJXJd2Qw7fbp9zXbq50LEy8nmroqKcpYWVlAKSFGMvnTTu/o
         5T/gUD9ajN0Z70dbzZgjtb/hjxm+Du3a8jPZZGetzrxlbsKp6G2u/OD8YuewLwGbRR+Y
         ARJvImV5nT1MxCRMNAPFblM1uaxQr9EwxN/KFrj54soxdAyJZEUvgCXs6IVGYGlaQnad
         PxZg==
X-Gm-Message-State: AOAM530Zxv/ybIpNU8O/JuqUQX22i9HqXhqiM+F5OQ/MLEHJHH7tCqzS
        poX0Z6sDZUJ/GMr04XmBSA0eMg==
X-Google-Smtp-Source: ABdhPJykyuN14JObwI2jP0AhXr3otAMVC8QKNGsov1lkfYScg+E0miAz4pkPnlEZ/2rCvQ8u04Jh3g==
X-Received: by 2002:adf:a415:: with SMTP id d21mr41045431wra.236.1634599789549;
        Mon, 18 Oct 2021 16:29:49 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id f10sm253306wri.84.2021.10.18.16.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 16:29:48 -0700 (PDT)
Date:   Tue, 19 Oct 2021 00:29:46 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     luo penghao <cgel.zte@gmail.com>
Cc:     linux-kernel@vger.kernel.org, penghao luo <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, linux-block@vger.kernel.org
Subject: Re: [PATCH linux-next] cdrom: Remove redundant variable and its
 assignment.
Message-ID: <YW4C4A5S+mjHzKN2@KernelVM>
References: <20211018090834.856992-1-luo.penghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211018090834.856992-1-luo.penghao@zte.com.cn>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 18, 2021 at 09:08:34AM +0000, luo penghao wrote:
> From: penghao luo <luo.penghao@zte.com.cn>
> 
> Variable is not used in functions, and its assignment is redundant too.
> So it should be deleted.
> 
> The clang_analyzer complains as follows:
> 
> drivers/cdrom/cdrom.c:877: warning:
> 
> Although the value stored to 'ret' is used in the enclosing expression,
> the value is never actually read from 'retâ€™.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: penghao luo <luo.penghao@zte.com.cn>
> ---

Dear Penghao,

Thank you for the patch, looks good, but please could I ask for a small
tweak:

>  drivers/cdrom/cdrom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 89a6845..393acf4 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -871,7 +871,7 @@ static void cdrom_mmc3_profile(struct cdrom_device_info *cdi)
>  {
>  	struct packet_command cgc;
>  	char buffer[32];
> -	int ret, mmc3_profile;
> +	int mmc3_profile;
>  
>  	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);
>  
> @@ -881,7 +881,7 @@ static void cdrom_mmc3_profile(struct cdrom_device_info *cdi)
>  	cgc.cmd[8] = sizeof(buffer);		/* Allocation Length */
>  	cgc.quiet = 1;
>  
> -	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
> +	if ((cdi->ops->generic_packet(cdi, &cgc)))

We no longer need the inner-most set of parentheses now, as we are
checking the result of the expression:
cdi->ops->generic_packet(cdi, &cgc)

rather than the result of the assignment expression:
(ret = cdi->ops->generic_packet(cdi, &cgc))

Please resubmit with this change and I'd be happy to approve the patch.
Many thanks.

Regards,
Phil
