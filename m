Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC62C43334
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 02:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbiGZCk1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jul 2022 22:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237361AbiGZCkY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 22:40:24 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBF229CA5
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 19:40:23 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h132so11985009pgc.10
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 19:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YDCQ69+j6DNEGXcsFGhvww2iHW1abII9YyREo17Wc9M=;
        b=nURnkjTNc8xF/ccGVoabMqVasflS0pMoXQ/Ik/dRiB0yWqinGlQdYjuNE/mofQjveP
         glgKAaoDzMXfOgSzVV4PtfQLcqWlIKnYxQ94QwgjOzwdlEqFsXGxdLn1Jz4kobD2rkvw
         vpAk4BmlARuz3J61Y4ICkCVUIqpEIi/j7YrEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YDCQ69+j6DNEGXcsFGhvww2iHW1abII9YyREo17Wc9M=;
        b=000g3xCc5vQLiUh3p5/98nKmK+zCWyL/XHsAGvl2LAAE/SRGfNtQ50ottSmkYuI7I0
         s1XaPP/I8vFcqoV/djby6OJBKqqq5Apj2JEI0v2k5TsqejZsZHb2IrsgBz2Djs4ue19C
         1zSAZAEPRIYR72kKDsbx2FaVgPfMHwTjpKKE+PiB4KaxFzb/lqxiBRxYbe5b0h8YSLqv
         KAG8T0pd6dk9WX2luuEIb3L/N7s6oNqaZ/OI2+iUYwEz8TprIKOgXpkONNgfGurYajEq
         VNqbx2IktkZJFQsf2owO/4YYgnl3wY6m18P9lPhgpWFT0vSqMVKuenbFXVPvngzEDNWD
         Tgsw==
X-Gm-Message-State: AJIora8MfKZP6fgW5pPn2DMHV8ZEpN2xpbBmCH5I18xw8E2fBL011bRA
        fJ4JKlik92Xl6CDaHX9S0bQkmA==
X-Google-Smtp-Source: AGRyM1vx5o3O82d+UwS4QXR3lui4cdf2xPHbdWNIwHc/5apxbNSIwtpsF6MA6NxtaEX1qzpjbghRdw==
X-Received: by 2002:a63:5fc9:0:b0:419:9871:fc8d with SMTP id t192-20020a635fc9000000b004199871fc8dmr13109285pgb.422.1658803222173;
        Mon, 25 Jul 2022 19:40:22 -0700 (PDT)
Received: from google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id a16-20020aa78e90000000b0052b29fd7982sm10250313pfr.85.2022.07.25.19.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 19:40:21 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
X-Google-Original-From: Daniil Lunev <dlunev@google.com>
Date:   Tue, 26 Jul 2022 12:40:14 +1000
To:     Israel Rukshin <israelr@nvidia.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Nitzan Carmi <nitzanc@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>, dm-devel@redhat.com,
        linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 1/1] block: Add support for setting inline encryption key
 per block device
Message-ID: <Yt9UDoKbidXaTmYd@google.com>
References: <1658316391-13472-1-git-send-email-israelr@nvidia.com>
 <1658316391-13472-2-git-send-email-israelr@nvidia.com>
 <Ytj249InQTKdFshA@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytj249InQTKdFshA@sol.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 20, 2022 at 11:49:07PM -0700, Eric Biggers wrote:
> I'm glad to see a proposal in this area -- this is something that is greatly
> needed.  Chrome OS is looking for something like "dm-crypt with inline crypto
> support", which this should work for.  Android is also looking for something
> similar with the additional property that filesystems can override the key used.
Yes, this is exciting to see proposals in this area. In ChromeOS we were
contemplating ways to upstream Eric's work for Android. This solution should
work generally for our use-case, however I would like to add a few extra pieces
we were considering.

One thing we were looking for is having an option to pass inline encryption keys
via keyrings, similarly to how dm-crypt allows suuplying keys both ways: raw and
keyring attached. I would assume that is something that should still be possible
with the IOCTL-based approach, though proposed API can make it a bit obscure. I
was wondering whether there should be a separate field to allow this kind of
differentiation?

The other aspect is the key lifetime. Current implementation doesn't allow to
unset the key once set. This is something that would still work with dm setups,
presumably, since the key lifetime is tied to the lifetime of the device itself,
but may render problematic if this is applied to a raw device or partition of a
raw device, I would assume - allowing no ways to rotate the key without reboot.
I am not sure if this is a particularly important issue, but something that I
wanted to raise for the discussion. This also becomes relevant in the context of
the keyring usages, i.e. whether to revoke the key from the block device when
the key is removed from the keyring, or assume it is bound at the time of device
setup. The dm-crypt follows the latter model, AFAIU, and it is fine to keep it
consistent, but then the question comes back to inability to remove the key in
the current API in general.

And speaking about dm, the other thing we were looking into is compatibility of
inline encryption key setup with dm stacks. Current kernel implementaiton
propagates the crypto context through linear and flakey target, we also had
initial tests enabling it on thin pools by adding DM_TARGET_PASSES_CRYPTO, which
didn't show any problems at first glance (but more testing is required). We
believe that an ability to setup multiple different dm targets with different
keys over the same physical device is an important use case - and as far as I
can tell proposed approach supports it, but wanted to highlight that as well.

--Daniil

