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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B05C07E9B
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 07:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F0F761165
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 07:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhGTGpC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jul 2021 02:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhGTGof (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jul 2021 02:44:35 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648B3C061574;
        Tue, 20 Jul 2021 00:25:13 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id y17so21668111pgf.12;
        Tue, 20 Jul 2021 00:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6JUzViD68gegqNetI6y/wfdESHnVphWZoL6pCq6XpXA=;
        b=Z18XKz2sTPo5nFjVL/hrpIGU1K/u3urwWI2NKSE/7ysBnJQyS4FuA39J2/DiRwzNVY
         pwIEWYxDKfnS+N2znevDC4ZdafFGwKJ7+sDMF3NMuSTrJE0Z0yZk4vpyco619bpZMzce
         7sv7Tt8LmM4RVNib4tHMhku1gT9tqWyxEnlXDiA5S39qp6mmQNPt25tOpWSRQVYYoRoP
         gq1yV9SesEwF3pLf5Ha+CSs0W01FDWsUCp4ebOiWGhcPpA5J3WYZN8hhOcfd/K4++Zvo
         yilRrjwi3XAwlmGVdNYPMbi6AHy/Vl8mA1tdlyfw7Jmhc1umX7P8/6Pr2KinphuZDWj7
         FFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6JUzViD68gegqNetI6y/wfdESHnVphWZoL6pCq6XpXA=;
        b=BpZc4WJByP/HKuTLAHNOJN+TgPQqbTyfr022sdNJfZJGNtguf3vcfb+Q7Mvq3SxW7o
         itddjoQBzYNw07lr9Qnvg6OWt7HzaXv8B0d3GodktcuwmIWNDUoxuc4ww263am/6XGB+
         UewY+idXVoWC+Nei+HsttTDKpSwYQXRAyaquFxQJWdeD5XyDd+OCFs9UuCZ9JxuuD7VO
         A5jAsqYKXVDOOOXf73XREcrEaQEhvYURE4gJABlrP9q+nd3iOfqRBNO79YRAP0LdK77z
         MBg7QQnc+b5hr5rWcKfFe/wmTgRRefNvVrZq5PwdIKQ8AJXUa/uneFtVSTt8iROK1LGt
         K92Q==
X-Gm-Message-State: AOAM530UFo33ZlVaTqtIxcVuhIrfycIQoML33i6KBQTipNwjX9jRe4KE
        Rfbgd4up+ky1sa/A3rc2yVO3JB+lRpZo+PXF
X-Google-Smtp-Source: ABdhPJz+YMOMa0hzD7xkWBOX4U1SKNDvi9xrV2fcZL08Kso6/AXDMUptccfIAPVdNWpPY/lx/umHqw==
X-Received: by 2002:a62:87c6:0:b029:327:8be4:978e with SMTP id i189-20020a6287c60000b02903278be4978emr29765113pfe.50.1626765912887;
        Tue, 20 Jul 2021 00:25:12 -0700 (PDT)
Received: from fedora ([2405:201:6008:6ce2:9fb0:9db:90a4:39e2])
        by smtp.gmail.com with ESMTPSA id u16sm25236201pgh.53.2021.07.20.00.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 00:25:12 -0700 (PDT)
Date:   Tue, 20 Jul 2021 12:55:07 +0530
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     axboe@kernel.dk, hch@infradead.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+cf89d662483d6a1a0790@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] loop: fix setting arbitrarily large block size
Message-ID: <YPZ6U29ci0xjIQ/O@fedora>
References: <20210623050933.140572-1-chouhan.shreyansh630@gmail.com>
 <20210626082406.348821-1-chouhan.shreyansh630@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626082406.348821-1-chouhan.shreyansh630@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Pinging for review since there has been no activity on this
patch for some time.

Thank you,
Shreyansh Chouhan

On Sat, Jun 26, 2021 at 01:54:06PM +0530, Shreyansh Chouhan wrote:
> 
> loop_validate_block_size took an unsigned short argument. Passing an
> argument with size greater than the size of unsigned short would cause
> an overflow and could potentially render the upper bound check on the
> block size useless, allowing to set an arbitrarily large block size.
> 
> Reported-by: syzbot+cf89d662483d6a1a0790@syzkaller.appspotmail.com
> Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
> ---
> 
> Changes from v1: Fixed the spelling of reported-by tag. Fixed the
> commit message.
> 
>  drivers/block/loop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 9a758cf66507..635baff0dd66 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -236,7 +236,7 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
>   * @bsize: size to validate
>   */
>  static int
> -loop_validate_block_size(unsigned short bsize)
> +loop_validate_block_size(unsigned long bsize)
>  {
>  	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
>  		return -EINVAL;
> -- 
> 2.31.1
> 
