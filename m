Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34EBC433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 14:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbiBOOws (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 09:52:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbiBOOwG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 09:52:06 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16276E2B1
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 06:51:29 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so3055606pjv.5
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 06:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=EErPPWuRJox9e1Yjv9hCXSvzhR0fF+n4TpbJdh/Uqp8=;
        b=vMghHipKm6JYlMnk3ZspYTFv1eauTMM5RPt/aQgZIS4JLMvmOZwmW6VQUpM7KviVJq
         yJnO4BOvvZz7gvCu8YSYvTIc+dgcZcaf65QizoGkqKOTmUtv3hl/dce/yCWL2NB9zFoD
         pMWuCz7GlirfgDynLXDtVuz6HYlwV98nRPJfrFmkGr11m8KAcqhz0cyvaj37Hnnd1Q/D
         47NS6EmzSZHd55on7zYWrUUc2siqSu8kT1i7L0iIWXwcl9QLwdiw3oHqTpQ/SkNEilFQ
         b5lc+r+QMLTFHvEC02GrBnDLc4RO/+ENTVNjuBgXp3vr4ml6S4DJd54JE8gVO6m9ndOH
         dqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=EErPPWuRJox9e1Yjv9hCXSvzhR0fF+n4TpbJdh/Uqp8=;
        b=QqFpe8P4Hxmjaz6ONOsQw6Jl7GjeJYlL8YFIda5LK9eBcvB8kIkQJncABfC4Q0dYb3
         2EPVOfCL0QC6zUs49XPnmObxNrFyPXJvNW0R3eAtmAEnjguQTMEYtZvv+jCyEl9uWakc
         ++mPQeT8XB7UHlyqi++IPOXXXdFBQvbMolbxVHZh08oQY1VyfHi+F/h9AvpKOPPfxnzx
         L5gWZYJ9l1nSm20xVTiFwgEqpD2sbU1iVjo10o3gC3NaAR3Nah3YOLMKRylpvj8QrJzO
         1nPA5Qs+MzG2SNz9E56MS82PvOv+TWtqwzuHiBeMdvPvoVvNiYM1/BG2U0k02e10ZK2G
         Ktfg==
X-Gm-Message-State: AOAM532iilJgrF3uubw20HRqK+iqGz7YQgyo6PYcR5k+8FQc/S7EIjS2
        NE1dOrZ0It+PX0rZ1fjbh/g/9g==
X-Google-Smtp-Source: ABdhPJwajT8nyQqkQRns5JT3ZnySQ8fbq1+IqjrW4R2P06KzkHFd8XWjZ4ogCafoj4Y+OxTsI7xJlg==
X-Received: by 2002:a17:902:9307:: with SMTP id bc7mr4491466plb.140.1644936689376;
        Tue, 15 Feb 2022 06:51:29 -0800 (PST)
Received: from [192.168.1.116] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id il14sm3141053pjb.18.2022.02.15.06.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 06:51:28 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
Cc:     damien.lemoal@wdc.com, jiangguoqing@kylinos.cn,
        shinichiro.kawasaki@wdc.com, ming.lei@redhat.com,
        mgurtovoy@nvidia.com, colin.king@intel.com
In-Reply-To: <20220215115951.15945-1-kch@nvidia.com>
References: <20220215115951.15945-1-kch@nvidia.com>
Subject: Re: [PATCH] null_blk: fix return value from null_add_dev()
Message-Id: <164493668645.128202.1898679225604775091.b4-ty@kernel.dk>
Date:   Tue, 15 Feb 2022 07:51:26 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 15 Feb 2022 03:59:51 -0800, Chaitanya Kulkarni wrote:
> The function nullb_device_power_store() returns -ENOMEM when
> null_add_dev() fails. null_add_dev() can fail with return value
> other than -ENOMEM such as -EINVAL when Zoned Block Device option
> is used, see :
> 
> nullb_device_power_store()
>  null_add_dev()
>   null_init_zoned_dev()
> 	return -EINVAL;
> 
> [...]

Applied, thanks!

[1/1] null_blk: fix return value from null_add_dev()
      (no commit info)

Best regards,
-- 
Jens Axboe


