Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8F0C43334
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 12:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbiGTMqw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 08:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239484AbiGTMqu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 08:46:50 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242D62AE14
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 05:46:49 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bf13so16277618pgb.11
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 05:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=sEGQ7L1KrUZZSjc5lTCBdg4P620qJO0ftLSgZHwILC8=;
        b=rwUDwbnnw3bPn47kNfg7ezqzV/LZChu0a3v2CN0AynDdb4B+/tvtYW8/uAOhGtObcZ
         jdMz1+jCJ13tg2VyNFIzZPhKJMc7Ob2J0tf6XGCs9xkgJA/nrmYYJUXRUHBi0tUDuQmj
         v79GFiy1F8xNZ7qkRqvQzBaOyUzpSCbt2HEHzsViyqik+g6/sisTG7KHot3xgK9bWkbA
         SJQ83R0YkKJ6jYgdD1HuOk/8/NmH1MmCioP9T8sQD3DJRieSUOW7MGmgP6Ej+rLEdg//
         DEOGINokGsTjCA7yDSww75D/W4A1AhfCxEmU4SbMXhlSs0PN5n/iF3nOL2lr+c/vdHve
         w/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=sEGQ7L1KrUZZSjc5lTCBdg4P620qJO0ftLSgZHwILC8=;
        b=PrhI1SlY59Owz7ZBoRwul01OX3Adl87H/hIWuXGOzOwjfy/l6pdCf/sHrqmIARbfik
         oLumYoK8VWn4j/5A4gQQ8l+FfAtklzFzsLArLvxGD9Vi/03lZEBGc/DV0CaXmb4nV+pF
         2wZSRLjLsX11VTRbpQSQwwwtOyiMNUccMQTIXdlfLZZcOTwQ0O42OF7aopvXN2JEhM1d
         8rN3zQnCLxM1UXC3GNmSpS8/j/dGXqYwnCmACldHrdUReQ3gpNtSU7RSQ2o794FUnQUp
         I4OWyTO25R+pyWK6yDJuph9ANicOxlzeCWqDV0XPCjnNNLBvaJpeIeENajHHUOvXMXa6
         FiyQ==
X-Gm-Message-State: AJIora+kb2gA+2ahFdcQ4kZ/eC/dZ5RT5b67Pr1oqAt6T4bS+hpd7tAq
        7QmdiRIqCE1gDBWM3AcDb//wOo6exWW2/w==
X-Google-Smtp-Source: AGRyM1t7wriEhr2mqYC6echsB2BY8+c43mOtwnGP0h8SWWvTQ+c/TMAVrHpPIfdz3GHa7zH8ZeSiww==
X-Received: by 2002:a65:6d98:0:b0:41a:6331:cffe with SMTP id bc24-20020a656d98000000b0041a6331cffemr3365206pgb.297.1658321207565;
        Wed, 20 Jul 2022 05:46:47 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ru7-20020a17090b2bc700b001f219ace0acsm1544392pjb.16.2022.07.20.05.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 05:46:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, hanjinke.666@bytedance.com
Cc:     linux-block@vger.kernel.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220720093616.70584-1-hanjinke.666@bytedance.com>
References: <20220719165313.51887-1-hanjinke.666@bytedance.com> <20220720093616.70584-1-hanjinke.666@bytedance.com>
Subject: Re: [PATCH v4] block: don't allow the same type rq_qos add more than once
Message-Id: <165832120656.248441.6551351074316660910.b4-ty@kernel.dk>
Date:   Wed, 20 Jul 2022 06:46:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 20 Jul 2022 17:36:16 +0800, Jinke Han wrote:
> From: Jinke Han <hanjinke.666@bytedance.com>
> 
> In our test of iocost, we encountered some list add/del corruptions of
> inner_walk list in ioc_timer_fn.
> 
> The reason can be described as follow:
> cpu 0						cpu 1
> ioc_qos_write					ioc_qos_write
> 
> [...]

Applied, thanks!

[1/1] block: don't allow the same type rq_qos add more than once
      commit: 14a6e2eb7df5c7897c15b109cba29ab0c4a791b6

Best regards,
-- 
Jens Axboe


