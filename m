Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF98C433FE
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 09:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29CE61108
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 09:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhINJGP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhINJGP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 05:06:15 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6738CC061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 02:04:58 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h1so22441727ljl.9
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 02:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJGnWAchz/HDqF7HydjX2fUZvRJTYMKYHvyvKYF6LTA=;
        b=gsRYdLNT2BSVgBpZbeqTFVqbuZ67wWkrXvsQwtq0WLXmHe/pl4s2ggGSn5W150c6NX
         fqT6OzdCP/P+GMEGsvZfkMrRsKlKoV3bs+aoh/pJox88oCfQMj88wXcJE7q+p0vyhBwM
         4Z3Hfsw8LQ9OEXmd1bMlCw/9a0W4y/J57kJYDMkw8QFf+RZVkF1pgx66wlTAyPzANWAB
         EDg5+DOWidgpAJINmPs8zJ6LA2IrDSsIJkDGlR+E6bSssBbgs0qkB4oM8g1NGMpIdX16
         KVwjrQ8QX9r0CbMGHrPAXko2ja5ROaV1asQSeSU6nAMbC8+DA0OSoV/OUL75BLVJ5Y8b
         iKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJGnWAchz/HDqF7HydjX2fUZvRJTYMKYHvyvKYF6LTA=;
        b=BmDPfpg1qxfDPK5EXZLD3nuG/V3U+Kju7wI7W62gbkOve+YJExuGwiwZT3Sfik5UZL
         wL3ASmiFExL/zjGqbp6e1OiEHaGkK7TcVwgt6g7xWelbLUCBU3VXUL5nWbXRcU7nPfKc
         465GvQuE/exzehYkce+I2ry5iHT5ON8rHD2IkpQ94WaYZ36p1Mb6/z1ZNEQtlALlCt65
         NEgq9WOkgc9I5azaPNrafTRmouSqN4uzqBgdGV3DMsT97Lh3b4uNVcNX+CnQtXF4V1kn
         W+BpDo6mA5hsa+9dqVTHBWuwhmZUKsoHbigWq2Pz4lw/+QztcKXlWmWfnBuJQwPYf4NO
         T26A==
X-Gm-Message-State: AOAM533qA3BQHAMmMLSc9dtG0JU6wylbHdrlzy45I50QzBzqpVSm6Szk
        blS7vyq+N3dhgKFp3NNM1anbMYR1COZcmYzqdKV82A==
X-Google-Smtp-Source: ABdhPJxZC/j49j+CcIzIqzNYUN//TpHs73k6VRwmbWS0R4xoDibBWk/HYQNi25ajG7KIqw46sDy4K+S8GNnu6KTzYqE=
X-Received: by 2002:a2e:960c:: with SMTP id v12mr14672590ljh.300.1631610296769;
 Tue, 14 Sep 2021 02:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210913013135.102404-1-ebiggers@kernel.org> <20210913013135.102404-5-ebiggers@kernel.org>
In-Reply-To: <20210913013135.102404-5-ebiggers@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Sep 2021 11:04:20 +0200
Message-ID: <CAPDyKFpvZAQ+5niZkw2tk-q_6w=VAuK=P-OVGjQA7QbJW7OvgQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] blk-crypto: rename blk_keyslot_manager to blk_crypto_profile
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>, dm-devel@redhat.com,
        Satya Tangirala <satyaprateek2357@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 13 Sept 2021 at 03:35, Eric Biggers <ebiggers@kernel.org> wrote:
>
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
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  block/blk-crypto-fallback.c        |  60 ++--
>  block/blk-crypto-profile.c         | 518 ++++++++++++++---------------
>  block/blk-crypto.c                 |  25 +-
>  block/blk-integrity.c              |   2 +-
>  drivers/md/dm-core.h               |   2 +-
>  drivers/md/dm-table.c              | 168 +++++-----
>  drivers/md/dm.c                    |   8 +-
>  drivers/mmc/core/crypto.c          |  11 +-
>  drivers/mmc/host/cqhci-crypto.c    |  31 +-
>  drivers/scsi/ufs/ufshcd-crypto.c   |  32 +-
>  drivers/scsi/ufs/ufshcd-crypto.h   |   9 +-
>  drivers/scsi/ufs/ufshcd.c          |   2 +-
>  drivers/scsi/ufs/ufshcd.h          |   4 +-
>  include/linux/blk-crypto-profile.h | 164 +++++----
>  include/linux/blkdev.h             |  18 +-
>  include/linux/device-mapper.h      |   4 +-
>  include/linux/mmc/host.h           |   2 +-
>  17 files changed, 548 insertions(+), 512 deletions(-)
>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC

[...]

Kind regards
Uffe
