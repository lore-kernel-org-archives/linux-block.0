Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B43C001B2
	for <linux-block@archiver.kernel.org>; Wed, 14 Dec 2022 16:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239191AbiLNQ5F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Dec 2022 11:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239199AbiLNQ47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Dec 2022 11:56:59 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B483429CA2
        for <linux-block@vger.kernel.org>; Wed, 14 Dec 2022 08:56:58 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id q190so3699385iod.10
        for <linux-block@vger.kernel.org>; Wed, 14 Dec 2022 08:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ju0SN0CEVcplXYOw1X7EyarT02yn23kHgLqVSbDEE4=;
        b=QhWtChl13fEjzn+c7stogJNanm2k7IHx55x+oP67ZKqO6ImEwYdM+5fiS9G+uqiooE
         a1/ZHEP9J+4tgZZZNRYS2+lcbPgkq2Jfcdz0vFEDOM36QIQUIlzMj1qza+w6pOueO7n3
         tZZJeS227c7o6UQSCclnUN28FezhrZrlkv/Yj+TtnCSJfgWNZTjRKZbvTAIdi4/kHL84
         5oWKCJHAD34g81IWBxv7KeV1EE/JMQ0Lkk9R40PZIrUcx+b4TtXyuw5IU4wTgLw/1IHG
         gg5CCs44vTq7EwWicegB+poRTotw8JsjL13C/6+Sly36aZVJMT5gNJmRBpsYzYxeDF5l
         3pOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ju0SN0CEVcplXYOw1X7EyarT02yn23kHgLqVSbDEE4=;
        b=FqXm9AKA6IZCPl4nOnKBTHSNhs+HZL18fXqhhrSUlsvaFSbABaznYt9U+SgVzvy7Nr
         jsOqdZJNTg2TBv8MuabdkeMVybgsLaoDr6yaUiJMFxE3AQAuVdJrntW42MBVaWTjTulF
         eFIZ/q+A1lNKPu9O3ijf1MtefywbwtBCVMN0X9OLaS6qUu602s8pQFcmiJ9kx5MF1g1u
         4YLMI+00W8+jOyIELizQXSD3Mems1kzyaQ28sHs0uaQvSR6Nh8zYnFdM0poRw2FrOPUO
         4c5Aex8xxKlUCubTiVkVe0DIcNCvXHXxlq7IVxxNI8pAbCjV7T+qV4DvNlH+uKUXgc6j
         GtgA==
X-Gm-Message-State: ANoB5pnpavEz9KiwYAnECtMxGRcxEUUmVJCip26C2HbMdLeCDZfEZFEe
        lhJBfWZE8ytkkra0EvALyob5Sw==
X-Google-Smtp-Source: AA0mqf7BMcqzrhfanZkvUyfWE7632ujYz6f26WUmSC5MB1Ub7wpu0VFEZXO6pYWYl7NDTPViNmT0Dw==
X-Received: by 2002:a05:6602:21c2:b0:6e2:d939:4f30 with SMTP id c2-20020a05660221c200b006e2d9394f30mr2514770ioc.0.1671037017900;
        Wed, 14 Dec 2022 08:56:57 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j21-20020a0566022cd500b006bbddd49984sm102876iow.9.2022.12.14.08.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 08:56:57 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
In-Reply-To: <20221213120826.17446-1-jirislaby@kernel.org>
References: <20221213120826.17446-1-jirislaby@kernel.org>
Subject: Re: [PATCH v3] block/blk-iocost (gcc13): keep large values in a new enum
Message-Id: <167103701689.7871.5096840115794235278.b4-ty@kernel.dk>
Date:   Wed, 14 Dec 2022 09:56:56 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 13 Dec 2022 13:08:26 +0100, Jiri Slaby (SUSE) wrote:
> Since gcc13, each member of an enum has the same type as the enum [1]. And
> that is inherited from its members. Provided:
>   VTIME_PER_SEC_SHIFT     = 37,
>   VTIME_PER_SEC           = 1LLU << VTIME_PER_SEC_SHIFT,
>   ...
>   AUTOP_CYCLE_NSEC        = 10LLU * NSEC_PER_SEC,
> the named type is unsigned long.
> 
> [...]

Applied, thanks!

[1/1] block/blk-iocost (gcc13): keep large values in a new enum
      commit: ff1cc97b1f4c10db224f276d9615b22835b8c424

Best regards,
-- 
Jens Axboe


