Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61732CCA481
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 15:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiGOPFj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 11:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbiGOPFj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 11:05:39 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB922C67A
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 08:05:38 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 125so4061702iou.6
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 08:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=GyF5vVUfYg0uGjuHMOooMcwwdDurfB/NjUpbYbcr06U=;
        b=bhPLfwdwXmyk/H2PFbTvP7ybSzx+AT91O5DBfH2+tqH2stNW+hsOg6UmwAFKcvUNCn
         uncUJMNKhY5Y4qOKfeaWfsxcGh9k8iYTZx4deOreqM9P6c3nmkraj7OW8BylNicHMELi
         dg1HGYu7o0dP1GjkU569oCBYJMGgs8q7/unEoIlwJPvux6xC3lpTdr8bYpS8Ukjp3+aZ
         ncgda/mTwjoel/ChXx+1OzuUDwR7k4DYvXyekTFaDsEqJ/WkDK8IcdOD7o6UYcWkIQup
         6Rc1ivxsjJQ8cMDbwILq+A3N3x6pCnuz0xxqdLIsKu1T1k3BMUpfQZNJgz9qveM0m0Jd
         kCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=GyF5vVUfYg0uGjuHMOooMcwwdDurfB/NjUpbYbcr06U=;
        b=Cz6zPF8IVEif8I4rpwA1aH5bYjwbdf9dGriMI52y9UoixPA+oIOl6WY08oEI2RITsv
         sF2yUPVn5NcPfZ2RhytMoU47hdy6jvIHcmEGhlFPFYbieSKEurMnpshDe6iW2sq/ukHE
         zOL3bPb1B6MxxjMR2HaUgHlK4xksztVlID+oDn+xIKwjC8dBzhRYVAVRUxWw1FDCWBur
         cynCf45XGf8hh2JxGmFreNFfimRYPJ4wua9lWa8Np8+2bRWs3DuCUAQk2ix3teBWJnJH
         HLMKhUw7EWEgy9vTbwG47Ade0FswWXRYkrP9p7pA4LLEKHqo+Rtv6bOalpTucyKxCva1
         74Jg==
X-Gm-Message-State: AJIora8fh0dmvP65slLIiz8WYJXOOACampeOR5ZZLg5B+4ditqkZNkIq
        KPC0qT58max7U9UpqNNCGw7EbQ==
X-Google-Smtp-Source: AGRyM1v+28YqO5JTOYmncYwGj3waUtsYsregMJHG1FOY0Z/GGxqQRCyVAmj2xpNB6nT8hfkLgIXn3g==
X-Received: by 2002:a05:6602:3298:b0:675:7d23:6643 with SMTP id d24-20020a056602329800b006757d236643mr6925275ioz.143.1657897537524;
        Fri, 15 Jul 2022 08:05:37 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a27-20020a027a1b000000b0033ef5e3c7b8sm1991129jac.142.2022.07.15.08.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 08:05:36 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     vincent.fu@samsung.com, dan.carpenter@oracle.com
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        johannes.thumshirn@wdc.com, kernel-janitors@vger.kernel.org,
        damien.lemoal@opensource.wdc.com, kch@nvidia.com,
        shinichiro.kawasaki@wdc.com
In-Reply-To: <YtEhCjDq2oe2SIkS@kili>
References: <YtEhCjDq2oe2SIkS@kili>
Subject: Re: (subset) [PATCH 1/2] null_blk: prevent NULL dereference in null_init_tag_set()
Message-Id: <165789753645.280962.1878458022201591770.b4-ty@kernel.dk>
Date:   Fri, 15 Jul 2022 09:05:36 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 15 Jul 2022 11:10:50 +0300, Dan Carpenter wrote:
> The "nullb" pointer can be NULL.  Smatch prints a warning about this:
> 
>     drivers/block/null_blk/main.c:1914 null_init_tag_set()
>     error: we previously assumed 'nullb' could be null (see line 1911)
> 
> 

Applied, thanks!

[2/2] null_blk: fix ida error handling in null_add_dev()
      commit: 8c740c6bf12dec03b6f35b19fe6c183929d0b88a

Best regards,
-- 
Jens Axboe


