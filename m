Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6523C433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 13:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D3860E9C
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 13:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhJFNaR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 09:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230077AbhJFNaP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Oct 2021 09:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633526902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1tJD1MyAZSMlO+w5dHejgDl1BZyQkw7PrMG9J/BwPx4=;
        b=Ax0NXD/9LgNZJ+Y+nwoVdqtuG/pOhYCOMCyBssx/lVgR34jWiBIa1YUsv/4/xN4i/YELxY
        nF8n0gRv/MxLN772d4KUa/bjo+waN/SF/ZSxEaH6hx4Bda5brvNkk3NTKd7DUh/N7S/XpA
        YyWmOu7d8tg0LcAIo2gUolVqHUx52Pk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-O1eZQBxvNKylX3LcmLRbig-1; Wed, 06 Oct 2021 09:28:22 -0400
X-MC-Unique: O1eZQBxvNKylX3LcmLRbig-1
Received: by mail-qt1-f198.google.com with SMTP id h10-20020ac8584a000000b002a712bc435fso2237357qth.20
        for <linux-block@vger.kernel.org>; Wed, 06 Oct 2021 06:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1tJD1MyAZSMlO+w5dHejgDl1BZyQkw7PrMG9J/BwPx4=;
        b=vZ8vHfqAO7VUFK6CPQghPO4q5F74oq4QRQ+mqch2/DkCkPXMNF02I8AEtT0sqqbZhS
         HLLtu17wYZs++7BkbyIMDru7xv1d+FodhFVRLRnA58Snu0YxJOMe6AY5lnMyQECHHFWn
         SKLRHHc6N5S55WNpMShIwrthgVr8pO9C5yl/qg5EUtDdbsOSXC1TSQkVXfQNHiw8hOuL
         kYXoBx97PeRQKBG8gJoOAN7OObbLoE7Kr2FjRBl8UbkUbE2jnhGfDFee4jYRbu4LcoO9
         m5llj4zhkNJnuQRXaQELzLdkxz37Tb/8V+w3wQJTZs6R9k2ydRmktYTFnKWu7PYtc4Af
         CYvQ==
X-Gm-Message-State: AOAM531mnjgzvnOJPTuX53CYaiQKHzF38EDPr5PliLRE04Q/rikGBp7j
        7boAuTqxsWM47DRb8WCGRmH+MQmw9QqiTWUJDbHB3xxs6hgNhDvJOI1/LCQixorelV8eaMU4V5O
        lnw0LXkGLUTG+rDT7PB8Jp+DDK7O/t6WrpqQpqoF+a7AuNPAdxp47dv2J4bAocIE7hreC/cU6
X-Received: by 2002:a05:622a:614:: with SMTP id z20mr26023538qta.232.1633526901406;
        Wed, 06 Oct 2021 06:28:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQYqJgkQDoER0wVjEnhGOvfMferVnYWL3MCFbh+T5SgAmvWHhmeJb7yIfGG5UVXT07/2sCPA==
X-Received: by 2002:a05:622a:614:: with SMTP id z20mr26023510qta.232.1633526901173;
        Wed, 06 Oct 2021 06:28:21 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id m1sm1131877qtu.59.2021.10.06.06.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 06:28:20 -0700 (PDT)
Date:   Wed, 6 Oct 2021 09:28:20 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Satya Tangirala <satyaprateek2357@gmail.com>, dm-devel@redhat.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 3/4] blk-crypto: rename blk_keyslot_manager to
 blk_crypto_profile
Message-ID: <YV2kdHeS4GTXUdpi@redhat.com>
References: <20210929163600.52141-1-ebiggers@kernel.org>
 <20210929163600.52141-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929163600.52141-4-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 29 2021 at 12:35P -0400,
Eric Biggers <ebiggers@kernel.org> wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> blk_keyslot_manager is misnamed because it doesn't necessarily manage
> keyslots.  It actually does several different things:
> 
>   - Contains the crypto capabilities of the device.
> 
>   - Provides functions to control the inline encryption hardware.
>     Originally these were just for programming/evicting keyslots;
>     however, new functionality (hardware-wrapped keys) will require new
>     functions here which are unrelated to keyslots.  Moreover,
>     device-mapper devices already (ab)use "keyslot_evict" to pass key
>     eviction requests to their underlying devices even though
>     device-mapper devices don't have any keyslots themselves (so it
>     really should be "evict_key", not "keyslot_evict").
> 
>   - Sometimes (but not always!) it manages keyslots.  Originally it
>     always did, but device-mapper devices don't have keyslots
>     themselves, so they use a "passthrough keyslot manager" which
>     doesn't actually manage keyslots.  This hack works, but the
>     terminology is unnatural.  Also, some hardware doesn't have keyslots
>     and thus also uses a "passthrough keyslot manager" (support for such
>     hardware is yet to be upstreamed, but it will happen eventually).
> 
> Let's stop having keyslot managers which don't actually manage keyslots.
> Instead, rename blk_keyslot_manager to blk_crypto_profile.
> 
> This is a fairly big change, since for consistency it also has to update
> keyslot manager-related function names, variable names, and comments --
> not just the actual struct name.  However it's still a fairly
> straightforward change, as it doesn't change any actual functionality.
> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Unfortunate how fiddley this change forced you to get but it looks
like you've done a very solid job of cleaning it all up to be
consistent.

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

