Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424ECC54EE9
	for <linux-block@archiver.kernel.org>; Thu,  8 Sep 2022 15:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiIHPXV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Sep 2022 11:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiIHPXP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Sep 2022 11:23:15 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8B5EB2CA
        for <linux-block@vger.kernel.org>; Thu,  8 Sep 2022 08:23:05 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id q81so14342564iod.9
        for <linux-block@vger.kernel.org>; Thu, 08 Sep 2022 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date;
        bh=stK1ht9fWSnkQnXFo8JZT/Y7GNru1MpSHx0zpqkAgbY=;
        b=3GtqgllRYHFE1EKMM4aLp2V3LO6mztidY6CaAc0cBNDFL6E0tOtaB32CesPnQ4fDUT
         IGSuxb3ohIQbDS286JrW4OjbvTG7MEysVGk28xp/9P4fw9MoahHDZXYIGUv57YJhrV7i
         b4+IevOoO6xjyjkKUl5USvCsaf4rbm22ej5LjDy00KS5zUZu2OHksAnyeH+XoByxPfVE
         r2BN15nFslkG3EQpx47cIzKv+PH4fuVLa6yXBLEwSoSd3bDMfwpfNb5eck5VEfxWtm+z
         Ux7GOF5+rSABkqmy+TMGP2wFj9z5To5HtHZNzTA1WK910cM/Wcr3l5xVKbXQrVGEFt/h
         D27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=stK1ht9fWSnkQnXFo8JZT/Y7GNru1MpSHx0zpqkAgbY=;
        b=1oyzALOiAeK2WKUXgt1nk1AWXBxDYv5CJER5N4dhavl2Lvz7fY6phK+Ym7MZQ+FUQg
         5dZXQIPnZSC0mNejJT9kcAJJNottAyrnfw82nR3NOP0RXH+EVsuO82zwt9HHS75foXBk
         k9yFlr28u0cCOOFMh/BWVZN3OZ74WFjqaN3tpHfcymYAJ/nLWv74OzSOQ7rnYBoJNE0l
         1BkhJvt4X7QChVBheVRIf5lbV/DEgz91KI++T4SHj2Yrjah6j37WAMXChDpC8R9+pMTO
         8OEIg81aKBv75WhGikNV1w+zZov6URTTJDbiJIBFP8wfSzQruu6UxwzptvGoi01wDNtP
         2TAg==
X-Gm-Message-State: ACgBeo0K/NwbVJtoVyUCzxhKtEwaDEfTvcYw1w4KPQJX7rvYi4PbKG4i
        Gd3OfhBaioUyHN/mx1s6Kuhgzg==
X-Google-Smtp-Source: AA6agR72hquCJ6QUfzARtnsu8muIHNWRd2t/J5teQumDMXgyYRFYtmyjgoV0fM5KZnJzhxupuBkrEw==
X-Received: by 2002:a05:6602:3407:b0:688:e4bd:afc with SMTP id n7-20020a056602340700b00688e4bd0afcmr4352189ioz.24.1662650584167;
        Thu, 08 Sep 2022 08:23:04 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j17-20020a056e02125100b002f1e45896c4sm979749ilq.35.2022.09.08.08.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 08:23:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20220908151200.9993-1-ubizjak@gmail.com>
References: <20220908151200.9993-1-ubizjak@gmail.com>
Subject: Re: [PATCH RESEND v2] sbitmap: Use atomic_long_try_cmpxchg in __sbitmap_queue_get_batch
Message-Id: <166265058355.492758.3474516202964637778.b4-ty@kernel.dk>
Date:   Thu, 08 Sep 2022 09:23:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 8 Sep 2022 17:12:00 +0200, Uros Bizjak wrote:
> Use atomic_long_try_cmpxchg instead of
> atomic_long_cmpxchg (*ptr, old, new) == old in __sbitmap_queue_get_batch.
> x86 CMPXCHG instruction returns success in ZF flag, so this change
> saves a compare after cmpxchg (and related move instruction in front
> of cmpxchg).
> 
> Also, atomic_long_cmpxchg implicitly assigns old *ptr value to "old"
> when cmpxchg fails, enabling further code simplifications, e.g.
> an extra memory read can be avoided in the loop.
> 
> [...]

Applied, thanks!

[1/1] sbitmap: Use atomic_long_try_cmpxchg in __sbitmap_queue_get_batch
      commit: c35227d4e8cbc70a6622cc7cc5f8c3bff513f1fa

Best regards,
-- 
Jens Axboe


